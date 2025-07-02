public class TriggerHandler_PopulateShippingAddress {
    public static void beforeInsertAndUpdate(List<Account> LIST_TriggeredAccounts){
        List<String> accNameList = new List<String>();
        for(Account each_accList : [SELECT Id,Name FROM Account WHERE Name != NULL]){
            accNameList.add(each_accList.Name);
        }
        for(Account Record_Acount : LIST_TriggeredAccounts){
            //Prevent to create duplicate Accounts
            If(accNameList.contains(Record_Acount.Name)){
                Record_Acount.addError('You cannot create account with this account name. Its already existing. Please change the account name to avoid this error./n Error from TriggerHandler_PopulateShippingAddress Before insert method.');
            }
            
            IF(Record_Acount.BillingStreet != NULL){
                Record_Acount.ShippingStreet = Record_Acount.BillingStreet;
            }
            IF(Record_Acount.BillingCity != NULL){
                Record_Acount.ShippingCity = Record_Acount.BillingCity;
            }
            IF(Record_Acount.BillingState != NULL){
                Record_Acount.ShippingState = Record_Acount.BillingState;
            }
            IF(Record_Acount.BillingCountry != NULL){
                Record_Acount.ShippingCountry = Record_Acount.BillingCountry;
            }
            IF(Record_Acount.BillingPostalCode != NULL){
                Record_Acount.ShippingPostalCode = Record_Acount.BillingPostalCode;
            }
        }
    }
    
    public static void afterUpdate(List<Account> LIST_NEW_TriggeredAccounts){
        MAP<Id,List<Opportunity>> MAP_ACCId_OppList = new MAP<Id,List<Opportunity>>();
        SET<Id> SET_ACCOUNTIDs = new SET<Id>();
        FOR(Account Record_Acount : LIST_NEW_TriggeredAccounts){
            SET_ACCOUNTIDs.add(Record_Acount.Id);
        }
        List<Account> AccWithOpps = [SELECT Id,(SELECT ID,Amount,StageName,CreatedDate FROM Opportunities) FROM Account WHERE Id IN : SET_ACCOUNTIDs];
        System.debug('Acc Opp MAP ===>'+AccWithOpps);
        FOR(Account acc : AccWithOpps){
            List<Opportunity> List_Opportunity = acc.Opportunities;
            MAP_ACCId_OppList.put(acc.Id , List_Opportunity);
        }
        System.debug(MAP_ACCId_OppList);
        List<Opportunity> UPDATE_LIST_OPPOrtunities = new List<Opportunity>();
        FOR(Account Iterate_Account : LIST_NEW_TriggeredAccounts){
            IF(MAP_ACCId_OppList.containsKey(Iterate_Account.Id)){
                List<Opportunity> LIST_Opportunities = MAP_ACCId_OppList.get(Iterate_Account.Id);
                FOR(Opportunity OPP_Record : LIST_Opportunities){
                    IF(OPP_Record.createdDate > System.Now()+30){
                        OPP_Record.Amount = 4165;
                    }
                    ELSE{
                        OPP_Record.Amount = 6541;
                    }
                    UPDATE_LIST_OPPOrtunities.add(OPP_Record);
                }
            }
        }
        System.debug('Updating Opportunity ==> '+UPDATE_LIST_OPPOrtunities);
        if(UPDATE_LIST_OPPOrtunities.size()>0){
            try{
                update UPDATE_LIST_OPPOrtunities;
            }
            catch(Exception e){
                System.debug(e.getMessage());
            }
        }
    }
    
    
    public static void afterInsert(List<Account> LIST_NEW_TriggeredAccounts){
        List<Contact> LIST_Contacts = new List<Contact>();
        List<Account> LIST_Accounts = new List<Account>();
        for(Account acc : LIST_NEW_TriggeredAccounts){
            Contact con = new Contact(
                LastName = acc.Name,
                AccountId = acc.Id,
                Title = 'Test Title from Jagadeesh'
        	);
            LIST_Contacts.add(con);
        }
        if(LIST_Contacts.size()>0){
            insert LIST_Contacts;
        }
        
        for(Contact c : LIST_Contacts){
            for(Account a : LIST_NEW_TriggeredAccounts){
                if(c.AccountId == a.Id){
                    //a.Client_Contact__c = c.Id;
                    if(!LIST_Accounts.contains(a)){
                        LIST_Accounts.add(a);
                    }
                    
                }
            }
        }
        if(LIST_Accounts.size()>0){
            //update LIST_Accounts;
        }
    }
}
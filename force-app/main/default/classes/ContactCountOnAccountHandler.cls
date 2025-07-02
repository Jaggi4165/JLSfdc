public class ContactCountOnAccountHandler {
    public static void updateAccountWithConSize(List<Contact> listOfContacts){
        set<Id> accountIdSet = new set<Id>();
        for(Contact con : listOfContacts){
            if(con.AccountId !=null){ 
                accountIdSet.add(con.AccountId);     
            }
        }
        List<Account> listOfAccounts = new List<Account>();
        if(accountIdSet.size()>0){
            listOfAccounts = [SELECT Id,(SELECT Id,AccountId FROM Contacts) FROM Account WHERE Id IN : accountIdSet];
        }
        if(listOfAccounts.size()>0){
            for(Account acc : listOfAccounts){
                List<Contact> cons = acc.Contacts; 
                acc.Number_Of_Contacts__c = cons.size();
            }
        }
        if(listOfAccounts.size()>0){
            try{
                UPDATE listOfAccounts;
            }
            catch(Exception e){
                Error_Log__c err = new Error_Log__c();
                err.Error_Type__c = 'ContactCountOnAccountHandler.updateAccountWithConSize()';
                err.Error_Message__c = e.getMessage();
                err.Error_StackTrace__c = e.getStackTraceString();
                err.Error_Line__c = e.getLineNumber();
                Insert err;
            }
        }
    }
    
    public static void afterDeleteConSize(List<Contact> listOfContacts){
        set<Id> accountIdSet = new set<Id>();
        for(Contact con : listOfContacts){
            if(con.AccountId !=null){ 
                accountIdSet.add(con.AccountId);     
            }
        }
        List<Account> listOfAccounts = new List<Account>();
        if(accountIdSet.size()>0){
            listOfAccounts = [SELECT Id,(SELECT Id,AccountId FROM Contacts) FROM Account WHERE Id IN : accountIdSet];
        }
        if(listOfAccounts.size()>0){
            for(Account acc : listOfAccounts){
                List<Contact> cons = acc.Contacts; 
                acc.Number_Of_Contacts__c = cons.size();
            }
        }
        if(listOfAccounts.size()>0){
            try{
                UPDATE listOfAccounts;
            }
            catch(Exception e){
                Error_Log__c err = new Error_Log__c();
                err.Error_Type__c = 'ContactCountOnAccountHandler.updateAccountWithConSize()';
                err.Error_Message__c = e.getMessage();
                err.Error_StackTrace__c = e.getStackTraceString();
                err.Error_Line__c = e.getLineNumber();
                Insert err;
            }
        }
    }
    
    // This method will execute when the Account Record updated
    public static void onAfterUpdateOperation(Map<Id,Contact> triggered_Contact_newMap, Map<Id,Contact> triggered_Contact_oldMap){
        updateNumberOfContactsOnAccount(triggered_Contact_newMap, triggered_Contact_oldMap);
        
    }
    
    private static void  updateNumberOfContactsOnAccount(Map<Id,Contact> triggered_Contact_newMap, Map<Id,Contact> triggered_Contact_oldMap){
        Set<Id> LIST_AccountIds = new Set<Id>();
        LIST<Account> LIST_UPDATE_Accounts = new LIST<Account>();
        for(Contact con : triggered_Contact_newMap.values()){
            If(con.AccountId != NULL) LIST_AccountIds.add(con.AccountId);
        }

        // map<string,sObject> mapmap = new map<string,sObject>([SELECT accountid FROM contact WHERE Id IN : triggered_Contact_newMap.keyset() AND AccountId != NULL GROUP BY AccountId ]);
        // set<string> accountIDSet = mapmap.keyset();
        
        for(AggregateResult  aggr : [Select AccountId,Count(id) from contact where AccountId IN:LIST_AccountIds GROUP BY AccountId]){
            LIST_UPDATE_Accounts.add(new Account( Id = (Id)aggr.get('AccountId'),
                                                  Number_Of_Contacts__c = (Integer)aggr.get('expr0')
            									)
                                    ); //expr0
        }
        if(!LIST_UPDATE_Accounts.isEmpty()) UPDATE LIST_UPDATE_Accounts;
    }
    
}
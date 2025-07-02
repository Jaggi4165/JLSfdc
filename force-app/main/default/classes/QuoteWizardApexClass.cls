public with sharing class QuoteWizardApexClass {
    public QuoteWizardApexClass() {

    }

    @AuraEnabled( cacheable = true )  
    public static List< Contact > fetchContacts( String searchkey ) {  
      
        String strKey = '%' + searchkey + '%';  
        return [ SELECT Id, Name,AccountId FROM Contact WHERE (Name LIKE: strKey AND contact.AccountId != Null) ];  
 
    } 

    @AuraEnabled( cacheable = true )  
    public static List<Contact> fetchAccountDetails( String conId ) {  
       //system.debug('the value of the accID : '+accId);
        return [ SELECT Id,Name,Phone,AccountId,Account.Name,Account.Industry,Account.Owner.Name,Account.AccountNumber FROM Contact WHERE Id =: conId ]; 
         
          
    } 

    @AuraEnabled( cacheable = true )  
    public static List<Account> fetchAccount( String accId ) {  
    //    system.debug('the value of the accID : '+accId);
        return [ SELECT Id,Name,Industry,owner.Name,AccountNumber FROM Account WHERE Id =: accId ]; 
         
    }

    @AuraEnabled
    public static Account insertAccountMethod(Account accountObj){
        system.debug('Account Object : '+accountObj);
    
            insert accountObj;
            return accountObj;
        
    }

    @AuraEnabled
    public static Contact insertContactMethod(Contact contactObj){
        system.debug('Contact Object : '+contactObj);
            insert contactObj;
            return contactObj;
    }

    @AuraEnabled
    public static Quote insertQuoteMethod(Quote quoteObj){

            insert quoteObj;
            return quoteObj;

    }

    @AuraEnabled
    public static Order insertOrderMethod(Order orderObj){

            insert orderObj;
            return orderObj;

    }



    @AuraEnabled( cacheable = true )  
    public static List< Opportunity > fetchOpportunity( String searchkey ) {  // 
  
            return [SELECT Id, Name,AccountId,StageName,CloseDate,Amount FROM Opportunity WHERE  Opportunity.AccountId =: searchkey];

    }

    @AuraEnabled( cacheable = true )  
    public static List<Opportunity> fetchOppDetails( String oppId ) {  
       //system.debug('the value of the accID : '+accId);
        return [ SELECT Id,Name,StageName,CloseDate,Amount FROM Opportunity WHERE Id =: oppId ]; 
         
          
    } 

    @AuraEnabled(cacheable = true)
    public static List<Account> getAccountDetails(String accountRecordId) {
        return [SELECT Name, Owner.Name, AccountNumber,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry  FROM Account WHERE Id = :accountRecordId];
    }
    @AuraEnabled(cacheable = true)
    public static List<Contact> getContactDetails(String contactRecordId) {
        return [SELECT FirstName, LastName, Phone,Email  FROM Contact WHERE Id = :contactRecordId];
    }
    @AuraEnabled(cacheable = true)
    public static List<Opportunity> getOpportunityDetails(String oppRecordId) {
        return [SELECT Name, StageName, CloseDate  FROM Opportunity WHERE Id = :oppRecordId];
    }

    @AuraEnabled( cacheable = true )  
    public static List< Contract > fetchContracts( String contractsearchkey, String accountIdForContract) {  
      
        String strKey2 = contractsearchkey + '%'; 
        try{
            return [ SELECT Id, ContractNumber FROM Contract WHERE (ContractNumber LIKE: strKey2 AND AccountId =: accountIdForContract)]; 
            //return [ SELECT Id, ContractNumber FROM Contract WHERE (ContractNumber LIKE: strKey2)];
        }
        catch(Exception exp){
            throw new AuraHandledException(exp.getMessage());
        }
         
 
    } 
}
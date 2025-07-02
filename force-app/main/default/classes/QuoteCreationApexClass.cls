public with sharing class QuoteCreationApexClass {
    public QuoteCreationApexClass() {

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
    public static List< Opportunity > fetchOpp( String searchkey ) {  
      
 
        return [ SELECT Id, Name,AccountId FROM Opportunity WHERE accountId =: searchkey ];  
          
    } 

    @AuraEnabled( cacheable = true )  
    public static List< Opportunity > fetchOppDetails( String oppId ) {  
       //system.debug('the value of the accID : '+accId);
        return [ SELECT Id,Name, Account.Name FROM Opportunity WHERE Id =: oppId ]; 
         
          
    } 
    @AuraEnabled( cacheable = true )  
    public static List<Account> fetchAccount( String accId ) {  
       system.debug('the value of the accID : '+accId);
        return [ SELECT Id,Name,Industry,owner.Name,AccountNumber FROM Account WHERE Id =: accId ]; 
         
    }
}
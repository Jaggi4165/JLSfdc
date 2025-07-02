public with sharing class ApexController {
    public ApexController() {

    }
    // ContactSearchPage


    @AuraEnabled( cacheable = true )  
    public static List< Contact > fetchContacts( String searchkey ) {  
      
        String strKey = '%' + searchkey + '%';  
        return [ SELECT Id, Name,AccountId FROM Contact WHERE Name LIKE: strKey ];  
          
    } 

    @AuraEnabled( cacheable = true )  
    public static List< contact > fetchAccountDetails( String conId ) {  
       //system.debug('the value of the accID : '+accId);
        return [ SELECT Id,Name, Account.Name,Account.Industry,Phone FROM Contact WHERE Id =: conId ]; 
         
          
    } 

}
public with sharing class SalesforceController {
    // public SalesforceController(){}
    //----------------------------------------------------------------------------------------------------
    // DisplayAllContacts  
    @AuraEnabled(cacheable=true)

    public static List<Contact> getContacts()
    {

        return [SELECT Id, Name, Title, Phone, Email,AccountId 
                FROM Contact ];
    }
    //----------------------------------------------------------------------------------------------------
    @AuraEnabled(cacheable=true)
    public static List<Contact> getDataFromContact(){
      List<Contact> conList = [Select Id, FirstName, LastName, Email, Phone From Contact limit 10];
      try{
         return conList;
      }
      catch(Exception e){
         throw new AuraHandledException(e.getMessage());
      }
    }
    //----------------------------------------------------------------------------------------------------
    @AuraEnabled(cacheable=true)
    public static List<Contact> getSearchedContacts(String firstnamekey,String lastnamekey){

        String firstname = '%'+ firstnamekey + '%';
        String lastname = '%'+ lastnamekey + '%';

        return [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE (LastName LIKE :lastname AND FirstName LIKE :firstname)];
    }
//Account.name
    //----------------------------------------------------------------------------------------------------
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsOnModel(String id1){
        String recId=id1;
        return [SELECT Id, Birthdate, LeadSource, FirstName, LastName,Title FROM Contact WHERE Id = : recId];
        // WHERE (Id =: contactId)
    }
    
    
}
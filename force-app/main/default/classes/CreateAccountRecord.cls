public with sharing class CreateAccountRecord {
    public CreateAccountRecord() {

    }
    @AuraEnabled(cacheable=true)
    public static Account accountCreate(Account accRecObj){
        try{
             insert accRecObj;
             return accRecObj;
        }
        catch(Exception ex){
            throw new AuraHandledException(ex.getMessage());
        }
       
    }
}
public with sharing class CreateAnAccountRecord {
    public CreateAnAccountRecord() {

    }
    @AuraEnabled
    public static Account createAccount(Account accRecObj){
        try {
            insert accRecObj;
            return accRecObj;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
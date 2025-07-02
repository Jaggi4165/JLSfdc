public with sharing class getAllRecordsBikeHub {
    public getAllRecordsBikeHub() {

    }        
    @AuraEnabled(cacheable=true)
    public static List<Bike__c> retrieveBikeData(string keySearch) {

        return [Select Id,Vehicle_No__c, KMCovered__c from Bike__c where Hub__r.Name=:keySearch];
        

    }
}
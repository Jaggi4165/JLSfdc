public class GetHudDetails {
@auraEnabled
    public static List<Hub__c> getHubs(){
        return [select Id,Name,Location__c,Rating__c,Active__c from Hub__c];
    }
}
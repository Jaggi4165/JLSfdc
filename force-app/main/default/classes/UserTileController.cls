public with sharing class UserTileController {
    @AuraEnabled(cacheable=true)
    public static User getUserTilePermissions() {
        return [
            SELECT Id, Name,
                   Show_Reports__c,
                   Show_Dashboard__c,
                   Show_Admin_Tools__c
            FROM User
            WHERE Id = :UserInfo.getUserId()
            LIMIT 1
        ];
    }
}
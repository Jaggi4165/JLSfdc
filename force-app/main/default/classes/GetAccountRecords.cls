public with sharing class GetAccountRecords {
    public GetAccountRecords() {

    }
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts2(){
        return [
             SELECT id, name, type
             FROM Account
             LIMIT 10
        ];
     }
}
public with sharing class AccountListControllerLwc {
    @AuraEnabled(cacheable=true)
    public static Account queryAccountsByRevenue(Decimal annualRevenue){
        return [ SELECT Name FROM Account WHERE AnnualRevenue >= :annualRevenue ];
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Account> accountList(){
        return [ SELECT Id,Name,Rating FROM Account WHERE Rating = 'Hot' ];
    }
}
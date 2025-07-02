public with sharing class AccountContactController {
    public AccountContactController() {
        System.debug('AccountContactController Constructor');
    }
    public static List<Account> retrieveAccounts(){
        return [SELECT Id,Name FROM Account WHERE Name <> NULL WITH SECURITY_ENFORCED];
    }

    public static void method1(){
        List<Account> accountsList = [
            SELECT  Id ,
                    Name , 
                    (SELECT Id,LastName from Contacts) 
            FROM Account 
            WHERE Name <> NULL 
            WITH SECURITY_ENFORCED
        ];
    }
}
public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Name,Rating,Industry,Phone FROM Account ORDER BY CreatedDate DESC LIMIT 10];
    }

    @AuraEnabled
    public static List<Account> dynamicMethod() {  //dunamicApexCall LWC Component
        return [SELECT Id, Name,Rating,Industry,Phone FROM Account ORDER BY CreatedDate DESC LIMIT 10];
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name, Industry, AnnualRevenue FROM Account WHERE AnnualRevenue>0 LIMIT 50];
    }
    @AuraEnabled(cacheable=true)
    public static Account getSingleAccount() {
        return [
            SELECT Id, Name, Phone, Type
            FROM Account
            WITH SECURITY_ENFORCED
            LIMIT 1
        ];
    }

    @AuraEnabled
    public static List<Account> searchAccounts(String keyword) {
        String key = '%'+keyword+'%';
        return [
            SELECT Id, Name, Phone
            FROM Account WHERE Name LIKE : key
            ORDER BY Name
        ];
    }
    
    public static void onBeforeInsertOperation(List<Account> list_Accounts){
        List<String> accNameList = new List<String>();
        List<Contact> delete_Contacts = new List<Contact>();
        for(Account each_accList : [SELECT Id,Name FROM Account WHERE Name != NULL]){
            accNameList.add(each_accList.Name);       
        }
        for(Contact con : [SELECT Id,Name from contact Where Name !=NULL AND Name IN : accNameList]){
            delete_Contacts.add(con);
        }
        for(Account each_Acount : list_Accounts){
            //Prevent to create duplicate Accounts
            If(accNameList.contains(each_Acount.Name)){
                each_Acount.addError('You cannot create account with this account name. Its already existing. Please change the account name to avoid this error.\n Error from TriggerHandler_PopulateShippingAddress Before insert method.');
            }
            // Prefix Mr to the account name
            each_Acount.Name = 'Mr '+each_Acount.Name;
        }
        If(!delete_Contacts.isEmpty()){
            Delete delete_Contacts;
        }
    }
    
    
    @AuraEnabled(cacheable=true)
    public static List<Field_History__c> getAllHistories(string recordId) {
        try {
            return [SELECT Old_Value__c,New_Value__c,Tracked_Field_Label__c,LastModifiedDate, Tracked_Record_Id__c,createdDate,Is_Long_Text__c FROM Field_History__c WHERE Tracked_Record_Id__c=: recordId AND Is_Long_Text__c=False ORDER BY createdDate DESC LIMIT 100];
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching Accounts: ' + e.getMessage());
        }
    }
    
}
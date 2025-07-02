public class Account_Trigger_Handler {
    // Constructor
    public static void Account_Trigger_Handler(){
        
    }
    
    // This method will execute when the Account Record is going to insert
    public static void onBeforeInsertOperation(Map<Id,Account> triggered_Account_newMap){
        for(Account Record_Account : triggered_Account_newMap.values()){
            Record_Account.Description = Record_Account.Name + ' Description Updated';
        }
    }
    
    // This method will execute when the Account Record is going to insert
    public static void onBeforeUpdateOperation(Map<Id,Account> triggered_Account_newMap, Map<Id,Account> triggered_Account_oldMap){
        for(Account Record_Account : triggered_Account_newMap.values()){
            if(Record_Account.Create_Contact__c == false && triggered_Account_oldMap.get(Record_Account.Id).Create_Contact__c == true){
                Record_Account.addError('You cannot Modify Create Contact field.');
            }
            Record_Account.Description = triggered_Account_oldMap.get(Record_Account.Id).Description == NULL ? Record_Account.Name + ' Description Updated' : Record_Account.Description;
        }
    }
    
    // This method will execute when the Account Record updated
    public static void onAfterUpdateOperation(Map<Id,Account> triggered_Account_newMap, Map<Id,Account> triggered_Account_oldMap){
        Map<Id,Account> Map_Accounts = new  Map<Id,Account>();
        for(Account acc : [SELECT Id,Number_Of_Contacts__c,(SELECT Id,AccountId FROM Contacts) FROM Account WHERE Id IN : triggered_Account_newMap.keySet()]){
            Map_Accounts.put(acc.Id , acc);
        }
        for(Account Record_Account : triggered_Account_newMap.values()){
            Record_Account.Number_Of_Contacts__c = Map_Accounts.get(Record_Account.Id).Contacts != NULL ? Map_Accounts.get(Record_Account.Id).Contacts.Size() : 0;
        }
    }
    
    public static void createContactWhenCreateContactCheckBoxChecked(Map<Id,Account> triggered_Account_newMap, Map<Id,Account> triggered_Account_oldMap){
        List<Contact> LIST_Create_Contacts = new List<Contact>();
        for(Account acc : triggered_Account_newMap.values()){
            if(acc.Create_Contact__c == TRUE && triggered_Account_oldMap.get(acc.Id).Create_Contact__c != acc.Create_Contact__c){
                LIST_Create_Contacts.add(new Contact(
                	AccountId = acc.Id,
                    LastName = 'Contact created automatically for Account : '+acc.Name
                ));
            } 
        }
        if(!LIST_Create_Contacts.isEmpty()) INSERT LIST_Create_Contacts;
    }
 
}
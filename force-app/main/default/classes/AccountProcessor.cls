public class AccountProcessor {
	@future
    public static void countContacts(List<Id> accountIds){
        List<Account> accountToUpdate = new List<Account>();
        List<Account> accounts = [Select Id,Name,(select id from Contacts) from Account Where Id IN : accountIds];
        for(Account a : accounts){
            List<Contact> contactsList = a.Contacts;
            a.Number_Of_Contacts__c = contactsList.size();
            accountToUpdate.add(a);
        }
        update accountToUpdate;
    }
}
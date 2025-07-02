public with sharing class ContactSearch {
    public ContactSearch() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> findContacts(String conName){
        String KeyString = '%' + conName + '%';
        return [select Id,Name from Contact where Name like:KeyString];
    }
}
public class CreateContact {
@AuraEnabled
    public static Contact saveContact(Contact Contact) {
        account acc = new account();
        acc.name = Contact.FirstName +' '+ Contact.LastName;
        insert acc;
        Contact.AccountId = acc.id;
        insert Contact;
        return Contact;
    }
}
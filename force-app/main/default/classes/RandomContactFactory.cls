public class RandomContactFactory {
	public static List<contact> generateRandomContacts(Integer numCount,String lastName)
    {
        List<Contact> contactList = new List<Contact>();
        for(Integer i=1;i<=numCount;i++)
        {
            contact c = new contact(FirstName ='Test '+i, LastName = lastName);
            contactList.add(c);
        }
        return contactList;
    }
}
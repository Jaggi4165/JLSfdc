public class ContactAndLeadSearch {
	public static List<List<sObject>> searchContactsAndLeads(String names)
    {
         List<List<sObject>> searchList = [FIND :names IN ALL FIELDS RETURNING Contact(FirstName,LastName) ,Lead(FirstName,Lastname)];
        return searchList;
    }
}
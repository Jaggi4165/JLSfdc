public class PrimaryContactCheckBox {
	public static void updatePrimaryContactToInsert(list<Contact> listOfContact)
    {
        set<id> accountset = new set<id>();
        for(Contact con:listOfContact)
        {
            if(con.Primary_Contact__c=true)
            {
                accountset.add(con.AccountId);
            }
        }
    }
}
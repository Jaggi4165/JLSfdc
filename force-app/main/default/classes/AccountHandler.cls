public class AccountHandler {
    public static Account insertNewAccount(String AccName)
    {
        try 
        {
  		 	Account acct = new Account();
    		acct.Name = AccName;
    		insert acct;
            return acct;
		} 
        catch (DmlException e) 
        {
    		return null;
		}
	}
}
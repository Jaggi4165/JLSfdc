public class ApexClassForDeleteContacts {
    
         public Account acc {get;set;}
    	public List<Account> accounts {get;set;}
    public void ApexClassForDeleteContacts(){
        acc = new Account();
		accounts = new List<Account>();
    }
    public void deleteContacts (){
        delete accounts;
    }

}
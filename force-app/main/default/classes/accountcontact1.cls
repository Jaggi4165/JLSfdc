public class accountcontact1 {
    list<AccountWrapper> wraplist=new list<AccountWrapper>();
    public accountcontact1()
    {
       Map<Id, AccountWrapper> accMap=new Map<Id, AccountWrapper>();
       for(account a:[SELECT createdby.name,CreatedbyID,Account.Name,(SELECT      
                name,Contact.FirstName, Contact.LastName 
                FROM Account.Contacts) FROM Account])
       {
           AccountWrapper accWrap=accMap.get(a.CreatedBy.name);
           if (null==accWrap)
           {
              accWrap=new AccountWrapper();
              accMap.put(a.CreatedBy.name, accWrap);
              accWrap.username=a.CreatedBy.name;
           }
           accWrap.accounts.add(a);
       }
       wrapList=accMap.values();
   }
   public list<AccountWrapper> getaccounts()
   {
      return wraplist;
   }
   public class AccountWrapper
   {
      public string username {get; set;}
      public List<Account> accounts {get; set;}
      public AccountWrapper()
      {
         accounts=new List<Account>();
      }
   }
}
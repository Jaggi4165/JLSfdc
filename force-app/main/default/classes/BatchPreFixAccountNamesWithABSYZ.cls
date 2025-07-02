public class BatchPreFixAccountNamesWithABSYZ implements Database.Batchable<Account>
{ 
   public Iterable<Account> start(Database.BatchableContext info){ 
       return new List<Account>(); 
   }     
   public void execute(Database.BatchableContext info, List<Account> listOfAccounts){
       List<Account> accsToUpdate = new List<Account>();
       for(Account a : listOfAccounts)
       {
           if((a.Name).Contains('Absyz')){
               a.Name=a.Name;
               accsToUpdate.add(a); 
            }
            else {
                a.Name=a.Name+' Absyz';
                accsToUpdate.add(a); 
    	}   
       }
       update accsToUpdate; 
   }     
   public void finish(Database.BatchableContext info){     
   } 
}
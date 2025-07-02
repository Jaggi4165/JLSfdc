public class RetriveMerInvoice
{
        public String accName {get;set;}

    List<Account> lstacc = new List<Account>();
    List<contact> lstcon = new List<contact>();
    public List<contact> getContacts() {
       lstcon.clear();
       accIds.clear();
       lstacc.clear();      
       lstacc=[select id,name from Account where name=:accName];
       for(Integer i=0;i<lstacc.size();i++)
       {
           accIds.add(lstacc[i].Id);
       }
       
        lstcon =[select id,name,Phone, email,accountId from contact where accountid in : accIds];
        return lstcon;
    }
    
    set<string> accIds = new set<string>();
    public pagereference showContacts() {
       return null;        
    }
}
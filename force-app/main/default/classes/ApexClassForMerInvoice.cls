public class ApexClassForMerInvoice {

    public list<AccountContactWrapper> lstAccountContactWrapper { get; set; }
    public list<AccountContactWrapper> lstSelectedAccountContactWrapper { get; set; }
    public list<account> selectedAccounts{get;set;}   

    public ApexClassForMerInvoice () {
        lstSelectedAccountContactWrapper = new list<AccountContactWrapper>();
        if(lstAccountContactWrapper == null) {
            lstAccountContactWrapper = new list<AccountContactWrapper>();
            for(account a:[select id,name,(select id,name from contacts) from account limit 10]) {
                lstAccountContactWrapper.add(new AccountContactWrapper(a));
            }
        }
    }
 
    public void ProcessSelected() {
        lstSelectedAccountContactWrapper =new list<AccountContactWrapper>();
        selectedAccounts =new list<Account>();
        for(AccountContactWrapper wrapobj:lstAccountContactWrapper){
            if(wrapobj.isSelected==true) {
                selectedAccounts.add(wrapobj.acc);
            } 
        }
       
        for(Account acc:[select id,name,(select id,name from contacts) from account where id in:selectedAccounts]) {
            lstSelectedAccountContactWrapper.add(new AccountContactWrapper(acc)); 
        }
             
    }
    public class AccountContactWrapper {
 
        public Account acc {get;set;}
        public boolean isSelected {get;set;}
   
        public AccountContactWrapper(account a) {
            acc = a;
            isselected=false;
        }
    }

}
/*
Create a trigger to prevent an account from deleting if it has more than 3 contacts.
*/
trigger PreventDeletingIfMore3 on Account (before delete) {
    set<id> accid=new set<id>();
    for(Account a:trigger.old)
    {
        accid.add(a.id);
    }
    map<id,Account> accounts = new map<id,Account>([select id,(select id from contacts) from account where id IN : accid]);
    for(Account acc:trigger.old)
    {
        if(accounts.get(acc.id).contacts.size()>=3)
        {
            acc.addError('account records connot be deleted,It has more  than 3 records..');
        }
    }
    
}
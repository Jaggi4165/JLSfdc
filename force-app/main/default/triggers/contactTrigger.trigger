trigger contactTrigger on Contact (before insert,before update,After Insert,after delete) {
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        List<Contact> listOfContacts = [select Id,Email,Phone from Contact where Email!=null OR Phone!=null];
        for(Contact c : trigger.new){
            if(listOfContacts.size()>0){
                for(Contact cc : listOfContacts){
                    if(c.Email == cc.Email && c.Id != cc.Id && (c.Email!=null || c.Email!='')){
                        c.addError('Email is already existed . . .');
                    }
                    if(c.Phone == cc.Phone && c.Id != cc.Id && (c.Phone!=null || c.Phone=='')){
                        c.addError('Phone number is already existed . . .');
                    }
                }      
            }
        }
    }
    
    //Update the number of contacts field in account for that particular associated account
    if((trigger.isAfter && trigger.isInsert)){
        List<contact> contactList = trigger.new;
        List<Id> listOfAccIds = new List<Id>();
        for(Contact c : trigger.New){
            listOfAccIds.add(c.AccountId);
        }
        List<Account> listOfAccount = new List<Account>([select Id,Number_Of_Contacts__c,(select id,AccountId from Contacts where AccountId IN : listOfAccIds) from Account where Id IN : listOfAccIds]);
        for(Account a : listOfAccount){
            List<contact> listOfContactRecs = a.contacts;
            if(listOfContactRecs.size()>0){
                a.Number_Of_Contacts__c = listOfContactRecs.size();
            }
        }
        if(listOfAccount.size()>0){
           // update listOfAccount;
        }
        if(contactList.size()>0){
            DemoClass.updateAccountPhone(contactList);
        }
        
        
    }
    
    
    if(trigger.isAfter && trigger.isDelete){
        List<Id> listOfAccIds = new List<Id>();
        for(Contact c : trigger.old){
            listOfAccIds.add(c.AccountId);
        }
        List<Account> listOfAccount = new List<Account>([select Id,Number_Of_Contacts__c,(select id,AccountId from Contacts where AccountId IN : listOfAccIds) from Account where Id IN : listOfAccIds]);
        for(Account a : listOfAccount){
            List<contact> listOfContactRecs = a.contacts;
            if(listOfContactRecs.size()>0){
                a.Number_Of_Contacts__c = listOfContactRecs.size();
            }
        }
        if(listOfAccount.size()>0){
            update listOfAccount;
        }
    }
}
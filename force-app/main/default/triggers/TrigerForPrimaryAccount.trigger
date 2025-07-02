trigger TrigerForPrimaryAccount on Contact (before insert,before update) {
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        for(Contact c: trigger.new){
            c.Salutation = c.Gender__c == 'Male' ? 'Mr' : c.Gender__c == 'Female' ? 'Ms' : '';
        }
    }
}
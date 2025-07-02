trigger ApplicationTrigger on Applicant__c (before insert,before update) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            ApplicationTriggerHandler.beforeOperations(trigger.new,trigger.oldMap,'INSERT');
        }
        if(trigger.IsUpdate){
            ApplicationTriggerHandler.beforeOperations(trigger.new,trigger.oldMap,'UPDATE');
        }

    }
}
trigger Trigger_PopulateShippingAddress on Account (before insert,before update,after update) {
    
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        if(RecursiveTriggerHandler.isFirstTime){
            //TriggerHandler_PopulateShippingAddress.beforeInsertAndUpdate(trigger.new);
        }
        
    }
    if(trigger.isAfter && trigger.ISUPDATE){
        if(RecursiveTriggerHandler.isFirstTime){
            RecursiveTriggerHandler.isFirstTime = false;
            //TriggerHandler_PopulateShippingAddress.afterUpdate(trigger.new);
        }
    }
    
    if(trigger.isAfter && trigger.isInsert){
        //TriggerHandler_PopulateShippingAddress.afterInsert(trigger.new);
    }
}
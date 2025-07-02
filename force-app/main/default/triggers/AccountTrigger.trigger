trigger AccountTrigger on Account(
    before insert,
    after insert,
    before update,
    after update,
    before delete,
    after delete,
    after undelete
) {
    
    //new AccountTriggerHandler().run();

    //new MetadataTriggerHandler().run();
     if(trigger.isAfter && trigger.isInsert){
        TriggerHandler_PopulateShippingAddress.afterInsert(trigger.new);
    }
    
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
        AccountTriggerHandler.saveFieldHistories(Trigger.new, Trigger.oldMap);
    }
    
    
}
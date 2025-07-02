trigger Account_Trigger on Account (BEFORE INSERT, BEFORE UPDATE, BEFORE DELETE, AFTER INSERT, AFTER UPDATE) {
    // Before Contexts
    // In this context Pre populate field values in Account Object when the record is going to Insert
    IF(trigger.isBefore && trigger.isInsert){
        Account_Trigger_Handler.onBeforeInsertOperation(trigger.newMap);
    }
    
    // In this context Pre populate field values in Account Object when the record is going to Update
    IF(trigger.isBefore && trigger.isUpdate){
        Account_Trigger_Handler.onBeforeUpdateOperation(trigger.newMap, trigger.oldMap);
    }
    
    // In this context Pre populate field values in Account Object when the record is going to Update
    IF(trigger.isAfter && (trigger.isUpdate || trigger.isInsert)){
        Account_Trigger_Handler.createContactWhenCreateContactCheckBoxChecked(trigger.newMap, trigger.oldMap);
    }
}
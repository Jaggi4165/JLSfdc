trigger TCSQueNo1 on Case (after insert,after update,after delete) {
    // Before Cases gets Inserted, Updated, Deleted
    if(trigger.isBefore){
        if(trigger.isInsert){
            TCSQueNo1Handler.beforeInsertOperations(trigger.new, trigger.old);
        }
        if(trigger.isUpdate){
            TCSQueNo1Handler.beforeUpdateOperations(trigger.new, trigger.old);
        }
        if(trigger.isDelete){
            TCSQueNo1Handler.beforeDeleteOperations(trigger.new, trigger.old);
        }
        
    }
    // After Cases gets Inserted, Updated, Deleted
    if(trigger.isAfter){
        if(trigger.isInsert){
            TCSQueNo1Handler.afterInsertOperations(trigger.new, trigger.old);
        }
        if(trigger.isUpdate){
            TCSQueNo1Handler.afterUpdateOperations(trigger.new, trigger.old);
        }
        if(trigger.isDelete){
            TCSQueNo1Handler.afterDeleteOperations(trigger.new, trigger.old);
        }
    }
}
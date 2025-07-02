trigger ContactCountOnAccount on Contact (after insert,after delete,after update) {
    /*if(trigger.isAfter && trigger.isInsert){
        if(trigger.new.size()>0){
            ContactCountOnAccountHandler.updateAccountWithConSize(trigger.new);
        }
        
    }
    
    if(trigger.isAfter &&  trigger.isDelete){
        ContactCountOnAccountHandler.afterDeleteConSize(trigger.old);
    }*/
    if(trigger.isAfter && (trigger.isUpdate || trigger.isInsert)){
        ContactCountOnAccountHandler.onAfterUpdateOperation(trigger.newMap, trigger.oldMap);
        system.debug('Verified___');
    }
}
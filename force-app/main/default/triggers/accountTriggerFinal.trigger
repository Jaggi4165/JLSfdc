trigger accountTriggerFinal on Account (before insert,before update,before delete) {
    if(trigger.isBefore && trigger.isInsert){
        accountController.onBeforeInsertOperation(trigger.new);
    }
}
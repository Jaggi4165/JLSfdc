trigger roomMemberAfterupdate on Room_Member__c (after update) {
    if(trigger.isAfter && trigger.IsUpdate && trigger.new[0].Name != trigger.old[0].Name){
    List<Room_Member__c> rmNEW = [select Id,Name from Room_Member__c where Id =: trigger.new[0].Id];
    system.debug('rmNEW===> '+rmNew);
        List<Room_Member__c> rmOLD = [select Id,Name from Room_Member__c where Id =: trigger.old[0].Id];
            system.debug('rmOLD===> '+rmOLD);
      /*  trigger.new[0].Id = trigger.new[0].Id;
        if(trigger.new[0].Active__c){
                trigger.new[0].Active__c = false;
        }
        else{
                trigger.new[0].Active__c = true;
        }
        update trigger.new[0];*/
                //update new Room_Member__c(id=trigger.new[0].Id,Active__c=trigger.new[0].Active__c==true?false:true);

    }
}
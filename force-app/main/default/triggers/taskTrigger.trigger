trigger taskTrigger on Task (before delete) {
    if(trigger.isBefore && trigger.isDelete){
        List<Profile> p;
        Id profileId = UserInfo.getProfileId();
        String currentUserProfileName = [Select Id, Name from Profile where Id=: profileId].Name;
        for(Task t : trigger.old){
            if(t.OwnerId != null && currentUserProfileName !='System Administrator' ){
                t.addError('Only system adin can delete the task record.');
            }
        }
    }
}
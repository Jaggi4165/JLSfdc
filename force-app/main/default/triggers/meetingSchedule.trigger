trigger meetingSchedule on Meeting__c (after Insert,after Update) {
    list<Meeting__c> meetList= new list<Meeting__c>();
    for(Meeting__c meet:trigger.new){
        meetList.add(meet);
    }
    //AP_Meeting.sendInvite(meetList);
    //scheduleTeamsMeeting.createTeamsMeeting(String.valueOf(system.now()),30);
    //outLookIntegration.createMeeting();
   // GoogleInviteIntegration.createTeamsMeeting();
 }
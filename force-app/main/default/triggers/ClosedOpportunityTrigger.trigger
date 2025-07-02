trigger ClosedOpportunityTrigger on Opportunity (after update,after insert,before update,before insert) {
    List<Opportunity> oppListt = new List<Opportunity>();
    if(trigger.isAfter && trigger.isUpdate){
        List<Opportunity> closedWonOpps = new List<Opportunity>();
        for(Opportunity o : trigger.new){
            Opportunity opp = new Opportunity();
            opp.StageName = 'Needs Analysis';
            opp.Id = o.Id;
            if(o.StageName=='Closed Won'){
                closedWonOpps.add(o);
            }
            oppListt.add(opp);
        }
        if(closedWonOpps.size()>0){
            SlackNotifierForLeadOpp.postOppToslack(closedWonOpps);
        }
    }
    if(oppListt.size()>0){
        update oppListt;
    }
    if(trigger.isAfter && trigger.isUpdate){
        BuildingBlocksIncentiveController.incentiveRecordCreate(trigger.new,trigger.old);
    }
    
    
    if(trigger.isBefore && trigger.isInsert){
        List<Opportunity> listOfOpp = trigger.new;
        for(Opportunity opp : listOfOpp){
            opp.LeadSource = 'Web';
        }
    }
    
   
}
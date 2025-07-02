trigger DeleteCompetitorWhenOpportunityDeleted on Opportunity (before delete) {
	if(Trigger.isDelete && Trigger.isBefore)
    {
        List<Opportunity> listOfOpp = new List<Opportunity>();
        List<Id> idList = new List<Id>();
        for(Opportunity k : trigger.old)
        {
            idList.add(k.Id);
        }
        List<Competitor__c> compeRecords = new List<Competitor__c>([select Id from Competitor__c where Opportunity__c IN : idList]);
            delete compeRecords;
    }
}
global class LeadColdWarmManagementDemo implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext BC){
        
   		return Database.getQueryLocator([SELECT Id,LastModifiedDate,Warm_Cold__c from Lead]);
    }
    
    global void execute(Database.BatchableContext BC, List<Lead> scope){
        System.debug('Leads : '+scope);
        List<Lead> newLeadList = new List<Lead>();
		if(scope.size() > 0){
         for(Lead l : scope)
         {
             Date d1 = l.LastModifiedDate.Date();
		     Date d2 = System.now().Date();
             Integer numberofDays = d1.daysBetween(d2);
             System.debug('LastModifiedDate : '+d1);
             System.debug('Todat : '+d2);
             System.debug('Differ : '+numberofDays);
             if(numberofDays > 60 ){
                 l.Warm_Cold__c = 'Warm';
                 newLeadList.add(l);
             }
             else
                 l.Warm_Cold__c = 'Cold';
                 newLeadList.add(l);
         }
            update newLeadList;
        }
    }
    
    global void finish(Database.BatchableContext BC){
       
    }
}
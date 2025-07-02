global class LeadAssignAfter48BHDemo implements Database.Batchable<sObject>{
 
    
   global Database.QueryLocator start(Database.BatchableContext BC){
       
      return Database.getQueryLocator([SELECT Id,Owner.name FROM Lead]);
   }
 
   global void execute(Database.BatchableContext BC, List<Lead> scope){
       System.debug('upto here code is correct line:9');
       //get the businessHours ID
       Id businessHourId = [SELECT Id FROM BusinessHours WHERE name = 'LeadOwnerReAssignAfter48BH'].id;
      
     	for(Lead l : scope){
     		Datetime createtime = system.now();
            Datetime targetDT = BusinessHours.add(businessHourId,createtime, 48* 60 * 60 * 1000L);
            if(!(BusinessHours.isWithin(businessHourId, targetDT))){
           		l.Rating = 'Cold';
       		}
                   
     	}
       System.debug('upto here code is correct line:21');
     	update scope;
       System.debug('upto here code is correct line:23');
    }
 
   global void finish(Database.BatchableContext BC){
       //Send an Email alert to thr Lead Owner who recently get assigned.
       System.debug('upto here code is correct finish method');
   }
}
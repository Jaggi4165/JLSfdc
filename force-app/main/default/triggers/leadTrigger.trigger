trigger leadTrigger on Lead (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        List<Lead> convertedLeads = new List<Lead>();
        for(Lead l : trigger.new){
            if(l.Status=='Closed - Converted'){
                convertedLeads.add(l);
            }
        }
        if(convertedLeads.size()>0){
        	SlackNotifierForLeadOpp.postToslack(convertedLeads);
        }
    }
}
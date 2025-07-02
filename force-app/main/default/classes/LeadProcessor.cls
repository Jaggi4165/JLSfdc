global class LeadProcessor implements Database.Batchable<sObject> {
    global Integer count = 0;
    global Database.queryLocator start(Database.BatchableContext bc){
        return database.getQueryLocator('SELECT Id,LeadSource FROM Lead LIMIT 2');
    }
    
    global void execute(Database.BatchableContext bc , List<Lead> List_LeadRecords){
        List<Lead> updateLeadList = new List<Lead> ();
        for(Lead leadRecord : List_LeadRecords){
            leadRecord.LeadSource = 'Dreamforce';
            count = count + 1;
            updateLeadList.add(leadRecord);
        }
        update updateLeadList;
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Total Number of records processed : '+count);
    }
}
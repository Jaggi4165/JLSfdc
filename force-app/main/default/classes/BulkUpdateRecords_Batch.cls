global class BulkUpdateRecords_Batch implements Database.Batchable<sObject> {
    public string objectAPI, fieldAPI, valueTOupdate;
    public  BulkUpdateRecords_Batch(string objectAPI,string fieldAPI,string valueTOupdate){
        this.objectAPI=objectAPI;
        this.fieldAPI=fieldAPI;
        this.valueTOupdate=valueTOupdate;
 		System.debug('in constructor');
    }
    
    global Database.QueryLocator start( Database.BatchableContext BC ) {
        String query = 'SELECT Id,'+fieldAPI+' FROM '+objectAPI;
        System.debug('in start method');
        return Database.getQueryLocator( query );
        
    }
    
    global void execute( Database.BatchableContext BC, List< sObject > scope ) {
        List< sObject > sObjectRecordsToUpdate = new List< sObject >();
        for ( sObject rec : scope ){
            rec.put(fieldAPI,valueToUpdate);
            sObjectRecordsToUpdate.add(rec);
        }
        System.debug('in execute method');
        update sObjectRecordsToUpdate;
       
    }   
    global void finish( Database.BatchableContext BC ) {
        
    }
    
}
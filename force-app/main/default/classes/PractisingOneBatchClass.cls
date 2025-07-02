//this Batch is to process all the accounts if the AreaNumber__c is grater than 100
//update accounts description to  Your amount is grater than 100.
//,Database.Stateful

global class PractisingOneBatchClass implements Database.Batchable<sObject>,Schedulable,Database.Stateful{
    
    public static Integer processedRecordsCount;
    
    public void PractisingOneBatchClass(){
        processedRecordsCount = 0;
    } 
    //Fetch all the accounts whose amount is grated than 100
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT ID,Name,AreaNumber__c,Description FROM Account WHERE AreaNumber__c>100 with USER_MODE';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext Bc, List<Account> accounts){

        for(Account acc : accounts){
            if(acc.AreaNumber__c>100){
                acc.Name = acc.Name + ' : Updated by Batch job 1710';
                acc.Description = 'Your Account Amount is Exceeded 100 on 17/10/2023';
            }
            //processedRecordsCount = processedRecordsCount+1;
        }
        try{
            update accounts;
        }
        catch(Exception e){
            system.debug('Exception ===> '+e);
        }
       
    } 
    
    global void finish(Database.BatchableContext Bc){
        
        System.debug('Total Records involved in this Batch transaction : '+processedRecordsCount);
        
    }
    
    global void execute(SchedulableContext sc){
        
        PractisingOneBatchClass pobc = new PractisingOneBatchClass();
        Database.executeBatch(pobc,5);
        
    }
    
    
}
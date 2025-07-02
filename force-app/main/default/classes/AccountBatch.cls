global class AccountBatch implements Database.batchable<sobject>,Database.stateful {
    global Integer ProcessedRecordsCount = 0;
    global Database.QueryLocator start(Database.BatchableContext BC){
        string query = 'SELECT Id,Start_Date__c,End_Date__c,Name FROM ACCOUNT WHERE Start_Date__c < Today OR Start_Date__c=NULL';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC,List<Account> scope){
        List<Account> list_Accounts_To_Update = new List<Account>();
        for(Account account : scope){
            account.Rating = 'Hot';
            list_Accounts_To_Update.add(account);
        }
        if(!list_Accounts_To_Update.isEmpty()){
            Database.update(list_Accounts_To_Update,true);
            ProcessedRecordsCount += list_Accounts_To_Update.size();
        } 
    }
    
    global void finish(Database.BatchableContext BC){
        System.debug('Total Records Processed ===> '+ProcessedRecordsCount);
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new string[] {'jagadeeswararao.kusumuru@absyz.com','kusumuru705@gmail.com'};
        message.subject = ProcessedRecordsCount+' Account Records Updated to Rating - Hot';
        String messageBody = '<html><body>'+
            					'Hi '+UserInfo.getName()+', <br/><br/> '+
            				 	ProcessedRecordsCount+' Account Records Updated Successfully.<br/><br/><br/><br/>' +
            					'Thanks & Regards <br/> Account Team.'+
            				'</body></html>';
        message.setHtmlBody(messageBody); 
        message.plainTextBody = 'Hi,'+UserInfo.getName()+' ! Total Number of account records processed : '+ProcessedRecordsCount;
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '+ results[0].errors[0].message);
        }
	}
}
/*
Create a trigger which will not allow users to delete Invoice records when status is Closed. Use a
custom error message.
*/
trigger InvoiceRecordNotDeleteIfClosed on Invoice__c (before delete) {
	for(Invoice__c k:trigger.old){
        if(k.status__c=='Closed'){
           k.addError('You cannot delete this Invoice due to its status is closed');
        }
    }
}
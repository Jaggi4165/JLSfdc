public with sharing class ApplicationTriggerHandler {
    public ApplicationTriggerHandler() {

    }
    public static void beforeOperations(List<Applicant__c> ApplicantNewRecords, Map<Id,Applicant__c> ApplicantOldRecords, String Operation){
        for(Applicant__c applicant : ApplicantNewRecords){
            if(Operation == 'INSERT'){
                applicant.Type_Of_Loan__c = 'Personal Loan';
            }
            else if(Operation == 'Update'){
                
            }
        }
    }
}
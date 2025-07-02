@isTest
private class DailyLeadProcessorTest {
    public static string CRON_EXP = '0 0 0 1 11 ? 2023';
    static testmethod void testScheduledJob(){ 
        List<Lead> leads = new List<Lead>();
        for (Integer i=0; i<200; i++){
            Lead l = new Lead(FirstName = 'First ' + i, 
                LastName = 'LastName',
                Company = 'The Inc' ) ; 
            leads.add(l); 
        } 
        insert leads; 
        Test.startTest(); 
        String jobId = System.schedule( 'ScheduledApexTest', CRON_EXP, new DailyLeadProcessor()); 
        Test.stopTest(); 
        List<Lead> checkleads = new List<Lead>(); 
        checkleads = [Select Id From Lead Where LeadSource = 'Dreamforce' and Company = 'The Inc']; 
        System.assertEquals(200, checkleads.size(), 'Leads were not created'); 
    }
}
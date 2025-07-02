@isTest
public class LeadProcessorTest {
	@isTest
    public static void testit(){
        List<Lead> List_LeadRecords = new List<Lead>();
        for(Integer i = 0 ; i < 200 ; i++){
            Lead leadRec = new Lead();
            leadRec.LastName = 'BatchClass : '+i;
            leadRec.Company = 'ABSYZ : '+i;
            leadRec.Status = 'Qualified';
            List_LeadRecords.add(leadRec);
        }
        if(List_LeadRecords.size()>0){
            insert List_LeadRecords;
        }
        test.startTest();
        LeadProcessor Instance_LeadProcessor = new LeadProcessor();
        Id jobId = Database.executeBatch(Instance_LeadProcessor);
        test.stopTest();
    }
}
@IsTest
public class TaskUtilTests {
    
    @IsTest
    public static void testGetTaskPriorityNormal(){
        Test.startTest();
        string a = TaskUtil.getTaskPriority('KA');
        Test.stopTest();
        Assert.areEqual(a,'Normal');
    }
    
    @IsTest
    public static void testGetTaskPriorityHigh(){
        Test.startTest();
        string a = TaskUtil.getTaskPriority('CA');
        Test.stopTest();
        Assert.areEqual(a,'High');
    }
	
}
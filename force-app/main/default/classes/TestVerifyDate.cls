@isTest 
public class TestVerifyDate
{
    static testMethod void testMethodOne() 
    {
        Date d = VerifyDate.CheckDates(System.today(),System.today()+1);
        Date dOne = VerifyDate.CheckDates(System.today(),System.today()+60);
        Date dTwo = VerifyDate.CheckDates(System.today(),System.today()-60);
    }
}
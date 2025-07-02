/**
 * AsyncQueuableExample Class is a Queuable class where we going to insert Account Records
 *
 * @author			:	Jagadeeswara Rao Kusumuru
 * @version  		:	1.0	
 * @description		:	
 * @testedIn  		:
 * @uses 			:
 * @code 			:
 * @history
 * 05-07-2024 		:	Created	:	Jagadeeswara Rao Kusumuru
 */
public class AsyncQueuableExample implements Queueable {
	public void execute(QueueableContext context) {
        Account a = new Account(Name='Jagadeeswar Account From Queuable Class',Phone='(415) 555-1212');
        try{
            insert a; 
        }
        catch(Exception e){
            Error_Log__c err = new Error_Log__c();
            err.Error_Type__c = 'AsyncQueuableExample.execute()';
            err.Error_Message__c = e.getMessage();
            err.Error_StackTrace__c = e.getStackTraceString();
            err.Error_Line__c = e.getLineNumber();
            Insert err;
            System.debug('Exception : '+ e.getMessage());
        }
               
    }
}
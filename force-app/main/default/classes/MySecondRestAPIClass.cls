@RestResource(urlMapping='/api/Accounts/*')
global class MySecondRestAPIClass {
	@HttpGet
    global static List<Account> doGetList(){
        RestRequest rep = RestContext.request;
        RestResponse res = RestContext.response;
        List<Account> accList = [SELECT Id,Name,Start_Date__c FROM Account Where Start_Date__c != NULL LIMIT 200];
        Return accList;
    }
}
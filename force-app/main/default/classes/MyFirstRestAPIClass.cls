@RestResource(urlMapping='/api/Account/*')
global with sharing class MyFirstRestAPIClass
{
    @HttpGet
    global static Account doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String AccId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone,Start_Date__c,End_Date__c, Website FROM Account WHERE Id =: AccId ];
        return result;
    }

    @HttpDelete
    global static void doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String AccNumber = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :AccNumber ];
        delete result;
    }

    @HttpPost
    global static String doPost(String name,String phone,String AccountNumber ) {
        Account acc = new Account();
        acc.name= name;
        acc.phone=phone;
        //acc.AccountNumber =AccountNumber ;
        insert acc;
        return acc.id;
    }

}
public with sharing class DogAPIController {
    
    public static String continuationLabel{get;set;}
    public static String result {get;set;}
    
    @AuraEnabled(continuation=true cacheable=true)
    public static object fetchRandomDog() {
        
        Continuation con = new Continuation(40);
        con.continuationMethod='processResponse';
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Dog_API');
        request.setMethod('GET');
        
        continuationLabel = con.addHttpRequest(request);
        
        return con;
    }
    
    @AuraEnabled(cacheable=true)
    public static Object processResponse(List<String> labels, Object state) {
        // Get the response by using the unique label
        HttpResponse response = Continuation.getResponse(labels[0]);
        // Set the result variable
        String result = response.getBody();
       // System.debug('result is---'+result);
        return result;
    }
}
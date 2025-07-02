@isTest
private class Test_ApexContinuation {
    // Case 1: Valid HttpRequest using a Continuation
    @IsTest 
    private static void testDogAPIControlletApexClass() {
        
        String exResponseBody = '{"status:success"}';
        
        Test.startTest();
        Continuation con = (Continuation)DogAPIController.fetchRandomDog();
        Test.stopTest();
        
        // Verify that the continuation has the correct number of requests
        Map<String, HttpRequest> requests = con.getRequests();
        System.assertEquals(1, requests.size(), 'The number of requests associated to the Continuation is not correct');
        
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setBody(exResponseBody);
        
        Test.setContinuationResponse(DogAPIController.continuationLabel, response);
        
        List<String> labels = new List<String>{DogAPIController.continuationLabel};
            
            String result = (String)DogAPIController.processResponse(labels,DogAPIController.result);
        
        System.assertEquals(true, result.contains(exResponseBody), 'Continuation failed: response body not valid');
        System.assertEquals(true,result.contains('{"status:success"}'));
    }
}
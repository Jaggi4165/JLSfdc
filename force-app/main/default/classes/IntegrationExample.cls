public class IntegrationExample {
    // Replace with your actual values
    private static final String CLIENT_ID = '3MVG9n_HvETGhr3Av96QgNQFBBGcVxAxXjqnYqxoVidMphLyTUSQbsQaZgQ39265MpwV7QX2Cs3ycZeIcv20D';
    private static final String CLIENT_SECRET = '86CACC8312EE5FFEA951F2E006D8AFAC4A67E95098B6ED0B11E0BB339EE5D1A8';
    /*private static final String USERNAME = 'devorghg@hg.com';
private static final String PASSWORD = 'Jagadeesh@1';*/
    private static final String TOKEN = 'your_security_token';
    private static final String GRANT_TYPE = 'client_credentials';
    private static final String API_VERSION = '52.0';
    private static final String BASE_URL = 'https://harikaglamnationvizag-dev-ed.develop.my.salesforce.com/services/data/v' + API_VERSION + '/';
    
    @auraenabled
    public static string createRecords(string name) {
        // Get the access token
        String accessToken = getAccessToken();
        String instanceURL = 'https://harikaglamnationvizag-dev-ed.develop.my.salesforce.com';
        if (accessToken != null) {
            // Create the HTTP request
            HttpRequest request = new HttpRequest();
            request.setEndpoint(instanceURL + '/services/data/v57.0/sobjects/Integration_Records__c');
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Authorization', 'Bearer ' + accessToken);
            
            // Set the request body with the record data
            Cl1 c = new Cl1();
            c.Name = name;
            
            String requestBody = JSON.serialize(c);
            System.debug('requestBody==>'+requestBody);
            request.setBody(requestBody);
            
            // Send the HTTP request
            HttpResponse response = new Http().send(request);
            
            // Handle the response
            if (response.getStatusCode() == 201) {
                // Record created successfully
                System.debug('Record created successfully');
                return 'success';
            } else {
                // Error in creating the record
                System.debug('Error creating record: ' + response.getBody());
                return 'fail';
            }
        }
        else{
            return 'fail';
        }
    }
    
    private static String getAccessToken() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://harikaglamnationvizag-dev-ed.develop.my.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        // Set the request body with the authentication parameters
        String requestBody = 'client_id=' + EncodingUtil.urlEncode(CLIENT_ID, 'UTF-8');
        requestBody += '&client_secret=' + EncodingUtil.urlEncode(CLIENT_SECRET, 'UTF-8');
        requestBody += '&grant_type=' + EncodingUtil.urlEncode(GRANT_TYPE, 'UTF-8');
        /*requestBody += '&username=' + EncodingUtil.urlEncode(USERNAME, 'UTF-8');
requestBody += '&password=' + EncodingUtil.urlEncode(PASSWORD + TOKEN, 'UTF-8');*/
        request.setBody(requestBody);
        
        // Send the HTTP request
        HttpResponse response = new Http().send(request);
        
        // Parse the response and get the access token
        if (response.getStatusCode() == 200) {
            Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            return (String) jsonResponse.get('access_token');
        } else {
            // Error in getting the access token
            System.debug('Error getting access token: ' + response.getBody());
            return null;
        }
    }
    
    class Cl1 {
        public String Name;
    }
    
    //IntegrationExample.atestMethod();
    public static void atestMethod(){
        
        List<Database.SaveResult> saveResults= new list<Database.SaveResult>();
        try {
            account a = new account();
            a.name = '';
            //insert a;
            account b = new account();
            b.name = 'jaggu Bhai';
            List<account> aList = new List<account>();
            aList.add(a);
            aList.add(b);
            System.debug('After tay block:::2');
             saveResults = Database.insert(aList, false);
            
        } catch (Exception e) {
            System.debug('Exception'+e.getMessage());
        }
        System.debug('After tay block:::1'+saveResults);
        /*account a = new account();
a.name = '';
//insert a;
account b = new account();
b.name = 'jaggu Bhai';
List<account> aList = new List<account>();
aList.add(a);
aList.add(b);
System.debug('After tay block:::2');
List<Database.SaveResult> saveResults = Database.insert(aList, false);*/
        
        //system.debug('After true block:::'+saveResults);
    }
}
public class scheduleTeamsMeetingHandler {
    private static final String CLIENT_ID = '328c45e5-f833-4ba6-a9d7-d8fef2038242';   //Application (Client) Id after app register
    private static final String CLIENT_SECRET = 'KzJ8Q~dOvswPmlzD.Fnku1VAbuVzO3fPnPM_-ctj';  // Value in certificates/secrets
    private static final String REDIRECT_URI = 'https://absyz-11e-dev-ed.lightning.force.com/oauth_callback';
     
    public static String exchangeAuthorizationCodeForAccessToken() {
        
        String tenantId = 'd3a45221-5971-4fbb-b845-4e89b210b31f'; //we can get it from the registered app in the azure.
        
        String authEndpoint = 'https://login.microsoftonline.com/' + tenantId + '/oauth2/v2.0/token';
        String authUrl = 'grant_type=client_credentials&scope=https%3a%2f%2fgraph.microsoft.com%2f.default&client_id='+CLIENT_ID+'&client_secret=' +CLIENT_SECRET;
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(authEndpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setBody(authUrl);
        
        HttpResponse response = new Http().send(request);
        if (response.getStatusCode() == 200) {
            Map<String, Object> responseData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            System.debug('access token===> '+(String) responseData.get('access_token'));
            return (String) responseData.get('access_token');
        } else {
            string error = 'Error getting access token: ' + response.getStatusCode() + ' - ' + response.getStatus();
            return error;
        }
        
    }
    
}
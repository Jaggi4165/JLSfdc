public class outLookIntegration {
    @future (callout=true)
    public static void createMeeting() {
        // Define the Microsoft Graph API endpoint for creating a meeting
        String endpoint = 'https://graph.microsoft.com/v1.0/users/kusumuru4165_gmail.com#EXT#@kusumuru4165gmail.onmicrosoft.com/onlineMeetings';

        // Define the JSON payload for the meeting creation
        String requestBody = '{"startDateTime": "2023-08-24T14:00:00.0000000", "endDateTime": "2023-08-24T15:00:00.0000000"}';

        // Make the HTTP request to create the meeting
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + getAccessToken()); // Get the access token from your authentication
        request.setHeader('Content-Type', 'application/json');
        request.setBody(requestBody);

        Http http = new Http();
        HttpResponse response = http.send(request);

        // Handle the response
        if (response.getStatusCode() == 201) {
            // Meeting created successfully
            System.debug(response.getBody());
        } else {
            // Meeting creation failed
            System.debug('Error creating Teams meeting: ' + response.getBody());
        }
    }

    private static String getAccessToken() {
        String accessToken = scheduleTeamsMeetingHandler.exchangeAuthorizationCodeForAccessToken();
        return accessToken;
    }
}
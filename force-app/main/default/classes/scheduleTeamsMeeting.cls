public class scheduleTeamsMeeting {
    // Create a Teams meeting
    @future (callout=true)
    public static void createTeamsMeeting(String startDateTime, Integer durationInMinutes) {
        
        String meetingId = '';
        
        String requestBody = '{' +
            '"subject": "Test - Meeting with Manas",' +
            '"start": {' +
            '"dateTime": "2023-08-25T10:00:00",' +
            '"timeZone": "IST"' +
            '},' +
            '"end": {' +
            '"dateTime": "2023-08-25T11:00:00",' +
            '"timeZone": "IST"' +
            '},' +
            '"location": {' +
            '"displayName": "Conference Room"' +
            '},' +
            '"body": {' +
            '"contentType": "Text",' +
            '"content": "Discuss project updates."' +
            '},' +
            '"attendees": [' +
            '{' +
            '"emailAddress": {' +
            '"address": "manaspratapb@outlook.com",' +
            '"name": "Manas"' +
            '},' +
            '"type": "Required"' +
            '}' +
            ']' +
            '}';
        
        
        /*Map<String, Object> requestBody = new Map<String, Object>{
            'startDateTime' => startDateTime,
                'endDateTime' => calculateEndDateTime(startDateTime, durationInMinutes),
                'subject' => 'Salesforce Meeting',
                'attendees' => attendeesList
                //'isOnlineMeeting'=> true,
                //'onlineMeetingProvider' => 'teamsForBusiness'                
                };
                    system.debug('req body'+requestBody);*/
        //kusumuru4165_gmail.com#EXT#@kusumuru4165gmail.onmicrosoft.com
        String endpointUrl = 'https://graph.microsoft.com/v1.0/users/calender/events';
        //kusumuru4165gmail.onmicrosoft.com
        String token1 = scheduleTeamsMeetingHandler.exchangeAuthorizationCodeForAccessToken();
        system.debug('token in scheduleteamsmeeting class === > '+token1);
        
        // Create and execute HTTP request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpointUrl);
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + token1);
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        //request.setBody(JSON.serialize(requestBody));
        request.setBody(requestBody);
        
        HttpResponse response = new Http().send(request);
        
        if (response.getStatusCode() == 201) {
            Map<String, Object> responseData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            meetingId = (String) responseData.get('id');
        } else {
            System.debug('Error creating Teams meeting: ' + response.getBody());
        }
        
        System.debug('meetingId===>'+ meetingId);
    }
    
    // Calculate end date and time based on start time and duration
    private static String calculateEndDateTime(String startDateTime, Integer durationInMinutes) {
        Datetime startTime = Datetime.valueOfGmt(startDateTime);
        Datetime endTime = startTime.addMinutes(durationInMinutes);
        return endTime.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
    }
}
public class GoogleInviteIntegration {
       
        //@future (callout=true)
        public static void createTeamsMeeting(String refreshToken, String accesstoken){
            //String refreshToken = refreshToken; //'1//0e38oKtoihMrbCgYIARAAGA4SNwF-L9Ir30OECCU5eHUKV__edZftoZVBm4FE7zoXw5bBjHhJxHQT6Lp2iD74SFOeo-qSDupS9PU'; //generateRefreshToken();
            String consumerKey = '1072626927972-tdovhl5m0ijpn5b5n4i66p880j9vqhh9.apps.googleusercontent.com';
            String clientSecret = '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';
            String calenderInvitationCopy = 'manaspratapb@outlook.com';
            //String accessToken ;
            
            Http http = new Http();
            HttpRequest httpReq = new HttpRequest();
            HttpResponse httpRes = new HttpResponse();
            httpReq.setEndpoint('https://www.googleapis.com/oauth2/v4/token');
            httpReq.setMethod('POST');
            httpReq.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            
            
            String refreshTokenBody = 'client_id='+consumerKey+'&client_secret='+clientSecret+'&refresh_token='+refreshToken+'&grant_type=refresh_token';
            
            
            httpReq.setBody(refreshTokenBody);
            
            try{
                httpRes = http.send(httpReq);
                system.debug(httpRes.getBody());
                if(httpRes.getStatusCode() == 200){
                    Map<String,object> TokenInfo = (Map<String,object>)JSON.deserializeUntyped(httpRes.getBody());
                    String accesstoken1=String.valueOf(TokenInfo.get('access_token'));
                    system.debug('access token===>'+accesstoken1);
                    if(accessToken != null){
                        String Summary2 = 'Summary';
                        /*String[] allotmentStartTime = String.valueOf(allotment.Allotment_Start_Time__c).split(' ');
                        String[] allotmentEndTime = String.valueOf(allotment.Allotment_End_Time__c).split(' ');
                        String startTime = allotmentStartTime[0]+'T'+allotmentStartTime[1]+'+05:30';
                        String endTime = allotmentEndTime[0]+'T'+allotmentEndTime[1]+'+05:30';*/
                        String startTime = '2023-08-29T011:30:00-05:30'; //2023-8-29T10:00:00.000-07:15';
                        String endTime = '2023-08-29T011:30:00-05:30'; //'2023-8-29T10:00:00.000-07:30';
                        String descrip = 'This is the event to ask you to join the Allotment Event';
                        String location = 'Hyderabad'; //allotment.SessionLocation__c;
                        String createEventEndPoint = 'https://www.googleapis.com/calendar/v3/calendars/primary/events'; //?sendNotifications=true
                        String attendees='{"email":'+'"'+'kusumuru4165@gmail.com'+'"}';
                        
                        
                        String createEventBody = '{' +
                            '"attendees": ['+attendees+'],'+
                            '"end": {'+
                            '"dateTime": '+'"'+endTime+'"'+
                            '},'+
                            '"reminders": {'+
                            '"useDefault": true'+
                            '},'+
                            '"start": {'+
                            '"dateTime": '+'"'+startTime+'"'+
                            '},'+
                            '"summary":'+'"'+Summary2+'"'+','+
                            
                            '"calendarId": "primary",'+
                            
                            '"conferenceData": {'+
                            '"createRequest": {'+
                            '"conferenceSolutionKey": {'+
                            '"type": "hangoutsMeet"'+
                            '},'+ 
                            '}'+
                            '},'+
                            '"description":'+'"'+descrip+'"'+','+
                            '"location":'+'"'+location+'"'+
                            '}';
                        Http http2 = new Http();
                        HttpRequest httpReq2 = new HttpRequest();
                        httpResponse httpRes2 = new HttpResponse();
                        httpReq2.setEndpoint(createEventEndPoint);
                        httpReq2.setMethod('POST');
                        httpReq2.setBody(createEventBody);
                        system.debug(createEventBody);
                        httpReq2.setHeader('Content-Type', 'application/json');
                        httpReq2.setHeader('Accept', 'application/json');
                        httpReq2.setHeader('Authorization','Bearer '+accessToken1);
                        
                        try{
                            httpRes2 = http2.send(httpReq2);
                            if(httpRes2.getStatusCode() == 200){
                                system.debug('Calendar Event Successfully '+'\n'+' '+ HttpRes2.getBody()+'\n');
                                String responseBody = httpRes2.getBody();
                                
                                Map<String,Object> results = (Map<String,Object>)JSON.deserializeUntyped(responseBody);
                                String responseid =String.valueOf(results.get('id'));
                                System.debug('Meeting Id===>'+responseid);
                            }
                            else{
                                system.debug('httpRes2.getStatusCode()==>'+httpRes2.getStatusCode());
                            }
                        }
                        catch(System.Exception e){
                            system.debug('error 1 ===>'+e);
                        }
                    }
                    else{
                        system.debug('access token null');
                    }
                } 
                
            }
            catch(System.Exception e){
                system.debug('error 2 ===>'+e);
            }
        }
}




//=====================================Original
/*
 * public class GoogleInviteIntegration {
    
    public static void generateRefreshToken(){
        String consumerKey = '1072626927972-tdovhl5m0ijpn5b5n4i66p880j9vqhh9.apps.googleusercontent.com';
        String clientSecret = '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';
        String refresh_Token;
        Http http = new Http();
        HttpRequest httpReq = new HttpRequest();
        HttpResponse httpRes = new HttpResponse();
        String redirect_uri = 'login.salesforce.com';
        httpReq.setEndpoint('https://www.googleapis.com/oauth2/v4/token');
        httpReq.setMethod('POST');
        httpReq.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        String refreshTokenBody1 = '&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcalendar' +
        '&response_type=code&grant_type=authorization_code&access_type=offline&client_id='+consumerKey+'client_secret'+clientSecret+'&redirect_uri='+redirect_uri;
        httpReq.setBody(refreshTokenBody1);
        try{
            httpRes = http.send(httpReq);
            system.debug(httpRes.getBody());
            if(httpRes.getStatusCode() == 200){
                Map<String,object> TokenInfo = (Map<String,object>)JSON.deserializeUntyped(httpRes.getBody());
                refresh_Token=String.valueOf(TokenInfo.get('refresh_token'));
                system.debug('refresh token===>'+refresh_Token);
            }
        }
        catch(System.Exception e){
              system.debug('error==>'+e);  
        }
    }      
        @future (callout=true)
        public static void createTeamsMeeting(){
            //List<GoogleCalenderInfo__c> GoogleInfo = new List<GoogleCalenderInfo__c>();
            //GoogleInfo = GoogleCalenderInfo__c.getAll().values();
            String refreshToken;
            String consumerKey = '1072626927972-tdovhl5m0ijpn5b5n4i66p880j9vqhh9.apps.googleusercontent.com';
            String clientSecret = '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';
            String calenderInvitationCopy = 'manaspratapb@outlook.com';
            String accessToken;
            
            Http http = new Http();
            HttpRequest httpReq = new HttpRequest();
            HttpResponse httpRes = new HttpResponse();
            httpReq.setEndpoint('https://www.googleapis.com/oauth2/v4/token');
            httpReq.setMethod('POST');
            httpReq.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            
            
            String refreshTokenBody = 'client_id='+consumerKey+'&client_secret='+clientSecret+'&refresh_token='+refreshToken+'&grant_type=refresh_token';
            //String refreshTokenBody = 'grant_type=client_credentials&client_id='+consumerKey+'&client_secret='+clientSecret;
            
            httpReq.setBody(refreshTokenBody);
            
            try{
                httpRes = http.send(httpReq);
                system.debug(httpRes.getBody());
                if(httpRes.getStatusCode() == 200){
                    Map<String,object> TokenInfo = (Map<String,object>)JSON.deserializeUntyped(httpRes.getBody());
                    accesstoken=String.valueOf(TokenInfo.get('access_token'));
                    system.debug('access token===>'+accesstoken);
                    if(accessToken != null){
                        String Summary2 = 'Summary';
                        /*String[] allotmentStartTime = String.valueOf(allotment.Allotment_Start_Time__c).split(' ');
                        String[] allotmentEndTime = String.valueOf(allotment.Allotment_End_Time__c).split(' ');
                        String startTime = allotmentStartTime[0]+'T'+allotmentStartTime[1]+'+05:30';
                        String endTime = allotmentEndTime[0]+'T'+allotmentEndTime[1]+'+05:30';*/
                       /* String startTime = String.valueOf(system.now());
                        String endTime = String.valueOf(system.now().addMinutes(30));
                        String descrip = 'This is the event to ask you to join the Allotment Event';
                        String location = 'Hyderabad'; //allotment.SessionLocation__c;
                        String createEventEndPoint = 'https://www.googleapis.com/calendar/v3/calendars/primary/events?sendNotifications=true';
                        String attendees='{'+'"email":'+'"'+'kusumuru4165@gmail.com'+'"'+'},{'+'"email":'+'"'+calenderInvitationCopy+'"'+'}';
                        String createEventBody = '{' +
                            '"attendees": ['+attendees+'],'+
                            '"end": {'+
                            '"dateTime": '+'"'+endTime+'"'+
                            '},'+
                            '"reminders": {'+
                            '"useDefault": true'+
                            '},'+
                            '"start": {'+
                            '"dateTime": '+'"'+startTime+'"'+
                            '},'+
                            '"summary":'+'"'+Summary2+'"'+','+
                            
                            '"calendarId": "primary",'+
                            
                            '"conferenceData": {'+
                            '"createRequest": {'+
                            '"conferenceSolutionKey": {'+
                            '"type": "hangoutsMeet"'+
                            '},'+
                            '"requestId": "7qxalsvy0exxajf"'+  
                            
                            '}'+
                            '},'+
                            '"description":'+'"'+descrip+'"'+','+
                            '"location":'+'"'+location+'"'+
                            '}';
                        Http http2 = new Http();
                        HttpRequest httpReq2 = new HttpRequest();
                        httpResponse httpRes2 = new HttpResponse();
                        httpReq2.setEndpoint(createEventEndPoint);
                        httpReq2.setMethod('POST');
                        httpReq2.setBody(createEventBody);
                        system.debug(createEventBody);
                        httpReq2.setHeader('Content-Type', 'application/json');
                        httpReq2.setHeader('Authorization','Bearer '+accessToken);
                        
                        try{
                            httpRes2 = http2.send(httpReq2);
                            if(httpRes2.getStatusCode() == 200){
                                system.debug('Calendar Event Successfully '+'\n'+' '+ HttpRes2.getBody()+'\n');
                                String responseBody = httpRes2.getBody();
                                
                                Map<String,Object> results = (Map<String,Object>)JSON.deserializeUntyped(responseBody);
                                String responseid =String.valueOf(results.get('id'));
                                String eventAssignee = 'Jagadeeswar'; //System.label.EventAssigned;
                                User u = [Select Id from User where Email =:eventAssignee order by CreatedDate limit 1];
                                /*Event facultyAllotmentEvent = new Event();
                                facultyAllotmentEvent.Subject = 'subject';
                                facultyAllotmentEvent.OwnerId = u.Id;
                                facultyAllotmentEvent.StartDateTime = startTime ; //allotment.Allotment_Start_Time__c;
                                facultyAllotmentEvent.EndDateTime = endTime; //allotment.Allotment_End_Time__c;
                                facultyAllotmentEvent.WhatId = 'JagadeeswaraRao'; //facultyAllotment.Faculty_Name__c;
                                facultyAllotmentEvent.GoogleEventId__c = responseid;
                                //facultyAllotmentEvent.Execed_Session__c = allotment.id;
                                facultyAllotmentEvent.Location = 'Hyderabad'; //allotment.SessionLocation__c;
                                insert facultyAllotmentEvent;*/
                              /*  System.debug('Meeting Id===>'+responseid);
                            }
                        }
                        catch(System.Exception e){
                            
                        }
                    }
                }   
            }
            catch(System.Exception e){
                
            }
        }
    }
*/
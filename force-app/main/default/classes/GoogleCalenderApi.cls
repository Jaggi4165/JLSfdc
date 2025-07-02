public class GoogleCalenderApi {
		
		public static Boolean isAccessToken { get; set; }
		
		// Your CLient ID Here
		public Final static String consumerKey='1072626927972-tdovhl5m0ijpn5b5n4i66p880j9vqhh9.apps.googleusercontent.com';
		// Your Client Secret Here
		public Final static String clientSecret='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';
		
		public static String googleoAuthUrl='https://accounts.google.com/o/oauth2/auth?'; 
		// Your redirect URI here that you entered while creating the App in Google API console
		public static String redirect_uri = 'https://absyz-11e-dev-ed--c.vf.force.com/apex/googleInvetePage'; //System.Label.googleRedirectUrl;
		
		public static String calendar_Scope = 'https://www.googleapis.com/auth/calendar'; 
    	
    
		/* Constructor */
		public GoogleCalenderApi(){
			
		}
		
		public PageReference authorization(){  
			
			String request_Body = googleoAuthUrl+'redirect_uri='+redirect_uri+'&response_type=code&client_id='+consumerKey+
										'&scope='+calendar_Scope+'&prompt=consent&access_type=offline&include_granted_scopes=true';
			
			/*
				String body = googleoAuthUrl+'redirect_uri='+redirect_uri+'&response_type=code&client_id='+consumerKey +
				'&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcalendar&approval_prompt=force&access_type=offline';
			*/
			
			PageReference pr = new PageReference(request_Body); 
			return pr;
		}
		
		public static PageReference doFetchAccessToken(){ 
			
			String authCode = ApexPages.currentPage().getParameters().get('code');
			String errorMessage = '';
			
			String endPoint = 'https://www.googleapis.com/oauth2/v4/token';
			String authTokenBody = authCode;
			
			String requestTokenBody = 'code='+authCode+'&client_id='+consumerKey+'&client_secret='+
											clientSecret+'&redirect_uri='+redirect_uri+
												'&grant_type=authorization_code';
			
			Http http = new Http();
			httpRequest httpReq = new httpRequest();
			HttpResponse response = new HttpResponse();
			httpReq.setEndPoint(endPoint);
			httpReq.setBody(requestTokenBody);
			httpReq.setMethod('POST');
			try{
				response = http.send(httpReq);
				if(response.getStatuscode()==200){
					PageReference pageRef = new PageReference('/apex/googleInvetePage');
                    pageRef.setRedirect(true);
					Map<String,object> TokenInfo = (Map<String,object>)JSON.deserializeUntyped(response.getBody());
					System.debug('#### TokenInfo ==> '+String.valueOf(TokenInfo.get('refresh_token')));
                    String refreshTokenn = String.valueOf(TokenInfo.get('refresh_token'));
                    String accessTokenn = String.valueOf(TokenInfo.get('access_token'));
					GoogleInviteIntegration.createTeamsMeeting(refreshTokenn,accessTokenn);
                    return pageRef;
				}else{
					errorMessage = 'Unexpected Error while communicating with Google Calendar API. '
						+'Status '+response.getStatus()+' and Status Code '+response.getStatuscode();
                    return null;
				}     
			}catch(System.Exception e){
				if(String.valueOf(e.getMessage()).startsWith('Unauthorized endpoint')){
					errorMessage = 'Unauthorize endpoint: An Administer must go to Setup -> Administer -> Security Control ->'
						+' Remote Site Setting and add '+' '+ endPoint +' Endpoint';
                    return null;
				}else{
					errorMessage = 'Unexpected Error while communicating with Google Calendar API. '
						+'Status '+response.getStatus()+' and Status Code '+response.getStatuscode();
                    return null;
				}
			}  
		}
		
		public static void doRefreshToken(){
			
			String errorMessage ='';
			
			Http http = new Http();
			HttpRequest httpReq = new HttpRequest();
			HttpResponse httpRes = new HttpResponse();
			httpReq.setEndpoint('https://www.googleapis.com/oauth2/v4/token');
			httpReq.setMethod('POST');
			httpReq.setHeader('Content-Type', 'application/x-www-form-urlencoded');
			
			String refreshToken;
			System.debug('#### refreshToken '+refreshToken);
			String refreshTokenBody = 'client_id='+consumerKey+'&client_secret='+clientSecret+'&refresh_token='+refreshToken
											+'&grant_type=refresh_token';
			System.debug('#### refreshTokenBody '+refreshTokenBody);
			
			httpReq.setBody(refreshTokenBody);
					
			try{
			   httpRes = http.send(httpReq); 
				if(httpRes.getStatusCode() == 200){
					Map<String,object> TokenInfo = (Map<String,object>)JSON.deserializeUntyped(httpRes.getBody());
                    String Access_Token = String.valueOf(TokenInfo.get('access_token'));
                    String Refresh_Token = String.valueOf(TokenInfo.get('refresh_token'));
					System.debug('do Access Token '+Access_Token);
                    System.debug('do Refresh Token '+Refresh_Token);
				}else{
					errorMessage = 'Unexpected Error while communicating with Google Calendar API. '
						+'Status '+httpRes.getStatus()+' and Status Code '+httpRes.getStatuscode();
				}
			}catch(System.Exception e){
				
				System.debug('#### Exception Executed '+e.getStackTraceString() + ' '+e.getMessage());
				if(String.valueOf(e.getMessage()).startsWith('Unauthorized endpoint')){
					errorMessage = 'Unauthorize endpoint: An Administer must go to Setup -> Administer -> Security Control ->'
						+' Remote Site Setting and add '+' '+ 'https://www.googleapis.com/oauth2/v4/token' +' Endpoint';
				}else{
					errorMessage = 'Unexpected Error while communicating with Google Calendar API. '
						+'Status '+httpRes.getStatus()+' and Status Code '+httpRes.getStatuscode();
				}
			}
		}
	}
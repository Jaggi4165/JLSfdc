public class SendAccount {
    //Use your Client Id 
    String clientId ='3MVG9wt4IL4O5wvJHUzy5F61zbS_KlF9_TRIsDLkA1YwO7ibaHHpjQ13UgE5ze.Pi8DblW93Fp04kiSXd22dt';
    //Use your Client Secret
    String clientsecret='8E8663982F2A5FD4B20EDA0F7309A1B3DE6BF80AEE8EB92F254E81133CCEF1CC';
    //Your Destination org username
    String username='jagadeeswararao.kusumuru@absyz.com.cpq';
    //Your Destination orgPassword+Security Token
    String password='Jagadeesh@0';
    String accesstoken_url='https://login.salesforce.com/services/oauth2/token';
    String authurl='https://login.salesforce.com/services/oauth2/authorize';
    public class deserializeResponse {
        public String id;
        public String access_token;
    }
    public String ReturnAccessToken(SendAccount Acc){
        String reqbody = 'grant_type='+'password'+'&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        // String reqbody='{"grant_type":"password","client_id":clientId,"client_secret":clientSecret,"username":username,"password":password}’;
        Http h= new Http();
        HttpRequest req= new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        //Change “ap4” in url to your Destination Org Instance
        req.setEndpoint('https://absyz-2d4-dev-ed.develop.lightning.force.com/services/oauth2/token');
        HttpResponse res=h.send(req);
        System.debug(res.getBody()+'By-AP-1986-Response');
        deserializeResponse resp1=
        (deserializeResponse)JSON.deserialize(res.getBody(),deserializeResponse.class);
        System.debug(resp1+'By-AP-deserializeresponse');
        return resp1.access_token;
    }
    @future(callout=true)
    public static void createAccount(String Accname, String Phone, String Website){
        SendAccount acc1= new SendAccount();
        String accessToken=acc1.ReturnAccessToken(acc1);
        System.debug(accessToken+'###AP');
        if(accessToken!=null){
            //Change “ap4” in url to your Destination Org
            String endPoint='https://ap4.salesforce.com/services/data/v32.0/sobjects/Account';  
            String jsonstr='{"Name":'+ Accname +',"Phone:"'+ Phone +',"Website":'+Website+'}';
            Http h2= new Http();
            HttpRequest req2= new HttpRequest();
            req2.setHeader('Authorization','Bearer ' + accessToken);
            req2.setHeader('Content-Type','application/json');
            req2.setHeader('accept','application/json');
            req2.setBody(jsonstr);
            req2.setMethod('POST');
            req2.setEndpoint(endPoint);
            HttpResponse res2=h2.send(req2);
            System.debug(res2+'###Akash###');
            deserializeResponse deresp= (deserializeResponse)System.JSON.deserialize(res2.getBody(),deserializeResponse.class);
            System.debug('### Deserialized Response ###'+deresp);
        }
    }

}
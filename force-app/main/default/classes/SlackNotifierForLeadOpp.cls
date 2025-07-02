public with sharing class SlackNotifierForLeadOpp {
    public static void postToslack(List<Lead> leads) {
        String slackURL = 'https://hooks.slack.com/services/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';
        Map<string,Object> msg = new Map<String,Object>();
        String message = 'The Lead '+ leads[0].Id +' has Converted AND Status changed to '+ leads[0].Status+ ' .';
        msg.put( 'text',message);
        string body = JSON.serialize(msg);
        System.enqueueJob(new QueueableslackCall(slackURL, 'POST', body));
    }
    public static void postOppToslack(List<Opportunity> opps) {
        String slackURL = 'https://hooks.slack.com/services/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';
        Map<string,Object> msg = new Map<String,Object>();
        String message = 'The Opportunity '+ opps[0].Name +' has Closed-Won AND Stage changed to '+ opps[0].StageName+ ' .';
        msg.put( 'text',message);
        string body = JSON.serialize(msg);
        System.enqueueJob(new QueueableslackCall(slackURL, 'POST', body));
    }
    
    public class Queueableslackcall implements System.Queueable, Database.AllowsCallouts {
        
        private final String url;
        private final String method;
        private final String body;
        
        public Queueableslackcall(String url, String method, String body) {
            this.url = url;
            this.method = method;
            this.body = body;
        }
        
        public void execute(System.QueueableContext ctx) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod(method) ;
            req.setBody (body) ;
            Http http = new Http();
            HttpResponse res = http.send(req);
            System.debug('response===>'+res);
        }
    }
}
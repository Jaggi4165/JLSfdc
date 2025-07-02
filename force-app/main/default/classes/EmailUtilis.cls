/*
EmailUtilis email = new EmailUtilis();
email.setEmailTemplate('Amount_Exceed_20000');
email.setWhatId('a035g000000xtdrAAA');
email.prepareEmail();
email.sendPreparedEmailInService();
*/
public class EmailUtilis {
	private static Boolean EmailDeliverabilityEnabled = true;
    private String emailTemplateDeveloperName;
    private Id whatId;
    private List<String> toAddresses = new List<String>();
    private List<String> ccAddress = new List<String>();
    private Set<String> personIds = new Set<String>();
    private static List<String> bccAddressWhileTesting = new List<String>();
    public String senderDisplayName = 'JL Technologies';
    public String recursionIdentifierInThisInstance;
    public Id finalWhatId;
    
    private Boolean templateNotAvailable = false;
    
    public List<Messaging.SingleEmailMessage> mailToBeSentInThisInstance = new List<Messaging.SingleEmailMessage>();
    public static List<Messaging.SingleEmailMessage> allMailsToBeSent = new List<Messaging.SingleEmailMessage>();
    public static Messaging.SendEmailResult[] sendEmailresults;

    public List<EmailMessage> emailMessageInThisInstance = new List<EmailMessage>();
    public static List<EmailMessage> allEmailMessage = new List<EmailMessage>();

    private static Map<Id, Map<Id, Messaging.SingleEmailMessage>> emailByWhatIdByTemplateId = new Map<Id, Map<Id, Messaging.SingleEmailMessage>>();

    Map<Id, Id> whatIdByEmailId = new Map<Id, Id>();
    
    public static List<OrgWideEmailAddress> orgWideAddresses;
    
    public static Set<String> alreadyProcessedInService = new Set<String>();
    public static Set<String> emailTemplateDeveloperNameAlreadyProcessed = new Set<String>();
    public static Map<String, Id> emailTemplateIdByName = new Map<String, Id>();
    public static Map<Id, String> emailTemplateNameById = new Map<Id, String>();

    private List<String> formattingBody;
    private List<String> formattingSubject;

    private static Boolean developerLogOn = false;
    private String classMethodName;
    private Boolean saveAsActivity = true;
    
    public void setFinalWhatId(Id finalWhatId){
        this.finalWhatId = finalWhatId;
    }
    
    public void setEmailTemplate(String emailTemplateDeveloperName){
        this.emailTemplateDeveloperName = emailTemplateDeveloperName;
        List<EmailTemplate> emailTemplate = [SELECT Id,DeveloperName
                                       FROM EmailTemplate 
                                       WHERE DeveloperName = :emailTemplateDeveloperName];
        if(emailTemplate.size() == 0) {
            System.debug( 'Email Template DeveloperName not found => ' + emailTemplateDeveloperName);
            templateNotAvailable = true;
        }
        System.debug('email template name '+emailTemplate[0].DeveloperName);
        emailTemplateDeveloperNameAlreadyProcessed.add( emailTemplateDeveloperName );
        emailTemplateIdByName.put(emailTemplateDeveloperName, emailTemplate[0].Id);
        emailTemplateNameById.put(emailTemplate[0].Id, emailTemplateDeveloperName);
        
    }
    
    public void setWhatId(Id whatId){
        this.whatId = whatId;
    }
    // Prepare email
    public void prepareEmail(){
        if(templateNotAvailable) return;
        //if(toAddresses == null || toAddresses.size() == 0) return;

        if(!emailTemplateIdByName.containsKey( this.emailTemplateDeveloperName )) return;
        
        Id emailTemplateId = emailTemplateIdByName.get( this.emailTemplateDeveloperName );
        
        //if(orgWideAddresses == null)
        orgWideAddresses = [SELECT Id ,Address, DisplayName
                            FROM OrgWideEmailAddress WHERE DisplayName = 'Kusumuru4165@gmail.com' LIMIT 1];
        
        Messaging.SingleEmailMessage email;
        email = Messaging.renderStoredEmailTemplate(emailTemplateId, null, whatId);
        /*if(! ( emailByWhatIdByTemplateId.containsKey(whatId) && emailByWhatIdByTemplateId.get(whatId).containsKey(emailTemplateId))){
            email = Messaging.renderStoredEmailTemplate(emailTemplateId, null, whatId);
        }else{
            email = emailByWhatIdByTemplateId.get(whatId).get(emailTemplateId);
        }*/
        
        String emailSubject = email.getSubject();
        if(developerLogOn == true){
            emailSubject = this.emailTemplateDeveloperName + ' :: ' +this.classMethodName +   ' >>>> ' + emailSubject;
        }
        String emailHTMLBody = email.getHTMLBody();
        String plainTextBody = email.getPlainTextBody();
        if( this.formattingBody != null ){
            emailHTMLBody = String.format( emailHTMLBody, this.formattingBody);
            plainTextBody = String.format( plainTextBody, this.formattingBody);
        }

        if( this.formattingSubject != null){
            emailSubject =  String.format( emailSubject, this.formattingSubject);
        }

        email.setOrgWideEmailAddressId(orgWideAddresses[0].Id);
        email.setSubject(emailSubject);
        email.setHTMLBody(emailHTMLBody);
        email.setPlainTextBody(stripOutHtmlTags(plainTextBody));
        email.saveAsActivity = true; 
        email.toAddresses = new List<String>{'jagadeeswararao.kusumuru@absyz.com','kusumuru4165@gmail.com'};//this.toAddresses;
        //email.ccaddresses = this.ccAddress;
        //email.BccAddresses = bccAddressWhileTesting;

        if(this.finalWhatId != null){
            email.setWhatId(this.finalWhatId);
            email.saveAsActivity = true; 
        }
        mailToBeSentInThisInstance.add( email );
        allMailsToBeSent.add( email );
    }
    public void sendPreparedEmailInService(){
        System.debug('All Emails===>'+allMailsToBeSent);
        if(allMailsToBeSent == null || allMailsToBeSent.size() == 0) return;
        if(!Test.isRunningTest()) {
            try{
                sendEmailresults = Messaging.sendEmail( allMailsToBeSent );
            }
            catch(Exception e){
                System.debug('exception ===> '+e.getMessage());
            }
        }
    }
    
    private String stripOutHtmlTags(String htmlInput){
        htmlInput = htmlInput.replaceAll('<br/>', '\n');
        htmlInput = htmlInput.replaceAll('<[/a-zAZ0-9]*>','');
        htmlInput = htmlInput.replaceAll('&nbsp;','');
        return htmlInput;
    }
}
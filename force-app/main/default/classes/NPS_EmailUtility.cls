public class NPS_EmailUtility {
	public String fromAddress{get;set;}

    public String[] toAddressList{get;set;}

    public String subject{get;set;}

    public String body{get;set;}

    public Id orgWideEmailAddrId{get;set;}

    public List<Messaging.EmailFileAttachment> emailAttachmentList{get;set;}

    public void sendEmail(){

        Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();

        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();

        emailMsg.setReplyTo(fromAddress);

        emailMsg.setToAddresses(toAddressList);

        emailMsg.setSubject(subject);

        emailMsg.setHtmlBody('This is Jagadeeswara Rao Kusumuru : '+body);

        emailMsg.setOrgWideEmailAddressId(fromAddress);

       

        if(emailAttachmentList != null && emailAttachmentList.size() > 0){

            for(Messaging.Emailfileattachment efa: emailAttachmentList){

                fileAttachments.add(efa);

            }

        }

        emailMsg.setFileAttachments(fileAttachments);

        system.debug('Send email >> ' + emailMsg);

        try{

            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { emailMsg }); 

        }catch(System.EmailException ex){

            system.debug('Issue in sending email >> ' + ex.getMessage());

        }     

    }
}
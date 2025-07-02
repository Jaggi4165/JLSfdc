public class EmailTemplateUtility {
    
    // Cache for org-wide email address
    private static Id orgWideEmailAddressId;
    
    /**
     * Sends an email using a Classic Email Template
     * @param templateName Developer name of the email template
     * @param recipientIds List of recipient Ids (User, Contact, Lead)
     * @param targetObjectId The contact/lead the template is merged against
     * @param whatId Optional related record Id for merge fields
     * @param saveAsActivity Whether to save as activity on targetObjectId
     * @return List<Messaging.SendEmailResult> results of the send operation
     */
    public static List<Messaging.SendEmailResult> sendTemplateEmail(
        String templateName, 
        List<Id> recipientIds, 
        Id targetObjectId, 
        Id whatId, 
        Boolean saveAsActivity
    ) {
        // Validate inputs
        if (String.isBlank(templateName) || recipientIds == null || recipientIds.isEmpty()) {
            throw new EmailTemplateUtilityException('Template name and recipient Ids are required');
        }
        
        // Get the org-wide email address
        Id orgWideAddress = getOrgWideEmailAddress();
        if (orgWideAddress == null) {
            throw new EmailTemplateUtilityException('No org-wide email address found. Please setup an org-wide email address.');
        }
        
        // Get the email template
        EmailTemplate template = [
            SELECT Id FROM EmailTemplate 
            WHERE DeveloperName = :templateName 
            LIMIT 1
        ];
        
        if (template == null) {
            throw new EmailTemplateUtilityException('Email template not found: ' + templateName);
        }
        
        // Create email for each recipient
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        
        for (Id recipientId : recipientIds) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setTemplateId(template.Id);
            email.setTargetObjectId(targetObjectId);
            email.setWhatId(whatId);
            email.setSaveAsActivity(saveAsActivity);
            email.setToAddresses(new List<String>{ getEmailFromId(recipientId) });
            email.setOrgWideEmailAddressId(orgWideAddress);
            
            emails.add(email);
        }
        
        // Send emails
        return Messaging.sendEmail(emails);
    }
    
    /**
     * Gets the first active org-wide email address
     * @return Id of the org-wide email address
     */
    private static Id getOrgWideEmailAddress() {
        if (orgWideEmailAddressId == null) {
            List<OrgWideEmailAddress> addresses = [
                SELECT Id FROM OrgWideEmailAddress 
                WHERE IsAllowAllProfiles = true 
                LIMIT 1
            ];
            if (!addresses.isEmpty()) {
                orgWideEmailAddressId = addresses[0].Id;
            }
        }
        return orgWideEmailAddressId;
    }
    
    /**
     * Helper method to get email address from record Id
     * @param recordId User, Contact, or Lead Id
     * @return Email address
     */
    private static String getEmailFromId(Id recordId) {
        if (recordId.getSObjectType() == User.SObjectType) {
            User u = [SELECT Email FROM User WHERE Id = :recordId LIMIT 1];
            return u.Email;
        } else if (recordId.getSObjectType() == Contact.SObjectType) {
            Contact c = [SELECT Email FROM Contact WHERE Id = :recordId LIMIT 1];
            return c.Email;
        } else if (recordId.getSObjectType() == Lead.SObjectType) {
            Lead l = [SELECT Email FROM Lead WHERE Id = :recordId LIMIT 1];
            return l.Email;
        }
        throw new EmailTemplateUtilityException('Invalid recipient type. Must be User, Contact, or Lead');
    }
    
    public class EmailTemplateUtilityException extends Exception {}
}
/*

// Send email with automatic org-wide address
List<Messaging.SendEmailResult> results = EmailTemplateUtility.sendTemplateEmail(
    'My_Template_Dev_Name',
    new List<Id>{ '003XXXXXXXXXXXX' }, 
    '003XXXXXXXXXXXX', 
    null, 
    true
);

*/
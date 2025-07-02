public class NPS_MeetingInviteGenerator {
    public String startDate{get;set;}
    
    public String endDate{get;set;}
    
    public String meetingSubject{get;set;}
    
    public String meetingBody{get;set;}
    
    public String displayName{get;set;}
    
    public String attachmentName{get;set;}
    
    public string fromAddress{get;set;}
    
    public string toAddressList{get;set;}
    
    public Messaging.EmailFileAttachment generateMeetingInvite(){
        
        Messaging.EmailFileAttachment meetingInviteIcs = new Messaging.EmailFileAttachment();
        
        Blob b = doIcsAttachment();
        
        meetingInviteIcs.setFileName(attachmentName);
        
        meetingInviteIcs.setBody(b); 
        
        return meetingInviteIcs;
        
    }
    
    
    
    public Blob doIcsAttachment(){  
        
        String [] icsTemplate = new List<String> {'BEGIN:VCALENDAR',
            
            'PRODID:-//Microsoft Corporation //Outlook 16.0 MIMEDIR//EN',
            
            'VERSION:2.0',
            
            'METHOD:REQUEST',
            
            'BEGIN:VEVENT',
            
            'DTSTART: ' + startDate,
            
            'DTEND: ' + endDate,
            
            'UID: ' + String.valueOf(Crypto.getRandomLong()),
            
            'DESCRIPTION: ' + meetingBody,
            
            'X-ALT-DESC;FMTTYPE=text/html: ' + meetingBody,
            
            'SUMMARY: ' + meetingSubject,
            
            'ORGANIZER:MAILTO: outlook_effb50d7a41f7c02@outlook.com ', //+ fromAddress,
            
            'ATTENDEE;CN="' + displayName + '";RSVP=TRUE:mailto: ' + toAddressList,
            
            'BEGIN:VALARM',
            
            'TRIGGER:-PT1080M',
            
            'ACTION:DISPLAY',
            
            'DESCRIPTION:Reminder',
            
            'END:VALARM',
            
            'END:VEVENT',
            
            'END:VCALENDAR'
            
            };
                
                return Blob.valueof(String.join(icsTemplate, '\n'));
        
    }
}
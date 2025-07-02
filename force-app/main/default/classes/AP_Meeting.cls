public class AP_Meeting {
    public static void sendInvite(list<Meeting__c> meetingList) {
        list<string> UserEmailList = new list<string> ();
        string title;
        string meetingTitle;

        for(Meeting__c meet:meetingList){
            UserEmailList.add(meet.Meeting_Leader__c);
            meetingTitle=meet.name+': '+meet.Subject__c;
            title=meet.Subject__c;
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(UserEmailList);
            mail.setPlainTextBody('This to inform that we have meeting related to particular problem');
            mail.setSubject(title);
            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            attach.filename = 'meeting.ics';
            attach.ContentType = 'text/calendar; charset=utf-8; method=REQUEST'; //PUBLISH';//
            attach.inline = true;

            /***************************/
           attach.body = invite(UserEmailList, meet.Meeting_Leader__c, 'Jagadeesh Kusumuru', meet.Subject__c, meet.start__c, meet.End__c, meet.createdDate, meet.Objective_of_meeting__c, meet.LastModifiedDate);
       
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] {
                attach
                    });
            Messaging.SendEmailResult[] er = Messaging.sendEmail(new Messaging.Email[] {
                mail
                    });
        }
    }

    
    public static Blob invite(List<String> emailsList, String Organiser, string name, string subject, dateTime startDate, dateTime endDate, dateTime createdDate, string description, dateTime lastmodifiedDat) {
        String txtInvite = '';
        string startdateTime;
        string enddateTIme;
        string createdDateTime;
        string lastmodifiedDatTime;

        startdateTime = startDate.formatGMT('yyyyMMdd\'T\'HHmmss\'Z\'');
        enddateTIme = endDate.formatGMT('yyyyMMdd\'T\'HHmmss\'Z\'');
        createdDateTime = createdDate.formatGMT('yyyyMMdd\'T\'hhmmss\'Z\'');
        lastmodifiedDatTime = lastmodifiedDat.formatGMT('yyyyMMdd\'T\'hhmmss\'Z\'');

        txtInvite += 'BEGIN:VCALENDAR\n';
        txtInvite += 'PRODID:-//Microsoft Corporation//Outlook 16.0 MIMEDIR//EN\n';
        txtInvite += 'VERSION:2.0\n';
        txtInvite += 'CALSCALE:GREGORIAN\n';
        txtInvite += 'METHOD:REQUEST\n';
        txtInvite += 'REPLAY:ACCEPTED\n';
        txtInvite += 'BEGIN:VEVENT\n';
        txtInvite += 'ATTENDEE\n';
        txtInvite += 'CN=' + subject + '\n';
        for (String email: emailsList) {
            txtInvite += 'ATTENDEE:' + email + '\n';
        }
        txtInvite += 'X-MS-OLK-FORCEINSPECTOROPEN:TRUE\n';
        txtInvite += 'X-WR-RELCALID:{0000002E-9CDF-9CE8-AD4C-66FC0A5A25F7}\n';
        txtInvite += 'CLASS:PUBLIC\n';
        txtInvite += 'CREATED:' + createdDateTime+'\n';
        txtInvite += 'DTEND:' + enddateTIme+'\n';
        txtInvite += 'DTSTART:' + startdateTime+'\n';
        txtInvite += 'LAST-MODIFIED:' + lastmodifiedDatTime+'\n';
        txtInvite += 'ORGANIZER;CN=' + name + ':mailto:' + Organiser + '\n';
        txtInvite += 'RSVP=TRUE\n';
        txtInvite += 'ROLE=REQ-PARTICIPANT\n';
        txtInvite += 'PARTSTAT=NEEDS-ACTION\n';
        txtInvite += 'CN=' + subject + ':mailto:' + Organiser + '\n';
        txtInvite += 'LOCATION:Teams\n';
        txtInvite += 'PRIORITY:5\n';
        txtInvite += 'SEQUENCE:0\n';
        txtInvite += 'SUMMARY:\n';
        txtInvite += 'STATUS:NEEDS-ACTION\n';
        txtInvite += 'LANGUAGE=en-us:\n';
        txtInvite += 'TRANSP:OPAQUE\n';
        txtInvite += 'UID:4036587160834EA4AE7848CBD028D1D200000000000000000000000000000000\n';
        txtInvite += 'X-ALT-DESC;FMTTYPE=text/html:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN"><HTML><HEAD><META NAME="Generator" CONTENT="MS Exchange Server version 08.00.0681.000"><TITLE></TITLE></HEAD><BODY><!-- Converted from text/plain format --></BODY></HTML>\n';
        txtInvite += 'X-MICROSOFT-CDO-BUSYSTATUS:BUSY\n';
        txtInvite += 'X-MICROSOFT-CDO-IMPORTANCE:1\n';
        txtInvite += 'BEGIN:VALARM\n';
        txtInvite += 'TRIGGER:-PT15M\n';
        txtInvite += 'ACTION:DISPLAY\n';
        txtInvite += 'STATUS:CONFIRMED\n';
        txtInvite += 'DESCRIPTION:Reminder\n';
        txtInvite += 'END:VALARM\n';
        txtInvite += 'END:VEVENT\n';
        txtInvite += 'END:VCALENDAR';
        return Blob.valueOf(txtInvite);
     }
    
    
}
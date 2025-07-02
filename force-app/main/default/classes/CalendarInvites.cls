public class CalendarInvites {
public static void sendinvite() { 

            List < Messaging.SingleEmailMessage > lstMsgs = new List < Messaging.SingleEmailMessage > ();
             List < String > sendTo = new List < String > ();
            sendTo.add('jagadeeswararao.kusumuru@absyz.com');
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            //savepoint sp = Database.setsavepoint();
            mail.setToAddresses(sendTo);
            //mail.setTemplateId('Google meet testing');
    mail.setSubject('Google meet Subject');
    mail.setSaveAsActivity(false);
            lstMsgs.add(mail);
            System.debug('messege'+lstMsgs);
            //Database.rollback(sp);
            
            List < Messaging.SingleEmailMessage > lstMsgsToSend = new List < Messaging.SingleEmailMessage > ();
            for (Messaging.SingleEmailMessage email: lstMsgs) {
                Messaging.SingleEmailMessage emailToSend = new Messaging.SingleEmailMessage();
                emailToSend.setToAddresses(email.getToAddresses());
                emailToSend.setPlainTextBody(email.getPlainTextBody());
                emailToSend.setReplyTo('jagadeeswararao.kusumuru@absyz.com');
                emailToSend.setSenderDisplayName('CE Department');
                //emailToSend.setHTMLBody(email.getHTMLBody());
                emailToSend.setSubject(email.getSubject());    
                List < Messaging.Emailfileattachment > fileAttachments = new List < Messaging.Emailfileattachment > (); 
                 //for (Attachment a: attachList) {
                      
                    Messaging.Emailfileattachment attach = new Messaging.Emailfileattachment();
                attach.filename = 'reminder.ics'; 
                attach.ContentType = 'text/calendar;charset=utf-8; method=REQUEST';     
                attach.inline = true; 

                attach.body = invite(); 
                fileAttachments.add(attach);
                mail.setFileAttachments(new Messaging.EmailFileAttachment[] {attach});   
                Messaging.SendEmailResult[] er = Messaging.sendEmail(new Messaging.Email[] { mail }); 
            //}
            System.debug('file'+fileAttachments);
                 emailToSend.setFileAttachments(fileAttachments);
                lstMsgsToSend.add(emailToSend);
                System.debug('meme'+lstMsgsToSend);
            }
        }
        public static Blob invite() {
            DateTime dt=DateTime.now().adddays(1);
            String startdatetime=String.valueof(dt.year()+'0'+dt.month()+''+dt.day()+'T000000Z');
            String enddatetime=String.valueof(dt.year()+'0'+dt.month()+''+dt.day()+'T020000Z');
            String txtInvite = ''; 
            txtInvite += 'BEGIN:VCALENDAR\n';        
            txtInvite += 'PRODID::-//hacksw/handcal//NONSGML v1.0//EN\n';
            txtInvite += 'VERSION:2.0\n';
            txtInvite += 'METHOD:PUBLISH\n';
            txtInvite += 'X-MS-OLK-FORCEINSPECTOROPEN:TRUE\n';
            txtInvite += 'BEGIN:VEVENT\n';
            txtInvite += 'CLASS:PUBLIC\n';
            txtInvite += 'CREATED:20091026T203709Z\n';        
            txtInvite += 'DTEND:'+enddatetime+'\n';
            txtInvite += 'DTSTAMP:20191026T203709Z\n';        
            txtInvite += 'DTSTART:'+startdatetime+'\n';
            txtInvite += 'LAST-MODIFIED:20091026T203709Z\n';
            txtInvite += 'LOCATION:India\n';
            txtInvite += 'PRIORITY:5\n';
            txtInvite += 'SEQUENCE:0\n';
            txtInvite += 'SUMMARY;';
            txtInvite += 'LANGUAGE=en-us:Meeting\n';
            txtInvite += 'TRANSP:OPAQUE\n';
            txtInvite += 'X-ALT-DESC;FMTTYPE=text/html:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN"><HTML><HEAD><META NAME="Generator" CONTENT="MS Exchange Server version 08.00.0681.000"><TITLE></TITLE></HEAD><BODY><!-- Converted from text/plain format --></BODY></HTML>\n';
            txtInvite += 'X-MICROSOFT-CDO-BUSYSTATUS:BUSY\n';
            txtInvite += 'X-MICROSOFT-CDO-IMPORTANCE:1\n';
            txtInvite += 'END:VEVENT\n';
            txtInvite += 'END:VCALENDAR'; 
            return Blob.valueOf(txtInvite);
            
        }
    }
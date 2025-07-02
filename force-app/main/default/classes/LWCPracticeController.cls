public class LWCPracticeController {
    @AuraEnabled(cacheable=true)
    public static List<wrapperClass> getContacts(){
        List<contact> listOfContacts = new List<contact>([select Id,LastName,Phone from contact where LastName!=null AND Phone!=null Order by LastName DESC limit 5]);
        List<wrapperClass> newWrapperClass = new List<wrapperClass>();
        for(contact c : listOfContacts){
            wrapperClass w = new wrapperClass();
            w.name = c.LastName;
            w.phone = c.Phone;
            newWrapperClass.add(w);
        }
        return newWrapperClass;
    }

    public class wrapperClass{
        @auraenabled
        public string name{get;set;}
        @auraenabled
        public string phone{get;set;}

      }
}
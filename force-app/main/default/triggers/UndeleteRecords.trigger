trigger UndeleteRecords on Competitor__c (after undelete) {
list<Competitor__c> undeletecmr=new list<Competitor__c>();
  for (Competitor__c cm: trigger.new) {
   Competitor__c cmr = new Competitor__c();
   cmr.id =cm.id;
   cmr.Undeleted_Record__c=true; 
   undeletecmr.add(cmr);
}
   update undeletecmr;
}
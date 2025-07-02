public class HubController {
       @AuraEnabled
   	public static list <Hub__c> fetchHubs(){       
         List <Hub__c> returnHubsList = new List <Hub__c> ();
         for (Hub__c h: [SELECT Id,Name, Active__c, Location__latitude__s, Location__longitude__s, Rating__c from Hub__c]) {
             returnHubsList.add(h);
          }
         return returnHubsList;
   }

    @AuraEnabled
    public static List<Bike__c> getRelatedList(Id recordId){
        List<Bike__c> contactList = new List<Bike__c>();
        for(Bike__c oCon : [Select Id,Name,(select Id,Name from Bookings__r) from Bike__c WHERE Hub__c =: recordId ]){
           contactList.add(oCon); 
        }
        return contactList;
    }    
}
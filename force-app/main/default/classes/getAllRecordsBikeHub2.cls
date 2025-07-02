public with sharing class getAllRecordsBikeHub2 {
    public getAllRecordsBikeHub2() {

    }
  @AuraEnabled(cacheable=true)
     public static Integer bookedBikeCount(Id iiid){
   List<AggregateResult> aggList2 = new List<AggregateResult>();
         aggList2 = [ Select COUNT(Id)  From Bike__c Where (IsBooked__c=true AND Hub__c=:iiid)  ];
                                                                       
                return (Integer)aggList2[0].get('expr0');                                        
        }


        @AuraEnabled(cacheable=true)
        public static Integer serviceBike(Id iiid){
      List<AggregateResult> aggList3 = new List<AggregateResult>();
            aggList3 = [ Select COUNT(Id)  From Bike__c Where (DueToService__c=true AND Hub__c=:iiid)  ];
                                                                          
                   return (Integer)aggList3[0].get('expr0');                                        
           }

           @AuraEnabled(cacheable=true)
           public static Integer inactiveBikes(string iiid){
               List<AggregateResult> aggList = new List<AggregateResult>();
              aggList = [Select COUNT(Id) From Bike__c   Where (Active__c=false AND Hub__c=:iiid) ];
                                              
                  return (Integer)aggList[0].get('expr0');
       
           }
       
           @AuraEnabled(cacheable=true)
           public static Integer totalBikes(string iiid){
               List<AggregateResult> aggList5 = new List<AggregateResult>();
              aggList5 = [Select COUNT(Id) From Bike__c   Where Hub__c=:iiid];
                                              
                  return (Integer)aggList5[0].get('expr0');
       
           }




//*******************************************************************************************--
@AuraEnabled(cacheable=true)
    public static list<Bike__c> getBikeList(string searchKey) {
		
       // create contact list to store search result 
        list<Bike__c> contactListRecord = new list<Bike__c>();
        
        List<Hub__c> hubId = new List<Hub__c>();
        for(Hub__c h : [select Id,Name from Hub__c where Name =: searchKey]){
          hubId.add(h);
        }
        
     
	   // query contact records
        for(Bike__c conObj : [Select Name,KMCovered__c
                            From Bike__c
                            WHERE Hub__c =: hubId[0].Id ]){
           contactListRecord.add(conObj);
        }
        
         if(contactListRecord.size() == 0){
            throw new AuraHandledException('No Record Found..'); 
         }
         
        return contactListRecord;
    }
    //******************************************************************************************* */




    }
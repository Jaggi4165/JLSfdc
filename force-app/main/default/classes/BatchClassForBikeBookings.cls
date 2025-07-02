/*
Batch class should only take into account Records created for the last 30 days. 
Classification should be based on the following criteria -
No of Bookings >= 10 = Most Preferred
No of Bookings >= 5 but strictly less than 10 = Average Preference
No of Booking < 5 = Least Preferred



*/

global class BatchClassForBikeBookings implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
        DateTime dt = System.now().addDays(-30); 
        String query = 'SELECT Id,NoOfBookings_c,KMCoveredc FROM Bikec where Active_c=TRUE and CreatedDate >= :dt';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Bike__c> bikeList) {
        for(Bike__c bike : bikeList) {        
            if(bike.NoOfBookings__c > 5) {
                
            }     
        }
        try {
            //update bikeList;
        } catch(Exception e) {
            System.debug(e);
        } 
    }        
    global void finish(Database.BatchableContext BC) {
        
    }
}
public with sharing class lwcAppExampleApex {
    public lwcAppExampleApex() {

    }
    @AuraEnabled(cacheable=true)
    public static Decimal  retrieveContactData(string iid){       
        //List<Decimal> intList = new List<Decimal>();
        List<AggregateResult> aggList = new List<AggregateResult>();
       aggList = [
                                        Select SUM(ActualFare__c)
                                        From Booking__c 
                                        Where  Paid__c=false AND customer__c=:iid 
                                        ];
                                       
                                      return (Decimal)aggList[0].get('expr0');
           
             
                                    }
                         

}
public class DistanceCalculateActExpFare {
    public static void calculateDistAndfare(List<Booking__c> lstbk, Boolean isInsert){
        for(Booking__c bk : lstbk){
            decimal expectedfare = 0.0;
            decimal additionalCharges = 0.0;
            decimal actualfare = 0.0;
            decimal hourcharges = 0.0;
            Location loc1 = Location.newInstance(bk.StartLocation__Latitude__s ,bk.StartLocation__Longitude__s);
            Location loc2 = Location.newInstance(bk.EndLocation__Latitude__s,bk.EndLocation__Longitude__s);
            Double dist = Location.getDistance(loc1, loc2, 'mi');
            Long starttime = bk.RideStartTime__c.getTime();
            Long endtime = bk.RideEndTime__c.getTime();
            Long milliseconds = endtime - starttime;
            Long seconds = milliseconds / 1000;
            Long minutes = seconds / 60;
            hourcharges = minutes*1.7;
            Decimal bal=0.0;
            
            bk.DistanceKMs__c=dist;
            if(dist > 200){
                bk.addError('Booking Not Allowed');
            }
            else{
                if(dist<15){
                    //Expected fare
                    expectedfare = dist*1;
                    System.debug('P:::'+expectedfare);
                    bal = expectedfare+hourcharges;              
                    }
                else{
                    expectedfare = 15;
                    expectedfare = expectedfare+((dist-15)*2); 
                    bal =  expectedfare+hourcharges;
                }
            }       
        
            if(isInsert){
            	//bk.ExpectedFare__c =  bal;
                bk.ExpectedFare__c =  bal;
                Decimal gst2=bal+bal+((bal/100)*18);
                bk.ActualFare__c = gst2;
                
            }
            else if(!isInsert && bk.RideEndTime__c != null){
                bk.ExpectedFare__c =  bal;
                Decimal gst2=bal+((bal/100)*18);
                bk.ActualFare__c =  gst2;
            }
            else {
                System.debug('hai hello namaste');
            }
        }
        //Update the Hub location on the Bike when the ride ends.
        for(Booking__c bk : lstbk)
        {
            
        }
        //--------------------------------------------------
         
    }
}
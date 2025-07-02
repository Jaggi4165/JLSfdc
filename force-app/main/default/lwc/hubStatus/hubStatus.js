import { LightningElement, api, wire,track } from 'lwc';
import inactiveBikes from '@salesforce/apex/getAllRecordsBikeHub2.inactiveBikes';
import bookedBikeCount from '@salesforce/apex/getAllRecordsBikeHub2.bookedBikeCount';
import serviceBike from '@salesforce/apex/getAllRecordsBikeHub2.serviceBike';
import totalBikes from '@salesforce/apex/getAllRecordsBikeHub2.totalBikes';

export default class HubStatus extends LightningElement {
    @api recordId;
    @track bikes;
    @wire (inactiveBikes,{iiid : '$recordId'}) 
    wireRecord({data,error}){
        if(data){           
            this.bikes = data;
            this.error = undefined; 
           }
           else{
               this.error = error;
               this.bikes=undefined;
           }
    }
@track bookingbikes;
    @wire (bookedBikeCount,{iiid : '$recordId'}) 
    wireRecord2({data,error}){
        if(data){           
            this.bookingbikes = data;
            this.error = undefined; 
           }
           else{
               this.error = error;
               this.bookingbikes=undefined;
           }
    }
    @track bikeServe;
    @wire (serviceBike,{iiid : '$recordId'}) 
    wireRecord3({data,error}){
        if(data){           
            this.bikeServe = data;
            this.error = undefined; 
           }
           else{
               this.error = error;
               this.bikeServe=undefined;
           }
    }
    @track totBikes;
    @wire (totalBikes,{iiid : '$recordId'}) 
    wireRecord4({data,error}){
        if(data){           
            this.totBikes = data;
            this.error = undefined; 
           }
           else{
               this.error = error;
               this.totBikes=undefined;
           }
    }
    /*
    @track servicePercentage = ( bikeServe/ totBikes ) * 100 ;
    @track inactivePercentage = ( bikes / totBikes ) * 100 ;
    @track bookPercentage = ( bookingbikes / totBikes ) * 100 ;*/

}
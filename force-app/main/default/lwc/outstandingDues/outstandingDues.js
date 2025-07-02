import { LightningElement, track, wire,api } from 'lwc';
import retrieveContactData from '@salesforce/apex/lwcAppExampleApex.retrieveContactData';
export default class OutstandingDues extends LightningElement {
    @api recordId;  
    @track  lifetimeAgg;
     @track records;
     @wire (retrieveContactData,{iid:'$recordId'})
     getData({data,error}){
         if(data){       
            this.records = data;
             
             this.error = undefined;
  
            }else{
                this.error = error;
                this.data=undefined;
            }
     }
}
import { LightningElement,wire,api,track } from 'lwc';
//import bookedBikeCount from '@salesforce/apex/getAllRecordsBikeHub2.bookedBikeCount';

export default class BookingManager extends LightningElement {
    @api recordId;
}
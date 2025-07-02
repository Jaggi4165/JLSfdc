import { LightningElement,api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Last_Refresh__c';
import ID_FIELD from '@salesforce/schema/Account.Id';
import MY_OBJECT from '@salesforce/schema/Account';
import { updateRecord } from 'lightning/uiRecordApi';
export default class LastRefresh extends LightningElement {
    // Flexipage provides recordId and objectApiName
    @api recordId;
    time;
    refresh(){
        console.log("cursor in the refresh function");
        this.time=date.now();
        const filds={};
        fields[NAME_FIELD.fieldApiName]=this.time;
        fields[ID_FIELD.fieldApiName]=this.recordId;
        const recordInput={fields:fields};
        updateRecord();
    }
}
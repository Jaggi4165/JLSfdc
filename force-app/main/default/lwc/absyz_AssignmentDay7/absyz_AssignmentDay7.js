import { LightningElement , api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {  FlowNavigationBackEvent,  FlowNavigationNextEvent} from "lightning/flowSupport";
import NAME_FIELD from '@salesforce/schema/Contact.Name';
export default class Absyz_AssignmentDay7 extends LightningElement {
    @api objectApiName = 'Contact';
    @api recordId;

    fields = [NAME_FIELD];

    handleSubmit(event) {
        const evt = new ShowToastEvent({
            title: 'Creation in progress',
            message: 'Contact Record is going to Submit...',
            variant: 'success',
        });
        this.dispatchEvent(evt);
        event.preventDefault(); // stop the form from submitting
        const fields = event.detail.fields;
        fields.AccountId = this.recordId; // modify a field
        this.template.querySelector('lightning-record-form').submit(fields);
    }
    @api availableActions = [];
    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Contact created successfully',
            message: 'Record ID: ' + event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(evt);
        
        if (this.availableActions.find((action) => action === "NEXT")) {
        const navigateNextEvent = new FlowNavigationNextEvent();
        this.dispatchEvent(navigateNextEvent);
        }
    }
    handleError(event){
        console.log(event);
    }
}
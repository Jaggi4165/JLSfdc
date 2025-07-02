import { LightningElement , api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { RefreshEvent } from 'lightning/refresh';
import {  FlowNavigationBackEvent,  FlowNavigationNextEvent} from "lightning/flowSupport";
import NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import STAGENAME_FIELD from '@salesforce/schema/Opportunity.StageName';
import CLOSEDATE_FIELD from '@salesforce/schema/Opportunity.CloseDate';



export default class Absyz_AssignmentDay7Task2Oppo extends LightningElement {
    @api objectApiName = 'Opportunity';
    @api recordId;
@api availableActions = [];
    fields = [NAME_FIELD,STAGENAME_FIELD,CLOSEDATE_FIELD];

    handleSubmit(event) {
       
        event.preventDefault(); // stop the form from submitting
        const fields = event.detail.fields;
        fields.AccountId = this.recordId; // modify a field
        this.template.querySelector('lightning-record-form').submit(fields);
    }
    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Opportunity created successfully',
            message: 'Record ID: ' + event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(evt);
        if (this.availableActions.find((action) => action === "FINISH")) {
        const navigateNextEvent = new FlowNavigationNextEvent();
        this.dispatchEvent(navigateNextEvent);
        
        }
        this.dispatchEvent(new RefreshEvent());
    }
    handleError(event){
        console.log(event);
    }
}
import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import ACCOUNT_OBJECT from "@salesforce/schema/Applicant__c";
import ID_FIELD from "@salesforce/schema/Applicant__c.Id";
import ValidApplicant_FIELD from "@salesforce/schema/Applicant__c.Valid_Applicant__c";

import { updateRecord } from "lightning/uiRecordApi";

export default class ValidateApplicantLWC extends LightningElement {
    validData;
    @api recordId;
    handleClick(event){
    
        const fields = {};

        fields[ValidApplicant_FIELD.fieldApiName] = true;
        fields[ID_FIELD.fieldApiName] = this.recordId;
        const recordInput = {
            fields: fields
        };
        updateRecord(recordInput).then((record) => {
            console.log('updated');
            this.showToast();
            console.log('updated');
        }).catch((error) => {
            alert(JSON.stringify(error.body.message));
        });
    }
    showToast() {
        const event = new ShowToastEvent({
            title: 'Success',
            message: 'Application got updated successfully.',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
}
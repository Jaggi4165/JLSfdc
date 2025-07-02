import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//IMPORT ALL THE FIELDS WHICH WE WANT DISPLAY ON THE UI
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import ACCOUNT_LOOKUP from '@salesforce/schema/Contact.AccountId';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import NAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';

export default class ContactCreator extends LightningElement {

    objectApiName=CONTACT_OBJECT;
    fields = [FIRSTNAME_FIELD,NAME_FIELD,EMAIL_FIELD]; //
    handleSuccess(event) {
        const toastEvent = new ShowToastEvent({
            title: "Contact created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
    }
}
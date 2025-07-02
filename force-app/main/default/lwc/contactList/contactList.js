import { LightningElement, wire,track } from 'lwc';
import { reduceErrors } from 'c/ldsUtils';
//import getContactList from '@salesforce/apex/ContactController.getContactList';
import getContacts from '@salesforce/apex/ContactController.getContacts';

import NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';

const columns = [
    { label: 'First Name', fieldName: NAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Last Name', fieldName: LASTNAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Email', fieldName: EMAIL_FIELD.fieldApiName, type: 'text' }
];
export default class ContactList extends LightningElement {
    columnsList = columns;
    @wire(getContacts) contacts;
    
    get errors() {
        return (this.contacts.error) ?
            reduceErrors(this.contacts.error) : [];
    }

    handleSelect(event) {
        // 1. Prevent default behavior of anchor tag click which is to navigate to the href url
        event.preventDefault();
        // 2. Create a custom event that bubbles. Read about event best practices at http://developer.salesforce.com/docs/component-library/documentation/lwc/lwc.events_best_practices
        const selectEvent = new CustomEvent('contactselect', {
            detail: { contactId: event.currentTarget.dataset.contactId }
        });
        // 3. Fire the custom event
        this.dispatchEvent(selectEvent);
    }
}
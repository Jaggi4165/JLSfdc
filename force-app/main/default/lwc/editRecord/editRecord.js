import { LightningElement, api } from 'lwc';

import ACCOUNT_FIELD from '@salesforce/schema/Contact.AccountId';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import TITLE_FIELD from '@salesforce/schema/Contact.Title';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import DOB_FIELD from '@salesforce/schema/Contact.Birthdate';

export default class EditRecord extends LightningElement {
    
    @api recordId;
    @api objectApiName;

    fields = [ACCOUNT_FIELD, NAME_FIELD, TITLE_FIELD, PHONE_FIELD, EMAIL_FIELD, DOB_FIELD];
}
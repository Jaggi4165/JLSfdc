import { LightningElement } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';


export default class PrintHelloWorld extends LightningElement {
    accountObject = ACCOUNT_OBJECT;
    myFields = [NAME_FIELD, WEBSITE_FIELD, RATING_FIELD, PHONE_FIELD];

    handleAccountCreated(){
        // Run code when account is created.
        // success Toast Message
    }
}
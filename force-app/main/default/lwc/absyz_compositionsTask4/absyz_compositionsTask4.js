import { LightningElement,api,wire } from 'lwc';
import getContactsByAccountId from '@salesforce/apex/absyz_LWCSessionController.getContactsByAccountId';


export default class Absyz_compositionsTask4 extends LightningElement {
    @api recordId;
    contacts;
    @wire(getContactsByAccountId, { accountId: '$recordId' })
    wiredContacts({ error, data }) {
        if (data) {
            this.contacts = data;
            console.table(data);
        } else if (error) {
            console.error('Error retrieving contacts:', error);
        }
    }    
}
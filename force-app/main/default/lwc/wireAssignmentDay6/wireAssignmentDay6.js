import { LightningElement , wire , track } from 'lwc';
import getContactsList from '@salesforce/apex/absyz_LWCSessionController.getContacts';
import findContacts from '@salesforce/apex/absyz_LWCSessionController.findContacts';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
];
export default class WireAssignmentDay6 extends LightningElement {
    contacts;
    error;

    @wire(getContactsList)
    contacts({error,data}){
        if(data){
            this.contacts = data;
            this.error = undefined
        }
        else if(error){
            this.contacts = undefined;
            this.error = error;
        }
    }


    @track searchKey = '';
    @track contactsList;
    @track columnsList = columns;

    onHandleChange(event){
        this.searchKey = event.target.value;
        findContacts({ searchKeyword : event.target.value})
        .then(result => {
            this.contactsList = result;
            this.error = undefined;
            console.table(result);
        })
        .catch(error => {
            this.contactsList = undefined;
            this.error = error;
            console.error(this.error);
        })
    }
}
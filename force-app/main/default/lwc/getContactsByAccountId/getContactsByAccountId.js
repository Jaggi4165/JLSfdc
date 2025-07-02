import { LightningElement , api , wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
export default class GetContactsByAccountId extends LightningElement {
    columns = [
        {label : 'First Name' , fieldName : 'FirstName'},
        {label : 'Last Name' , fieldName : 'LastName'},
        {label : 'Email' , fieldName : 'Email' , type : 'email'},
        {label : 'Phone' , fieldName : 'Phone'},
    ];
    @api accountId;

    @wire(getContacts,{accountId : '$accountId'}) contacts;
}
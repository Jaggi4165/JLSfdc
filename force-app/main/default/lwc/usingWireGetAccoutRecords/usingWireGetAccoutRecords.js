import { LightningElement,api, wire } from 'lwc';
// step :1   Import the apex class
import getAccounts from '@salesforce/apex/GetAccountRecords.getAccounts';

export default class UsingWireGetAccoutRecords extends LightningElement {
// defining columns for data table
data;
columns = [
    {label : 'First Name',fieldName:'FirstName'},
    {label : 'Last Name',fieldName:'LastName'},
    {label : 'Email',fieldName:'Email',type:'email'},
];
//decorate my account id with api
@api accountId;
//wire
//
@wire(getAccounts,{accountId:'$accountId'}) contacts;

}
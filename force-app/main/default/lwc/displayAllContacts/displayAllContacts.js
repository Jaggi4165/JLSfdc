import { LightningElement,track,wire } from 'lwc';
import getContacts from '@salesforce/apex/AccountController.getContacts';
export default class DisplayAllContacts extends LightningElement {
    @track data;
    @track columns=[
        {label:'Name',fieldName:'Name',type:'text'},
        {label:'Phone',fieldName:'Phone',type:'phone'},
    ];
    @wire(getContacts) myContacts({error,data}){
        if(data){
            this.data=data;
        }
        else if(error){
            this.data=undefined;
        }
    }
}
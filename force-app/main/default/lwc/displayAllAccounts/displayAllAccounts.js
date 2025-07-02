import { LightningElement, track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
export default class DisplayAllAccounts extends LightningElement {
    @track data;
    @track columns=[
        {label:'Name',fieldName:'Name',type:'text'},
        {label:'Phone',fieldName:'Phone',type:'phone'},
        {label:'Industry',fieldName:'Industry',type:'text'},
        {label:'Rating',fieldName:'Rating',type:'text'},
    ];
    @wire(getAccounts) myAccounts({error,data}){
        if(data){
            this.data=data;
        }
        else if(error){
            this.data=error;
        }
    }
    
}
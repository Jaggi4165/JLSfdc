import { LightningElement,wire } from 'lwc';
import getContacts from '@salesforce/apex/LWCPracticeController.getContacts';
export default class HelloForEach extends LightningElement {
    contacts = [];
    error;
    @wire(getContacts) myContacts({error,data}){
        if(data){
            this.contacts = data;
            this.error=undefined;
        }
        else if(error){
            this.contacts = undefined;
            this.error=error;
        }
        console.log(data);
        console.log(error);
    }

    
    contacts1 = [
        {
            Id: '003171931112854375',
            Name: 'Amy Taylor',
            Title: 'VP of Engineering'
        },
        {
            Id: '003192301009134555',
            Name: 'Michael Jones',
            Title: 'VP of Sales'
        },
        {
            Id: '003848991274589432',
            Name: 'Jennifer Wu',
            Title: 'CEO'
        }
    ];
}
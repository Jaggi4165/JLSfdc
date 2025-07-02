import { LightningElement, wire, track } from 'lwc';
import findContacts from '@salesforce/apex/ContactSearch.findContacts';

const DELAY = 300;

export default class SearchContact extends LightningElement {
    contactName = '';
    @track contactList = [];
    @wire(findContacts, { conName: '$contactName'})
    retriveContacts({error,data}){
        if(data){
            this.contactList = data;
        }
        else if(error){

        }
    }

    handleSearch(event){
        this.contactName = event.target.value;
    }

}
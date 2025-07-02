import { LightningElement,track,wire,api } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
export default class SearchContacts extends LightningElement {


    searchValue = '';
    @track allcontacts;
    @track contactsRecord;
    @track error;

    // searchKeyword(event) {
    //     this.searchValue = event.target.value;
    // }
    handleShowContactNames(event){
        this.searchValue = event.target.value;

        getContactList({
            searchKey: this.searchValue
        })
        .then(result => { 
            this.allcontacts = result; 
        })
        .catch(error => {
            const event = new ShowToastEvent({
                title: 'Error',
                variant: 'error',
                message: error.body.message,
            });
            this.dispatchEvent(event);
            this.allcontacts = null;
        });
    } 
//----------------------------------------------------------------------------------
    handleSearchKeyword() {
        
        if (this.searchValue !== '') {
            console.log("search element ====> "+this.searchValue);
            getContactList({
                    searchKey: this.searchValue
                })
                .then(result => { 
                    this.contactsRecord = result; 
                })
                .catch(error => {
                    const event = new ShowToastEvent({
                        title: 'Error',
                        variant: 'error',
                        message: error.body.message,
                    });
                    this.dispatchEvent(event);
                    this.contactsRecord = null;
                });
        } else {
            console.log("search element ====> "+this.searchValue);
            const event = new ShowToastEvent({
                variant: 'error',
                message: 'Search text missing..',
            });
            this.dispatchEvent(event);
        }
    }

}
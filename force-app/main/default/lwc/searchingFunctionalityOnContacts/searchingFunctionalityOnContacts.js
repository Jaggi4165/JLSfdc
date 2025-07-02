import { LightningElement,track} from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
export default class SearchingFunctionalityOnContacts extends LightningElement {
    searchValue = '';
    @track contactsRecord;
    @track errors;
    getSearchValue(event) {
        this.searchValue = event.target.value;
    }
    handleSearchKeyword() {
        // console.log("searchValue ====> before size checking "+this.searchValue);

        if (this.searchValue != "" && this.searchValue.length >= 4) {
            //console.log("searchValue ====> "+this.searchValue);
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
            // console.log("searchValue ele ====> "+this.searchValue);
            const event = new ShowToastEvent({
                variant: 'error',
                message: 'Please enter some value with size of 4 or above',
            });
            this.dispatchEvent(event);
        }
    }

}
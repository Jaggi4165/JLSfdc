import { LightningElement, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import getAccountList from '@salesforce/apex/AccountController.getAccountList';
export default class LwcAssignmentDay10 extends LightningElement {
    accounts;
    error;

    /** Wired Apex result so it can be refreshed programmatically */
    wiredAccountsResult;

    @wire(getAccountList)
    wiredAccounts(result) {
        this.wiredAccountsResult = result;
        if (result.data) {
            this.accounts = result.data;
            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.accounts = undefined;
        }
    }

    showpopup = false;
    selectedRecord;
    viewAccount(event){
        this.showpopup = true;
        this.selectedRecord = event.target.name;
        console.log('data ===> ',event.target.name);
        console.log('selected Rec = ',this.selectedRecord);
    }
    closePopup(event){
        console.log('close popup',event.detail);
        this.showpopup = event.detail;
    }
}
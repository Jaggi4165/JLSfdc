import { LightningElement, wire,track} from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
export default class CustomEvent2 extends LightningElement {
    @track selectedAccount;
    @wire(getAccounts) accounts;
    accountSelected(event){
        const accountId = event.detail;
        this.selectedAccount=this.accounts.data.find(account => account.Id === accountId);
    }
}
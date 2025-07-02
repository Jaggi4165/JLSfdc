import { LightningElement, wire } from 'lwc';
import getAccounts from'@salesforce/apex/GetAccountRecords.getAccounts';
export default class GetAccounts extends LightningElement {
    @wire(getAccounts) accounts;
    accountIdOriginal;
    handleClick(event){
        event.PreventDefault();
        this.accountIdOriginal = event.target.dataset.accountId;
    }
}
import { LightningElement , wire} from 'lwc';
import getAccounts2 from '@salesforce/apex/GetAccountRecords.getAccounts2';
export default class GetALLAccounts extends LightningElement {
    @wire(getAccounts2) accounts;
    accountIdOriginal;
    handleClick(event){
        event.PreventDefault();
        this.accountIdOriginal = event.target.dataset.accountId;
    }
}
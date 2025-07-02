import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
// read the data from UI. so,
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_TYPE_FIELD from '@salesforce/schema/Account.Type';


export default class LDSExample1 extends LightningElement {
    accountName = ACCOUNT_NAME_FIELD;
    accountType = ACCOUNT_TYPE_FIELD;
    @api recordId;
    handleSuccess(event){
        const event2 = new ShowToastEvent({
            title: 'Toast message',
            message: 'Record Updated',
            variant: 'success',
        });
        this.dispatchEvent(event2);
    }

}
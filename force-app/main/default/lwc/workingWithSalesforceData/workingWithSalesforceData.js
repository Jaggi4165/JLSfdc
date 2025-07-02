import { LightningElement,api} from 'lwc';

export default class WorkingWithSalesforceData extends LightningElement {
    @api recordId;
    @api objectApiName;
    fields = ['AccountId', 'Name', 'Title', 'OwnerId', 'Phone', 'Type','Match_Billing_Address__c'];
}
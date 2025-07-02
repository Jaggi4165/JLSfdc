import { LightningElement, wire, api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getAllHistories from '@salesforce/apex/AccountController.getAllHistories';

export default class FieldHistoryDatatable extends LightningElement {


New_Value__c
Old_Value__c
Tracked_Record_Id__c
columns = [
    { label: 'Field', fieldName: 'Tracked_Field_Label__c' },
    
    { label: 'Old Value', fieldName: 'Old_Value__c' },
    { label: 'New Value', fieldName: 'New_Value__c' },
    //{ label: 'New Lont Text Value', fieldName: 'New_Value_Long_Text__c' },
    
    { label: 'Changed Time', fieldName: 'LastModifiedDate' }
];

@api recordId; // This will be automatically set to the current record ID

    accounts = [];
    error;

    @wire(getRecord, { recordId: '$recordId', fields: [NAME_FIELD] })
    record;

    // Wire the Apex method to get all Accounts
    @wire(getAllHistories,{ recordId: '$recordId' })
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.accounts = [];
        }
    }

    get accountName() {
        return this.record.data ? this.record.data.fields.Name.value : 'No Account Name';
    }

}
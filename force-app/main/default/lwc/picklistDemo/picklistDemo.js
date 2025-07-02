import { LightningElement,wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
//Account Fields
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import accName from '@salesforce/schema/Account.Name';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

export default class PicklistDemo extends LightningElement {
    // For Getting Industry field picklist values.
    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    objectInfo;
    @wire(getPicklistValues,
        {
            recordTypeId: '$objectInfo.data.defaultRecordTypeId',
            fieldApiName: INDUSTRY_FIELD
        }
    )
    industryValues;
}
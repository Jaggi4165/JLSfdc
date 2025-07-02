import { LightningElement,wire ,api} from 'lwc';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import NAME_FIELD from "@salesforce/schema/Account.Name";
import RATING_FIELD from "@salesforce/schema/Account.Rating";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
export default class Absyz_AssignmentDay8Task1 extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields: [NAME_FIELD,INDUSTRY_FIELD,RATING_FIELD] })
    account;

    get name() {
    return getFieldValue(this.account.data, NAME_FIELD);
  }

  get rating() {
    return getFieldValue(this.account.data, RATING_FIELD);
  }

  get industry() {
    return getFieldValue(this.account.data, INDUSTRY_FIELD);
  }
}
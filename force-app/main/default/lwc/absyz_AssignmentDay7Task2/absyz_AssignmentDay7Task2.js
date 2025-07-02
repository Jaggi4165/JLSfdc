import { LightningElement , api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {  FlowNavigationBackEvent,  FlowNavigationNextEvent} from "lightning/flowSupport";
export default class Absyz_AssignmentDay7Task2 extends LightningElement {
    @api recordId;
    @api availableActions = [];

  CreateContact() {
      const evt = new ShowToastEvent({
            title: 'Updated',
            message: 'Account is Updated',
            variant: 'success',
        });
        this.dispatchEvent(evt);
    if (this.availableActions.find((action) => action === "NEXT")) {
      const navigateNextEvent = new FlowNavigationNextEvent();
      this.dispatchEvent(navigateNextEvent);
    }
  }
  handleBack() {
    if (this.availableActions.find((action) => action === "BACK")) {
      const navigateBackEvent = new FlowNavigationBackEvent();
      this.dispatchEvent(navigateBackEvent);
    }
  }
}
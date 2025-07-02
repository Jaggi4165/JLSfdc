import { LightningElement,track } from 'lwc';

export default class CheckBoxValueReturm extends LightningElement {
    @track status=true;
    myHandlerCode(event){
     this.status = event.target.checked
    }
}
//this.checkBoxFieldValue = event.target.checked;
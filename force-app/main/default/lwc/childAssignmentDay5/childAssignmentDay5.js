import { LightningElement,api } from 'lwc';
export default class ChildAssignmentDay5 extends LightningElement {
    message = 'Default Message from Child'
    @api
    invokeByParent(message){
        this.message = message;
    }
}
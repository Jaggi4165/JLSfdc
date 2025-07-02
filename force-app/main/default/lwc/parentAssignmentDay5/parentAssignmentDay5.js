import { LightningElement } from 'lwc';
export default class ParentAssignmentDay5 extends LightningElement {
    onButtonClick(event){
        this.template.querySelector('c-child-assignment-day5').invokeByParent('This Message is from Parent Component');
    }
}
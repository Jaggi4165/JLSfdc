import { LightningElement } from 'lwc';
export default class Absyz_AssignmentDay9Parent extends LightningElement {
    valueFromChild='';
    onButtonClick(event){
        this.valueFromChild = event.detail;
    }
}
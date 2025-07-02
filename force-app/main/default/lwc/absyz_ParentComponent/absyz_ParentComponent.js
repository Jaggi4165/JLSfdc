import { LightningElement } from 'lwc';
export default class Absyz_ParentComponent extends LightningElement {
    input='';
    childinput = '';
    onInputChange(event){
        this.input = event.target.value;
    }

    onchangeinchild(event){
        this.childinput = event.detail.text;
    }
}
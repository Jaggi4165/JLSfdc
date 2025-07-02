import { LightningElement } from 'lwc';
export default class Absyz_DataBinding extends LightningElement {
    myName="Jagadeeswara Rao Kusumuru";
    showData = false;
    handlerCheckBoxChange(event){
        const eventName = event.target.name;
        if(eventName === "showData"){
            this.showData = event.target.checked;
        }
    }
}
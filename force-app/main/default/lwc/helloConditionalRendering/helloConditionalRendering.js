import { LightningElement } from 'lwc';

export default class HelloConditionalRendering extends LightningElement {
    areDetailsVisible = false;
    detailsHolder;
    handleChange(event) {
        this.areDetailsVisible = event.target.checked;
    }
    handleInputChange(event){
        this.detailsHolder = event.target.value;
    }
    get dataInUpperCase(){
        return `${this.detailsHolder}`.trim().toUpperCase();
        //return this.detailsHolder.upperCase();
    }
}
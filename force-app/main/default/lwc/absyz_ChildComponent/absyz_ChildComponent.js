import { LightningElement,api } from 'lwc';
export default class Absyz_ChildComponent extends LightningElement {
    @api parentinput;
    text = '';
    onTextChange(event){
        this.text = event.target.value;
    }

    onButtonClickHandle(event){
        const myCustomEvent = new CustomEvent('changeinchild',{
            detail : {
                text :  this.text
            }
        });
        this.dispatchEvent(myCustomEvent);
    }
}
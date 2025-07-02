import { LightningElement } from 'lwc';

export default class ParentComponent1310 extends LightningElement {
    myMessageHandler(event){
        var myMessage = event.target.value();
        console.log(myMessage);
        this.template.querySelector('c-parent-component1310').parentMessageHandler(myMessage);
    }
}
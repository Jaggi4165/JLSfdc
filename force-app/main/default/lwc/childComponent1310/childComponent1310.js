import { LightningElement,api } from 'lwc';

export default class ChildComponent1310 extends LightningElement {
    msg;
    @api parentMessageHandler(message){
        this.msg = message;
    }
}
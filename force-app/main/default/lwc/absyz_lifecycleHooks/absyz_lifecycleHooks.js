import { LightningElement } from 'lwc';
export default class Absyz_lifecycleHooks extends LightningElement {
    isRendered = false;
    constructor(){
        super();
        console.log('constructor');
    }
    connectedCallback() {
        console.log('connectedCallback');
    }
    renderedCallback(){      
        if(!this.isRendered){
            console.log('renderedCallback');
            this.isRendered = true;
        }
    }
    disconnectedCallback() {
        console.log('disconnectedCallback');
    }
    errorCallback() {
        console.log('errorCallback');
    }

    myName="Jagadeeswara Rao Kusumuru";
    showData = false;
    handlerCheckBoxChange(event){
        const eventName = event.target.name;
        if(eventName === "showData"){
            this.showData = event.target.checked;
        }
    }
    
}
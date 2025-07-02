import { LightningElement,api } from 'lwc';
export default class ReusableModal extends LightningElement {
    @api record;
    connectedCallback() {
        console.log(`data from parent ${JSON.stringify(this.record)}`);
    }
    closeModal(event){
        console.log('close Event');
        var eve = new CustomEvent('closepopup',{detail : false});
        this.dispatchEvent(eve);
    }
}


//
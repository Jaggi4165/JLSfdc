import { LightningElement,api } from 'lwc';

export default class CustomEvents extends LightningElement {
    // Code 
    @api account;

    selectYourAccount(event){
        event.preventDefault();
        const selectedEvent = new CustomEvent('selected',{detail:this.account.Id});
        this.dispatchEvent(selectedEvent);
    }
}
import { LightningElement } from 'lwc';
export default class ChildAssignmentDay9 extends LightningElement {
    handleClick(event){
        const eventName = event.target.name;
        var eventValue;
        if(eventName === 'absyz'){
            eventValue = 'www.absyz.com'
        }
        else if(eventName === 'trailhead'){
            eventValue = 'www.trailhead.com'
        }
        if(eventValue != null || eventValue != undefined){
            var eve = new CustomEvent('btnclick',{ detail : eventValue });
            this.dispatchEvent(eve);
        }
    }
}
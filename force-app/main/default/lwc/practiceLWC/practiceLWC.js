import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class PracticeLWC extends LightningElement {
    currentStep = "step-1";
    steps = [
        { label: 'Contacted', value: 'step-1' },
        { label: 'Open', value: 'step-2' },
        { label: 'Unqualified', value: 'step-3' },
        { label: 'Nurturing', value: 'step-4' },
        { label: 'Closed', value: 'step-5' }
    ];

    renderedCallback(){
        this.currentStep = this.currentStep;
    }
    onMove(event){
        this.steps = this.steps.map((item,index) => {
            if(this.currentStep == "step-"+index){
                return this.currentStep = "step-"+(index+1);
            }
        });
        console.table(this.steps);
    }
    onPrevious(event){
        this.steps = this.steps.map((item,index) => {
            if(this.currentStep == "step-"+index){
                return this.currentStep = "step-"+(index-1);
            }
        });
        console.table(this.steps);
    }
    showToast(title,message,variant,mode){
        const eve = new ShowToastEvent({
            title : title,
            message : message,
            variant : variant,
            mode : mode
        });
        this.dispatchEvent(eve);
    }
}
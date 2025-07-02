import {LightningElement, track} from 'lwc';
import flatpick from '@salesforce/resourceUrl/flatpickr';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
var flatpickdp ={};
 
export default class FlatPickerLWC extends LightningElement {
    @track selectedDate; 
    @track start;
    @track end;
    datepickerInitialized = false;
    
    renderedCallback(){
        if(this.datepickerInitialized){
            return;
        }
        this.datepickerInitialized = true;
  
        Promise.all([
            loadScript(this, flatpick + '/flatpickr.js'),
            loadStyle(this,flatpick + '/flatpickr.min.css')
        ]).then(() => {
            this.initDatepicker();
        })
        .catch(error => {
            console.log({message: 'Error onloading',error});
        });
    } 
 
    initDatepicker(){
        let self = this;
        const dpDiv = this.template.querySelector('lightning-input.flatpickr');
        flatpickdp =  flatpickr(dpDiv,{
            inline:false,
            minDate: "today",
            mode: "range",
            onChange: function(selectedDates, dateStr, instance) {
                self.getDateVal(dateStr);
                console.log(selectedDates);
                console.log("selected dates=1=>",dateStr);
                var ss = dateStr.split('to');
                this.start = ss[0];
                this.end = ss[1];
                console.log("Start",this.start);
                console.log("End",this.end);
            },
            onOpen: [
                function(selectedDates, dateStr, instance){
                    console.log(selectedDates);
                    console.log("selected dates=2=>",dateStr);
                },
                function(selectedDates, dateStr, instance){
                    console.log(selectedDates);
                    console.log("selected dates=3=>",dateStr);
                }
            ],
             
            onClose: function(selectedDates, dateStr, instance){
                console.log(selectedDates);
                console.log("selected dates=4=>",dateStr);
            }
        });
    }
 
    openDatePicker(){
        flatpickdp.open();
    }
  
    getDateVal(dateStr){
        console.log("selected dates=5=>",dateStr);
    }

    onButtonClick(event){
        
    }
}
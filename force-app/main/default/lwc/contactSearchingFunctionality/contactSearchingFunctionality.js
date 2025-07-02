import { LightningElement, api, wire, track } from 'lwc';
import getRelatedInputsMethod from '@salesforce/apex/ContactController.getRelatedInputsMethod';
import getRelatedInputsMethod2 from '@salesforce/apex/ContactController.getRelatedInputsMethod2';

export default class ContactSearchingFunctionality extends LightningElement {

    @track getRelatedInputs;
    searchKeys;
    mydata;
    myerror;
    mydata2;
    myerror2;

    getInput(event)
    {
        this.searchKeys = event.target.value;
        getRelatedInputsMethod({key1: this.searchKeys})
        .then(response => {
            this.mydata = response;
        }).catch(error => {
            this.myerror=error;
        });

    }
    
    setAsInput(event)
    {


        console.log("before===>"+this.searchKeys);
        this.searchKeys = this.template.querySelector('a').text;
        event.preventDefault();
        console.log("before2 ===>"+this.searchKeys);
    }

        getDetailsOfInput(event){
            if(this.searchKeys != null)
            {
                getRelatedInputsMethod2({key2: this.searchKeys})
                .then(response => {
                    this.mydata2 = response;
                 })
                 .catch(error => {
                    this.myerror2=error;
                });
            }
            
            else
            {
                alert('Please Enter something');
            }
        }
        
}
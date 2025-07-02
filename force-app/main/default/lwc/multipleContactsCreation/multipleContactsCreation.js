import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import NAME_FIELD from '@salesforce/schema/Contact.LastName';
import ACCNAME_FIELD from '@salesforce/schema/Contact.AccountId';



export default class MultipleContactsCreation extends LightningElement{
    @api recordId;
    @track visitorList = [{
        lastname:'',
        accId:'',
    }];

  
    addRow() {
        this.visitorList.push(JSON.parse(JSON.stringify(this.visitorList)));
    }

    deleteRow(event) {
        var rowIndex = event.currentTarget.dataset.index;
        if(this.visitorList.length > 1) {
            this.visitorList.splice(rowIndex, 1);
        } 
    }

    handleChange(event) {
        var rowIndex = event.currentTarget.dataset.index;
        if(event.target.name === 'name') {
            this.visitorList[rowIndex].name = event.target.value;
            this.visitorList[rowIndex].accid=this.recordId;
        }
    }


    handleSave() { 
        var emptyCheck = false; 
        for(let rowIndex in this.visitorList) { 
            if(this.visitorList[rowIndex].name == null ||
                
                this.visitorList[rowIndex].name == '') {
                emptyCheck = true;
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error',
                    message: 'Please fill all empty fields',
                    variant: 'error',
                }));
                return false;
            } else {
                console.log('pass'+this.recordId);
            }
        }
        
        if(emptyCheck === false) {
        const fields = {}; 
        for(let rowIndex in this.visitorList) {
            fields[NAME_FIELD.fieldApiName] = this.visitorList[rowIndex].name;
            fields[ACCNAME_FIELD.fieldApiName] = this.visitorList[rowIndex].accid;

            const recordInput = { apiName: CONTACT_OBJECT.objectApiName, fields};
            createRecord(recordInput)
            .then(result => {
                if(result !== undefined) { 
                    this.visitorList[rowIndex].name = '';
                    
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Success',
                        message: 'Visitor created Successfully',
                        variant: 'success',
                    }));
                }
            })
            .catch(error => {
                console.log("error is:"+error);
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error creating record',
                    message: 'ERROR IS '+error.body.message,
                    variant: 'error',
                }));
            });
          }
       }
    }

}
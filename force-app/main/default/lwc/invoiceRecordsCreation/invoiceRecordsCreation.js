import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import INVOICELINEITEM_OBJECT from '@salesforce/schema/InvoiceLine';
import NAME_FIELD from '@salesforce/schema/InvoiceLine.Name';
import PAYMENT_DUE_DATE_FIELD from '@salesforce/schema/InvoiceLine.Payment_Due_Date__c';
import QUANTITY_FIELD from '@salesforce/schema/InvoiceLine.Quantity';
import START_FIELD from '@salesforce/schema/InvoiceLine.InvoiceLineStartDate';
import END_FIELD from '@salesforce/schema/InvoiceLine.InvoiceLineEndDate';
import TYPE_FIELD from '@salesforce/schema/InvoiceLine.Type';
import INVOICE_FIELD from '@salesforce/schema/InvoiceLine.InvoiceId';



export default class InvoiceRecordsCreation extends LightningElement{
    @api recordId;
    @track visitorList = [{
        name:'',
        company:'',
        quantity:'',
        startdate:'',
        enddate:'',
        type:'',
        invoiceId:'',
  
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
        } else if(event.target.name === 'Payment Due Date') {
            this.visitorList[rowIndex].company = event.target.value;
        }
        else if(event.target.name === 'Quantity') {
            this.visitorList[rowIndex].quantity = event.target.value;
        } 
        else if(event.target.name === 'InvoiceLineStartDate') {
            this.visitorList[rowIndex].startdate = event.target.value;
        } 
        else if(event.target.name === 'InvoiceLineEndDate') {
            this.visitorList[rowIndex].enddate = event.target.value;
        } 
        else if(event.target.name === 'Type') {
            this.visitorList[rowIndex].type = event.target.value;
        } 
    }


    handleSave() { 
        var emptyCheck = false; 
        for(let rowIndex in this.visitorList) { 
            if(this.visitorList[rowIndex].name == null ||
                this.visitorList[rowIndex].company == null ||
                this.visitorList[rowIndex].quantity == null ||
                this.visitorList[rowIndex].name == '' ||
                this.visitorList[rowIndex].company == ''||
                this.visitorList[rowIndex].quantity =='') {
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
            fields[PAYMENT_DUE_DATE_FIELD.fieldApiName] = this.visitorList[rowIndex].company;
            fields[QUANTITY_FIELD.fieldApiName] = this.visitorList[rowIndex].quantity;
            fields[TYPE_FIELD.fieldApiName] = this.visitorList[rowIndex].type;
            fields[STARRT_FIELD.fieldApiName] = this.visitorList[rowIndex].startdate;
            fields[END_FIELD.fieldApiName] = this.visitorList[rowIndex].enddate;
            fields[INVOICE_FIELD.invoiceId] = this.recordId;

            const recordInput = { apiName: INVOICELINEITEM_OBJECT.objectApiName, fields};
            createRecord(recordInput)
            .then(result => {
                if(result !== undefined) { 
                    this.visitorList[rowIndex].name = '';
                    this.visitorList[rowIndex].company = '';
                    this.visitorList[rowIndex].quantity = '';
                    
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
                    message: error.body.message,
                    variant: 'error',
                }));
            });
          }
       }
    }

}
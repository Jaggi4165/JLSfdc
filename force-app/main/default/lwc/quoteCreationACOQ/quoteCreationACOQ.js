import { LightningElement,track } from 'lwc';

import fetchContacts from '@salesforce/apex/ApexController.fetchContacts';
import fetchAccountDetails from '@salesforce/apex/ApexController.fetchAccountDetails';

import { ShowToastEvent } from "lightning/platformShowToastEvent";
// Account Fields  Importing
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import ADDRESS_FIELD from '@salesforce/schema/Account.BillingAddress';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

//Contact Fiels Importing
import CONTACT_OBJECT from "@salesforce/schema/Contact";
import CONTACT_NAME_FIELD from '@salesforce/schema/Contact.Name';
import CONTACT_PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import CONTACT_EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import CONTACT_ADDRESS_FIELD from '@salesforce/schema/Contact.MailingAddress';
import CONTACT_ACCOUNT_FIELD from '@salesforce/schema/Contact.accountId';

export default class QuoteCreationACOQ extends LightningElement {
    finalAccountId;
    
// Pages
newContactPage=false;
existingContactPage=false;
newAccountPage=false;
existingAccountPage=false;
existingOppPage=false;
newOppPage=false;


// accountName = NAME_FIELD;
// accountPhone = PHONE_FIELD;
// accountIndusty=INDUSTRY_FIELD;
// accountAddress=ADDRESS_FIELD;



// contactName =CONTACT_NAME_FIELD;
// contactPhone=CONTACT_PHONE_FIELD;
// contactEmail=CONTACT_EMAIL_FIELD;
// contctAddress=CONTACT_ADDRESS_FIELD;
// contactAccountId=CONTACT_ACCOUNT_FIELD;

     //Options
     get optionsForContact() {
        return [
            { label: 'Existing Contact', value: 'Existing Contact' },
            { label: 'New Contact', value: 'New Contact' },
        ];
    }
    get optionsForAccount() {
        return [ 
            { label: 'Existing Account', value: 'Existing Account' },
            { label: 'New Account', value: 'New Account' },
        ];
    }
    get optionsForOpp() {
        return [ 
            { label: 'Existing Opportunity', value: 'Existing Opportunity' },
            { label: 'New Opportunity', value: 'New Opportunity' },
        ];
    }
    

    @track currentStep = '1';
 
    handleOnStepClick(event) {  this.currentStep = event.target.value; }
 
    get isStepOne() { return this.currentStep === "1";  }
    get isStepTwo() { return this.currentStep === "2"; }
    get isStepThree() { return this.currentStep === "3"; }
    get isEnableNext() { return this.currentStep != "3"; }
    get isEnablePrev() {return this.currentStep != "1"; }
    get isEnableFinish() {return this.currentStep === "3"; }
 
    handleNext()
    {
        if(this.currentStep == "1"){ this.currentStep = "2"; }
        //else if(this.currentStep = "2"){ this.currentStep = "3";}
        else if(this.currentStep == "2"){ this.currentStep = "3"; }
        else{ alert("Create Account & Opportunity"); }
    }
  
    handlePrev()
    {
        if(this.currentStep == "3"){ this.currentStep = "2"; }
        else if(this.currentStep = "2"){ this.currentStep = "1"; }
    }
 
    handleFinish(){
        // create Quote Code Here
        alert("Quote Created...");
    }

    handleRadioChange(event)
    {
        const selectedContactOption = event.detail.value;
        
        if (selectedContactOption == 'New Contact'){ this.newContactPage = true;  }
        else{ this.newContactPage = false; }

        if (selectedContactOption == 'Existing Contact'){ this.existingContactPage = true; }
        else{ this.existingContactPage = false; } 
    }

    handleRadioChange2(event)
    {
        const selectedAccountOption = event.detail.value;

        if (selectedAccountOption == 'New Account'){ this.newAccountPage = true; }
        else{ this.newAccountPage = false; }
      
        if (selectedAccountOption == 'Existing Account'){ this.existingAccountPage = true; }
        else{ this.existingAccountPage = false; } 
    }

    handleRadioChange3(event)
    {
        const selectedAccountOption = event.detail.value;
       

        if (selectedAccountOption == 'New Opportunity'){ this.newOppPage = true; }
        else{ this.newOppPage = false; }
      
        if (selectedAccountOption == 'Existing Opportunity'){ this.existingOppPage = true; }
        else{ this.existingOppPage = false; } 
    }


    handleContactSuccess(event) {
        const eventSuccess = new ShowToastEvent({
            title: 'Success',
            variant: 'success',
            message: 'Contact Created Successfully : '+event.detail.id,
        });
        this.dispatchEvent(eventSuccess);
    }
    handleContactSubmit(event) {
        event.preventDefault();
        // Get data from submitted form
        const fields = event.detail.fields;
        // Here you can execute any logic before submit
        // and set or modify existing fields
        fields.AccountId = this.finalAccountId.toString();
        // You need to submit the form after modifications
        this.template
            .querySelector('lightning-record-edit-form').submit(fields);
    }

    handleAccountSuccess(event) {
        this.finalAccountId=event.detail.id;
        const eventSuccess = new ShowToastEvent({
            title: 'Success',
            variant: 'success',
            message: 'Account Created Successfully : '+event.detail.id,
        });
        this.dispatchEvent(eventSuccess);
    }

    handleValueSelcted(event) {
        this.finalAccountId = event.detail;    
    } 
validateLookupField() {
        this.template.querySelector('c-custom-lookup').isValid();
    }


    ContactSearchKey=''; 
contactRecords;
contactRecords2;
presentContact='';
searchelement='';
// handleGetContactSearch(event)
// {
//     this.searchelement = event.target.value;
// }

handleGetContactSearch(event) {
        // Creates the event
        
        this.ContactSearchKey=event.target.value;
        //alert('clicked on :'+this.ContactSearchKey);
        fetchContacts({
            searchkey: this.ContactSearchKey
        })
        .then(result => { 
            // this.finalContactId=result.Id;
            // this.finalAccountId=result.AccountId;
            this.contactRecords = result; 

        })
        .catch(error => {
            const event = new ShowToastEvent({
                title: 'Error',
                variant: 'error',
                message: 'No Such Data Found !',
            });
            this.dispatchEvent(event);
        });
    }
    accountRecord;
    getTheData(event){
        this.ContactSearchKey = event.currentTarget.dataset.id;
        this.contactRecords='';
        // alert('selected row : '+this.ContactSearchKey);
        // alert("final contact id: "+this.finalContactId);
        // alert("final accountId " +this.finalAccountId);

        fetchAccountDetails({
            conId: this.ContactSearchKey
           
        })
        .then(result => { 
            this.accountRecord = result; 
        })
        .catch(error => {
            const event = new ShowToastEvent({
                title: 'Error',
                variant: 'error',
                message: 'No Such Data Found !',
            });
            this.dispatchEvent(event);
        });
     }


     //=================================Opportunity
     handleOppSubmit(event)
     {
        event.preventDefault();
        // Get data from submitted form
        const fieldsOpp = event.detail.fields;
        // Here you can execute any logic before submit
        // and set or modify existing fields
        fieldsOpp.AccountId = this.finalAccountId.toString();
        // You need to submit the form after modifications
        this.template
            .querySelector('lightning-record-edit-form').submit(fieldsOpp);
     }
     handleOppSuccess(event)
     {
        const eventOppSuccess = new ShowToastEvent({
            title: 'Success',
            variant: 'success',
            message: 'Opportunity Created Successfully : '+event.detail.id,
        });
        this.dispatchEvent(eventOppSuccess);
     }

}
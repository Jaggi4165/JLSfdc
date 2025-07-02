import { LightningElement,api,track,wire } from 'lwc';
import fetchContacts from '@salesforce/apex/QuoteWizardApexClass.fetchContacts';
import fetchAccountDetails from '@salesforce/apex/QuoteWizardApexClass.fetchAccountDetails';

import fetchOpp from '@salesforce/apex/QuoteWizardApexClass.fetchOpp';
import fetchOppDetails from '@salesforce/apex/QuoteWizardApexClass.fetchOppDetails';

import { ShowToastEvent } from "lightning/platformShowToastEvent";

const columns = [{ label: 'First Name', fieldName: 'Name' },];
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

// Opportunity Fields Importing 
import OPP_NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import OPP_STAGE_FIELD from '@salesforce/schema/Opportunity.StageName';
import OPP_CLOSEDATE_FIELD from '@salesforce/schema/Opportunity.CloseDate';



export default class QuoteWizardDemo extends LightningElement {

    finalAccountIdOpp;
    finalContactId;
    finalAccountId; 
    oppAccId;

    @track accRecord = {
        Name : NAME_FIELD,
        Industry : INDUSTRY_FIELD,
        Phone : PHONE_FIELD,
        BillingAddress : ADDRESS_FIELD
    };

    handleNameChange(event) {
        this.accRecord.Name = event.target.value;
        window.console.log('Name ==> '+this.accRecord.Name);
    }

    handlePhoneChange(event) {
        this.accRecord.Phone = event.target.value;
        window.console.log('Phone ==> '+this.accRecord.Phone);
    }

    handleAddressChange(event) {
        this.accRecord.BillingAddress = event.target.value;
        window.console.log('Type ==> '+this.accRecord.BillingAddress);
    }

    handleIndustryChange(event) {
        this.accRecord.Industry = event.target.value;
        window.console.log('Industry ==> '+this.accRecord.Industry);
    }

    createAccount() {
        const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.accRecord.Name;
        fields[PHONE_FIELD.fieldApiName] = this.accRecord.Phone;
        fields[INDUSTRY_FIELD.fieldApiName]=this.accRecord.Industry;
        fields[ADDRESS_FIELD.fieldApiName]=this.accRecord.BillingAddress;
        const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields };
        createRecord(recordInput)
            .then(account => {
                this.finalAccountId = account.id;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account created',
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
        }








    
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
    
        // Pages
        newContactPage=false;
        existingContactPage=false;
        newAccountPage=false;
        existingAccountPage=false;
        existingOppPage=false;
        newOppPage=false;
    
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
            else if(this.currentStep == "2" && this.oppIDValid==true){ this.currentStep = "3"; }
            else{
                alert("Create Account & Opportunity");
            }
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
}
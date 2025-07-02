import { LightningElement,api,track,wire } from 'lwc';
import fetchContacts from '@salesforce/apex/QuoteWizardApexClass.fetchContacts';
import fetchAccountDetails from '@salesforce/apex/QuoteWizardApexClass.fetchAccountDetails';

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

// Opportunity Fields Importing 
import OPP_NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import OPP_STAGE_FIELD from '@salesforce/schema/Opportunity.StageName';
import OPP_CLOSEDATE_FIELD from '@salesforce/schema/Opportunity.CloseDate';



export default class FinalQuoteWizard extends LightningElement {

    @api finalAccountId;
    @api finalContactId;
// Pages
newContactPage=false;
existingContactPage=false;
newAccountPage=false;
existingAccountPage=false;
existingOppPage=false;
newOppPage=false;


accountName = NAME_FIELD;
accountPhone = PHONE_FIELD;
accountIndusty=INDUSTRY_FIELD;
accountAddress=ADDRESS_FIELD;



contactName =CONTACT_NAME_FIELD;
contactPhone=CONTACT_PHONE_FIELD;
contactEmail=CONTACT_EMAIL_FIELD;
contctAddress=CONTACT_ADDRESS_FIELD;
contactAccountId=CONTACT_ACCOUNT_FIELD;

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
    cname;
    cmail;
    cphone;
    caddres;
    nameHandleChange(event){
        this.cname = event.target.value;
    }
    phoneHandleChange(event){
        
        this.cphone = event.target.value;
    }
    emailHandleChange(event){
        this.cmail = event.target.value;
    }
    addresHandleChange(event){
        this.caddres = event.target.value;
    }
    saveContact(event){
        const fields = {};

        fields[CONTACT_NAME_FIELD.fieldApiName] = this.cname;
        fields[CONTACT_PHONE_FIELD.fieldApiName] = this.cphone;
        fields[CONTACT_EMAIL_FIELD.fieldApiName] = this.cmail;
        fields[CONTACT_ADDRESS_FIELD.fieldApiName] = this.caddres;
        fields[CONTACT_ACCOUNT_FIELD.fieldApiName] = this.finalAccountId;
         var conRecordInput = {apiName : CONTACT_OBJECT.fieldApiName, fields};
        createRecord(conRecordInput).then(response => {
            alert('Contact created with Id: ' +response.id);
            this.finalContactId=respone.id;
        }).catch(error => {
            alert('Error: ' +JSON.stringify(error));
        });
    }

    handleAccountSuccess(event){
        this.finalAccountId=event.detail.id;
        alert("account id: ==== > "+this.finalAccountId);
    }
    handleContactSuccess(event)
    {
        this.finalContactId=event.detail.id;
        alert("contact id: ==== > "+this.finalContactId);
        
    }
  

// lookUp for contact search
ContactSearchKey=''; 
contactRecords;
searchelement='';
handleSearchElement(event){
    this.ContactSearchKey = event.target.value;
}
handleContactSearch(event) {
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
AccountRecord;
getTheData(event){
    this.ContactSearchKey = event.currentTarget.dataset.id;
    this.contactRecords='';

    fetchAccountDetails({
        conId: this.ContactSearchKey
    })
    .then(result => { 
        this.AccountRecord = result; 
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




handleValueSelcted(event) {
        this.finalAccountId = event.detail;    
    } 
validateLookupField() {
        this.template.querySelector('c-custom-lookup').isValid();
    }
    


    
 


 
    
    //----------------------------------------------------------------------------------    
    // -------------------------------------------------------------------------------------- STEP : 1---------


    }
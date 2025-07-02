import { LightningElement,api,track,wire } from 'lwc';
import fetchAccounts from '@salesforce/apex/ApexController.fetchAccounts';
import fetchAccountDetails from '@salesforce/apex/ApexController.fetchAccountDetails';

import { createRecord,getRecord} from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
// Account Fields  Importing
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import ADDRESS_FIELD from '@salesforce/schema/Account.BillingAddress';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

// Opportunity Fields Importing 
import OPP_NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import OPP_STAGE_FIELD from '@salesforce/schema/Opportunity.StageName';
import OPP_CLOSEDATE_FIELD from '@salesforce/schema/Opportunity.CloseDate';
import StayInTouchSignature from '@salesforce/schema/User.StayInTouchSignature';

export default class Demo1 extends LightningElement {

    finalContactId;
    finalAccountId;
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

    // Pages
    newContactPage=false;
    existingContactPage=false;
    newAccountPage=false;
    existingAccountPage=false;

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


    handleAccountSuccess(event){
       
        
        this.accountRecordId=event.detail.id; 
        console.log("account name : "+event.detail.Id);
        this.finalAccountId = event.detail.id;
        
    }

   
    //----------------------------------------------- lookup for account

    
    //----------------------------------------------------------------------------------    
    // -------------------------------------------------------------------------------------- STEP : 1---------
}
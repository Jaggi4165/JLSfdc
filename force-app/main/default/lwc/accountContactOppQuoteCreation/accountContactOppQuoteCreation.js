/*
Use Case             :      Quote Creation Wizard
Developer Name       :      Kusumuru jagadeeswara rao
Last Modifid On      :      11 - Nov - 2021
*/

import { LightningElement, track, wire, api } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
//Apex Methods
//For Step-1
import fetchContacts from '@salesforce/apex/QuoteWizardApexClass.fetchContacts';
import fetchAccountDetails from '@salesforce/apex/QuoteWizardApexClass.fetchAccountDetails';
import fetchAccount from '@salesforce/apex/QuoteWizardApexClass.fetchAccount';
import insertAccountMethod from '@salesforce/apex/QuoteWizardApexClass.insertAccountMethod';
import insertContactMethod from '@salesforce/apex/QuoteWizardApexClass.insertContactMethod';
//For Step-2
import fetchOpportunity from '@salesforce/apex/QuoteWizardApexClass.fetchOpportunity';
import fetchOppDetails from '@salesforce/apex/QuoteWizardApexClass.fetchOppDetails';
//For Step-3
import getAccountDetails from '@salesforce/apex/QuoteWizardApexClass.getAccountDetails';
import getContactDetails from '@salesforce/apex/QuoteWizardApexClass.getContactDetails';
import getOpportunityDetails from '@salesforce/apex/QuoteWizardApexClass.getOpportunityDetails';
import insertQuoteMethod from '@salesforce/apex/QuoteWizardApexClass.insertQuoteMethod';
//For step-4
import fetchContracts from '@salesforce/apex/QuoteWizardApexClass.fetchContracts';
import insertOrderMethod from '@salesforce/apex/QuoteWizardApexClass.insertOrderMethod';
//Toast Mesages,Object Info,Navigation
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { NavigationMixin } from 'lightning/navigation';
import conLastName from '@salesforce/schema/Contact.LastName';
import accountId from '@salesforce/schema/Contact.AccountId';
//Account Fields
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import accName from '@salesforce/schema/Account.Name';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
//PermissionSetsdata
// import hasPermissionSetUp from '@salesforce/userPermission/ViewSetup';//Quote_Wizard_Manager
import hasPermissionSetUp from '@salesforce/customPermission/Can_Create_Orders_in_Quote_Wizard';
//Custom Labels
// for step-1
import Step1Name from '@salesforce/label/c.Lightning_Indicator_step1_name';
import Step2Name from '@salesforce/label/c.Lightning_Indicator_step2_name';
import Step3Name from '@salesforce/label/c.Lightning_Indicator_step3_name';
import Step4Name from '@salesforce/label/c.Lightning_Indicator_step4_name';
import contactInfoDivider from '@salesforce/label/c.contactInfoSectionDivider';
import contactNameLable from '@salesforce/label/c.contactNameLable';
import generalConInfoDivider from '@salesforce/label/c.newConPageGeneralConInfoDivider';
import conFirstNameLabel from '@salesforce/label/c.contactFirstNameLabel';
import conLastNameLabel from '@salesforce/label/c.contactLastNameLabel';
import conPhoneLabel from '@salesforce/label/c.contactPhoneLabel';
import conEmailLabel from '@salesforce/label/c.contactEmailLabel';
import conAddressInfoDivider from '@salesforce/label/c.conPageConAddressInfoDivider';
import conMailingAddressLabel from '@salesforce/label/c.conMailingAddressLabel';
import conMailingStreetLabel from '@salesforce/label/c.conMailingStreetLabel';
import conMailingStateLabel from '@salesforce/label/c.conMailingStateLabel';
import conMailingcityLabel from '@salesforce/label/c.conMailingcityLabel';
import conMailingCodeLabel from '@salesforce/label/c.conMailingCodeLabel';
import conMailingCountryLabel from '@salesforce/label/c.conMailingCountryLabel';
import accountInfoDivider from '@salesforce/label/c.conPageAccInfoDivider';
//Button Labels 
import nextButtonLabel from '@salesforce/label/c.nextButtonLabel';
import previousButtonLabel from '@salesforce/label/c.previousButtonLabel';
import cancelButtonLabel from '@salesforce/label/c.cancelButtonLabel';
import createQuoteButtonLabel from '@salesforce/label/c.createQuoteButtonLabel';
import createOrderButtonLabel from '@salesforce/label/c.createOrderButoonLabel';

import exAccSectionDivider from '@salesforce/label/c.exAccSectionDivider';
import generalAccInfoDivider from '@salesforce/label/c.generalAccInfoDivider';
import accNumberLabel from '@salesforce/label/c.accNumberLabel';
import accOwnerLabel from '@salesforce/label/c.accOwnerLabel';
import accNameLabel from '@salesforce/label/c.accNameLabel';
import accIndustryLabel from '@salesforce/label/c.accIndustryLabel';
import accPhoneLabel from '@salesforce/label/c.accPhoneLabel';
import accBillingAddressLabel from '@salesforce/label/c.accBillingAddressLabel';
import accBillingStreetLabel from '@salesforce/label/c.accBillingStreetLabel';
import accBillingStateLabel from '@salesforce/label/c.accBillingStateLabel';
import accBillingcityLabel from '@salesforce/label/c.accBillingcityLabel';
import accBillingCodeLabel from '@salesforce/label/c.accBillingCodeLabel';
import accBillingCountryLabel from '@salesforce/label/c.accBillingCountryLabel';
import accAddressInfoDivider from '@salesforce/label/c.newPageAccAddressInfoDivider';
import selectedAccInfoDivider from '@salesforce/label/c.selectedAccInfoDivider';
import accInfoDivider from '@salesforce/label/c.accInfoDivider';
import conInfoDivider from '@salesforce/label/c.conInfoDivider';
import oppInfoDivider from '@salesforce/label/c.oppInfoDivider';
import selectOppInfoDivider from '@salesforce/label/c.selectOppInfoDivider';
import generalOppInfoDivider from '@salesforce/label/c.generalOppInfoDivider';
import selectedOppInfoDivider from '@salesforce/label/c.selectedOppInfoDivider';
import oppNameLabel from '@salesforce/label/c.oppNameLabel';
import oppStagenameLabel from '@salesforce/label/c.oppStagenameLabel';
import oppCloseDateLabel from '@salesforce/label/c.oppCloseDateLabel';
import oppAmountLabel from '@salesforce/label/c.oppAmountLabel';

import contractNameLabel from '@salesforce/label/c.contractNameLabel';
//Toast  Message Labels
import noSuchDataLabel from '@salesforce/label/c.noSuchDataLabel';
import firstStepErrorLabel from '@salesforce/label/c.firstStepErrorLabel';
import accountCreateSuccessMessageLabel from '@salesforce/label/c.accountCreateSuccessMessageLabel';
import contactCreateSuccessMessageLabel from '@salesforce/label/c.contactCreateSuccessMessageLabel';
import selectedAccountMessageLabel from '@salesforce/label/c.selectedAccountMessageLabel';
import selectedContactMessageLabel from '@salesforce/label/c.selectedContactMessageLabel';

const columns = [
    { label: oppNameLabel, fieldName: 'Name' },
    { label: oppStagenameLabel, fieldName: 'StageName' },
    { label: oppCloseDateLabel, fieldName: 'CloseDate' },
    { label: oppAmountLabel, fieldName: 'Amount' }
];
export default class AccountContactOppQuoteCreation extends NavigationMixin(LightningElement)
{
    // labels
    progressBarLabel = { Step1Name, Step2Name, Step3Name, Step4Name };

    sectionTitleDividerLabels = {
        contactInfoDivider, contactNameLable, generalConInfoDivider, conAddressInfoDivider,
        accountInfoDivider, exAccSectionDivider, generalAccInfoDivider, accAddressInfoDivider,
        selectedAccInfoDivider, accInfoDivider, conInfoDivider,
        oppInfoDivider, selectOppInfoDivider, generalOppInfoDivider, selectedOppInfoDivider
    };

    newConPageLabels = {
        conFirstNameLabel, conLastNameLabel, conPhoneLabel, conEmailLabel, conMailingAddressLabel,
        conMailingStreetLabel, conMailingStateLabel, conMailingcityLabel, conMailingCodeLabel, 
        conMailingCountryLabel
    };

    ButtonNameLabels = { nextButtonLabel, previousButtonLabel, cancelButtonLabel, createQuoteButtonLabel, 
        createOrderButtonLabel };
    
    newAccountPageLabels = {
        accNumberLabel, accOwnerLabel, accNameLabel, accIndustryLabel, accPhoneLabel, 
        accBillingAddressLabel,accBillingStreetLabel, accBillingStateLabel, accBillingcityLabel,
        accBillingCodeLabel, accBillingCountryLabel
    };

    contractObjecLabels = { contractNameLabel };

    opportunityObjectLabels = { oppNameLabel, oppCloseDateLabel, oppStagenameLabel };

    toastMessagesLabels={noSuchDataLabel};

    @api finalAccountId;
    @api finalContactId;
    @api finalOppId;
    @api finalQuoteId;
    @api finalContractId;
    @api finalOrderId;
    error;
    hasPermissionSetUp = false;
    @api conid1;
    @api accid1;
    isStepFour = false;

    @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        this.currentPageReference = currentPageReference;
        if (this.currentPageReference) {
            this.finalContactId = this.currentPageReference.state.c__finalContactIdDemo;
            this.finalAccountId = this.currentPageReference.state.c__myAccid;
            this.conid1 = this.finalContactId;
            this.accid1 = this.finalAccountId;
        }
    }

    // For Getting Industry field picklist values.
    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    objectInfo;
    @wire(getPicklistValues,
        {
            recordTypeId: '$objectInfo.data.defaultRecordTypeId',
            fieldApiName: INDUSTRY_FIELD
        }
    )
    industryValues;

    //Contact Object for storing to insert
    @track myContactRecord = {
        FirstName: '',
        LastName: conLastName,
        Phone: '',
        Email: '',
        MailingStreet: '',
        MailingCity: '',
        MailingState: '',
        MailingPostalCode: '',
        MailingCountry: '',
        AccountId: accountId
    };
    //Account Object for storing to insert
    @track myAccountRecord = {
        Name: accName,
        Phone: '',
        Industry: '',
        BillingStreet: '',
        BillingCity: '',
        BillingState: '',
        BillingPostalCode: '',
        BillingCountry: ''
    };


    // Pages
    newContactPage = false;
    existingContactPage = false;
    newAccountPage = false;
    existingAccountPage = false;
    existingOppPage = false;
    newOppPage = false;
    existingContractPage = false;

    //=========================> Current Steps <=====================================================

    @track currentStep = '1';
    handleOnStepClick(event) {
        this.currentStep = event.target.value;
    }

    get isStepOne() { return this.currentStep === "1"; }
    get isStepTwo() { return this.currentStep === "2"; }
    get isStepThree() { return this.currentStep === "3"; }
    get isStepFour() { return this.currentStep === "4"; }
    get isEnableNext() { return this.currentStep != "4"; }
    get isEnablePrev() { return this.currentStep != "1"; }
    get isEnableFinish() { return this.currentStep === "4"; }

    handleNext() {
        if (this.currentStep == "1") { this.currentStep = "2"; }
        else if (this.currentStep == "2") { this.currentStep = "3"; }
        else {
            const event = new ShowToastEvent({
                title: 'Error',
                variant: 'error',
                message: firstStepErrorLabel, //'Create Account & Opportunity',
            });
            this.dispatchEvent(event);
        }
    }
    //===========================================================================================================
    //=========================================================================Custom Lookup for Contact===========
    ContactSearchKey = '';
    contactRecords;
    contactRecords2;
    handlecontactname(event) {
        this.ContactSearchKey = event.target.value;
    }
    handleGetContactSearch(event) {
        this.ContactSearchKey = event.target.value;
        fetchContacts({
            searchkey: this.ContactSearchKey
        })
            .then(result => {
                this.contactRecords = result;
            })
            .catch(error => {
                const event = new ShowToastEvent({
                    title: 'Error',
                    variant: 'error',
                    message: noSuchDataLabel,//'No such data Found !' ,
                });
                this.dispatchEvent(event);
            });
    }
    accountRecord;
    getTheData(event) {
        // this.ContactSearchKey = event.currentTarget.dataset.id;
        this.ContactSearchKey = event.currentTarget.dataset.value;
        this.ContactSearchKeyId = event.currentTarget.dataset.id;
        this.finalContactId = event.currentTarget.dataset.id;
        this.contactRecords = '';
        fetchAccountDetails({
            conId: this.ContactSearchKeyId
        })
            .then(result => {
                this.accountRecord1 = false;
                this.accountRecord = result;
                this.finalAccountId = result[0].AccountId;
            })
            .catch(error => {
                const event = new ShowToastEvent({
                    title: 'Error',
                    variant: 'error',
                    message: noSuchDataLabel,//'No Such Account Data Found !',
                });
                this.dispatchEvent(event);
            });

    }


    //===================================Radio Button options for Contact
    get optionsForContact() {
        return [
            { label: 'Existing Contact', value: 'Existing Contact' },
            { label: 'New Contact', value: 'New Contact' },
        ];
    }
    valueRadioContact;
    handleRadioChange(event) {
        const selectedContactOption = event.detail.value;
        this.valueRadioContact = event.detail.value;
        if (selectedContactOption == 'New Contact') { this.newContactPage = true; this.valueRadioOpp = "New Opportunity"; }
        else { this.newContactPage = false; }
        if (selectedContactOption == 'Existing Contact') {
            this.existingContactPage = true; this.existingAccountPage = false;
            this.existingOppPage = true; this.newAccountPage = false; this.valueRadioOpp = "Existing Opportunity"
        }
        else { this.existingContactPage = false; }
    }

    //===================================Radio Button options for Account
    get optionsForAccount() {
        return [
            { label: 'Existing Account', value: 'Existing Account' },
            { label: 'New Account', value: 'New Account' },
        ];
    }
    valueRadioAccount;
    handleRadioChange2(event) {
        const selectedAccountOption = event.detail.value;
        this.valueRadioAccount = event.detail.value;
        if (selectedAccountOption == 'New Account') {
            this.newAccountPage = true; this.newOppPage = true;
            this.newOppPage = true; this.valueRadioOpp = "New Opportunity"; this.existingOppPage = false;
        }
        else { this.newAccountPage = false; }
        if (selectedAccountOption == 'Existing Account') {
            this.existingAccountPage = true; this.existingOppPage = true;
            this.newOppPage = false; this.valueRadioOpp = "Existing Opportunity";
        }
        else { this.existingAccountPage = false; }
    }

    //===================================Radio Button options for Opportunity
    get optionsForOpp() {
        return [
            { label: 'Existing Opportunity', value: 'Existing Opportunity' },
            { label: 'New Opportunity', value: 'New Opportunity' },
        ];
    }
    valueRadioOpp;
    handleRadioChange3(event) {
        const selectedOppOption = event.detail.value;
        this.valueRadioOpp = event.detail.value;
        //alert("the selected radio button is : "+this.valueRadioOpp);
        if (selectedOppOption == 'New Opportunity') { this.newOppPage = true; this.existingOppPage = false; this.finalOppId = '' }
        else { this.newOppPage = false; }
        if (selectedOppOption == 'Existing Opportunity') { this.existingOppPage = true; this.newOppPage = false; }
        else { this.existingOppPage = false; }
    }

    //======================================================================Getting the values from Forms=======================
    //Contact Fields
    handleContactFirstName(event) {
        this.myContactRecord.FirstName = event.detail.value;
    }
    handleContactName(event) {
        this.myContactRecord.LastName = event.detail.value;
    }
    handleContactPhone(event) {
        this.myContactRecord.Phone = event.detail.value;
    }
    handleContactEmail(event) {
        this.myContactRecord.Email = event.detail.value;
    }
    handleContactMailingStreet(event) {
        this.myContactRecord.MailingStreet = event.detail.value;
    }
    handleContactMailingCity(event) {
        this.myContactRecord.MailingCity = event.detail.value;
    }
    handleContactMailingState(event) {
        this.myContactRecord.MailingState = event.detail.value;
    }
    handleContactMailingcode(event) {
        this.myContactRecord.MailingPostalCode = event.detail.value;
    }
    handleContactMailingCountry(event) {
        this.myContactRecord.MailingCountry = event.detail.value;
    }

    //Account Fields
    handleAccountIndusrty(event) {
        this.value = event.detail.value;
        this.myAccountRecord.Industry = this.value;
    }
    handleAccountPhone(event) {
        this.myAccountRecord.Phone = event.detail.value;
    }
    handleAccountName(event) {
        this.myAccountRecord.Name = event.detail.value;
    }
    handleAccountBillingStreet(event) {
        this.myAccountRecord.BillingStreet = event.detail.value;
    }
    handleAccountBillingCity(event) {
        this.myAccountRecord.BillingCity = event.detail.value;
    }
    handleAccountBillingState(event) {
        this.myAccountRecord.BillingState = event.detail.value;
    }
    handleAccountBilingcode(event) {
        this.myAccountRecord.BillingPostalCode = event.detail.value;
    }
    handleAccountBillingCountry(event) {
        this.myAccountRecord.BillingCountry = event.detail.value;
    }

    //==================================================================Existing Account (Account Lookup)==========================
    accountRecord1;
    handleValueSelcted(event) {
        this.finalAccountId = event.detail[0];
        fetchAccount({
            accId: event.detail[0]
        })
            .then(AccDateWhenSelectedOnAccountLookup => {
                this.accountRecord = false;
                this.accountRecord1 = AccDateWhenSelectedOnAccountLookup;
            })
            .catch(error => {
                const event1 = new ShowToastEvent({
                    title: 'Error',
                    variant: 'error',
                    message: noSuchDataLabel,//'No Such Account Data Found !',
                });
                this.dispatchEvent(event1);
            });
    }
    validateLookupField() {
        this.template.querySelector('c-custom-lookup').isValid();
    }

    //======================================================================================================
    handleCancle(event) {

        if (this.conid1 !== undefined) {
            eval("$A.get('e.force:refreshView').fire();");
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.conid1,
                    actionName: 'view'
                },
            });
        }
        else {
            eval("$A.get('e.force:refreshView').fire();");
        }

    }
    // Account And Contact Creation
    handleNextStep1(event) {
        // ========> New Contact And New Account  <=======
        if (this.finalAccountId == null && this.finalContactId == null) {


            // =====> Insert Account Object   <=======
            insertAccountMethod({ accountObj: this.myAccountRecord })
                .then(result => {
                    this.finalAccountId = result.Id;
                    this.myContactRecord.AccountId = result.Id;
                    const toastEvent = new ShowToastEvent({
                        title: 'Success!',
                        message: accountCreateSuccessMessageLabel + 'this.finalAccountId',//'Account created successfully : ' + this.finalAccountId,
                        variant: 'success'
                    });
                    this.dispatchEvent(toastEvent);

                    // =====> Insert Contact Object   <=======
                    insertContactMethod({ contactObj: this.myContactRecord })
                        .then(result2 => {
                            this.finalContactId = result2.Id;
                            const toastEvent2 = new ShowToastEvent({
                                title: 'Success!',
                                message: contactCreateSuccessMessageLabel,//'Contact created successfully : ' + this.finalContactId,
                                variant: 'success'
                            });
                            this.dispatchEvent(toastEvent2);
                            this.currentStep = "2";
                        })
                        .catch(error2 => {
                        });
                })
                .catch(error => {

                });
        }

        // =====>  Existing Account AND New Contact <=======
        else if (this.finalAccountId != null && this.finalContactId == null) {
            this.myContactRecord.AccountId = this.finalAccountId;
            insertContactMethod({ contactObj: this.myContactRecord })
                .then(result2 => {
                    this.finalContactId = result2.Id;
                    const toastEvent2 = new ShowToastEvent({
                        title: 'Success!',
                        message: contactCreateSuccessMessageLabel + this.finalContactId + accountCreateSuccessMessageLabel + this.finalAccountId,
                        variant: 'success'
                    });
                    this.dispatchEvent(toastEvent2);
                    this.currentStep = "2";
                })
                .catch(error2 => {
                });
        }

        //======> Existing Contact  <======
        else if (this.finalAccountId != null && this.finalContactId != null) {
            // this.valueRadioContact = "Existing Contact";
            // this.existingContactPage = true;
            const toastEventExiAccExCon = new ShowToastEvent({
                title: 'Success!',
                message: selectedContactMessageLabel + this.finalContactId + selectedAccountMessageLabel + this.finalAccountId,
                variant: 'success'
            });
            this.dispatchEvent(toastEventExiAccExCon);
            this.currentStep = "2";
        }
        else {
            const event = new ShowToastEvent({
                title: 'Error',
                variant: 'error',
                message: 'Fill the data for both account and contact.',
            });
            this.dispatchEvent(event);
        }
    }
    // ==============================================End STEP - 1=========================================== 


    //  Step-2========================================= STEP : 2 ========================================Step-2

    // ===========================> Opportunity Fields <======================================
    oppName;
    oppStageName;
    oppCloseDate;
    handleChangeOppName(event) {
        this.oppName = event.detail.value;
    }
    handleChangeOppStageName(event) {
        this.oppStageName = event.detail.value;
    }
    handleChangeOppCloseDate(event) {
        this.oppCloseDate = event.detail.value;
    }
    // ===========================>Existing Opportunity <======================================


    //====================> Existing Opportunities
    opportunityRecords;
    @track columns = columns;
    @track error41;
    noRecs;
    @wire(fetchOpportunity, {
        searchkey: '$finalAccountId'
    }) wireopp({ data, error }) {
        if (data) {
            if (data.length === 0) {
                this.noRecs = true;
            }
            else
                this.opportunityRecords = data;
        }
        else if (error) {
            this.error41 = "No Records Associated with selected account";
        }
    }

    handleRowSelection = event => {
        var selectedRows = event.detail.selectedRows;
        this.finalOppId = selectedRows[0].Id;
        if (selectedRows.length > 1) {
            var el = this.template.querySelector('lightning-datatable');
            selectedRows = el.selectedRows = el.selectedRows.slice(1);
            event.preventDefault();
            return;
        }
    }

    handleNextStep2(event) {
        // =========================> New Opportunity <======================================
        if (this.finalOppId == null && this.finalAccountId != null && this.valueRadioOpp != "Existing Opportunity") {
            const oppforms = this.template.querySelector('.oppForm');
            if (this.finalOppId == null) {
                // oppforms.submit();
                if (oppforms.submit()) { this.currentStep = "3"; }
                else { this.currentStep = "2"; }

            }
            else {
                const event = new ShowToastEvent({
                    title: 'Error',
                    variant: 'error',
                    message: 'I think You Already Selected OR Created Your Opportunity Record.',
                });
                this.dispatchEvent(event);
            }
        }
        else if (this.finalOppId != null && this.finalAccountId != null && this.valueRadioOpp == "New Opportunity") {
            this.finalOppId = '';
            const oppforms = this.template.querySelector('.oppForm');
            if (this.finalAccountId != null) {
                // oppforms.submit();
                if (oppforms.submit()) { this.currentStep = "3"; }
                else { this.currentStep = "2"; }
            }
            else {
                const event = new ShowToastEvent({
                    title: 'Error',
                    variant: 'error',
                    message: 'I think You Already Selected OR Created Your Opportunity Record.',
                });
                this.dispatchEvent(event);
            }
        }
        // =========================> Existing Opportunity <======================================
        else if (this.finalOppId != null && this.finalAccountId != null && this.finalContactId != null) {
            this.currentStep = "3";
        }
        // Getting error while creating opportunity
        else {
            const event = new ShowToastEvent({
                title: 'Error',
                variant: 'error',
                message: 'Please Select Or Create an Opportunity.',
            });
            this.dispatchEvent(event);
        }
    }
    // getting success message after successful opportunity creation
    handleOppSuccess(event) {
        this.finalOppId = event.detail.id;

        if (this.finalOppId != null) {
            const toastEvent = new ShowToastEvent({
                title: 'Success!',
                message: 'Opportunity created successfully : ' + this.finalOppId,
                variant: 'success'
            });
            this.dispatchEvent(toastEvent);
            this.currentStep = "3";
        }
        else {
            const toastEvent = new ShowToastEvent({
                title: 'Error!',
                message: 'Opportunity Not created successfully : ',
                variant: 'error'
            });
            this.dispatchEvent(toastEvent);
            this.currentStep = "2";
        }

    }
    opportunityRecord;
    @wire(fetchOppDetails, {
        oppId: '$finalOppId'
    }) wireopp2({ data, error }) {
        if (data) {
            this.opportunityRecord = data;
        }
        else if (error) {
            this.opportunityRecord = "Please select Any One Of its Opportunity";
        }
    }
    // Back Button Performance in step - 2
    handlePrevStep2(event) {
        this.currentStep = "1";
    }
    //=========================================== END OF STEP - 2 ==========================================

    //================================================= STEP : 3 =======================================

    // Display Account Information in step : 3
    accountDetails;
    @wire(getAccountDetails, { accountRecordId: '$finalAccountId' })
    wiredAccount({ error, data }) {
        if (data) {
            this.accountDetails = data[0];
        } else if (error) {
        }
    }
    get myName() { return this.accountDetails?.Name; }
    get myAccountNumber() { return this.accountDetails?.AccountNumber; }
    get myOwner() { return this.accountDetails?.Owner.Name; }


    // Display Contact Information in step : 3
    contactDetails;
    @wire(getContactDetails, { contactRecordId: '$finalContactId' })
    wiredContact({ error, data }) {
        if (data) {
            this.contactDetails = data[0];
        } else if (error) {
        }
    }
    get myFirstName() { return this.contactDetails?.FirstName; }
    get myLastName() { return this.contactDetails?.LastName; }
    get myPhone() { return this.contactDetails?.Phone; }
    get myEmail() { return this.contactDetails?.Email; }

    // Display Opportunity Information in step : 3
    opportunityDetails;
    @wire(getOpportunityDetails, { oppRecordId: '$finalOppId' })
    wiredOpportunity({ error, data }) {
        if (data) {
            this.opportunityDetails = data[0];
        } else if (error) {
        }
    }
    get myOppName() { return this.opportunityDetails?.Name; }
    get myStageName() { return this.opportunityDetails?.StageName; }
    get myCloseDate() { return this.opportunityDetails?.CloseDate; }

    // Back Button Performance in STEP - 3
    handlePrevStep3(event) {
        this.currentStep = "2";
    }

    //============================================>  Quote Creation <===========================================
    // Quote Record to insert
    @track myQuoteRecord = {
        AccountId: '',
        ContactId: '',
        OpportunityId: '',
        Name: '',
        BillingStreet: '',
        BillingCity: '',
        BillingState: '',
        BillingPostalCode: '',
        BillingCountry: ''
    };

    // When clicking on create Quote Button is STEP - 3
    handleFinish(event) {

        // console.log("name of te accout"+this.accountDetails.Name);
        if (this.finalAccountId != null && this.finalContactId != null && this.finalOppId != null && this.finalQuoteId == null) {
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
            var yyyy = today.getFullYear();
            this.today = yyyy + '-' + mm + '-' + dd;
            this.myQuoteRecord.Name = 'Quote' + this.today;
            //console.log("This. today is : "+this.today);
            this.myQuoteRecord.AccountId = this.finalAccountId;
            this.myQuoteRecord.ContactId = this.finalContactId;
            this.myQuoteRecord.OpportunityId = this.finalOppId;
            this.myQuoteRecord.BillingStreet = this.accountDetails.BillingStreet;
            this.myQuoteRecord.BillingCity = this.accountDetails.BillingCity;
            this.myQuoteRecord.BillingState = this.accountDetails.BillingState;
            this.myQuoteRecord.BillingPostalCode = this.accountDetails.BillingPostalCode;
            this.myQuoteRecord.BillingCountry = this.accountDetails.BillingCountry;

            //insert Opportunity Record
            insertQuoteMethod({ quoteObj: this.myQuoteRecord })
                .then(result2 => {
                    this.finalQuoteId = result2.Id;
                    const toastEventQuote = new ShowToastEvent({
                        title: 'Success!',
                        message: 'Quote created successfully : ' + this.finalQuoteId,
                        variant: 'success'
                    });
                    this.dispatchEvent(toastEventQuote);

                })
                .catch(error2 => {
                })
                .finally(finally1 => {
                    if (this.finalQuoteId != null) {
                        if (hasPermissionSetUp) {
                            this.existingContractPage = true;
                            this.isStepFour = true;
                            this.currentStep = "4";
                        }
                        else {
                            this.isStepFour = false;
                            this[NavigationMixin.Navigate]({
                                type: 'standard__recordPage',
                                attributes: {
                                    recordId: this.finalQuoteId,
                                    actionName: 'view'
                                },
                            });
                        }

                        // this[NavigationMixin.Navigate]({
                        //     type: 'standard__recordPage',
                        //     attributes: {
                        //         recordId: this.finalQuoteId,
                        //         actionName: 'view'
                        //     },
                        // });
                    }

                    else {
                        const toastEvent1 = new ShowToastEvent({
                            title: 'Error!',
                            message: 'No Redirection to Quote Page ',
                            variant: 'Error'
                        });
                        this.dispatchEvent(toastEvent1);
                        this.currentStep = "3";
                    }

                });
        }
        else if (this.finalQuoteId != null) {
            if (hasPermissionSetUp) {
                this.existingContractPage = true;
                this.isStepFour = true;
                this.currentStep = "4";
            }
            else {
                this.isStepFour = false;
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: this.finalQuoteId,
                        actionName: 'view'
                    },
                });
            }
        }
        else if (this.finalAccountId == null || this.finalContactId == null || this.finalOppId == null) {
            const toastEvent1 = new ShowToastEvent({
                title: 'Error!',
                message: 'Please Create Account & Contact & Opportunity to create Quote Record .',
                variant: 'Error'
            });
            this.dispatchEvent(toastEvent1);
        }
    }

    // step4
    //===========================================================================================================
    //=========================================================================Custom Lookup for Contract===========
    @track myOrderRecord = {
        AccountId: '',
        ContractId: '',
        EffectiveDate: '',
        Status: ''
    };


    ContractSearchKey = '';
    ContractSearchKeyId;
    contractRecords;
    contractRecords2;
    handlecontractname(event) {
        this.ContractSearchKey = event.target.value;
    }
    handleGetContractSearch(event) {
        this.ContractSearchKey = event.target.value;
        fetchContracts({
            contractsearchkey: this.ContractSearchKey,
            accountIdForContract: this.finalAccountId
        })
            .then(result => {
                this.contractRecords = result;
            })
            .catch(error => {
                const event = new ShowToastEvent({
                    title: 'Error',
                    variant: 'error',
                    message: noSuchDataLabel,//'No Such Contact Data Found !',
                });
                this.dispatchEvent(event);
            });
    }
    getTheContractData(event) {
        // this.ContactSearchKey = event.currentTarget.dataset.id;
        this.ContractSearchKey = event.currentTarget.dataset.value;
        this.ContractSearchKeyId = event.currentTarget.dataset.id;
        this.finalContractId = event.currentTarget.dataset.id;
        this.contractRecords = '';
    }


    handlePrevStep4(event) {
        this.isStepFour = false;
        this.currentStep = "3";
    }
    handleFinishInStep4(event) {
        if (hasPermissionSetUp && this.finalContractId != null) {
            var today = new Date();
            this.myOrderRecord.EffectiveDate = this.today;
            this.myOrderRecord.AccountId = this.finalAccountId;
            this.myOrderRecord.ContractId = this.finalContractId;
            this.myOrderRecord.Status = 'Draft';

            insertOrderMethod({ orderObj: this.myOrderRecord })
                .then(result3 => {
                    this.finalOrderId = result3.Id;
                    const toastEventQuote = new ShowToastEvent({
                        title: 'Success!',
                        message: 'Order created successfully : ' + this.finalOrderId,
                        variant: 'success'
                    });
                    this.dispatchEvent(toastEventQuote);

                    this[NavigationMixin.Navigate]({
                        type: 'standard__recordPage',
                        attributes: {
                            recordId: this.finalOrderId,
                            actionName: 'view'
                        },
                    });

                })
                .catch(error2 => {
                })

        }
        else {
            const toastEventOrderPage = new ShowToastEvent({
                title: 'Error!',
                message: 'Please verify the process to create the order. ',
                variant: 'Error'
            });
            this.dispatchEvent(toastEventOrderPage);
        }
    }

}
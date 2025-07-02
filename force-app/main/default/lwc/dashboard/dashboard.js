/* eslint-disable dot-notation */
/* eslint-disable vars-on-top */
/* eslint-disable no-console */
import { LightningElement, api, wire, track } from 'lwc';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';

/* Import Refresh Event*/
import { refreshApex } from '@salesforce/apex';

/* Import the Static Resources for Tabulator Open source libraries*/
import TabulatorCSS from "@salesforce/resourceUrl/TabulatorCSS";
import TabulatorJS from "@salesforce/resourceUrl/TabulatorJS";
import FA from "@salesforce/resourceUrl/FA";

/* Import Toast Events*/
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import { updateRecord } from 'lightning/uiRecordApi';

/* Import the Conflict Check Utilities Method */
import getConflictCheckRequests from '@salesforce/apex/conflictCheckUtilities.getConflictCheckRequests';
import getRecentConflictCheckRequests from '@salesforce/apex/conflictCheckUtilities.getRecentConflictCheckRequests';


export default class Dashboard extends LightningElement {

    // Make a Component Aware of Its Record Context
    // https://developer.salesforce.com/docs/component-library/documentation/lwc/lwc.use_object_context
    @api recordId;
    @track clientRecordId;
    @track ccDashboardHeader = 'ccAnnouncementHeader';
    @track ccDashboardAnnouncement = 'ccAnnouncementText';

    @track isRenderedCallBackInitialized = false;

    @track wiredConflictCheckRequests; // Holding variable used in refreshApex for Conflict Check Requests (hold data and error)
    @track conflictCheckRequests;
    @track numberOfRequests;
    @track conflictCheckSelectedRecordId; 

    // Variables for Engage/Do Not engage
    @track isShowEngagementModal = false;  
    @track isShowDoNotEngagementModal = false;

    // Variable to show/hide Conflict Check Form
    @track initiateCCForm = false;
    // Get the Conflict Check Requests related to the Originating Attorney and also fetch Master Detail Data  
    

    
    @track showInitiateCCButton = false;
    @track showEngageButton = false;
    @track showDonotEngageButton = false;

   connectedCallback(){
    this.showInitiateCCButton = this.recordId != undefined ? false : true;
    this.getConflictCheck();
   }

   getConflictCheck(){
        getConflictCheckRequests({recordId : this.recordId}).then((data) => {
            // Clear the user enter values
            this.loadScripts();
            this.wiredConflictCheckRequests = data;
            // if(this.recordId != undefined){
            //     this.showEngageButton = (this.wiredConflictCheckRequests[0].Logged_in_User_is_Creator__c || this.wiredConflictCheckRequests[0].Logged_in_User_is_Originating_Attorney__c) ? false : true;
            //     this.showDonotEngageButton = this.showEngageButton;
            //     console.log('CREATOR ===> ',this.wiredConflictCheckRequests[0].Logged_in_User_is_Creator__c);
            //     console.log('OA ====>',this.wiredConflictCheckRequests[0].Logged_in_User_is_Originating_Attorney__c);
            // }
            // else{
            //     this.showEngageButton = true;
            //     this.showDonotEngageButton = true;
            // }
            
            
            this.conflictCheckRequests = JSON.parse(JSON.stringify(data)).map(request => ({
                ...request,
                //isExpanded: false,  // Set isExpanded to false initially
            }));
            this.numberOfRequests = this.wiredConflictCheckRequests.length;
            console.log(`Conflict Check Requests : ${JSON.stringify(this.conflictCheckRequests)}`);
            this.initializeConflictCheckTable();
            //return refreshApex(this.wiredConflictCheckRequests);
                
        })
        .catch((error) => {
            console.log('Error connected call back Creation.', JSON.stringify(error));
        });
    }

    loadScripts(){
        loadScript(this, TabulatorJS).then(() => {
            loadStyle(this, TabulatorCSS).then(() => {
                //loadStyle(this, FA + '/font-awesome-4.7.0/css/font-awesome.css').then(() => {
                    console.log('Scripts Loaded Successfully');
                    this.isRenderedCallBackInitialized = true;
                    this.initializeConflictCheckTable();
               // });
            });
        });
    }

    onloadConflickCheckDashboard(){
      this.loadScripts();  
    }

    renderedCallback() {
        if (this.isRenderedCallBackInitialized) {
            this.initializeConflictCheckTable()
            return;
        }
        console.log('recordId', this.recordId);

    }

    initializeConflictCheckTable() {
        this.component = this.template.querySelector('[data-id="MCCIPConflictCheckDashboard"]');
        console.log('In Method : Initializing Conflict Check Table');

       
        console.log('data in initialize data table ==> ',JSON.stringify(this.conflictCheckRequests));
        //var sfdcURL = window.location.origin;

        //Initialize table
        var table = new Tabulator(this.component, {
            height: "100%",
            layout: "fitColumns",
            resizableColumns: true,
            reactiveData: true,
            data: this.conflictCheckRequests,
            pagination: "local",
            paginationSize: 10,
            // responsiveLayout: "collapse",
            columns: [
                //     {
                //     title: "", field: "isSelected", align: "center", resizable: false, frozen: true, headerSort: false, formatter: function (cell, formatterParams) {
                //         if (cell.getRow().getData().isSelected) {
                //             return "<i class='fa fa-check-circle'></i>";
                //         } else {
                //             return "<i class='fa fa-circle'></i>";
                //         }
                //     }, cellClick: function (e, cell) {
                        
                //         const isSelected = cell.getRow().getData().isSelected;
                //         var vRows = table.getRows();
                //         console.log ('Number of Rows : ' + vRows.length);
                //         for (var i= 0; i< vRows.length; i++) { 
                //             console.log ('Inside For ');
                //             console.log ('Selected ' + i);
                //             console.log ('Row Selected ' + vRows[i].getData().isSelected);
                //             try {
                //                 vRows[i].getData().isSelected = false;
                //                 table.updateRow(vRows[i].getIndex(),vRows[i].getData()); 
                //             } catch (error) {
                //                 console.log ('Error : ' + JSON.stringify(error));
                //             }
                            
                //         }

                //         cell.getRow().getData().isSelected = !isSelected;
                //     }
                // },
                // {
                //     title: "", field: "isExpanded", align: "center", resizable: false, frozen: true, headerSort: false, formatter: function (cell, formatterParams) {
                //         if (cell.getRow().getData().clientRecords.length > 0 || cell.getRow().getData().contributorRecords.length > 0 || cell.getRow().getData().keywordRecords.length > 0){
                //             if (cell.getRow().getData().isExpanded) {
                //                 return "<i class='fa fa-minus-circle'></i>";
                //             } else {
                //                 return "<i class='fa fa-plus-circle'></i>";
                //             }
                //         }
                //     }, cellClick: function (e, cell) {
                //         if (cell.getRow().getData().clientRecords.length > 0 || cell.getRow().getData().contributorRecords.length > 0 || cell.getRow().getData().keywordRecords.length > 0){
                //             const isExpanded = cell.getRow().getData().isExpanded;
                //             cell.getRow().getData().isExpanded = !isExpanded;
                //             const id = cell.getRow().getData().recordId;
                //             const visibility = isExpanded ? 'hidden' : 'visible';
                //             const display = isExpanded ? 'none' : 'block';

                //             document.querySelectorAll(".subTable" + id).forEach(childTable => {
                //                 childTable.style.visibility = visibility;
                //                 childTable.style.display = display;
                //             });
                //         }
                //     }
                // },
                {
                    title: "Request # ", field: "recordName", headerFilter: true
                },
                // {
                //     title: "Request # ", field: "recordName", headerFilter: true, formatter: function (cell, formatterParams) {
                //         var value = cell.getValue();
                //         return "<span style='color:#c29304; font-weight:bold;'><a href='" + sfdcURL + "/" + cell.getRow().getData().recordId + "'>" + value + "</a></span>";
                //     }
                // },
                // {
                //     title: "Account Name", field: "recordName", headerFilter: true,formatter: function (cell, formatterParams) {
                //         var value = cell.getValue();
                //         if (value === undefined)
                //             return "<span style='color:#ff0000; font-weight:bold;'></span>";
                //         return "<span style='font-weight:bold;'>" + value + "</span>";
                //     }
                // },
               
            ],
        });


    }
    
    initiateNewConflictCheck() {
        this.initiateCCForm = true;
    }
    hideModalBox() {
        this.initiateCCForm = false;
    }
    onclosepopup(event) {
        this.initiateCCForm = false;
        this.refreshTable();

    }

    @track areaOfLaw;
    onAreaOfLawSelected(event){
        this.areaOfLaw = event.detail; 
        if(this.areaOfLaw == 'Patent'){
            this.isAreaOfLawNotExists = false;
            this.isPatentIntakeForm = true;
            this.isDisignIntakeForm = false;
            this.isShowEngagementModal = true;
            this.modalName = 'Patent';
            this.areaOfLaw = 'Patent';
        }
        else if(this.areaOfLaw == 'Design'){
            this.isAreaOfLawNotExists = false;
            this.isDisignIntakeForm = true;
            this.isPatentIntakeForm = false;
            this.isShowEngagementModal = true;
            this.modalName = 'Design';
            this.areaOfLaw = 'Design';
        }
        else{
            this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'Not Configured '+ this.areaOfLaw+' Intake Forms. Please reachout to your system administrator for further.',
                            mode:'dismissable',
                            variant: 'error'
                        })
                    );
        }
    }
    hideAreaOfLawModal(event){
        this.isAreaOfLawNotExists = false;
    }

    @track selectedClientId;
    @track isDisignIntakeForm= false;
    @track isPatentIntakeForm = false;
    @track modalName;
    @track isAreaOfLawNotExists = false;
    engageClient(event) {

        console.log('Conflict Check Data : ' + JSON.stringify(this.conflictCheckRequests));
        

        // Verify atleast 1 Conflict Check record is selected. 
        // If selected, show the engagement model
        // If no record is selected, throw a toast message with error that atleast one conflict check record must be selected
        let selectedConflictCheck = [];
        selectedConflictCheck = this.conflictCheckRequests.filter(function(element){
                                    return element.isSelected == true
                                });
        
        if (selectedConflictCheck.length > 0) { 
            
            if(selectedConflictCheck.length == 1){
                this.conflictCheckSelectedRecordId = selectedConflictCheck[0].recordId;
                this.selectedClientId = selectedConflictCheck[0].clientId;
                if(selectedConflictCheck[0].isOriginatingAttorney){
                    if(selectedConflictCheck[0].areaOfLaw!=null && selectedConflictCheck[0].areaOfLaw == 'Patent'){
                        this.isAreaOfLawNotExists = false;
                        this.isPatentIntakeForm = true;
                        this.isDisignIntakeForm = false;
                        this.isShowEngagementModal = true;
                        this.modalName = 'Patent';
                        this.areaOfLaw = 'Patent';
                    }
                    else if(selectedConflictCheck[0].areaOfLaw!=null && selectedConflictCheck[0].areaOfLaw == 'Design'){
                        this.isAreaOfLawNotExists = false;
                        this.isDisignIntakeForm = true;
                        this.isPatentIntakeForm = false;
                        this.isShowEngagementModal = true;
                        this.modalName = 'Design';
                        this.areaOfLaw = 'Design';
                    }
                    // else if(selectedConflictCheck[0].areaOfLaw!=null && selectedConflictCheck[0].areaOfLaw != 'Patent' || selectedConflictCheck[0].areaOfLaw != 'Design'){
                    //     this.dispatchEvent(
                    //         new ShowToastEvent({
                    //             title: 'Error',
                    //             message: 'Not Configured '+selectedConflictCheck[0].areaOfLaw+' Intake Forms. Please reachout to your system administrator for further.',
                    //             mode:'dismissable',
                    //             variant: 'error'
                    //         })
                    //     );
                    // }
                    else{
                        //Open a popup to select are of law
                        this.isAreaOfLawNotExists = true;
                    }
                    // else if(selectedConflictCheck[0].areaOfLaw == null){
                    //     this.dispatchEvent(
                    //         new ShowToastEvent({
                    //             title: 'Error',
                    //             message: 'Area of law if mandate to Engage this Conflict Check.',
                    //             mode:'dismissable',
                    //             variant: 'error'
                    //         })
                    //     );
                    // }
                    // else if(selectedConflictCheck[0].areaOfLaw != 'Patent' || selectedConflictCheck[0].areaOfLaw != 'Design'){
                    //     this.dispatchEvent(
                    //         new ShowToastEvent({
                    //             title: 'Error',
                    //             message: 'Not Configured '+selectedConflictCheck[0].areaOfLaw+' Intake Forms. Please reachout to your system administrator for further.',
                    //             mode:'dismissable',
                    //             variant: 'error'
                    //         })
                    //     );
                    // }
                    
                }
                else{
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'Only Originating Attorney can Engage this Conflict Check.',
                            mode:'dismissable',
                            variant: 'error'
                        })
                    );
                }
                
            }
            else{
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Please select one Conflict Check record at  a time.',
                        mode:'dismissable',
                        variant: 'error'
                    })
                );
            }
        } else {

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Please select Conflict Check record to proceed.',
                    mode:'dismissable',
                    variant: 'error'
                })
            );
        }
        
    }

    donotEngageClient(event) {
        // TODO: 
        // Either Filter or loop through for isSelected (this.conflictCheckRequests)= true and 
        // verify atleast 1 record is selected. 
        // If selected, show the engagement model
        // If no record is selected, throw a toast message with error that atleast one conflict check record must be selected
        let selectedConflictCheck = [];
        selectedConflictCheck = this.conflictCheckRequests.filter(function(element){
                                    return element.isSelected == true
                                });
        
        if (selectedConflictCheck.length > 0 ) { 
            if(selectedConflictCheck.length == 1){
                this.conflictCheckSelectedRecordId = selectedConflictCheck[0].recordId;
                if(selectedConflictCheck[0].isRecordCreator && selectedConflictCheck[0].isOriginatingAttorney){
                    this.isShowDoNotEngagementModal = true;
                }
                else{
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'Only Originating Attorney can paerform Do Not Engage on this Conflict Check.',
                            mode:'dismissable',
                            variant: 'error'
                        })
                    );
                }
                
            }
            else{
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Please select one Conflict Check record at  a time.',
                        mode:'dismissable',
                        variant: 'error'
                    })
                );
            }
            
        } else {

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Please select a Conflict Check record to proceed.',
                    mode:'sticky',
                    variant: 'error'
                })
            );
        }
    }

    refreshTable(){
        getRecentConflictCheckRequests({recordId : this.recordId}).then((data) => {
            // Clear the user enter values
            this.wiredConflictCheckRequests = data;
            this.conflictCheckRequests = JSON.parse(JSON.stringify(data)).map(request => ({
                ...request,
                isExpanded: false,  // Set isExpanded to false initially
            }));
            this.numberOfRequests = this.wiredConflictCheckRequests.length;
            this.initializeConflictCheckTable();
            return refreshApex(this.wiredConflictCheckRequests);
                
        })
        .catch((error) => {
            console.log('Error during Client record Creation.', JSON.stringify(error));
        });
    }
    

    // TODO: Why we have multiple methods doing the same logic? 
    closeEngagementModal(event) {
        this.isShowEngagementModal = false;
    }

    closeDonotEngagementModal(event) {
        this.isShowDoNotEngagementModal = false;
        try{
            this.refreshTable();
        }
        catch(error){
            console.log(JSON.stringify(error));
        }
        
        //this.dispatchEvent(new RefreshEvent());
    }
    hideEngagementModal() {
        this.isShowEngagementModal = false;
    }
    hideDonotEngagementModal() {
        this.isShowDoNotEngagementModal = false;
        
    }
}
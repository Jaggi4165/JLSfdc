import { LightningElement ,api , wire , track}  from 'lwc';
import {getRecord , getFieldValue , getRecords}      from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT                   from '@salesforce/schema/Account';
import ACCOUNT_NAME                     from '@salesforce/schema/Account.Name';
import ACCOUNT_INDUSTRY                 from '@salesforce/schema/Account.Industry';
import ACCOUNT_RATING                   from '@salesforce/schema/Account.Rating';

export default class Jag_ldsGetRecordA extends LightningElement {
    // Api variables
    @api recordId;

    // Track Variables

    // Normal Variables
    error;
    accName;
    accIndustry;
    accRating;
    @track accounts;

    // Api functions

    //Wire Functions
    @wire(getRecord,{
        recordId : "$recordId",
        fields : [ACCOUNT_NAME,ACCOUNT_INDUSTRY,ACCOUNT_RATING]
    }) account({error,data}){
        if(data){
            this.accountRecord = data;
            this.error = undefined;
            console.table(this.accountRecord);
            this.accName = getFieldValue(data,ACCOUNT_NAME);
            this.accIndustry = getFieldValue(data,ACCOUNT_INDUSTRY);
            this.accRating = getFieldValue(data,ACCOUNT_RATING);
        }
        else if(error){
            this.accountRecord = undefined;
            this.error = error;
        }
    };
    
    @wire(getRecords,{
        objectApiName : ACCOUNT_OBJECT,
        fields : [ACCOUNT_NAME,ACCOUNT_INDUSTRY,ACCOUNT_RATING]
    })accList({data,error}){
        console.log('Get Records....');
        if(data){
            this.accounts =  data.records.map(record => {
                return {
                    Id: record.fields.Id.value,
                    Name: record.fields.Name.value,
                    Industry: record.fields.Industry.value,
                    Rating: record.fields.Rating.value
                };
            });
            this.error = undefined;
            console.log(' this.accounts ===> ',JSON.stringify( this.accounts));
        }
        else if(error){
            this.accounts = undefined;
            this.error = error;
            console.log('Get Records....',error);
        }
    };
    // Getter functions
    
    // Constructor
    constructor() {
        super();
        console.info('Constructor Called.');
    }
    // ConnectedCallback
    connectedCallback() {
        console.info('Connected Callback Called.');
    }
    // Rendered Callback
    renderedCallback(){
        console.info('Rendered Callback Called.');
    }
    // Disconnected Callback
    disconnectedCallback() {
        console.info('DisConnected Callback Called.');
    }
    // Error Callback
    errorCallback(error, stack) {
        console.error('Error Callback Called.');
        this.error = error;
    }
    

    
}
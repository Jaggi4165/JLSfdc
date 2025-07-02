import { LightningElement,api,wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getObjectInfo, getPicklistValues, getPicklistValuesByRecordType } from "lightning/uiObjectInfoApi";
import ACCOUNT_OBJECT from '@salesforce/schema/Hub__c';
import ADDRESS_FIELD from '@salesforce/schema/Hub__c.Address__c';
export default class NewForm extends LightningElement {
@api recordId;
@api objectAPIName='Hub__c';
strStreet;
strCity;
strState;
strCountry;
strPostalCode;
@api objectApiName = 'Hub__c'; // Object API Name (e.g., Account, Contact)
    @api countryFieldName = 'Address__Country__s'; // API Name of the Country field
    @api stateFieldName = 'Address__State__s'; // API Name of the State field

    countryPicklistValues = [];
    countryPicklistValuesMap = new Map();
    statePicklistValues = [];

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    objectInfo;

    @wire(getPicklistValuesByRecordType, {
        objectApiName: ACCOUNT_OBJECT,
        recordTypeId: '$objectInfo.data.defaultRecordTypeId',
    })
    wiredPicklistValues({ error, data }) {
        if (data) {
            // Get country and state picklist values
            const countryPicklistValues1 = data.picklistFieldValues.Address__CountryCode__s.values;
            console.log('this.countryPicklistValues1',JSON.stringify(countryPicklistValues1));

           // this.countryPicklistValues = 
            countryPicklistValues1.map(picklistValue => {
                //return {
                    // label: picklistValue.label,
                    // value: picklistValue.value,
                    console.log(picklistValue.label +' ==== '+ picklistValue.value);
                    this.countryPicklistValuesMap.set(picklistValue.label, picklistValue.value);
                //};
            });
            this.countryPicklistValues = data.picklistFieldValues.Address__CountryCode__s.values;
            this.statePicklistValues = data.picklistFieldValues.Address__State__s;
            console.log('this.data',JSON.stringify(data));
            console.log('this.countryPicklistValues',JSON.stringify(this.countryPicklistValuesMap));
            //console.log('this.countryPicklistValues',JSON.stringify(data.picklistFieldValues));
        } else if (error) {
            console.error('Error fetching picklist values:', error);
        }
    }

    // @wire(getPicklistValues, { objectApiName: ACCOUNT_OBJECT, recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: '$countryFieldName' })
    // countryPicklistValuesWire({ error, data }) {
    //     if (data) {
    //         this.countryPicklistValues = data.values.map(picklistValue => {
    //             return {
    //                 label: picklistValue.label,
    //                 value: picklistValue.value
    //             };
    //         });
    //     } else if (error) {
    //         console.error('Error fetching country picklist values', error);
    //     }
    // }

    // @wire(getPicklistValues, { objectApiName: ACCOUNT_OBJECT, recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: '$stateFieldName' })
    // statePicklistValuesWire({ error, data }) {
    //     if (data) {
    //         this.statePicklistValues = data.values.map(picklistValue => {
    //             return {
    //                 label: picklistValue.label,
    //                 value: picklistValue.value
    //             };
    //         });
    //     } else if (error) {
    //         console.error('Error fetching state picklist values', error);
    //     }
    // }

handleSuccess( event ) {
  
    console.log( 'Updated Record Id is ', event.detail.id );
    this.dispatchEvent(
    new ShowToastEvent({
    title: 'Successful Record Update',
    message: 'Record Updated Surccessfully!!!',
    variant: 'success'
    })
    );
}
handleSubmit( event )

{

    console.log('this.countryPicklistValues',JSON.stringify(this.countryPicklistValues));
  console.log('this.statePicklistValues',JSON.stringify(this.statePicklistValues));
    let fields = event.detail.fields;
    console.log( 'Fields are ' + JSON.stringify( fields ) );
    event.preventDefault();
    fields.Address__Street__s = this.strStreet;
    fields.Address__City__s = this.strCity;
    //fields.Address__CountryCode__s = this.countryPicklistValuesMap.get(this.strCountry);
    fields.Address__CountryCode__s = this.strCountry;
    fields.Address__PostalCode__s = this.strPostalCode;
    fields.Address__StateCode__s = this.strState;
    this.template.querySelector( 'lightning-record-edit-form' ).submit( fields );
}
addressInputChange( event ) {
this.strStreet = event.target.street;
this.strCity = event.target.city;
this.strState = event.target.province;
this.strCountry = event.target.country;
this.strPostalCode = event.target.postalCode;

}
}
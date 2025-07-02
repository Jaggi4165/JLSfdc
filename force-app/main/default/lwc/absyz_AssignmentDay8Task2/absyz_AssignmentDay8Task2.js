import { LightningElement } from 'lwc';
import { createRecord } from "lightning/uiRecordApi";
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import RATING_FIELD from '@salesforce/schema/Account.Rating'
export default class Absyz_AssignmentDay8Task2 extends LightningElement {
    accName = '';
    accRating = '';
    accId='';


handleChange(event){


    if(event.target.name == 'Name')
    {
       this.accName = event.target.value
    }
    if(event.target.name == 'Rating')
    {
       this.accRating = event.target.value
    }


}
createAccount(){


    const fields = {}
    fields[NAME_FIELD.fieldApiName] = this.accName;
    fields[RATING_FIELD.fieldApiName] = this.accRating;


    const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields };
    
    createRecord(recordInput)
    .then(acc=>{
        console.log('Account Record',acc)
        this.accName = ''
        this.accPhone = ''
        this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account created successfully',
                        variant: 'success',
                    }),
                );
    })
    .catch(error=>{
        this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error while creating record',
                        message: 'Kindly provide all values',
                        variant: 'error',
                    }),
                );
    })


}
}
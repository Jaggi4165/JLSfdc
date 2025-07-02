import { LightningElement } from 'lwc';
export default class Absyz_FlowInLWC extends LightningElement {
    objectMap = [
        {
            label : "Account",
            object : "Account",
            flowApiName : "Account_Record_Create_Screen",
            inputVariables : ''
        },
        {
            label : "Contact",
            object : "Contact",
            flowApiName : "",
            inputVariables : ''
        },
        {
            label : "Opportunity",
            object : "Opportunity",
            flowApiName : "",
            inputVariables : ''
        }
    ];

    handleStatusChange(event){

    }
}
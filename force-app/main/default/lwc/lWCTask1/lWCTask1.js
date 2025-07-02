import { LightningElement,track,wire } from 'lwc';
import getDataFromContact from '@salesforce/apex/SalesforceController.getDataFromContact';
const columns=[
    {label: 'First Name',fieldName: 'FirstName'},
    { label: 'Last Name', fieldName: 'LastName' },
    { label: 'Email', fieldName: 'Email' },
    { label: 'Phone', fieldName: 'Phone' },
    { type: 'button', fixedWidth: 150, 
     typeAttributes: { // iconName: 'action:preview',
        label: 'View Details',
         title: 'View Details',
            name: 'viewDetails',
             value: 'viewDetails',
             variant: 'brand',
    }}
];
export default class LWCTask1 extends LightningElement {

    @track columns = columns;
    @track contactRow={};
    @track rowOffset = 0;  
    @track modalContainer = false;
     @wire(getDataFromContact) wireContact;
   
     handleRowAction(event){
        const dataRow = event.detail.row;
        window.console.log('dataRow@@ ' + dataRow);
        this.contactRow=dataRow;
        window.console.log('contactRow## ' + dataRow);
        this.modalContainer=true;
     }
  
     closeModalAction(){
      this.modalContainer=false;
     }
}
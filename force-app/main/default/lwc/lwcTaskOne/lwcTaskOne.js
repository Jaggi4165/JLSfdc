import { LightningElement,track,wire } from 'lwc';
import getSearchedContacts from '@salesforce/apex/SalesforceController.getSearchedContacts';
import getContactsOnModel from '@salesforce/apex/SalesforceController.getContactsOnModel';
const columns=[
    {label: 'First Name',fieldName: 'FirstName'},
    { label: 'Last Name', fieldName: 'LastName' },
    { label: 'Email', fieldName: 'Email' },
    { label: 'Phone', fieldName: 'Phone' },
    // { label: 'Account name', fieldName: 'Account.name' },
    {  type: 'button', typeAttributes: { // iconName: 'action:preview',
                                                                                title: 'Preview',
                                                                                label: 'View Details',
                                                                                name : 'View Details',
                                                                                 variant: 'border-filled',
                                                                                 value: 'viewDetails',
                                                                                 alternativeText: 'View'}
    }
];
 
export default class LwcTaskOne extends LightningElement
{
    @track columns = columns;
    data;
    firstName='';
    lastName='';
    @track contactRow={};
    @track rowOffset = 0;  
    @track modalContainer = false;

   getfirstname(event){
       this.firstName = event.target.value;
       console.log(this.firstName);
       event.preventDefault();
   } 
   getlastname(event){
    this.lastName = event.target.value;
    console.log(this.lastName);
    event.preventDefault();
    }
    handleRowAction(event){
        const dataRowId = event.detail.row.Id;
        getContactsOnModel({ id1: dataRowId})   //modal
        .then((result) => {
           this.contactRow = result;

           this.modalContainer=true;
         })
         .catch((error) => {
             this.contactRow = error;
             this.modalContainer=false;
         });
     }
  
     closeModalAction(){
      this.modalContainer=false;
     }
    
    handleSearch()
    {

        // Actual code
        if((this.firstName != '' && this.lastName != ''))
        {   
         getSearchedContacts({ firstnamekey: this.firstName , lastnamekey: this.lastName})
        .then((result) => {
            this.data = result;
        })
        .catch((error) => {
            this.error = error;
        });
        }
        else
        {
            alert("Some fields are empty...");
        }    
    }
}
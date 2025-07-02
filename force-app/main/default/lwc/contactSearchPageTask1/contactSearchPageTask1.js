import { LightningElement,track,wire } from 'lwc';
import getSearchedContacts from '@salesforce/apex/ContactController.getSearchedContacts';
export default class ContactSearchPageTask1 extends LightningElement {
    //declare variables
    firstName='';
    lastName='';
    phoneNumber='';
    email='';
    validFirstName=false;
    validLastName=false;
    validPhone=false;
    validEmail=false;
    @track contacts;
    @track error='';
    @track columns=[
        {label:'Name',fieldName:'Name',type:'text'},
        {label:'Account Name',fieldName:'AccountId',type:'lookup'},
        {label:'Phone',fieldName:'Phone',type:'phone'},
        {label:'Email',fieldName:'Email',type:'email'},
  
    ];

handleSearch()
{

    this.firstName = this.template.querySelector('.fname').value;
    this.lastName = this.template.querySelector('.lname').value;
    this.email = this.template.querySelector('.email').value;
    this.phoneNumber = this.template.querySelector('.phone').value;
    //    console.log("firstname=====>"+this.firstName);
    //    console.log("lastname=====>"+this.lastName);
    //    console.log("email=====>"+this.email);
    //    console.log("phone=====>"+this.phoneNumber);
    //-------------------------------------------------------------------validation for firstName
    if((this.firstName!=null && this.firstName!='')
        &&(this.lastName!=null && this.lastName!='')
        &&(this.phoneNumber!=null && this.phoneNumber!='')
        &&(this.email !=null && this.email !=''))
    {
        //    console.log("firstname=====>"+this.firstName);
        //    console.log("lastname=====>"+this.lastName);
        //    console.log("email=====>"+this.email);
        //    console.log("phone=====>"+this.phoneNumber);
        this.validFirstName=true;
        this.validLastName=true;
        this.validPhone=true;
        this.validEmail=true;
    }
    else
    {
        //    console.log("firstname=====>"+this.firstName);
        //    console.log("lastname=====>"+this.lastName);
        //    console.log("email=====>"+this.email);
        //    console.log("phone=====>"+this.phoneNumber);
        this.validFirstName=false;
        this.validLastName=false;
        this.validPhone=false;
        this.validEmail=false;
    }
         
    // Actual code
    if((this.validFirstName && this.validLastName) && (this.validPhone && this.validEmail))
    {
        //    console.log("firstname=====>"+this.firstName);
        //    console.log("lastname=====>"+this.lastName);
        //    console.log("email=====>"+this.email);
        //    console.log("phone=====>"+this.phoneNumber);

     // Fetching data from salesforce using promises   
    getSearchedContacts({ firstnamekey: this.firstName , lastnamekey: this.lastName})
    .then((result) => {
        this.contacts = result;
    })
    .catch((error) => {
        this.error = error;
    });

    }
    else
    {
        //    console.log("may be some fields are empty");
        alert("Some fields are empty...");
    }
}
}
import { LightningElement,track,wire } from 'lwc';
import getSearchedContacts from '@salesforce/apex/ContactController.getSearchedContacts';
import { NavigationMixin } from 'lightning/navigation';

export default class ContactSearchPageByName extends LightningElement {

    //declare variables
    modelView=false;
    vodelId;
    firstName='';
    lastName='';
    phoneNumber='';
    email='';
    validFirstName=false;
    validLastName=false;
    @track contacts2;
    @track error2='';
    @track contacts;
    @track error='';

    
    @track columns=[
        {label:'Name',fieldName:'Name',type:'text'},
        {label:'Account Name',fieldName:'AccountId',type:'text'},
        {label:'Phone',fieldName:'Phone',type:'phone'},
        {label:'Email',fieldName:'Email',type:'email'},
        {
            type: "button",
            fixedWidth: 150,
            
            typeAttributes: {
                label: 'View Details',
                title: 'View Details',
                name: 'viewDetails',
                value: 'viewDetails',
                variant: 'brand',
                class: 'scaled-down'
            },
        },
  
    ];
    //------------------------------------------------
    callRowAction( event ) {  
          console.log("jagadeesh here");
        const recId =  event.detail.row.Id;  
        const actionName = event.detail.action.name; 
        console.log("jagadeesh here"+recId);
        console.log("jagadeesh here"+actionName);
            this.modelId=recId;
            this.modelView=true;
            console.log("before"+result);
            getContactDetailsOnModel({ modelId: this.modelId})
        .then((result) => {
            console.log("after"+result);
        this.contacts2 = result;
         })
        .catch((error) => {
        this.error2 = error;
    });
    this.dispatchEvent(callRowAction);
        } 
    //------------------------------------------------


handleSearch()
{

    this.firstName = this.template.querySelector('.fname').value;
    this.lastName = this.template.querySelector('.lname').value;
    this.email = this.template.querySelector('.email').value;
    this.phoneNumber = this.template.querySelector('.phone').value;
    if((this.firstName!=null && this.firstName!='')
        &&(this.lastName!=null && this.lastName!=''))
    {

        this.validFirstName=true;
        this.validLastName=true;
    }
    else
    {
        this.validFirstName=false;
        this.validLastName=false;
    }
         
    // Actual code
    if((this.validFirstName && this.validLastName))
    {
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
        alert("Some fields are empty...");
    }
}


@track isModalOpen = false;
    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
    }
    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        this.isModalOpen = false;
    }






}
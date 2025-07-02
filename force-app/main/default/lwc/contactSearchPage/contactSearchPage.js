import { LightningElement,track,wire,api } from 'lwc';
import getContactsBySearch from '@salesforce/apex/ContactController.getContactsBySearch';
export default class ContactSearchPage extends LightningElement {

    contactname='';
    @track contactList=[];
    @track error='';
    FIlds

 
handleSearch(){
    this.contactname = this.template.querySelector('.contactname').value;
    
    console.log(" here 1");
       if(this.contactname != null)
       {
        console.log(" here 1");
        getContactsBySearch({ contactname: this.contactname})
        .then((result) => {
            console.log(" here 1");
            this.contactList = result;
        })
        .catch((error) => {
            this.error = error;
        });
    
       }
       else{
        alert('field is empty');
       }

}
}
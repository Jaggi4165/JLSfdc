import { LightningElement } from 'lwc';
import {add,multiplication,division,substract,alerts} from "c/utilityComponent";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import searchAccount from '@salesforce/apex/AccountController.searchAccounts';
const COLUMNS = [
    {lable:"Account Name", fieldName:"Name" ,type:"text"},
    {lable:"Account Phone" , fieldName:"Phone" , type:"phone"}
]
export default class SearchFunctionality extends LightningElement {
    searchkey;
    accounts;
    actualData;
    filterByPhone = false;
    error;
    columns = COLUMNS;
    showSpinner = true;
    searchLength = 3;
    haveAccounts = false;
    progress = 0;

    connectedCallback() {
        // Connected Callback
    }

    renderedCallback(){
        //Click on Enter symbol in laptop
        var event = this.template.querySelector('[data-id="searchKeyword"]');
        event.addEventListener("keydown", (event) => {
            if(event.key === "Enter") {
                this.handleClick();
            }
        });
        //this.progress = this.accounts.length > 0 ? this.accounts.length : 0;
    }
    onchangehandler(event){
        this.searchkey = event.target.value;
        this.searchLength = 3 - this.searchkey.length;        
    }
    onchangeChkhandler(event){
        this.filterByPhone = event.target.checked;
        if(this.filterByPhone){
            this.accounts = this.actualData.filter(loopItem => {
                return loopItem.Phone!=null
            });
        }
        else{
            this.accounts = this.actualData;
        }
    }
    handleClick(){
        console.log('Add ==> '+add(41,65));
        console.log('Multiplication ==> '+multiplication(41,65));
        console.log('Substraction  ==> '+substract(41,65));
        console.log('Division ==> '+division(41,65));
        this.searchAccount();
        if(this.searchkey.length>2){ 
            // setTimeout(() => {
            //     this.searchAccount();
            // }, 2000);
        }
    }

    searchAccount(){
        this.showSpinner = true;
        searchAccount({keyword : this.searchkey.toUpperCase()})
        .then(result => {
            console.table(result);
            this.actualData = result;
            this.progress = this.actualData.length;
            if(this.filterByPhone){
                this.accounts = result.filter(loopItem => {
                    return loopItem.Phone!=null
                });
                this.progress = this.accounts.length;
            }
            else{
                this.accounts = result;
                this.progress = this.accounts.length;
            }
            this.error = undefined;
            
            result.length>0 ? this.showNotification('Success',`${result.length} Records Found.`,'success','dismissable') : this.showNotification('Error','Data not Found!','error','dismissable');
            this.haveAccounts = result.length>0 ? true : false;
            this.showSpinner = false;
            
        })
        .catch(error =>{
            this.accounts = undefined;
            this.haveAccounts = false;
            this.progress = 0;
            this.error = error.body.message;
            this.showNotification('Error',`${this.error} .`,'error','dismissable')
        });
    }

    // Reusable show Toast Message function 
    // Params : Title of the Toast, Message,the variant of the toast and the mode.
    showNotification(titleText,messageText,variant,mode) {
        const evt = new ShowToastEvent({
            title: titleText,
            message: messageText,
            variant: variant,
            mode : mode
        });
        this.dispatchEvent(evt);
  }
}
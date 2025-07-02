import { LightningElement, track, api } from 'lwc';

export default class MyBankProfileCard extends LightningElement {
@api recordId;
@track myBankName = "SBI";
myaccount="";

myaccountjs(){
    this.myaccount=this.myBankName + this.recordId;
    
}


}
import { LightningElement,wire,api,track} from 'lwc';
import retrieveBikeData from '@salesforce/apex/getAllRecordsBikeHub.retrieveBikeData';
export default class HubSearch extends LightningElement {
@track records;
@track currentAccountName;
   @track searchAccountName;
    handleChangeAccName(event){
      this.currentAccountName = event.target.value;      
    }
 
    handleAccountSearch(){
       this.searchAccountName = this.currentAccountName;
    }

    
   
@wire(retrieveBikeData,{keySearch : '$searchAccountName'})
wireData({data,error}){
    this.records=data;
    
}

}
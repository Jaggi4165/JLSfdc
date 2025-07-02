import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';

export default class NavigationExampleLWCTask1 extends  NavigationMixin(LightningElement) {
    myRecId;
    name;
    phoneNumber;
    nameChangedHandler(event){
        this.name = event.target.value;
    }
    ratingChangedHandler(event){
        this.rating = event.target.value;
    }
    phoneChangedHandler(event){
        this.phoneNumber = event.target.value;
    }

    


    createAccount(){

        var fields = {'Name' : this.name,'Phone' : this.phoneNumber};
        var input = {'apiName' : 'Account', fields};

        createRecord(input).then(response => {
            this.myRecId=response.id;

           /* this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: response.id,
                    objectApiName: 'Account',
                    actionName: 'view'
                },
            });
            */
            this.navi(response.id);
            console.log("responce id1 is: ===== > "+this.myRecId);

        }).catch(error => {
            console.log("responce Error is: ===== > "+error);
        });
    }

    navi(myid)
    {
        if(myid != '')
        {
        console.log("responce id2 is before navigation: ===== > "+myid);
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: myid,
                objectApiName: 'Account',
                actionName: 'view'
            },
        });
        }
        else
            console.log("responce id2 is after navigation: ===== > "+myid);

    }
}
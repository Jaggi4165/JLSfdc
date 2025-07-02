import { LightningElement ,api} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

import fetchAccountDetails from '@salesforce/apex/QuoteWizardApexClass.fetchAccountDetails';
export default class QuoteButtonOnContact extends NavigationMixin(LightningElement) {
    @api recordId;
    @api myAccid;

    handleClickOnQuoteCreateButton(event){
            fetchAccountDetails({
                conId: this.recordId
            })
            .then(result => { 
                    this.myAccid = result[0].AccountId;
                    // console.log("select contact then account id id: "+this.myAccid);
                    // console.log("Result is : "+JSON.stringify(result))
                    if(this.myAccid != undefined){
                        this[NavigationMixin.Navigate]({
                            type: 'standard__navItemPage',
                            attributes: {
                                apiName: 'Quote_Creation_Wizard',
                            },
                            state: {
                                c__finalContactIdDemo : this.recordId,
                                c__myAccid : this.myAccid
                            }
            
                        });
                    }
                    else {
                        const event = new ShowToastEvent({
                            title: 'Error',
                            variant: 'error',
                            message: '"No Account is Associated with this Contact. So we cannot navigate to the QUOTE WIZARD.',
                        });
                        this.dispatchEvent(event);
                    }
            })
            .catch(error => {
                const event5 = new ShowToastEvent({
                    title: 'Error',
                    variant: 'error',
                    message: 'No Such Account Data Found !',
                });
                this.dispatchEvent(event5);
            });
        
        
    }
}
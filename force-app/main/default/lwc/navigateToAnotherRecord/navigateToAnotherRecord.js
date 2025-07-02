import { LightningElement, api, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class NavigateToAnotherRecord extends NavigationMixin(LightningElement) {
    @api recordId; // Current record ID, auto-passed when added to a record page
    handleNavigation(){
        const destinationAppDeveloperName = 'Apex_Recipes'; // Use app developer name
        this[NavigationMixin.Navigate]({
         type: 'standard__app',
            attributes: {
                appTarget: destinationAppDeveloperName,
                pageRef: {
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: this.recordId,
                        actionName: 'view'
                    }
                }
            }
        });
    }
}
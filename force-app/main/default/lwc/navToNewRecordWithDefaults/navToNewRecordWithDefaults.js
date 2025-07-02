import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';

export default class NavToNewRecordWithDefaults extends NavigationMixin(
    LightningElement
) {
    navigateToNewContactWithDefaults() {
        const defaultValues = encodeDefaultFieldValues({
            FirstName: 'Jagadeeswara Rao',
            LastName: 'Kusumuru',
            LeadSource: 'Other'
        });

        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Contact',
                actionName: 'new'
            },
            state: {
                defaultFieldValues: defaultValues
            }
        });
    }
}
import { LightningElement, wire, track } from 'lwc';
import getAccountsWithContacts from '@salesforce/apex/CustomLabelsComponentController.getAccountsWithContacts';

const columns = [
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Industry', fieldName: 'Industry', type: 'text' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Website', fieldName: 'Website', type: 'url' }
];

const contactColumns = [
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Title', fieldName: 'Title', type: 'text' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
];
export default class CustomLabelsComponent extends LightningElement {
    // ExternalString.Name,Language,Value FROM ExternalStringLocalization WHERE ExternalString.Name LIKE 'Wishing';
    @track accountsWithContacts = [];
    @track columns = columns;
    contactColumns = contactColumns;
    @track isLoading = true;
    @track error;

    @wire(getAccountsWithContacts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accountsWithContacts = data.map(account => {
                return {
                    ...account,
                    isExpanded: false,
                    contacts: account.Contacts ? account.Contacts : []
                };
            });
            this.error = undefined;
            this.isLoading = false;
        } else if (error) {
            this.error = error;
            this.accountsWithContacts = [];
            this.isLoading = false;
            console.error('Error fetching accounts with contacts:', error);
        }
    }

    handleToggle(event) {
        const rowIndex = event.currentTarget.dataset.index;
        this.accountsWithContacts[rowIndex].isExpanded = !this.accountsWithContacts[rowIndex].isExpanded;
        this.accountsWithContacts = [...this.accountsWithContacts];
    }
}
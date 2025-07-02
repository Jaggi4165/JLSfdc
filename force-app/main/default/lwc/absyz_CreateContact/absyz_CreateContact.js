import { LightningElement, track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/absyz_LWCSessionController.getAccounts';
import saveContact from '@salesforce/apex/absyz_LWCSessionController.saveContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Absyz_CreateContact extends LightningElement {
    @track accountOptions = [];
    @track accountId;
    @track lastName = '';
    @track title = '';
    @track email = '';
    @track phone = '';

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accountOptions = data.map(account => {
                return { label: account.Name, value: account.Id };
            });
        } else if (error) {
            this.showToast('Error', error.body.message, 'error');
        }
    }

    handleAccountChange(event) {
        this.accountId = event.detail.value;
    }

    handleInputChange(event) {
        const field = event.target.name;
        if (field === 'lastName') {
            this.lastName = event.target.value;
        } else if (field === 'title') {
            this.title = event.target.value;
        } else if (field === 'email') {
            this.email = event.target.value;
        } else if (field === 'phone') {
            this.phone = event.target.value;
        }
    }

    handleSave() {
        const contact = {
            LastName: this.lastName,
            Title: this.title,
            Email: this.email,
            Phone: this.phone,
            AccountId: this.accountId
        };

        saveContact({ contact })
            .then(result => {
                this.showToast('Success', 'Contact created successfully', 'success');
                this.clearFields();
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(evt);
    }

    clearFields() {
        this.accountId = '';
        this.lastName = '';
        this.title = '';
        this.email = '';
        this.phone = '';
    }
}
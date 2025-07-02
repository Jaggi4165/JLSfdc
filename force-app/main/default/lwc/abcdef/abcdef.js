import { LightningElement} from 'lwc';
export default class Abcdef extends LightningElement {
    acc;
    handleSuccess(event) {
        alert('onsuccess event recordEditForm',event.detail.id);
        console.log('onsuccess event recordEditForm',event.detail.id);
    }
    handleSubmit(event) {
        event.preventDefault();
        // Get data from submitted form
        const fields = event.detail.fields;
        // Here you can execute any logic before submit
        // and set or modify existing fields
        fields.AccountId = this.acc;
        // You need to submit the form after modifications
        this.template
            .querySelector('lightning-record-edit-form').submit(fields);
    }
    handleSuccess1(event) {
        alert('onsuccess event recordEditForm',event.detail.id);
        this.acc = event.detail.id;
        console.log('onsuccess event recordEditForm',event.detail.id);
    }
    
}
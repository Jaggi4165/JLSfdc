import {api, LightningElement} from 'lwc';

export default class TrcAdminField extends LightningElement {
    @api fieldObject;

    get fieldLabel() {
        return this.fieldObject?.label;
    }

    get fieldApiName() {
        return this.fieldObject?.apiName;
    }

    get isChecked() {
        return this.fieldObject?.checked;
    }

    handleFieldChange(event) {
        this.dispatchEvent(new CustomEvent('fieldchange', {
            detail: {
                fieldName: this.fieldApiName,
                checked: event.detail.checked
            }
        }));
    }
}
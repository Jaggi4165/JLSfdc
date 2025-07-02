import { LightningElement } from 'lwc';

export default class PickListAssignment extends LightningElement {
    value = '';

    get options() {
        return [
            { label: 'Red', value: 'Red' },
            { label: 'Green', value: 'Green' },
            { label: 'Blue', value: 'Blue' },
            { label: 'Yellow', value: 'Yellow' },
            { label: 'Black', value: 'Black' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }
}
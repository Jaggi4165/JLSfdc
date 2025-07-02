import { LightningElement,api } from 'lwc';
import LOCALE from '@salesforce/i18n/locale';
export default class DemoComponent extends LightningElement {
    name="Jagadeesh Kusumuru"
    firstName = '';
    lastName = '';
    handleChange(event) {
        const field = event.target.name;
        if (field === 'firstName') {
            this.firstName = event.target.value;
        } else if (field === 'lastName') {
            this.lastName = event.target.value;
        }
    }
    get uppercasedFullName() {
        return `${this.firstName} ${this.lastName}`.toUpperCase();
    }

    @api show = false;

    date = new Date();
    formattedDate = new Intl.DateTimeFormat(LOCALE).format(this.date);

}
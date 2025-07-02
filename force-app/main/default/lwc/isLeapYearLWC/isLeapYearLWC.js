import { LightningElement,track } from 'lwc';
export default class IsLeapYearLWC extends LightningElement {
     @track year = '';
    @track result = '';
    @track isLeapYear = false;
    currentDate;

    handleYearChange(event) {
        this.year = event.target.value;
    }

    connectedCallback() {
        this.currentDate = new Date().toLocaleTimeString(); // 11:18:48 AM
    }

    checkLeapYear() {
        this.isLeapYear = false;
        const yearNum = parseInt(this.year, 10);

        if (isNaN(yearNum)) {
            this.result = 'Please enter a valid number.';
            this.isLeapYear = false;
            return;
        }

        if (yearNum<1 || yearNum>10000) {
            this.result = 'Please enter a number between 1 to 10000.';
            this.isLeapYear = false;
            return;
        }

        if ((yearNum % 4 === 0 && yearNum % 100 !== 0) || (yearNum % 400 === 0)) {
            this.isLeapYear = true;
            this.result = `${yearNum} is a leap year.`;
        } else {
            this.isLeapYear = false;
            this.result = `${yearNum} is not a leap year.`;
        }
    }


}
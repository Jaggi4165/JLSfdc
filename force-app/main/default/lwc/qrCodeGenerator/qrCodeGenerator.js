import { LightningElement,api,track,wire } from 'lwc';
import qrcode from './qrcode.js';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import RATING_FIELD from "@salesforce/schema/Account.Rating";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
const fields = [NAME_FIELD, RATING_FIELD, INDUSTRY_FIELD];

export default class QrCodeGenerator extends LightningElement {
    @api recordId;
    digits = 8;
    inputValue = '';
    isDisabled = false;
    @wire(getRecord, {recordId: '$recordId',fields:fields})
    accounts({ data, error }) {
        if (data) {
            this.inputValue= data.fields.Name.value;
            const qrCodeGenerated = new qrcode(0, 'H');
            //let strForGenearationOfQRCode  = data.fields.Name.value;
            let randomNumber  = Math.floor(Math.random() * (9 * (Math.pow(10, this.digits-1)))) + (Math.pow(10, this.digits-1))
            let strForGenearationOfQRCode  = randomNumber+'A';
            console.log('Random ===> ',strForGenearationOfQRCode);
            qrCodeGenerated.addData(strForGenearationOfQRCode);
            qrCodeGenerated.make();
            let element = this.template.querySelector(".qrcode2");
            element.innerHTML = qrCodeGenerated.createSvgTag({});
        } else if (error) {
            window.console.log("Error");
        }

    }
    randomNumber(){
        //Math.floor(Math.random() * (999999 - 100000 + 1)) + 100000;
        //Math.floor(Math.random() * (9 * (Math.pow(10, this.digits)))) + (Math.pow(10, this.digits));
    }
    connectedCallback() {
        //this.letterHandler();
    }
//    inputChange() {
//         this.inputValue = event.target.value;
//     }
    letterHandler() {
        const qrCodeGenerated = new qrcode(0, 'H');
        let strForGenearationOfQRCode  = Math.floor(Math.random() * (999999 - 100000 + 1)) + 100000;;
        qrCodeGenerated.addData(strForGenearationOfQRCode);
        qrCodeGenerated.make();
        let element = this.template.querySelector(".qrcode2");
        element.innerHTML = qrCodeGenerated.createSvgTag({});
    }
}
/*import { LightningElement } from 'lwc';

export default class qrCodeGenerator extends LightningElement {
    inputValue = '';
    value      = false;
    url        = "https://chart.googleapis.com/chart?chs=200x200&cht=qr&chl=";
    img_url    = '';

    inputChange(event) {
        this.inputValue = event.target.value;
        
    }

    letterHandler() {
        
        this.value      = true;
        this.img_url    = this.url + this.inputValue;

    }
}*/
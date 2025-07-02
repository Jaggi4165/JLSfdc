import { LightningElement } from 'lwc';

export default class Hello extends LightningElement {
    greeting = 'Jagadeeswar !';
    firstNumber;
    secondNumber;
    result=0;
    handleInputChange1(event){
        this.firstNumber = event.target.value;
    }
    handleInputChange2(event){
        this.secondNumber = event.target.value;
    }
    handleButtonClick(){
        this.result=parseInt(this.firstNumber)+parseInt(this.secondNumber);
    }
}
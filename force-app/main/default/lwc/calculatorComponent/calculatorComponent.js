import { LightningElement, track } from 'lwc';

export default class CalculatorComponent extends LightningElement {

@track firstNumber;
@track secondNumber;
@track allResults=[];
result;
symbol;
eventHandlerOne(event){
    this.firstNumber = parseInt(event.target.value);
}
eventHandlerTwo(event){
    this.secondNumber = parseInt(event.target.value);
}
addtionFunction(){
    this.result = this.firstNumber + this.secondNumber;
    this.allResults.push(this.result);
    this.symbol='+';
}
subtractFunction(){
    this.result  = this.firstNumber - this.secondNumber;
    this.allResults.push(this.result);
    this.symbol='-';
}
multiplicationFunction(){
    this.result = this.firstNumber * this.secondNumber;
    this.allResults.push(this.result);
    this.symbol='*';
}
divisionFunction(){
    this.result = this.firstNumber / this.secondNumber;
    this.allResults.push(this.result);
    this.symbol='/';
}
}
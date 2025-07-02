export function showNotification(titleText,messageText,variant,mode) {
    const evt = new ShowToastEvent({
        title: titleText,
        message: messageText,
        variant: variant,
        mode : mode
    });
    this.dispatchEvent(evt);
}
export function alerts(string){
    alert(string);
}
export function add(int1, int2){
    return int1+int2;
}
export function multiplication(int1, int2){
    return int1*int2;
}
export function division(int1, int2){
    return int1/int2;
}
export function substract(int1, int2){
    return int1-int2;
}
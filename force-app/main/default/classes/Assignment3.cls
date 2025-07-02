public class Assignment3 {
	   Public Integer number1=10,number2=20,number3=30;
    public Assignment3(Integer a,Integer b,Integer c){
        System.debug('Beffore Modification : ');
        System.debug('number1 :'+number1);
        System.debug('number2 :'+number2);
        System.debug('number3 :'+number3);
        this.number1=a;
        this.number2=b;
        this.number3=c;
    }
    public void printValues(){
        System.debug('After Modification : ');
        System.debug('number1 :'+number1);
        System.debug('number2 :'+number2);
        System.debug('number3 :'+number3);
    }
}
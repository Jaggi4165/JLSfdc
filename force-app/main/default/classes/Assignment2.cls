public class Assignment2 {
    public void methodForInchFeet(Decimal inch1,Decimal inch2){
        Decimal sum=inch1+inch2;
        Decimal inchSumInFeet=sum*0.08333;
        System.debug(inchSumInFeet);
    }
    public void methodForMeterKm(Decimal meter1,Decimal meter2){
        Decimal sum2=meter1+meter2;
        Decimal meterSumInKm=sum2/1000;
        System.debug(meterSumInKm);
    }
}
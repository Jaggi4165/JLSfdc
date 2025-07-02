public class MyHelloWorld {
    public static void applyDiscount(Book__c[] books) {
        Decimal defaultDiscount = 0.01;
        for (Book__c b :books){
            if(defaultDiscount > 0.1 || b.Apply_Default_Discount__c){
                b.Price__c *= b.Apply_Default_Discount__c ? defaultDiscount : 1;
            }
            else{
                //b.addError('Default Discount should be greater than 0.1');
            }
            
        }
    }
}
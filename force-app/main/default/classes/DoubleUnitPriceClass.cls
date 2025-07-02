public class DoubleUnitPriceClass {
    public static void unitPrice(List<Merchandise__c> merchList) {
        Set<Id> merchId = new Set<Id>();
        
        for(Merchandise__c a: merchList) {
            merchId.add(a.Id);
        }
        
        List<Line_Item__c> lineItemList = [Select Merchandise__r.Id, Merchandise__r.Quantity__c, Unit_Price__c
                                          From Line_Item__c
                                          Where Merchandise__r.Id IN: merchId];
        
        for(Line_Item__c b: lineItemList) {
            if(b.Merchandise__r.Quantity__c == 20) {
                b.Unit_Price__c = 2 * b.Unit_Price__c;
            }
        }
        
        update lineItemList;
    }
}
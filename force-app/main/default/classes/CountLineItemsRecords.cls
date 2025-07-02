public class CountLineItemsRecords {
    public static void countLineItems(List<Line_Item__c> lineItemList) {
        Set<Id> merchId = new Set<Id>();
        
        for(Line_Item__c a: lineItemList) {
            merchId.add(a.Id);
        }
        
        List<Merchandise__c> merchList = new List<Merchandise__c>();
        List<Merchandise__c> merchUpdate = new List<Merchandise__c>();
        List<Line_Item__c> merchIdList = new List<Line_Item__c>();
        
        merchList = [Select Id, No_Of_LineItems__c From Merchandise__c Where Id IN: merchId];
        merchIdList = [Select Id From Line_Item__c Where Merchandise__c IN: merchId];
        
        Integer count = merchIdList.size();
        
        System.debug('Count is: ' + count);
        
        for(Merchandise__c b: merchList) {
            b.No_Of_LineItems__c = count;
            merchUpdate.add(b);
        }
        
        update merchUpdate;
    }
    
    public static void countLineItemsPart2(List<Line_Item__c> lineItemList) {
        Set<Id> merchId = new Set<Id>();
        
        for(Line_Item__c a: lineItemList) {
            merchId.add(a.Merchandise__c);
        }
        
        List<Merchandise__c> merchList = new List<Merchandise__c>();
        List<Merchandise__c> merchUpdate = new List<Merchandise__c>();
        List<Line_Item__c> merchIdList = new List<Line_Item__c>();
        
        merchList = [Select Id, No_Of_LineItems__c From Merchandise__c Where Id IN: merchId];
        merchIdList = [Select Id From Line_Item__c Where Merchandise__c IN: merchId];
        
        Integer count = merchIdList.size();
        
        System.debug('Count is: ' + count);
        
        for(Merchandise__c b: merchList) {
            b.No_Of_LineItems__c = count;
            merchUpdate.add(b);
        }
        
        update merchUpdate;
    }
}
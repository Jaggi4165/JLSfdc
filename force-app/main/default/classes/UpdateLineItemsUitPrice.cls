/*
Create an apex method which updates all the line item unit prices based on the price
available on the Merchandise record. If the Merchandise record Price is 100 and that
merchandise has 5 Line Item records , update the unit price of Line Item to 20
*/
public class UpdateLineItemsUitPrice {
	public static void updateLineItems()
    {
        List<Merchandise__c> merList = [SELECT Id,Price__c from Merchandise__c];
        List<Id> idlistOfMer = new List<Id>();
        for(Merchandise__c merListId:merList)
        {
            idListOfMer.add(merListId.Id);
        }
        List<Line_Item__c> lic = new List<Line_Item__c>();
        for(Line_Item__c lic2:[select Id,Merchandise__c,Unit_Price__c from Line_Item__c])
        {
            
        }
    }
}
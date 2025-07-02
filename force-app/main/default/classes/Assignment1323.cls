public class Assignment1323 {
	public void method()
    {
        List<Line_Item__c> listOfItems = new List<Line_Item__c>();
        for(Merchandise__c mrec : [select Id,Price__c,(select Id,Unit_Price__c from Line_Items__r) from Merchandise__c])
        {
        	Integer records = mrec.Line_Items__r.size();
            Decimal uPrice = mrec.Price__c/records;
            for(Line_Item__c up : mrec.Line_Items__r)
            {
                up.Unit_Price__c=uPrice;
                listOfItems.add(up);
            }
        }
         if(listOfItems.size()>0)
         {
             update listOfItems;
         }
    }
}
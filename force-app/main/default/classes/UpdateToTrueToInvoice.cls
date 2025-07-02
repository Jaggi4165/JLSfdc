public class UpdateToTrueToInvoice {
	public void orderComplete()
    {
        List<Invoice__c> listOfInvoices = [SELECT Order_Complete__c FROM Invoice__c];
        List<Merchandise__c> listOfMerchandise = [SELECT Order_Complete__c FROM Merchandise__c];
        for(Merchandise__c merList : listOfMerchandise)
        {
            for(Invoice__c invList : listOfInvoices)
            {
                if(merList.Order_Complete__c==True)
                {
                    invList.Order_Complete__c=True;
                }
            }
        }
        update listOfInvoices;
    }
}
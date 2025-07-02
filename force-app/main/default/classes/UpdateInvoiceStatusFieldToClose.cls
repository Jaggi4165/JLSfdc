public class UpdateInvoiceStatusFieldToClose 
{
   public void updatingStausField()
   {
       
       map<Id,Decimal> idWithSumTotal = new map<Id,Decimal>();
       List<Invoice__c> invList = new List<Invoice__c>();
       for(Line_Item__c lic : [select id,Line_Item_Total__c,Invoice__c from Line_Item__c])
       {
           Decimal total;
           if(idWithSumTotal.containsKey(lic.Invoice__c))
           {
               total=idWithSumTotal.get(lic.Invoice__c)+lic.line_Item_Total__c;
               idWithSumTotal.put(lic.Invoice__c,total);
           }
           else
           {
               idWithSumTotal.put(lic.Invoice__c,lic.line_Item_Total__c);
           }
       }
       if(idWithSumTotal.size()>0)
       {
           for(Invoice__c invoiceRecord:[select Id,Status__c from Invoice__c where Id IN:idWithSumTotal.keyset()])
           {
               if(idWithSumTotal.containsKey(invoiceRecord.Id)&& idWithSumTotal.get(invoiceRecord.Id)>100)
               {
                   invoiceRecord.Status__c='Closed';
                   invList.add(invoiceRecord);
               }
           }
       }
       if(invList.size()>0){
           update invList;
       }
   }
}
public class Assignment13{
    public static void insertInvoiceReference(Invoice__c iv){
    	iv.Status__c='Closed';
        iv.Value__c=999;
        insert iv;
    }
    public void insert10Records(Integer records){
        //Invoice__c iv=new Invoice__c();
        List<Invoice__c> invoice_List_Records = new List<Invoice__c>();		
        
        for(Integer i=1;i<=records;i++){
            Invoice__c iv = new Invoice__c(Status__c='Open',Value__c=4165);
            invoice_List_Records.add(iv);
            //System.debug(i +' Records Inserted........');
        }
        insert invoice_List_Records;
    
        //return invoice_List_Records;
        Assignment13 ass=new Assignment13();
		ass.updateValueTo100(invoice_List_Records);
    }
    
    public void updateValueTo100(List<Invoice__c> invoice_List_Records){
        System.debug('enter to update records to 100');
         set<Id> idList = new set<Id>(); 
         for(Invoice__c obj : invoice_List_Records )
        {
            idList.add(obj.Id);
        }    
        List<Invoice__c> idList2 = [ Select Id FROM Invoice__c where Id IN : idList ];
         for(Invoice__c invId : idList2)
        {
            //System.debug('Process.....................................updating....');
            invId.value__c = 100;
        }
        if(idList.size() > 0)
        {
            update idList2;
        }
        System.debug('Updated....');
    }
}


/*
Anonymus window code:-

Assignment13 ass=new Assignment13();
Invoice__c iv=new Invoice__c();
Assignment13.insertInvoiceReference(iv);
ass.insert10Records(3);

*/
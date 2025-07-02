public class Extra{
    public static void insertInvoiceReference(Invoice__c iv){
        System.debug('starting........');
    	iv.Status__c='Closed';
        iv.Value__c=165;
        insert iv;
    }
    public void insert10Records(Integer records){
        Integer rec=records;
        Invoice__c iv=new Invoice__c();
        List<Invoice__c> tenRecords = new List<Invoice__c>();        
        for(Integer i=1;i<=records;i++){
            iv = new Invoice__c(Status__c='Open',Value__c=4165);
            tenRecords.add(iv);
            System.debug('Insert '+i);
        }
        insert tenRecords;
        System.debug('Total ' +records +'Records have been Inserted........');
        
    }
    
    public void updateValueTo100(){
        
         List<Invoice__c> idList = new List<Invoice__c>();        
        for(Integer i=1;i<=10;i++)
        {
            idList.add([Select ID from Invoice__c]);
        }
        for(Invoice__c upd: idList )
        		{
           			 upd.Value__c = 100;
        		}

        if(idList.size() > 0)
        {
            update idList;
        }
        
    }
}
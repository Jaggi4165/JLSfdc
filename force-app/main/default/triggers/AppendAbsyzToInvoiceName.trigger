/*
Create a trigger, which will append ‘Absyz’ to the names of Invoice records whenever any insertion
happens.
*/
trigger AppendAbsyzToInvoiceName on Invoice__c (before insert,before Update) {
     	for(Invoice__c inv:trigger.new)
    	{
         	if((inv.Name__c).Contains('Absyz')){
                inv.Name__c=inv.Name__c;
            }
            else {
                inv.Name__c=inv.Name__c+' Absyz';   
    	}   
    }
}
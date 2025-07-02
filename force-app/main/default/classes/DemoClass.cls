public class DemoClass {
    @AuraEnabled
    public static void updateAccountPhone(List<Contact> listOfContacts){
		List<Id> accountIds = new List<Id>(); 
    	Map<Id,Contact> mapList = new Map<Id,Contact>();
    	for(Contact c : listOfContacts){
        	if(c.Phone != null){
            	accountIds.add(c.AccountId);
            	mapList.put(c.AccountId,c);
        	}
    	}
    	List<Account> accountList = [select Id,Phone from Account where Id in : accountIds];
    	for(Account a : accountList){
        	if(mapList.containskey(a.Id)){
            	a.Phone = mapList.get(a.id).Phone;
        	}
    	}
    	update accountList;
    }
}
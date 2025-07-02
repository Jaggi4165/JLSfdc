/* TODO: 1. Filter data where createdBy = Logged in user or Originating Attorney
         2. Query needs to fetch all the data related to the Conflict Check, Clients, Inventors and Keywords 
         3. Add the variables to the Wrapper for Keywords and Inventor Table

*/
public with sharing class conflictCheckUtilities {
    @AuraEnabled
	public static List<accountWrapper> getRecentConflictCheckRequests(String recordId) {
        List<accountWrapper> wrapperResults = getConflictCheckRequests(recordId);
        return wrapperResults;
    }
    @AuraEnabled(cacheable=true)
	public static List<accountWrapper> getConflictCheckRequests(String recordId) {
		// Wrapper for the Conflic Check Requests
        
		List<Account> conflictCheckRequests = new List <Account>();
        System.debug('recordId ====> '+recordId);
        if(String.isNotBlank(recordId)){
            conflictCheckRequests = [SELECT   id
                                            , Name
                                            
                                            , (SELECT id, AccountId
                                               FROM Contacts
                                               WHERE AccountId!= null
                                              )
                                    FROM Account
                                    WHERE Id=:recordId AND CreatedById =: UserInfo.getUserId()
                                ];
        }
        else{
            conflictCheckRequests =[SELECT   id
                                            , Name
                                            
                                            , (SELECT id
                                                    , AccountId
                                                FROM Contacts
                                            )
                                    FROM Account
                                    LIMIT 5
                                ];
        }
		System.debug('conflictCheckRequests ==> '+conflictCheckRequests);
      List<accountWrapper> conflictCheckWrapperRecords = new List<accountWrapper>();
      
      if(conflictCheckRequests.size() > 0 ){ 

        for(Account cc : conflictCheckRequests){
            accountWrapper ccWrapper = new accountWrapper();
            ccWrapper.recordId              = cc.Id;
            ccWrapper.recordName            = cc.Name;            
            conflictCheckWrapperRecords.add(ccWrapper);
        }
        
    }
    System.debug('records from database ==> '+conflictCheckWrapperRecords);
    return conflictCheckWrapperRecords;
      }
}
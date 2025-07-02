public class TCSQueNo1Handler {
    public static void beforeInsertOperations(List<Case> newVersionCasesList,List<Case> oldVersionCasesList){
        
    }
    public static void beforeUpdateOperations(List<Case> newVersionCasesList,List<Case> oldVersionCasesList){
        
    }
    public static void beforeDeleteOperations(List<Case> newVersionCasesList,List<Case> oldVersionCasesList){
        
    }
    public static void afterInsertOperations(List<Case> newVersionCasesList,List<Case> oldVersionCasesList){
        // After case inserted, update Account rating based on the count of closed cases.
        updateAccountRating(newVersionCasesList); 
    }
    public static void afterUpdateOperations(List<Case> newVersionCasesList,List<Case> oldVersionCasesList){
        // After case inserted, update Account rating based on the count of closed cases.
        updateAccountRating(newVersionCasesList); 
    }
    public static void afterDeleteOperations(List<Case> newVersionCasesList,List<Case> oldVersionCasesList){
        // After case inserted, update Account rating based on the count of closed cases.
        updateAccountRating(newVersionCasesList); 
    }
    
    // Private Methods starts here
    private static void updateAccountRating(List<Case> newVersionCasesList){
        AggregateResult[] aggregateCases = [SELECT AccountId, Count(Id) closedCases From Case WHERE Id IN : newVersionCasesList AND Status='Closed' Group by AccountId];
        List<Account> accountToUpdate = new List<Account>();
        for(AggregateResult aggr : aggregateCases){
            Integer countOfClosedCases = Integer.valueOf(aggr.get('closedCases'));
            String rating =  countOfClosedCases<=3 ? 'Hot' : countOfClosedCases>3 && countOfClosedCases<=5 ? 'Warm' :  countOfClosedCases>5 ? 'Cold' : '';
            accountToUpdate.add(new Account(Id = string.valueOf(aggr.get('AccountId')), Rating = rating));
        }
        if(!accountToUpdate.isEmpty()) Update as user accountToUpdate;
    }
}
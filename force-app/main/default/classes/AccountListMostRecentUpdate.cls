public class AccountListMostRecentUpdate {
@AuraEnabled
    public static List<Account> getAccountRecord()
   {
        return new List<Account>([Select id,Name,Phone,AnnualRevenue,Website,Type,Rating from Account ORDER BY LastModifiedDate DESC LIMIT  10]);
    }
}
/**
 * @description Service layer class for Account operations that demonstrates
 * security best practices, governor limit awareness, and Apex coding standards
 */
public with sharing class AccountService {
    
    // Use constants for static values that might be reused
    private static final Integer MAX_RECORDS_TO_QUERY = 10000;
    private static final String DEFAULT_COUNTRY = 'United States';
    
    // Custom exception class for specific error handling
    public class AccountServiceException extends Exception {}
    
    /**
     * @description Updates the annual revenue for accounts matching the criteria
     * @param industry The industry to filter accounts by
     * @param minEmployees Minimum number of employees to filter by
     * @param revenueIncrease Amount to increase annual revenue by
     * @return List<Account> Updated accounts
     * @throws AccountServiceException If validation fails or DML operation fails
     */
    public static List<Account> updateRevenueForIndustryAccounts(
        String industry, 
        Integer minEmployees, 
        Decimal revenueIncrease
    ) {
        // Validate input parameters
        if (String.isBlank(industry)) {
            throw new AccountServiceException('Industry parameter cannot be blank');
        }
        if (minEmployees < 0) {
            throw new AccountServiceException('Employee count cannot be negative');
        }
        if (revenueIncrease == null || revenueIncrease < 0) {
            throw new AccountServiceException('Revenue increase must be a positive number');
        }

        try {
            // Use SOQL with bind variables and field-level security check
            String query = 'SELECT Id, Name, AnnualRevenue, Industry, NumberOfEmployees ' +
                           'FROM Account ' +
                           'WHERE Industry = :industry ' +
                           'AND NumberOfEmployees >= :minEmployees ' +
                           'WITH SECURITY_ENFORCED ' +
                           'LIMIT :MAX_RECORDS_TO_QUERY';
            
            List<Account> accountsToUpdate = Database.query(query);
            
            if (accountsToUpdate.isEmpty()) {
                return accountsToUpdate;
            }
            
            // Bulkify operations - process all records in memory first
            for (Account acc : accountsToUpdate) {
                if (acc.AnnualRevenue == null) {
                    acc.AnnualRevenue = 0;
                }
                acc.AnnualRevenue += revenueIncrease;
            }
            
            // Use Database methods with allOrNone=false for partial success handling
            Database.SaveResult[] saveResults = Database.update(accountsToUpdate, false);
            
            // Process and log any errors
            handleSaveResults(saveResults, accountsToUpdate);
            
            return accountsToUpdate;
        } catch (Exception e) {
            // Log exception details before rethrowing
            System.debug(LoggingLevel.ERROR, 'Error in updateRevenueForIndustryAccounts: ' + 
                e.getMessage() + '\n' + e.getStackTraceString());
            throw new AccountServiceException('Failed to update accounts: ' + e.getMessage(), e);
        }
    }
    
    /**
     * @description Creates new accounts with default values
     * @param accountNames List of account names to create
     * @return List<Account> Created accounts
     */
    public static List<Account> createAccounts(List<String> accountNames) {
        // Validate input
        if (accountNames == null || accountNames.isEmpty()) {
            throw new AccountServiceException('Account names list cannot be null or empty');
        }
        
        // Check for duplicates in input
        Set<String> uniqueNames = new Set<String>(accountNames);
        if (uniqueNames.size() < accountNames.size()) {
            throw new AccountServiceException('Duplicate account names found in input');
        }
        
        List<Account> newAccounts = new List<Account>();
        for (String name : accountNames) {
            if (String.isBlank(name)) {
                continue; // Skip blank names
            }
            
            Account acc = new Account(
                Name = name.trim(),
                BillingCountry = DEFAULT_COUNTRY,
                // Set other default values
                AnnualRevenue = 0,
                NumberOfEmployees = 1
            );
            newAccounts.add(acc);
        }
        
        if (newAccounts.isEmpty()) {
            return newAccounts;
        }
        
        try {
            // Use Database.insert with partial success option
            Database.SaveResult[] saveResults = Database.insert(newAccounts, false);
            handleSaveResults(saveResults, newAccounts);
            
            return newAccounts;
        } catch (DmlException e) {
            System.debug(LoggingLevel.ERROR, 'DML Exception in createAccounts: ' + 
                e.getMessage() + '\n' + e.getStackTraceString());
            throw new AccountServiceException('Failed to create accounts: ' + e.getMessage(), e);
        }
    }
    
    /**
     * @description Handles save results and logs errors
     * @param saveResults Results from Database.insert/update/upsert
     * @param records List of records that were processed
     */
    private static void handleSaveResults(Database.SaveResult[] saveResults, List<SObject> records) {
        for (Integer i = 0; i < saveResults.size(); i++) {
            Database.SaveResult sr = saveResults[i];
            if (!sr.isSuccess()) {
                SObject record = records[i];
                String errorMsg = 'Failed to save record ' + record.get('Name') + ': ';
                
                for (Database.Error err : sr.getErrors()) {
                    errorMsg += err.getStatusCode() + ': ' + err.getMessage();
                    if (err.getFields() != null && !err.getFields().isEmpty()) {
                        errorMsg += ' Fields: ' + String.join(err.getFields(), ',');
                    }
                }
                
                // Log error for each failed record
                System.debug(LoggingLevel.ERROR, errorMsg);
            }
        }
    }
    
    /**
     * @description Future method to process account updates asynchronously
     * @param accountIds List of account IDs to process
     */
    @Future
    public static void processAccountsAsync(Set<Id> accountIds) {
        if (accountIds == null || accountIds.isEmpty()) {
            return;
        }
        
        // Query accounts with all necessary fields
        List<Account> accounts = [
            SELECT Id, Name, AnnualRevenue, NumberOfEmployees
            FROM Account
            WHERE Id IN :accountIds
            WITH SECURITY_ENFORCED
            LIMIT :MAX_RECORDS_TO_QUERY
        ];
        
        if (accounts.isEmpty()) {
            return;
        }
        
        // Process accounts asynchronously
        for (Account acc : accounts) {
            // Example processing logic
            if (acc.NumberOfEmployees > 100) {
                acc.AnnualRevenue = acc.AnnualRevenue * 1.1; // 10% increase
            }
        }
        
        // Update accounts with error handling
        Database.update(accounts, false);
    }
}
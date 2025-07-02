/**
 * @File Name : RevokeAccessForCasesCreated7DaysBefore.cls
 * @Description : Batch class to revoke access for Case records older than 7 days by deleting CaseShare records
 * @Author : Jagadeeswara Rao Kusumuru
 * @Last Modified By : Jagadeeswara Rao Kusumuru
 * @Last Modified On : December 11, 2024
 * @Modification Log : 
 * ==============================================================================
 * Ver | Date | Author | Modification
 * ==============================================================================
 * 1.0 | December 11, 2024 | Jagadeeswara Rao Kusumuru   | Initial Version
 **/

public class RevokeAccessForCasesCreated7DaysBefore implements Database.Batchable<SObject> {

    // Start method to collect the records to delete
    public Database.QueryLocator start(Database.BatchableContext BC) {
        // Query to get all Case records older than 7 days
        String query = 'SELECT Id FROM Case WHERE CreatedDate <= :System.now().addDays(-7)';
        return Database.getQueryLocator(query);
    }

    // Execute method to revoke access by deleting CaseShare records in chunks
    public void execute(Database.BatchableContext BC, List<Case> scope) {
        // Check if the scope is empty
        if (scope.isEmpty()) {
            return;
        }

        // Collect Case Ids from the current scope
        List<Id> caseIds = new List<Id>();
        for (Case c : scope) {
            caseIds.add(c.Id);
        }

        // Query to get all CaseShare records where ParentId is in the scope and RowCause is 'Manual'
        List<CaseShare> caseSharesToDelete = [
            SELECT Id , CaseId , RowCause
            FROM CaseShare 
            WHERE CaseId IN : caseIds AND RowCause = 'Manual'
        ];

        // Delete the selected CaseShare records
        if (!caseSharesToDelete.isEmpty()) {
            try {
                delete caseSharesToDelete;
                System.debug('Successfully deleted ' + caseSharesToDelete.size() + ' CaseShare records.');
            } catch (DmlException e) {
                // Handle DML errors if needed
                System.debug('Error deleting CaseShare records: ' + e.getMessage());
            }
        }
    }
	
    // Finish method (optional)
    public void finish(Database.BatchableContext BC) {
        // Send an email or notification once the batch job finishes (optional)
        System.debug('Batch Process Finished');
    }
}
public with sharing class GenericApprovalProcessController {
    @AuraEnabled(cacheable=true)
    public static List<String> getSupportedObjects() {
        // Add more objects as needed
        return new List<String>{'Account', 'Opportunity', 'Expense','Expanse__c'};
    }

   @AuraEnabled(cacheable=true)
public static List<Map<String, Object>> getPendingApprovals(String sObjectName) {
    List<Map<String, Object>> results = new List<Map<String, Object>>();

    List<ProcessInstanceWorkitem> items = [
        SELECT Id, ActorId, CreatedDate, OriginalActorId, ProcessInstanceId,
               ProcessInstance.TargetObjectId
        FROM ProcessInstanceWorkitem
        WHERE ActorId = :UserInfo.getUserId()
    ];

    for (ProcessInstanceWorkitem item : items) {
        Id targetId = item.ProcessInstance.TargetObjectId;
        if (targetId != null && String.valueOf(targetId).startsWith(getPrefixForObject(sObjectName))) {
            try {
                SObject target = Database.query('SELECT Id, ExpenseNumber FROM ' + sObjectName + ' WHERE Id = :targetId');
                results.add(new Map<String, Object>{
                    'recordId' => target.Id,
                    'recordName' => (String)target.get('ExpenseNumber'),
                    'workitemId' => item.Id,
                    'createdDate' => item.CreatedDate
                });
            } catch (Exception e) {
                // Handle cases where record no longer exists
                continue;
            }
        }
    }
    return results;
}

// Optional: Helper to filter by object type using prefix
private static String getPrefixForObject(String sObjectName) {
    Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
    Schema.DescribeSObjectResult r = gd.get(sObjectName).getDescribe();
    return r.getKeyPrefix();
}

    @AuraEnabled
    public static void handleApprovalAction(String workitemId, String actionName, String comments) {
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        req.setWorkitemId(workitemId);
        req.setAction(actionName); // 'Approve' or 'Reject'
        req.setComments(comments);
        Approval.ProcessResult result = Approval.process(req);

        if (!result.isSuccess()) {
            throw new AuraHandledException('Approval Failed: ' + result.getInstanceStatus());
        }
    }
}
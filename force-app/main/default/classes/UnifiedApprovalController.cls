public with sharing class UnifiedApprovalController {

    @AuraEnabled(cacheable=true)
    public static List<String> getSupportedObjects() {
        return new List<String>{'Account', 'Opportunity'}; // Add custom objects here
    }

    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getRecordsForObject(String objectName) {
        String query = 'SELECT Id, Name FROM ' + objectName + ' LIMIT 100';
        List<SObject> results = Database.query(query);
        List<Map<String, String>> recordList = new List<Map<String, String>>();
        for (SObject rec : results) {
            recordList.add(new Map<String, String>{
                'Id' => (String)rec.get('Id'),
                'Name' => (String)rec.get('Name')
            });
        }
        return recordList;
    }

    @AuraEnabled
    public static void submitApproval(String recordId) {
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setObjectId(recordId);
        Approval.ProcessResult result = Approval.process(req);
        if (!result.isSuccess()) {
            throw new AuraHandledException('Submission failed: ' + result.getInstanceStatus());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> getPendingApprovals(String objectName) {
        List<ProcessInstanceWorkitem> items = [
            SELECT Id, ActorId, CreatedDate, ProcessInstanceId, ProcessInstance.TargetObjectId
            FROM ProcessInstanceWorkitem
            WHERE ActorId = :UserInfo.getUserId()
        ];

        List<Map<String, Object>> response = new List<Map<String, Object>>();
        for (ProcessInstanceWorkitem item : items) {
            Id targetId = item.ProcessInstance.TargetObjectId;
            if (targetId != null && String.valueOf(targetId).startsWith(getPrefixForObject(objectName))) {
                try {
                    SObject record = Database.query('SELECT Id, Name FROM ' + objectName + ' WHERE Id = :targetId');
                    response.add(new Map<String, Object>{
                        'recordId' => record.Id,
                        'recordName' => String.valueOf(record.get('Name')),
                        'workitemId' => item.Id,
                        'createdDate' => item.CreatedDate
                    });
                } catch (Exception e) {
                    continue;
                }
            }
        }
        return response;
    }

    @AuraEnabled
    public static void handleApprovalAction(String workitemId, String actionName, String comments) {
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        req.setWorkitemId(workitemId);
        req.setAction(actionName);
        req.setComments(comments);
        Approval.ProcessResult result = Approval.process(req);

        if (!result.isSuccess()) {
            throw new AuraHandledException('Approval Failed: ' + result.getInstanceStatus());
        }
    }

    private static String getPrefixForObject(String sObjectName) {
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.DescribeSObjectResult r = gd.get(sObjectName).getDescribe();
        return r.getKeyPrefix();
    }
}
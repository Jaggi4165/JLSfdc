global class cmpJKBulkUpdateCtrl {
    public static Request invocableRequest;
    public static Result invocableResult = new Result();
    
    
    @AuraEnabled(cacheable=true)
    public static string getObjectInfo(Id recordId) {
        String sObjName = recordId.getSObjectType().getDescribe().getLabel();
        String sObjAPIName = recordId.getSObjectType().getDescribe().getName();
        return sObjName+'|'+sObjAPIName;        
    }
    
    
    @AuraEnabled(cacheable=true)
    public static  Map<String,String> getObjectsFieldsInfo(Id recordId) {
        Map<String, List<string>> mapObjField = new Map<String, List<string>>();
        //string BulkUpdateObjectFieldSetup = System.Label.BulkUpdateObjectFieldSetup;
        Map<String, BulkUpdateSetup__c> BulkUpdateSetup = BulkUpdateSetup__c.getAll();
        
        //List<string> list_BulkUpdateObjectFieldSetup = BulkUpdateObjectFieldSetup.split('&');
        
        Map<String,String> mapPicklistvalues=new Map<String,String>();
        String sObjName = recordId.getSObjectType().getDescribe().getName();
        
        for(String str : BulkUpdateSetup.keySet()) {
            BulkUpdateSetup__c config = BulkUpdateSetup.get(sObjName); 
            if(config==null) return null;
            string fields = config.Field_API_Name__c;
            List<string> individual_Fields = fields.split(',');
            for(String field : individual_Fields){
                if(sObjName == str){
                    if(!mapObjField.containskey(sObjName)){
                        mapObjField.put(sObjName,new list<string>{field});
                    }
                    else{
                        mapObjField.get(sObjName).add(field);
                    }     
                }
            }
            
        } 
        
        Map <String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.SObjectType sobjType = gd.get(sObjName);
        Schema.DescribeSObjectResult r = sobjType.getDescribe();
        Map<String, Schema.SObjectField> MapofField = r.fields.getMap();
        List<String> allFields = new List<String>();
        for(String fieldName : MapofField.keySet()) 
        {
            if(mapObjField.containskey(sObjName)){
                for(String setUpFields : mapObjField.get(sObjName)){
                    if(MapofField.get(fieldName).getDescribe().isUpdateable()){
                        Schema.SObjectField field = MapofField.get(fieldName);
                        Schema.DescribeFieldResult F = field.getDescribe();
                        if(setUpFields == F.getName()){
                            mapPicklistvalues.put(F.getLabel(),F.getName());
                        }
                    }
                }
            }
            else{
                return null; 
            }            
        } 
        return mapPicklistvalues;
    }
    
    
    
    /*
    @AuraEnabled(cacheable=true)
    public static  Map<String,String> getObjectsFieldsInfo1(Id recordId) {
        Map<String, List<string>> mapObjField = new Map<String, List<string>>();
        string BulkUpdateObjectFieldSetup = System.Label.BulkUpdateObjectFieldSetup;
        List<string> list_BulkUpdateObjectFieldSetup = BulkUpdateObjectFieldSetup.split('&');
        
        Map<String,String> mapPicklistvalues=new Map<String,String>();
        String sObjName = recordId.getSObjectType().getDescribe().getName();
        
        for(String s : list_BulkUpdateObjectFieldSetup){
            List<string> list_objField = s.split('-');
            if(sObjName == list_objField[0]){
                if(!mapObjField.containskey(sObjName)){
                    mapObjField.put(sObjName,new list<string>{list_objField[1]});
                }
                else{
                    mapObjField.get(sObjName).add(list_objField[1]);
                }
                
            }
        }
        Map <String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.SObjectType sobjType = gd.get(sObjName);
        Schema.DescribeSObjectResult r = sobjType.getDescribe();
        Map<String, Schema.SObjectField> MapofField = r.fields.getMap();
        List<String> allFields = new List<String>();
        for(String fieldName : MapofField.keySet()) 
        {
            if(mapObjField.containskey(sObjName)){
                for(String setUpFields : mapObjField.get(sObjName)){
                    if(MapofField.get(fieldName).getDescribe().isUpdateable()){
                        Schema.SObjectField field = MapofField.get(fieldName);
                        Schema.DescribeFieldResult F = field.getDescribe();
                        if(setUpFields == F.getName()){
                            mapPicklistvalues.put(F.getLabel(),F.getName());
                        }
                    }
                }
            }
            else{
                return null; 
            }            
        } 
        return mapPicklistvalues;
    }
    */
    @AuraEnabled
    public static String getFieldDataType(String objectAPIName, String fieldName){
        String datatype = '';
        try{
            datatype = [SELECT DataType FROM FieldDefinition WHERE EntityDefinitionId=:objectAPIName AND QualifiedApiName=:fieldName LIMIT 1].DataType;
        }
        catch(Exception e){
            System.debug('error ==> '+e);
        }
        return datatype;
    }
    
    @auraEnabled
    public static Map<String,String> getPicklistValues(String objectAPIName,String fieldName){
        Schema.DescribeFieldResult fieldResult = Schema.getGlobalDescribe().get(objectAPIName).getDescribe().fields.getMap().get(fieldName).getDescribe();
        Map<String,String> mapPicklistvalues=new Map<String,String>();
        for(Schema.PicklistEntry entry:fieldResult.getPicklistValues()){
            mapPicklistvalues.put(entry.getLabel(),entry.getValue());
        }
        return mapPicklistvalues;
    }
    
    //Update Docket Activity
    @InvocableMethod
    public static List<Result> get(List<Request> requestList) {
        invocableRequest = requestList[0];
        String uniqueIdentifier_Invocable = invocableRequest.uniqueIdentifier_Invocable; 
        switch on uniqueIdentifier_Invocable {
            when 'Update_Docket_Activity_Records'{
                new cmpJKBulkUpdateCtrl().updateDocketActivity();
            }
            when 'Update_All_Records'{
                new cmpJKBulkUpdateCtrl().updateAllRecords();
            }
        }
        return null;
    }
    
    public class Request {
        @InvocableVariable 
        public String uniqueIdentifier_Invocable;
        
        @InvocableVariable
        public String objectAPIName;
        
        @InvocableVariable
        public String fieldAPIName;
        
        @InvocableVariable
        public String fieldValue;
        
        @InvocableVariable
        public String taskClosingReason;
    }
    public class Result {
        public Result() {
            
        }
        
        @InvocableVariable
        public String resultStatus;
    }
    
    public void updateDocketActivity(){
        string objAPI = invocableRequest.objectAPIName;
        string fieldAPI = invocableRequest.fieldAPIName;
        string valueToUpdate = invocableRequest.fieldValue ;
        string comments = invocableRequest.taskClosingReason;
        
        
    }
    public void updateAllRecords(){
        string objAPI = invocableRequest.objectAPIName;
        string fieldAPI = invocableRequest.fieldAPIName;
        string valueToUpdate = invocableRequest.fieldValue ;
        string comments = invocableRequest.taskClosingReason;
        List<sObject> sObjectRecords = new List<sObject>();
        List<sObject> sObjectRecordsToUpdate = new List<sObject>();
        String queryString='';
        queryString = 'SELECT Id,'+fieldAPI;
        queryString += ' FROM '+objAPI; 
        sObjectRecords = Database.query(queryString);
        if(!sObjectRecords.isEmpty()){
            for(sObject rec : sObjectRecords){
                rec.put(fieldAPI,valueToUpdate);
                sObjectRecordsToUpdate.add(rec);
            }
        }
        if(!sObjectRecordsToUpdate.isEmpty()){
            //Database.update(sObjectRecordsToUpdate,false);
        }
        Database.executeBatch(new BulkUpdateRecords_Batch(objAPI,fieldAPI,valueToUpdate) ,200);
    }
    
}
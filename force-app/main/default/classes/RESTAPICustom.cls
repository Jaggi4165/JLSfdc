@RestResource(urlMapping='/CustomAPI/*')
global with sharing class RESTAPICustom {
    
    @HttpPost
    global static String createRecords(){
        try{
            String jsonRequestString = RestContext.request.requestBody.toString();
            String responseString;
            restRequestWrapper wrapper = restRequestWrapper.parse(jsonRequestString);
            restResponseWrapper response = new restResponseWrapper();
            sObject instance;
            String objectName;
            String message;
            String responseStr;
            Boolean status = false;
            Integration_Object__mdt obj;
            if(!string.isBlank(wrapper.objectApi)){
                objectName = (string)wrapper.objectApi;
                Schema.SObjectType targetType = Schema.getGlobalDescribe().get(objectName);
                instance = targetType.newSObject();
            }
            else{
                message = message == null ? 'objectApi is mandatory in the request body.' : message;
            }
            if(string.isBlank(objectName)){
                message = message == null ? 'Something went wrong.' : message;
            }
            Map<String, Object> reqData;
            if(wrapper.data == null){
                message = message == null ? 'Request body is not matched. Please refer the document.' : message;
            }
            else{
                Map<String, Object> reqJSONbody = (Map<String, Object>) JSON.deserializeUntyped(jsonRequestString);
                reqData = (Map<String, Object>) reqJSONbody.get('data');
            }
            if(!String.isBlank((string)wrapper.operation)){
                //get object from custom metadata
                obj = [SELECT Id,Object_API_Name__c,Is_Active__c,Insert_Access__c,Update_Access__c,Insert_Access_Error__c 
                       FROM Integration_Object__mdt 
                       WHERE Object_API_Name__c =: objectName];
                //get fields from custom metadata
                if(obj == null){
                    message = message == null ? 'Please contact to system admin to configure object setting : '+objectName : message;
                    return message;
                }
                if(!obj.Is_Active__c){
                    message = message == null ? 'Please contact to system admin to activate setting : '+objectName+' to start integrate.' : message;
                    return message;
                }
                Map<string,string> fields = new Map<String,string>();
                if(instance != null && objectName != null){
                    List<Integration_Field__mdt> configfields = [SELECT Id, Integration_Object__c,Field_API__c,JSON_Body_Key__c,Field_Label__c
                                                                 FROM Integration_Field__mdt 
                                                                 WHERE Integration_Object__c=: obj.Id];
                    if(!configfields.isEmpty()){
                        for(Integration_Field__mdt field : configfields){
                            fields.put(field.JSON_Body_Key__c.toLowercase(),field.Field_API__c);
                        }
                    }
                    else{
                        message = message == null ? 'Please configure fields for Object : '+objectName : message;
                        createError(null,message,'createRecords');
                    }
                }
                for(String key : reqData.keySet()){
                    if(fields.containsKey(key.toLowercase())){
                        instance.put(fields.get(key.toLowercase()) , reqData.get(key));
                    }
                } 
                if(wrapper.operation !=null && wrapper.operation.equalsIgnoreCase('insert')){
                    if(!obj.Insert_Access__c){
                        message = message == null ? 'Please contact to system admin to give insert access setting for Object : '+objectName : message;
                        createError(null,message,'createRecords');
                    }
                    else{
                        try{
                            Database.insert(instance);
                            message = message == null ? 'Record Inserted : '+instance.id : message;
                            status = true;
                        }
                        catch(Exception e){
                            message = message == null ? e.getMessage() : message;
                            status = false;
                            createError(e,message,'createRecords');
                        }
                    }
                }
                responseStr = createResponse(message,status);
            }
            return responseStr;
        }
        catch(Exception e){
            createError(e,null,'createRecords');
            return 'Insertion failed. please provide this error message and ask admin to check the error log.';
        }
        
    }
    
    // Upadte
    @HttpPut
    global static Void updateRecords(){
        String jsonRequestString = RestContext.request.requestBody.toString();
        String responseString;
        restRequestWrapper wrapper = restRequestWrapper.parse(jsonRequestString);
        restResponseWrapper response = new restResponseWrapper();
        sObject instance;
        String objectName;
        if(!string.isBlank(wrapper.objectApi)){
            objectName = (string)wrapper.objectApi;
            Schema.SObjectType targetType = Schema.getGlobalDescribe().get(objectName);
            instance = targetType.newSObject();
        }
        else{
            response.message = 'objectApi is mandatory in the request body.';
            response.status = false;
            return;
        }
        if(string.isBlank(objectName)){
            response.message = 'Something went wrong.';
            response.status = false;
            createError(null,response.message,'updateRecords'); 
            return;
        }
        Map<String, Object> reqData;
        if(wrapper.data == null){
            response.message = 'Request body is not matched. Please refer the document.';
            response.status = false;
            createError(null,response.message,'updateRecords'); 
            return;
        }
        else{
            Map<String, Object> reqJSONbody = (Map<String, Object>) JSON.deserializeUntyped(jsonRequestString);
            reqData = (Map<String, Object>) reqJSONbody.get('data');
        }
        if(!string.isBlank(wrapper.operation)){
            //get object from custom metadata
            Integration_Object__mdt obj = [SELECT Id,Object_API_Name__c,Is_Active__c,Insert_Access__c,Update_Access__c 
                                           FROM Integration_Object__mdt 
                                           WHERE Object_API_Name__c =: objectName];
            //get fields from custom metadata
            if(obj == null){
                response.message = 'Please contact to system admin to configure object setting : '+objectName;
                response.status = false;
                createError(null,response.message,'updateRecords'); 
                return;
            }
            if(!obj.Is_Active__c){
                response.message = 'Please contact to system admin to activate setting'+objectName+' to start integrate.';
                response.status = false;
                createError(null,response.message,'updateRecords'); 
                return;
            }
            Map<string,string> fields = new Map<String,string>();
            if(instance != null && objectName != null){
                List<Integration_Field__mdt> configfields = [SELECT Id, Integration_Object__c,Field_API__c,JSON_Body_Key__c,Field_Label__c
                                                             FROM Integration_Field__mdt 
                                                             WHERE Integration_Object__c=: objectName];
                if(!configfields.isEmpty()){
                    for(Integration_Field__mdt field : configfields){
                        fields.put(field.JSON_Body_Key__c , field.Field_API__c);
                    }
                }
                else{
                    response.message = 'Please configure fields for Object : '+objectName;
                    response.status = false;
                    createError(null,response.message,'updateRecords'); 
                    return;
                }
            }
            Map<String, Object> record = new Map<String, Object>();
            for(String key : reqData.keySet()){
                instance.put(fields.get(key) , reqData.get(key));
            } 
            if(wrapper.operation.equalsIgnoreCase('update')){
                if(!obj.Update_Access__c){
                    string message = 'Please contact to system admin to give insert access setting for Object : '+objectName;
                    String s = createResponse(message,false);
                    createError(null,message,'updateRecords'); 
                    return;
                }
                else{
                    try{
                        string message = 'Processing...';
                        String s = createResponse(message,false);
                        update instance;
                    }
                    catch(Exception e){
                        String s = createResponse(e.getMessage(),false);
                        createError(e,null,'updateRecords'); 
                        return;
                    }
                }
            }
            
        }
    } 
    
    public class restRequestWrapper{
        public cls_data data;
        public String operation;
        public String objectApi;
    }
    public class cls_data {
        public String name;	
        public String rating;
        public String objectApi;
        public boolean active;
    }
    public static restRequestWrapper parse(String json){
        return (restRequestWrapper) System.JSON.deserialize(json, restRequestWrapper.class);
    }
    
    public class restResponseWrapper{
        public boolean status;
        public String message;
    }
    
    public static string createResponse(string msg, boolean status){
        if(msg == null){
            msg = 'Something went wrong...';
            createError(null,msg,'createResponse');  
        }
        restResponseWrapper response = new restResponseWrapper();
        response.message = msg;
        response.status = status;
        return JSON.serialize(response);
    }
    
    public static void createError(Exception e,string msg,string method){
        Error_Log__c err = new Error_Log__c();
        err.Error_Type__c = 'RESTAPICustom.'+method ;
        
        if(e != null){
            err.Category__c = 'Integration Exception Error';
            err.Error_Message__c = e.getMessage();
            err.Error_StackTrace__c = e.getStackTraceString();
            err.Error_Line__c = e.getLineNumber();
        }
        else{
            err.Error_Message__c = msg;
            err.Category__c = 'Integration Custom Error';
        }
        err.Integration_Request_Body__c = RestContext.request.requestBody.toString();
        Insert err;
    }
}
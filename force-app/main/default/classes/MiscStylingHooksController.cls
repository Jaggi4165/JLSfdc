public class MiscStylingHooksController {
    @AuraEnabled(cacheable=true)
    public static SchoolConfigurations__c getSchoolSetting(){
        SchoolConfigurations__c setting = SchoolConfigurations__c.getOrgDefaults();
        return setting;
    }

    @AuraEnabled
    public static string updateBooleanSchoolSetting(String field,boolean value){
        SchoolConfigurations__c setting = SchoolConfigurations__c.getOrgDefaults();
        setting.put(field,value);
        try{
            update setting;
            return 'Success';
        }
        catch(Exception e){
            return e.getMessage();
        }
    }
    @AuraEnabled
    public static string updateDateSchoolSetting(String field,String value){
        SchoolConfigurations__c setting = SchoolConfigurations__c.getOrgDefaults();
        setting.put(field,Date.valueOf(value));
        try{
            update setting;
            return 'Success';
        }
        catch(Exception e){
            return e.getMessage();
        }
    }
}
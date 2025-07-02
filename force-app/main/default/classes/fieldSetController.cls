public class fieldSetController { 
    //fieldSetController.getFieldSetForAccount('Account','FSL__Emergency_Account_Fields');
    // objectAPIName : Object Name
    // fieldSetName  : Api name of the fieldset name
    public static void getFieldSetForAccount(string objectAPIName , string fieldSetName){
        // Define the object and field set API names
        //String objectAPIName = 'Account';
        //String fieldSetName = 'FSL__Emergency_Account_Fields';
        // Get the field set information
        Schema.SObjectType objectType = Schema.getGlobalDescribe().get(objectAPIName);
        Schema.DescribeSObjectResult objectDescribe = objectType.getDescribe();
        Schema.FieldSet fieldSet = objectDescribe.fieldSets.getMap().get(fieldSetName);
        
        // Retrieve the field set fields
        List<Schema.FieldSetMember> fieldSetMembers = fieldSet.getFields();
        
        // Create a dynamic query to fetch the fields specified in the field set
        String query = 'SELECT ';
        for (Schema.FieldSetMember fieldSetMember : fieldSetMembers){
            query += fieldSetMember.getFieldPath() + ', ';
        }
        query = query.removeEnd(', ') + ' FROM ' + objectAPIName + ' LIMIT 5';
        
        // Execute the query
        List<SObject> records = Database.query(query);
        
        // Iterate over the records and access the field values dynamically
        for (SObject record : records) {
            for (Schema.FieldSetMember fieldSetMember : fieldSetMembers) {
                String fieldAPIName = fieldSetMember.getFieldPath();
                Object fieldValue = record.get(fieldAPIName);
                System.debug('Field: ' + fieldAPIName + ', Value: ' + fieldValue);
            }
        }   
    }
}
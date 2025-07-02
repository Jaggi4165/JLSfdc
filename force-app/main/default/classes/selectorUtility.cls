public with sharing class selectorUtility {
    public selectorUtility() {

    }

    public static List<sObject> soqlQuery(String query){
        List<sObject> results = new List<sObject>();
        try{
            results = Database.query(query);
        }catch(Exception ex){
            ExceptionHandeler.logError(ex,'selectorUtility.soqlQuery()'); 
        }
        return results;
    }
}
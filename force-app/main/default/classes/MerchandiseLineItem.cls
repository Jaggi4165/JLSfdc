public class MerchandiseLineItem {
    public void displayMerLine(){
        //----------------------------------------------My Code----------------------
        
       map<Merchandise__c,List<Line_Item__c>> mymap= new map<Merchandise__c,List<Line_Item__c>>();
        for(Merchandise__c values : [select id,Name,Price__c from Merchandise__c])
             {
             list<Line_Item__c> values2= [select id,Name  from Line_Item__c where Merchandise__c=:values.id ];
             mymap.put(values,values2);
             }
        System.debug(mymap);
    }
}
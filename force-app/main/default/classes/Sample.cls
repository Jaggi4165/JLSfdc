/*
child :LineItem
parent:Merchendise
*/
public class Sample {
    public static void method(){
   List<Merchandise__c> merList = new List<Merchandise__c>();
    List<Id> idlist = new List<Id>(); 
    for(Merchandise__c k : [select Id from Merchandise__c])
    {
        idlist.add(k.Id);
        merList.add(k);
    }
       System.debug('merchList-->'+merList); 
    List<Line_Item__c> licList = new List<Line_Item__c>();
    for(Line_Item__c j : [SELECT Unit_Price__c from Line_Item__c where Merchandise__c IN : merList])
    {
            System.debug('mer quantity -->'+j);
        
    }
    
    } 
}
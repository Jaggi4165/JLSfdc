public class Assignment4 {
    Boolean bool=false;
    public void method1(String name){
        if(name.equals('')){
            System.debug('null');  
        }
        else if(name.contains('Test')){
            //bool=true;
            System.debug(name.contains('Test'));
        }
         else if(name=='Salesforce'){
             //bool=true;
            System.debug(name.equals('Salesforce'));
        }
        else{
            System.debug(bool);
        }
}
}
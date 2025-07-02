public class Assignment6 {
    public void uppercaseString(String stringName){
        System.debug(stringName.toUpperCase());
        if(stringName.contains('value')){
            System.debug('Invalid String');
        }
        else{
            System.debug('Valid String');
        }
        System.debug(stringName+' Welcome to ABSYZ');
        
    }
}
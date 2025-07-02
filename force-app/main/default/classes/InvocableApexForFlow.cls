public class InvocableApexForFlow {

    @InvocableMethod(label = 'Pass Records Collection and get Keys')
    public static list<ReturnVariables> returnValues(List<InputVariables> inputVariables){
        List<sObject> inputVariable = inputVariables[0].listOfValues;
        ReturnVariables r = new ReturnVariables();
        r.returnlistOfkeys=new List<String>(new Map<string,sObject>(inputVariable).keySet());
        return new list<ReturnVariables>{r};
    } 
    public class InputVariables{
        @InvocableVariable (label = 'sObject Collections')
        public list<sObject> listOfValues;
    }
    public class ReturnVariables{
        @InvocableVariable (label = 'Key Collections')
        public list<string> returnlistOfkeys;
    }
    
    
}
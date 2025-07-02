public class InvocableApexForFlow2 {
    @InvocableMethod(label = 'Pass Record key and Collection and get Record')
    public static list<ReturnRecord> returnValues(List<InputVariables> inputVariables){
        List<sObject> inputVariable = inputVariables[0].listOfRecords;
        string keyword = inputVariables[0].keys;
        ReturnRecord r = new ReturnRecord();
        Map<string,sObject> sobjectMap = new Map<string,sObject>(inputVariable);
        r.record = sobjectMap.get(keyword);
        return new list<ReturnRecord>{r};
    }     
    public class InputVariables{
        @InvocableVariable (label = 'Collection')
        public list<sObject> listOfRecords;
        @InvocableVariable (label = 'Key')
        public string keys;
    }                     
    public class ReturnRecord{
        @InvocableVariable (label = 'records Collection')
        public Sobject record;
    }
}
public class BuildingBlocksIncentiveController {
    public static void incentiveRecordCreate(List<opportunity> opp,List<opportunity> oldOpp) {
        try{
            List<opportunity> oppList =  new List<opportunity>();
            Map<Id,opportunity> oldOppRecs = new Map<Id,opportunity>();
            for(opportunity op : oldOpp){
                oldOppRecs.put(op.Id,op);
            }
            for(opportunity o : opp){
                if(o.Id==oldOppRecs.get(o.Id).Id && o.Applicable__c=='Yes' && oldOppRecs.get(o.Id).Applicable__c!=o.Applicable__c){
                    oppList.add(o);
                }
            }
            List<Incentive__c> incRec = new List<Incentive__c>();
            for(opportunity opRec : oppList){
                Incentive__c incentiveRec = new Incentive__c();
                incentiveRec.Name = 'Incentive - '+opRec.Name;
                incentiveRec.Opportunity__c = opRec.Id;
                incentiveRec.Project__c = opRec.Project__c;
                incRec.add(incentiveRec);
            }
            if(incRec.size()>0){
                insert incRec;
            }  
        }
        catch(Exception e){
            system.debug(e);
        }    
    }
    public static void payoutRecordsCreate(List<Incentive__c> inc,List<Incentive__c> oldInc) {
        Map<Id,List<BuildingBlock_Incentives__mdt>> mdtMap = new Map<Id,List<BuildingBlock_Incentives__mdt>>();
        Map<Id,Incentive__c> oldIncMap = new Map<Id,Incentive__c>();
        List<Incentive__c> incList  = new List<Incentive__c>();
        for(Incentive__c oi : oldInc){
            oldIncMap.put(oi.id,oi);
        }
        for(Incentive__c i :inc){
            if(i.Id==oldIncMap.get(i.Id).Id && i.Create_Payouts__c == true && oldIncMap.get(i.Id).Create_Payouts__c==false && oldIncMap.get(i.Id).Create_Payouts__c!=i.Create_Payouts__c){
                incList.add(i);
            }
        }
        List<BuildingBlock_Incentives__mdt> cmdt = [select Incentive_Percentage__c,Project_Segment__c,User_Type__c,Type_Of_Sale__c,Opportunity_Source__c,
                                                    Employee_Name__c,Employee_Role__c from BuildingBlock_Incentives__mdt 
                                                    where Project_Segment__c!=:null AND  User_Type__c!=:null AND Type_Of_Sale__c!=:null AND Opportunity_Source__c!=:null with security_enforced]; 
        
        Map<string,List<BuildingBlock_Incentives__mdt>> mapOfMtd = new Map<string,List<BuildingBlock_Incentives__mdt>>();
        for(BuildingBlock_Incentives__mdt metadataRec : cmdt){
            string keyString = metadataRec.Project_Segment__c+metadataRec.User_Type__c+metadataRec.Type_Of_Sale__c+metadataRec.Opportunity_Source__c;
            List<BuildingBlock_Incentives__mdt> listCmdt = new List<BuildingBlock_Incentives__mdt>();
            listCmdt.add(metadataRec);
            if(!mapOfMtd.containskey(keyString)){
                mapOfMtd.put(keyString,listCmdt);
            }
            else{
                mapOfMtd.get(keyString).add(metadataRec);
            }
        }       
        if(incList!=null){
            for(Incentive__c i : incList){
                List<BuildingBlock_Incentives__mdt> cmdtList = new List<BuildingBlock_Incentives__mdt>();
                string incKeyString = i.Project_Type__c+i.User_Type__c+i.Type_Of_Sale__c+i.Lead_Source_Category__c;
                for(BuildingBlock_Incentives__mdt metadataRec : mapOfMtd.get(incKeyString)){
                    cmdtList.add(metadataRec);
                }
                if(cmdtList.size()>0){
                    mdtMap.put(i.id,cmdtList);
                }
            }
            List<Payout__c> payoutList  = new List<Payout__c>();
            for(Incentive__c i : incList){
                Decimal totIncAmount = i.Overall_Incentive_Amount__c;
                for(BuildingBlock_Incentives__mdt m : mdtMap.get(i.id)){
                    if(m.Employee_Name__c != null){
                        Payout__c p = new Payout__c();
                        p.Employee_Name__c = m.Employee_Name__c;
                        p.Incentive__c = i.Id;
                        p.Incentive_Percent__c = m.Incentive_Percentage__c;
                        p.Incentive_Amount__c = totIncAmount * (m.Incentive_Percentage__c/100);
                        payoutList.add(p);
                    }  
                }
            }
            if(payoutList.size()>0){
                insert payoutList;
            }
        }        
    }

    @AuraEnabled(cacheable=true)
    public static List<ProductWrapper> oppReportData() {
        List<Opportunity> oppList = [select id,OwnerId,Owner.Name from Opportunity with security_enforced];
        Map<Id,String> userNameMap = new  Map<Id,String>();
        for(Opportunity opp : oppList){
            userNameMap.put(opp.OwnerId ,opp.Owner.Name);
        }
        Map<Id,Integer> stageNameMap = new  Map<Id,Integer>();
        List<AggregateResult> oppStageByOwner = [SELECT OwnerId, COUNT(Id) oppCount,count(StageName) stages FROM Opportunity WHERE StageName='Closed Won' with security_enforced GROUP BY OwnerId];
        for (AggregateResult ar : oppStageByOwner){
            stageNameMap.put((Id) ar.get('OwnerId'),(Integer) ar.get('stages'));
        }
        system.debug('stageNameMap==>'+stageNameMap);
       	List<AggregateResult> oppCountByOwner = [SELECT OwnerId, COUNT(Id) oppCount FROM Opportunity with security_enforced GROUP BY OwnerId];
        List<ProductWrapper> wrapperList = new List<ProductWrapper>();
        for (AggregateResult ar : oppCountByOwner) {
            String ownerName='';
            if(userNameMap.containskey((Id) ar.get('OwnerId'))){
            	ownerName = userNameMap.get((Id) ar.get('OwnerId'));
            }
    		
    		Integer oppCount = (Integer) ar.get('oppCount');
            Integer oppSuccessRes;
            if(stageNameMap.containskey((Id) ar.get('OwnerId'))){
                oppSuccessRes = stageNameMap.get((Id) ar.get('OwnerId'));
            }
            
            ProductWrapper pw = new ProductWrapper();
            pw.oppOwner = ownerName;
            pw.handling = Decimal.valueOf(oppCount);
            pw.successRate = Decimal.valueOf((oppSuccessRes/oppCount));
            wrapperList.add(pw);
		}   
        return wrapperList;
    }
    public class ProductWrapper
    {
        @auraenabled
        public String oppOwner{get;set;}
        @auraenabled
        public Decimal handling{get;set;}
        @auraenabled
        public Decimal successRate{get;set;}
    }
}
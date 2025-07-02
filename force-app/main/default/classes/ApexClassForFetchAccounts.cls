public class ApexClassForFetchAccounts {
    
     public Opportunity opp {get;set;}
    public List<Opportunity> opportunities {get;set;}
    
    public ApexClassForFetchAccounts() {
        opp = new Opportunity();
		opportunities = new List<Opportunity>();
    }
    
    public void showOpp() {
        if(opp.StageName == 'Prospecting'){
            opportunities = [SELECT Id, Name, StageName FROM Opportunity WHERE StageName='Prospecting'];
        }
        if(opp.StageName == 'Qualification'){
            opportunities = [SELECT Id, Name, StageName FROM Opportunity WHERE StageName='Qualification'];
        }
        if(opp.StageName == 'Needs Analysis'){
            opportunities = [SELECT Id, Name, StageName FROM Opportunity WHERE StageName='Needs Analysis'];
        }
        if(opp.StageName == 'Proposal/Price Quote'){
            opportunities = [SELECT Id, Name, StageName FROM Opportunity WHERE StageName='Proposal/Price Quote'];
        }
        if(opp.StageName == 'Closed Won'){
            opportunities = [SELECT Id, Name, StageName FROM Opportunity WHERE StageName='Closed Won'];
        }
        if(opp.StageName == 'Closed Lost'){
            opportunities = [SELECT Id, Name, StageName FROM Opportunity WHERE StageName='Closed Lost'];
        }
        if(opp.StageName == 'Negotiation/Review'){
            opportunities = [SELECT Id, Name, StageName FROM Opportunity WHERE StageName='Negotiation/Review'];
        }
        if(opp.StageName == 'Value Proposition'){
            opportunities = [SELECT Id, Name, StageName FROM Opportunity WHERE StageName='Value Proposition'];
        }
        if(opp.StageName == 'Id. Decision Makers'){
            opportunities = [SELECT Id, Name, StageName FROM Opportunity WHERE StageName='Id. Decision Makers'];
        }
        if(opp.StageName == 'Perception Analysis'){
            opportunities = [SELECT Id, Name, StageName FROM Opportunity WHERE StageName='Perception Analysis'];
        }
        
        // Add more Stages
    }

}
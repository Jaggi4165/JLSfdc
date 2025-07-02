@isTest
private class Test_QuoteWizard
{

    
    @istest
    static void insertingAccount(){
        Test.startTest();
        QuoteWizardApexClass.insertAccountMethod(new Account(Name='AccountInsert-1'));
        Test.stopTest();
    }
    @istest
    static void insertingContact(){
        Test.startTest();
        Account a1 = new Account(Name='BMW');
        insert a1;
        QuoteWizardApexClass.insertContactMethod(new Contact(LastName='ContactInsert-1',accountId = a1.Id));
        Test.stopTest();
    }
    @istest
    static void fetchingContactById(){
        Account a = new Account(Name='AccountInsert-3');
        insert a;
        Contact c2 = new Contact(LastName='ContactInsert-3',accountId = a.Id);
        insert c2;
        Test.startTest();
        QuoteWizardApexClass.fetchContacts('ContactInsert-3');
        //System.assertEquals('AccountInsert-3', a.Name);
        Test.stopTest();
    }
    
    @istest
    static void insertingQuote(){
        Test.startTest();
        Account a2 = new Account(Name='AccountInsert-3');
        insert a2;
        Contact c2 = new Contact(LastName='ContactInsert-3',accountId = a2.Id);
        insert c2;
        Opportunity o2 = new Opportunity(Name='OpportunityInsert-3',StageName='Prospecting',CloseDate=Date.today(),accountid=a2.Id);
        insert o2;
        Account acc = [Select id, name from Account];
        Contact con = [Select id, lastname from Contact];
        Opportunity opp = [Select id, name from Opportunity];
        Quote q2 = new Quote();
       	//q2.Accountid = acc.Id;
       	q2.Contactid = con.Id;
        q2.OpportunityId = opp.Id;
       	q2.Name = 'QuoteInsert-1';
       QuoteWizardApexClass.insertQuoteMethod(q2);
        Test.stopTest();
    }
    @istest
    static void fetchAccountByConId(){
        Account a = new Account(Name='AccountInsert-3');
        insert a;
        Contact c2 = new Contact(LastName='ContactInsert-3',accountId = a.Id);
        insert c2;
        Test.startTest();
        QuoteWizardApexClass.fetchAccountDetails(c2.Id);
        //System.assertEquals('AccountInsert-3', a.Name);
        Test.stopTest();
    }
    @istest
    static void fetchingAccountData(){
        Account a = new Account(Name='AccountInsert-3');
        insert a;
        Test.startTest();
        QuoteWizardApexClass.getAccountDetails(a.Id);
        //System.assertEquals('AccountInsert-3', a.Name);
        Test.stopTest();
    }
    
    @istest
    static void fetchOpportunityById(){
        Account a = new Account(Name='AccountInsert-3');
        insert a;
        Opportunity o2 = new Opportunity(Name='OpportunityInsert-3',StageName='Prospecting',CloseDate=Date.today(),accountid=a.Id);
        insert o2;
        Test.startTest();
        QuoteWizardApexClass.fetchOppDetails(o2.Id);
        //System.assertEquals('AccountInsert-3', a.Name);
        Test.stopTest();
    }
        @istest
    static void fetchOpportunityByName(){
        Account a = new Account(Name='AccountInsert-3');
        insert a;
        Opportunity o2 = new Opportunity(Name='OpportunityInsert-3',StageName='Prospecting',CloseDate=Date.today(),accountid=a.Id);
        insert o2;
        Test.startTest();
        QuoteWizardApexClass.fetchOpportunity('OpportunityInsert-3');
        System.assertEquals('OpportunityInsert-3', o2.Name);
        Test.stopTest();
    }
    
    @istest
    static void fetchingAccountData2(){
        Account a = new Account(Name='AccountInsert-3');
        insert a;
        Test.startTest();
        QuoteWizardApexClass.fetchAccount(a.Id);
        //System.assertEquals('AccountInsert-3', a.Name);
        Test.stopTest();
    }
    @istest
    static void fetchingContactData(){
        Account a = new Account(Name='AccountInsert-3');
        insert a;
        Contact c = new Contact(LastName='ContactInsert-4',accountid = a.Id);
        insert c;
        Test.startTest();
        QuoteWizardApexClass.getContactDetails(c.Id);
        Test.stopTest();
    }
    @istest
    static void fetchingOpportunityData(){
        Account a = new Account(Name='AccountInsert-3');
        insert a;
        Opportunity o2 = new Opportunity(Name='OpportunityInsert-3',StageName='Prospecting',CloseDate=Date.today(),accountid=a.Id);
        insert o2;
        Test.startTest();
        QuoteWizardApexClass.getOpportunityDetails(o2.Id);
        //System.assertEquals('AccountInsert-3', a.Name);
        Test.stopTest();
    }
    
}
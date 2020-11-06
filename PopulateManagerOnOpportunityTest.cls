@isTest
public class PopulateManagerOnOpportunityTest {
    /*
     * setup data for test
     */ 
    @testSetup
    static void setUpTestdata()
    {
        List<Opportunity> opportunities = new List<Opportunity>();
        for(integer i=0 ; i < 100 ; i++){
            opportunities.add(new Opportunity(name='test'+i,stageName = 'Prospecting',closeDate = Date.newInstance(2016, 12, 9))); 
        }
        INSERT opportunities;
        List<Account> accounts = new list<Account>();
        for(integer i=0 ; i < 10 ; i++){
            accounts.add(new Account(name = 'testAccount'+i));
        }
        INSERT accounts;
        Integer index=0;
        List<Contact> contacts = new List<Contact>();
        for(integer i=0 ; i < 10; i++)
        {
            contacts.add(new Contact(lastname = 'testContact'+i,AccountId = accounts[index].Id ));
            index++;
        }
        INSERT contacts;
    }
    
    /*
     * Test if manager field populates on update of opportunity
     */ 
    @isTest
    static void TestManagerField()
    {
        List<Opportunity> opportunities = [SELECT ID , 	BillToContact__c , Manager__c FROM Opportunity];
        List<Contact> contacts = [SELECT ID , accountId FROM Contact];
        List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
        Integer index=0;
        Test.startTest();
        for(Opportunity opp : opportunities)
        {
            opp.BillToContact__c  = contacts[index].Id;
           	opportunitiesToUpdate.add(opp);
            index++;
        }
        index=0;
        update opportunities;
        List<opportunity> updatedOpportunities = [SELECT ID , 	BillToContact__c  , Manager__c FROM Opportunity];
        Test.stopTest();
        for(Opportunity opp : updatedOpportunities)
        {
            System.assertEquals(contacts[index].accountId, opp.Manager__c);
            index++;
        }
        
    }
}
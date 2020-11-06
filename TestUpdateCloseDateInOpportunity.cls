@isTest
public class TestUpdateCloseDateInOpportunity {
 	@isTest
    static void UpdateBulkOpportunity()
    {
        List<Opportunity> opps = TestUpdateCloseDateInOpportunityUtility.createOpportunity(100);
        opps = TestUpdateCloseDateInOpportunityUtility.UpdateOpportunity(opps);
        UPDATE opps;
        List<Opportunity> updatedOpps = [SELECT CloseDate FROM Opportunity WHERE Id IN : opps];
        for(Opportunity op : updatedOpps)
        {
        	System.assertEquals(date.today(),op.closeDate);
        }
        
    }
}
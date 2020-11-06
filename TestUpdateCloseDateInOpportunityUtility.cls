@isTest
public class TestUpdateCloseDateInOpportunityUtility {
    
    /*
     * Create opportunity objects
     */ 
    public static List<Opportunity> createOpportunity(Integer noOfOpportunity)
    {        
        List<Opportunity> opps = new List<Opportunity>();
        for(Integer i = 0; i < noOfOpportunity ; i++)
        {
            opps.add(new Opportunity(name='Opportunity'+i,stageName = 'Prospecting',closeDate = Date.newInstance(2020, 01,02)));
        }
        insert opps;
        return opps;
    }
    /*
     * update opportunity objects
     */ 
    public static list<Opportunity> UpdateOpportunity(List<Opportunity> opps)
    {        
        List<Opportunity> oppsToUpdate = new List<Opportunity>();
        for(Opportunity op : Opps)
        {
            op.stageName = 'Closed Won';
            oppsToUpdate.add(op);
        }
        return oppsToUpdate;
    }    
}
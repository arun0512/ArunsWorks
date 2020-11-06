public class CustomLookUpController {
    
   public String selectedContact {get; set;}
    public Id currentOpportunityId{get;set;}
    public Opportunity currentOpportunity{get;set;}
    
    public CustomLookUpController()
    {
        currentOpportunityId = ApexPages.currentpage().getparameters().get('id');
        currentOpportunity = [SELECT Id , Name , BillToContact__c , Manager__c FROM Opportunity WHERE Id = :currentOpportunityId ];
    }
    
    public List<SelectOption> getContactOptions() 
    {
        List<SelectOption> options = new List<SelectOption>();
        for(Contact con : [SELECT Name FROM Contact WHERE AccountId = :currentOpportunity.Manager__c ])
        {
            options.add(new SelectOption(con.Id,con.Name));
        }
        return options;
    }
    
    public PageReference saveContact() 
    {
        currentOpportunity.BillToContact__c = selectedContact ;
        UPDATE currentOpportunity;
        return new PageReference('/'+currentOpportunityId);
    }
    public PageReference clearContact()
    {
        currentOpportunity.BillToContact__c = null ;
        UPDATE currentOpportunity;
        return new PageReference('/'+currentOpportunityId);
    }
    public PageReference cancel()
    {
        return new PageReference('/'+currentOpportunityId);
    }
}
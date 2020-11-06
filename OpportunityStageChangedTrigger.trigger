trigger OpportunityStageChangedTrigger on Opportunity (before update) {
    

         for(opportunity op : Trigger.New ){
            if((Trigger.oldMap.get(op.Id).StageName != op.StageName) && (op.StageName == 'Closed Won' || op.StageName == 'Closed Lost')){
                op.CloseDate = date.today();

            }
        }

    
 

}
trigger classdeleteFemalestudentsTrigger on Class__c (before delete) {       
    AggregateResult[] groupedResults= [select Class__c,COUNT(id),sex__c 
                                       from Student__c 
                                       WHERE sex__c ='F' AND Class__c in: Trigger.oldMap.keySet()
                                       GROUP BY sex__c,Class__c
                                       HAVING COUNT(id) > 1];
 
    for(AggregateResult ar : groupedResults)
    {
        Id clsId =(Id) (ar.get('Class__c'));  
        Trigger.oldMap.get(clsId).addError(String.format(System.Label.Dissalow_Female_Stdnt_msg, new List<String>{Trigger.oldMap.get(clsId).name}));
        
        
    }
}

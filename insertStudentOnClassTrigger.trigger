trigger insertStudentOnClassTrigger on Student__c (after insert,after update ) {
    Set<Id> classIds = new Set<Id>();

    for (Student__c student : trigger.New){
        classIds.add(student.Class__c);
    }
    AggregateResult[] groupedResults=[Select MAX(Class__r.maxSize__c) maxSize,COUNT(id) cnt,Class__c
                                      from Student__c 
                                      WHERE Class__C IN : classIds
                                      GROUP BY Class__c];
    classIds = new Set<Id>();
    for(AggregateResult ar : groupedResults){
        Integer maxSize =Integer.valueOf(ar.get('maxSize'));
        Integer cnt =Integer.valueOf(ar.get('cnt'));
        Id clsId =(Id) (ar.get('Class__c'));   
        
        if(cnt >= maxSize){
            classIds.add(clsId);
        }
        
    }
    for(Student__c stdnt :  Trigger.new){         
        if(classIds.contains(stdnt.Class__c)){
            Trigger.newMap.get(stdnt.id).addError(System.Label.class_max_size_msg); 
        }
        
    }
    
}

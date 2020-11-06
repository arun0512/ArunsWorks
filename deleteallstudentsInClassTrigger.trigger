trigger deleteallstudentsInClassTrigger on Class__c (after update) {    
      
    List<Class__c> clsToReset = new List<Class__c>();
    
    for(Class__c newcls : Trigger.new)
    {
        Class__c oldCls = Trigger.oldMap.get(newcls.id);  
        if(newcls.custom_Status__c == 'Reset' && oldCls.custom_Status__c != 'Reset')
        {
            clsToReset.add(newcls) ;
        }
    }
    
    if (!clsToReset.isEmpty())
    {
        List<Student__c> students =[SELECT id FROM student__c where class__c in: clsToReset];
        if(!students.isEmpty())
        {
            delete students;
         }
    }
}

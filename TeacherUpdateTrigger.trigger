trigger TeacherUpdateTrigger on Contact (before insert,before update) {
    
     for(Contact teacher :  Trigger.new) { 
        if(teacher.subjects__c.contains('Hindi')){
             Trigger.newMap.get(teacher.Id).addError( String.format(System.Label.Trigger_error_teacher_update, new List<String>{teacher.name}));            
 
        }
          }
   
}

public class TestUpdateMyCountFieldUtility {
    
  
     public static list<Student__c> CreateStudents(Integer noOfStudents){
        
        Class__c cls = new Class__c(name = 'testClass',maxSize__c=50);
        insert cls;
        list<Student__c> students = new list<student__c>();
        for(Integer j = 0;j<noOfStudents;j++){
            students.add(new Student__c(name='student'+j,last_Name__c = 'sur'+j,class__c = cls.Id));
        }
        return Students;
    }
}
@isTest
public class TestStudentLimit {
    
    /*
     * Insert single Student within limit
     */
    @isTest
    static void studentInLimit(){
        list<Student__c> students = TestStudentLimitUtility.CreateStudents(1,10);
        test.startTest();
        database.SaveResult result = database.Insert(students[0],false);
        test.stopTest();
        System.assert(result.isSuccess());
        
    }
    
    /*
     * Insert Students out of limit
     */
    @isTest
    static void studentOutOfLimit(){
        list<Student__c> students = TestStudentLimitUtility.CreateStudents(1,0);
        test.startTest();
        database.SaveResult result = database.Insert(students[0],false);
        test.stopTest();
        System.assert(!result.isSuccess());
        System.assertEquals('class size already full', result.getErrors()[0].getMessage());            
    }
    /*
     * Insert BulkStudents within limit
     */
    @isTest
    static void bulkStudentsInLimit(){
        list<Student__c> students = TestStudentLimitUtility.CreateStudents(20,20);
        test.startTest();
        database.SaveResult[] results = database.Insert(students,false);
        test.stopTest();
        for(Database.SaveResult result : results){
            System.assert(result.isSuccess());
        }
    }
    /*
     * Insert BulkStudents out of limit
     */
    @isTest
    static void bulkStudentsOutOfLimit(){
        list<Student__c> students = TestStudentLimitUtility.CreateStudents(20,0);
        test.startTest();
        database.SaveResult[] results = database.Insert(students,false);
        test.stopTest();
        for(Database.SaveResult result : results){
            System.assert(!result.isSuccess());
            System.assertEquals('class size already full', result.getErrors()[0].getMessage()); 
        }
    }
    
    
}
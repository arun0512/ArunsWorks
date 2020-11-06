@isTest
public class TestRestrictStudentInsertion {

    
    @isTest
    static void studentInLimit()
    {
        List<Student__c> students = CreateStudentsUtility.createStudents(1,10);
        Test.startTest();
        Database.SaveResult result = Database.INSERT(students[0],false);
        Test.stopTest();
        System.assert(result.isSuccess());    
    }
    
    /*
     * Insert Students out of limit
     */
    @isTest
    static void studentOutOfLimit()
    {
        List<Student__c> students = CreateStudentsUtility.createStudents(1,0);
        Test.startTest();
        Database.SaveResult result = Database.INSERT(students[0],false);
        System.debug('result: '+result);
        Test.stopTest();
        System.assert(!result.isSuccess());
      //  System.assertEquals('class size already full', result.getErrors()[0].getMessage());            
    }
    /*
     * Insert BulkStudents within limit
     */
    @isTest
    static void bulkStudentsInLimit()
    {
        List<Student__c> students = CreateStudentsUtility.createStudents(20,20);
        Test.startTest();
        Database.SaveResult[] results = Database.INSERT(students,false);
        Test.stopTest();
        for(Database.SaveResult result : results)
        {
            System.assert(result.isSuccess());
        }
    }
    /*
     * Insert BulkStudents out of limit
     */
    @isTest
    static void bulkStudentsOutOfLimit()
    {
        List<Student__c> students = CreateStudentsUtility.createStudents(20,0);
        Test.startTest();
        Database.SaveResult[] results = Database.INSERT(students,false);
        Test.stopTest();
        for(Database.SaveResult result : results)
        {
            System.assert(!result.isSuccess());
          //  System.assertEquals('class size already full', result.getErrors()[0].getMessage()); 
        }
    }   
}
@isTest
public class TestUpdateMyCountField {
    
    /*
     * Test to Insert single student 
     */ 
    @isTest
    static void InsertStudent(){
        list<Student__c> students = TestUpdateMyCountFieldUtility.CreateStudents(1);
        test.startTest();
        database.SaveResult result = database.Insert(students[0],false);
        test.stopTest();
        Decimal count = [SELECT MyCount__c FROM Class__c WHERE ID IN (SELECT Class__c FROM Student__c WHERE Id = :students)][0].MyCount__c;
        System.assert(result.isSuccess());
        System.assertEquals(1, count);
        
    }
    /*
     * Test to Insert Bulk students 
     */ 
    @isTest
    static void InsertBulkStudents(){
        list<Student__c> students = TestUpdateMyCountFieldUtility.CreateStudents(100);
        test.startTest();
        database.SaveResult[] result = database.Insert(students,false);
        test.stopTest();
        Decimal count = [SELECT MyCount__c FROM Class__c WHERE ID IN (SELECT Class__c FROM Student__c WHERE Id IN :students)][0].MyCount__c;
        System.assertEquals(100, count);
    }
}
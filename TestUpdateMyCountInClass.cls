@isTest
private class TestUpdateMyCountInClass {
    
    @isTest static void testCountInLimit()
    {
        List<Student__c> students = CreateStudentsUtility.createStudents(1,1);
        Test.startTest();
        Database.SaveResult result = Database.insert(students[0],false);
        Test.stopTest();
        System.assert(result.isSuccess());
    }
     @isTest static void testCountOutLimit()
    {
        List<Student__c> students = CreateStudentsUtility.createStudents(1,0);
        Test.startTest();
        Database.SaveResult result = Database.INSERT(students[0],false);
        Test.stopTest();
        System.assert(!result.isSuccess());
    }
     @isTest static void testCountInBulk()
    {
        List<Student__c> students = CreateStudentsUtility.createStudents(10,10);
        Test.startTest();
        Database.SaveResult[] results = Database.INSERT(students,false);
        Test.stopTest();
        for(Database.SaveResult result : results)
        {
            System.assert(result.isSuccess());
        }
    }
     @isTest static void testCountOutBulk()
    {
        List<Student__c> students = CreateStudentsUtility.createStudents(10,5);
        Test.startTest();
        Database.SaveResult[] results = Database.INSERT(students,false);
        Test.stopTest();
        for(Database.SaveResult result : results)
        {
            System.assert(!result.isSuccess());
            System.assertEquals('Class is already occupied', result.getErrors()[0].getMessage()); 
        }
    }
}
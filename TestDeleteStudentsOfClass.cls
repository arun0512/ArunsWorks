@isTest
public class TestDeleteStudentsOfClass {
 @isTest
    static void testForStateReset()
    {
        Class__c newClass1 = DeleteStudentsOfClassUtility.createClass(20);
        Class__c newClass2 = DeleteStudentsOfClassUtility.createClass(10);
        Integer studentCount1= [SELECT count() FROM Student__c WHERE Class__r.Id =: newClass1.Id];
        Integer studentCount2= [SELECT count() FROM Student__c WHERE Class__r.Id =: newClass2.Id];
        System.assertEquals(studentCount1,20);
        System.assertEquals(studentCount2,10);
        Test.startTest();
        newClass1.Custom_Status__c = 'Reset';
        newClass2.Custom_Status__c = 'Reset';
        update newClass1;
        update newClass2;
        Test.stopTest();
        studentCount1= [SELECT count() FROM Student__c WHERE Class__r.Id = :newClass1.Id];
        studentCount2= [SELECT count() FROM Student__c WHERE Class__r.Id = :newClass2.Id];
        System.assertEquals(studentCount1,0);   
        System.assertEquals(studentCount2,0); 
    }
    /*
     * Test Class object when status changes to 'Open'
     */
    @isTest
    static void testForStateOpen()
    {
        Class__c newClass1 = DeleteStudentsOfClassUtility.createClass(20);
        Class__c newClass2 = DeleteStudentsOfClassUtility.createClass(10);
        Integer studentCount1= [SELECT count() FROM Student__c WHERE Class__r.Id =: newClass1.Id];
        Integer studentCount2= [SELECT count() FROM Student__c WHERE Class__r.Id =: newClass2.Id];
        System.assertEquals(studentCount1,20);
        System.assertEquals(studentCount2,10);
        Test.startTest();
        newClass1.custom_Status__c = 'Open';
        newClass2.custom_Status__c = 'Open';
        UPDATE newClass1;
        UPDATE newClass2;
        Test.stopTest();
        studentCount1= [SELECT count() FROM Student__c WHERE Class__r.Id =: newClass1.Id];
        studentCount2= [SELECT count() FROM Student__c WHERE Class__r.Id =: newClass2.Id];
        System.assertEquals(studentCount1,20);   
        System.assertEquals(studentCount2,10);  
    }
}
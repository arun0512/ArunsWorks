@isTest
public class TestResetClass {
    /*
     * Test Class object when status changes to 'Reset'
     */ 
    @isTest
    static void CheckWhenStatusIsReset(){
        Class__c newClass = TestResetClassUtility.createClass(20);
        Integer count= [SELECT count() FROM Student__c Where Class__r.Id = :newClass.Id];
        System.assertEquals(count,20);
        test.startTest();
        newClass.custom_Status__c = 'Reset';
        Update newClass;
        test.stopTest();
        count= [SELECT count() FROM Student__c Where Class__r.Id = :newClass.Id];
        System.assertEquals(count,0);
        
    }
    /*
     * Test Class object when status changes to 'Open'
     */
    @isTest
    static void CheckWhenStatusIsOpen(){
        Class__c newClass = TestResetClassUtility.createClass(20);
        Integer count= [SELECT count() FROM Student__c Where Class__r.Id = :newClass.Id];
        System.assertEquals(count,20);
        test.startTest();
        newClass.custom_Status__c = 'Open';
        Update newClass;
        test.stopTest();
        count= [SELECT count() FROM Student__c Where Class__r.Id = :newClass.Id];
        System.assertEquals(count,20);
        
    }
}
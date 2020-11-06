/*
 * Test class for ClassHavingFemale trigger
 */
@isTest
public class TestClassHavingFemale {
    /*
     * Test to delete class with one girl
     */
    @isTest
    static void classWithOneGirl(){
        list<Class__c> classes = TestClassFemaleCheckUtility.CreateClass(1,1);
        test.startTest();
        database.DeleteResult result = database.delete(classes[0],false);
        test.stopTest();
        System.assert(!result.isSuccess());    
    }

    /*
     * Test to delete class with more than one girl
     */
    @isTest
    static void classWithGirls(){
        list<Class__c> classes = TestClassFemaleCheckUtility.CreateClass(1,4);
        test.startTest();
        database.DeleteResult result = database.delete(classes[0],false);
        test.stopTest();
        System.assert(!result.isSuccess());
       // System.assertEquals('Cant delete class having more than 1 Female Students', result.getErrors()[0].getMessage());            
    }
    
    /*
     * Test to delete bulk classes with more than one girl
     */
    @isTest
    static void ClassesWithGirls(){
        list<Class__c> classes = TestClassFemaleCheckUtility.CreateClass(10,10);
        test.startTest();
        database.DeleteResult[] results = database.delete(classes,false);
        test.stopTest();
        for(Database.DeleteResult result : results){
            System.assert(!result.isSuccess());
           // System.assertEquals('Cant delete class having more than 1 Female Students', result.getErrors()[0].getMessage()); 
        }
    }
    /*
     * Test to delete bulk classes with no girl
     */
    @isTest
    static void ClassesWithNoGirls(){
        list<Class__c> classes = TestClassFemaleCheckUtility.CreateClass(10,0);
        test.startTest();
        database.DeleteResult[] results = database.delete(classes,false);
        test.stopTest();
        for(Database.DeleteResult result : results){
            System.assert(result.isSuccess());
        }
    }
    
}
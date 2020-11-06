@isTest
private class TestRestrictTeacherInsertUpdate
{
    @isTest static void testRestrictTeacherInsertUpdate()
    {
        Contact c = new Contact(FirstName='Arun',LastName='Nair');
        INSERT c;
        Class__c classObj = new Class__c(Name='Class 7');
        INSERT classObj;
        Teach__c teach = new Teach__c(Name='Teach11',Subject__c='Hindi',Teacher__c=c.Id,Class__c=classObj.Id);
        Database.INSERT(teach);
        c.FirstName='Arun01';
        Test.startTest(); 
        Database.SaveResult result = Database.UPDATE(c,false);        
        Test.stopTest();
        System.assert(result.isSuccess());
       // System.assertEquals('Cannot update this teacher as he teaches Hindi',result.getErrors()[0].getMessage());        
    }
}
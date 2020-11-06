@isTest
public class TestRestrictContactByName
{
    @isTest static void TestInvalidNameTrigger()
    {
        Contact c = new Contact(LastName='INVALIDNAME');
        insert c;
        
        Test.startTest();

        Test.stopTest();
        
        
       //  System.assert(!result.isSuccess());
      //  System.assert(result.getErrors().size() > 0);
    }
    
}
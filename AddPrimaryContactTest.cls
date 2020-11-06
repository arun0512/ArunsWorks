@isTest
public class AddPrimaryContactTest {
    
      public static testMethod void testFn(){
          
             List<Account> accountList = new List<Account>();
          
          for(Integer i=0; i < 50; i++){
              
              accountList.add(new Account(BillingState='CA',name='TEST ACCOUNT CA '+i));
              
          }
           for(Integer i=0; i < 50; i++){
              
              accountList.add(new Account(BillingState='NY',name='TEST ACCOUNT NY '+i));
              
          }
          
          insert accountList;
          
          
          COntact c = new COntact();
          
          c.FirstName='TEST FIRSTNAME';
          c.LastName='TEST LASTNAME';
          insert c;
          String state ='CA';
          
          
          AddPrimaryContact apc = new AddPrimaryContact(c,state);
          
           Test.startTest();
      System.enqueueJob(apc);
        Test.stopTest();
          
      }

}
/*
 * Test class for ContactDetails Class
 */
@isTest
public class TestContactDetails {
    
 @isTest static void testUpdateAccountWithContactId()
    {
        Account a = new Account(Name='Demo Account');
        INSERT a;
        Integer contactsToBeCreated = 2;
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 0; i<contactsToBeCreated ; i++)
        {
            Contact c = new Contact(LastName = 'Demo '+i);
            c.Account = a;
            c.AccountId = a.Id;
            contacts.add(c);
        }
        INSERT contacts;
        Integer randomNumber = Math.mod(Integer.valueof((Math.random() * 10)),contactsToBeCreated);
        UpdateAccountWithContactId.manipulateAccount(contacts[randomNumber].Id);
        String contactIDsinAccount = [SELECT ContactID__c FROM Account WHERE Id =: a.Id].get(0).ContactID__c;
        System.assert(contactIDsinAccount.split(',').size() == contactsToBeCreated);
    }
}
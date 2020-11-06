public class UpdateAccountWithContactId { 
    
    public static void manipulateAccount(Id COntactID)

    {
       // Id COntactID='0032w000001a4vdAAA';

        List<Account> listOfAccounts = [ SELECT Id,name,ContactID__c, (SELECT Id FROM Contacts) FROM Account];      

        for (Account a : listOfAccounts){
            
            If( String.isBlank(a.ContactID__c) ){ 
             List<ID> listOfContactIds=new List<ID>();
                for(Contact c : a.Contacts){
                    System.debug(a.Contacts.size());
                    listOfContactIds.add(c.id);
                    a.ContactID__c  = String.join(listOfContactIds,',');

                }
                // a.ContactID__c =listOfContactIds;   
              
            }
            
            else{

                List<String> cntctLstString = a.ContactID__c.split(',');

                
                if(cntctLstString.contains(COntactID)){
                    System.debug('Contact ID- '+COntactID+'already is related to this account '+a.Id);
                }
                else{

                    cntctLstString.add(COntactID);
                    a.ContactID__c  = String.join(cntctLstString,',');
                }
            }
            
            
              update a;
            //
        }
        
    }
        
}
public class ShowJSONController 
{
    private final Class__c cls;
    public String jSONObjectString {get; set;}
    
    public ShowJSONController(ApexPages.StandardController stdController)
    {
        this.cls = (Class__c) stdController.getRecord();
    }

    public void serialize() 
    {
        Class__c classObj = [SELECT Id, Name, Custom_Status__c, Board__c, Fee__c,
                             MaxSize__c, MyCount__c  FROM Class__c WHERE Id =: cls.Id];
        jSONObjectString = JSON.serialize(classObj);
    }    
}
public class DeleteStudentRemoteActionController {
   public boolean render{get;set;}
    
    public DeleteStudentRemoteActionController(ApexPages.StandardSetController controller) 
    {
        if(controller.getSelected().size() == 0) 
        {
            render = false;
        }
        else 
        {
            render = true;
        }
    }
    
    @RemoteAction
    public static Database.DeleteResult[] deleteStudents(List<Id> students)
    {
        Database.DeleteResult[] result;
        try 
        {
            result = Database.delete(students);
        }
        catch(Exception ex) 
        {
            ApexPages.addMessages(ex);
        }
        return result;
    }
}
public with sharing class AccountSearchPaginationController 
{
    public Account acc {get;set;}  
    public Integer noOfAccountsToDisplay {get;set;}
    public ApexPages.StandardSetController con{get; set;} 
    public AccountSearchPaginationController ()
    {
        acc = new Account();
        lstAccount = new List<Account>();
        noOfAccountsToDisplay = 2;
    }
    public List<Account> lstAccount 
    {  
        get  
        {  
            if(con != null)  
                return (List<Account>) con.getRecords();  
            else  
                return null ;  
        }  
        set;
    }  
    public PageReference search()
    {
        String query= '';
        String strFilter = '';
        if(acc.BillingCity != null && (acc.BillingCity ).trim() !='')
        {
            strFilter  = strFilter  +  ' WHERE BillingCity Like \''+acc.BillingCity+'%\'' ;
        }
        if(acc.BillingState != null && (acc.BillingState).trim() !='' )
        {
            if(strFilter == '')
            { 
                strFilter  +=  ' WHERE BillingState LIKE \''+acc.BillingState+'%\'' ;
            }
            else
            {
                strFilter  +=  ' AND BillingState LIKE \''+acc.BillingState+'%\'' ;
            }
        }
        if(acc.BillingCountry != null && (acc.BillingCountry).trim() !='' )
        {
            if(strFilter == '')
            { 
                strFilter  +=  ' WHERE BillingCountry LIKE \''+acc.BillingCountry+'%\'' ;
            }
            else
            {
                strFilter  +=  ' AND BillingCountry LIKE \''+acc.BillingCountry+'%\'' ;
            }
        }
        if(strFilter != '')
        {
            query = 'SELECT Name , BillingCity, BillingState, BillingCountry FROM Account '+strFilter;
        }
        else
        {
            query = 'SELECT Name , BillingCity, BillingState, BillingCountry FROM Account';           
        }
        System.debug('Query ---->'+ query );
        con = new ApexPages.StandardSetController(Database.getQueryLocator(query)); 
        con.setPageSize(noOfAccountsToDisplay);
        return null;
    }
    public Boolean hasNext  
    {  
        get  
        {  
            return con.getHasNext();  
        }  
        set;  
    }
    public Boolean hasPrevious  
    {  
        get  
        {  
            return con.getHasPrevious();  
        }  
        set;  
    } 
    public void first()  
    {  
        con.first();
    }  
    public void last()  
    {  
        con.last();  
    }  
    public Integer pageNumber  
    {  
        get  
        {  
            return con.getPageNumber();  
        }  
        set;  
    }  
    public void previous()  
    {  
        con.previous();  
    }  
    public void next()  
    {  
        con.next();  
    }  
    
}
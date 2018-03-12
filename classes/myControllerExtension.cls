public class myControllerExtension{

    public Account account{get;set;}

    public String acct;
    public Account acnt{get;set;}
     public myControllerExtension(ApexPages.StandardController stdController)
     {
            account = new Account();
     }
    
    public PageReference saveData() 
    {
      try{
           insert account;
        }catch (DmlException e) {   
              System.debug(e.getMessage());
       }
       PageReference pageRef = new PageReference('https://c.na15.visual.force.com/'+account.Id+'');
       pageRef.setRedirect(true);
     return pageRef; 
    }
    
    public pageReference saveAndNew()
    {
        PageReference pageRef =Page.StandardExtensionControllerPages; 
        try
        {
           insert account;
           pageRef.setRedirect(true);
        }catch (DmlException e) {   
                  System.debug(e.getMessage());
                  return null;
         }
              account=new Account();
              return null;
    }
    
    public pageReference recordCancel()
    {
        return null;
        //pageReference page = new pageReference('https://c.na15.visual.force.com/+');
        //page.setRedirect(true);
        //return page;
    }
}
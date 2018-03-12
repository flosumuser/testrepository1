public class CustomObjectFieldViewerController
{
    //page refrence
    public PageReference processSelected() 
    {
         System.debug('::::::::::::::::::::::::::::::::::::::in processSelected::::::::::');
         selectedObjectFields = new List<sObject>();
         PageReference p = Page.Export;
    
         for(ExportClass exc : result) 
         {
            if(exc.selected == true) 
            {
                selectedObjectFields.add(exc.sob);
                System.debug('::::::::::::::::::::::::::::::::::::::selected record to export::::::::::'+exc.sob.Id);
            }
            else
            {
                System.debug('::::::::::::::::::::::::::::::::::::::no not selected to export::::::::::'+exc.sob.Id);
            }
         }
         p.setRedirect(true);
         //result=null;
         return p;
    }

    //fields
    Schema.DescribeSobjectResult[] results;
    List<sObjectType> objects;
    public String selectedobject {get;set;}
    public List<ExportClass> result{get;set;}
    public List<sObject> selectedObjectFields{get;set;}
    public Integer OffSetSize=0;
    public Integer LimitSize=5;
    public integer totalRecs = 0;
    public boolean bnxt;
    public boolean bprv;
    
    //set offsesize to 0
    public void setOffset()
    {
        OffSetSize=0;
    }
    //cunstructor of class
    public CustomObjectFieldViewerController()
    { 
            
    }
    
    // return a selectoption list of custom objects
    public List<SelectOption> getObjectList()
    {
        //Return sobjecttype list of your organization
        
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();    
        List<SelectOption> options = new List<SelectOption>();
        for(Schema.SObjectType f : gd)
        {
            if(f.getDescribe().isCustom())
            {
                //add object name and object label to selectoption list
                options.add(new SelectOption(f.getDescribe().getName(),f.getDescribe().getLabel()));
            }
        }
        return options;
    }  
    // to show fields of selected object
    public List<ExportClass> getObjectFields()
    {
        result= new List<ExportClass>();
        totalRecs=0;
        try
        {
            System.debug(':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::select object:'+selectedobject);
            if(selectedobject!= null)
            {
                String que='SELECT Id,Name FROM '+ selectedobject+' LIMIT '+LimitSize+' OFFSET '+OffSetSize;
                System.debug('::::::::::::::::::::::::::query:'+'SELECT Id,Name FROM '+ selectedobject+' LIMIT '+LimitSize+' OFFSET '+OffSetSize);
                //result=Database.query(que);
                //
                //List<sObject> result = Database.query(que);
                for(sObject so: Database.query(que)) 
                {
                    result.add(new ExportClass(so));
                    System.debug(':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::record after added:'+so);
                }
                
                
                // count the row
                for(ExportClass s : result)
                {
                   totalRecs++;
                }
                que='SELECT Id,Name FROM '+ selectedobject;
                totalRecs = Database.query(que).size();
                System.debug(':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::total Records:'+totalRecs);
           }
           else
           {
               System.debug(':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::not selected:');
           }
        }
        catch(Exception e)
        {
            System.debug('Exception type caught:::::::::::::::::::::::::::::::::::::::::::::::::::: ' + e.getTypeName());
            System.debug('Message of exception::::::::::::::::::::::::::::::::::::::::::::::::::::: ' + e.getMessage());
             System.debug('Cause:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: ' + e.getCause());
            System.debug('Line number:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: ' + e.getLineNumber());
            System.debug('Stack trace:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: ' + e.getStackTraceString());
        }      
        return result;
    }
    //wraper class
    public class ExportClass
    {
        // fields
        public sObject sob 
        {
            get;set;
        }
        public boolean selected
        {
            get;set;
        }
        //cunstructor
        public ExportClass(sObject s)
        {
            sob=s;
            selected=false;
        }
    }
    
    // pagination methods
    //view first page
    public void FirstPage()
    {
            OffsetSize = 0;
    }
    //view previous
    public void previous()
    {
            OffsetSize = OffsetSize - LimitSize;
    }
    // view next
    public void next()
    { 
            OffsetSize = OffsetSize + LimitSize;
    }
    //view last page
    public void LastPage()
    {
            OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
    }
    // return true if already on first page
    public boolean getprev()
    {
        if(OffsetSize == 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    //return true if already on last page
    public boolean getnxt()
    {
        if((OffsetSize + LimitSize) > totalRecs)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}
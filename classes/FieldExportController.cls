public class FieldExportController
{
    //cunstructor
    //public FieldExportController(){}
   //fields
    Schema.DescribeSobjectResult[] results;
    List<sObjectType> objects;
    public String selectedobject {get;set;}
    public List<ExportClass> result{get;set;}
    public List<ExportClass> totalResult{get;set;}
    public List<sObject> selectedObjectFields{get;set;}
    public Integer OffSetSize=0;
    public Integer LimitSize=5;
    public Integer totalRecs = 0;
    public boolean bnxt;
    public boolean bprv;
    
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
    
    //page refrence add records to selectedobjectfields and return pagerefrence
    public PageReference processSelected() 
    {
         System.debug('::::::::::::::::::'+selectedObjectFields+'::::::::::');
             if(selectedObjectFields == null)
             {
                 System.debug('::::::::::::::::::::selected object field is null or size 0::::::::::::::::::::::::::::::::::::::::::::');
                 selectedObjectFields = new List<sObject>();
                 for(ExportClass exc : result) 
                 {
                    if(exc.selected == true) 
                    {
                        selectedObjectFields.add(exc.sob);
                        System.debug('::::::::::::::::::::::::::::::::::::::selected record to export::::::::::'+exc.sob.Id);
                    }
                 }
             }
             else
             {
                 System.debug('::::::::::::::::::::selected object field is NOT null::::::::::::::::::::::::::::::::::::::::::::');
                 for(ExportClass exc : result) 
                 {
                     if(exc.selected == true) 
                     {  
                         boolean b=false;
                         for(sObject lis :selectedObjectFields) 
                         {
    
                                  if(exc.sob.id == lis.id)
                                  {
                                      b=true;
                                  }                                    
                                // selectedObjectFields.add(exc.sob);
                                 //System.debug(':::selected objectfields:::::::'+selectedObjectFields+':::::::::::::::');
                         }
                         if(!b)
                         {
                              selectedObjectFields.add(exc.sob);
                         }
                    }
                 }
                 System.debug(':::selected objectfields:::::::'+selectedObjectFields+':::::::::::::::');
             }
         PageReference p = Page.Export;
         //p.setRedirect(true);
         return p;
    }
    // for add in selectedfieldlist when pagination button pressed
    public void addToSelectedList()
    {
        try
        {
             System.debug('::::::::::::::::::'+selectedObjectFields+'::::::::::');
             if(selectedObjectFields == null)
             {
                 System.debug('::::::::::::::::::::selected object field is null or size 0::::::::::::::::::::::::::::::::::::::::::::');
                 selectedObjectFields = new List<sObject>();
                 for(ExportClass exc : result) 
                 {
                    if(exc.selected == true) 
                    {
                        selectedObjectFields.add(exc.sob);
                        System.debug('::::::::::::::::::::::::::::::::::::::selected record to export::::::::::'+exc.sob.Id);
                    }
                 }
             }
             else
             {
                 System.debug('::::::::::::::::::::selected object field is NOT null::::::::::::::::::::::::::::::::::::::::::::');
                 for(ExportClass exc : result) 
                 {
                     if(exc.selected == true) 
                     {  
                         boolean b=false;
                         for(sObject lis :selectedObjectFields) 
                         {
    
                                  if(exc.sob.id == lis.id)
                                  {
                                      b=true;
                                  }                                    
                                // selectedObjectFields.add(exc.sob);
                                 //System.debug(':::selected objectfields:::::::'+selectedObjectFields+':::::::::::::::');
                         }
                         if(!b)
                         {
                              selectedObjectFields.add(exc.sob);
                         }
                    }
                 }
                 System.debug(':::selected objectfields:::::::'+selectedObjectFields+':::::::::::::::');
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
    }
    
    //get Object List of custom objects
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
     //list of objects
     public void writeObjectFields(Integer OffSetSize)
     {
        totalRecs=0;
        try
        {
            result = new List<ExportClass>();
            System.debug(':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::select object:'+selectedobject);
            if(selectedobject!= null)
            {
                String que='SELECT Id,Name FROM '+ selectedobject+' LIMIT '+LimitSize+' OFFSET '+OffSetSize;
                System.debug('::::::::::::::::::::::::::query:'+'SELECT Id,Name FROM '+ selectedobject+' LIMIT '+LimitSize+' OFFSET '+OffSetSize);
                // return id and name of selected object to result list
                for(sObject so: Database.query(que)) 
                {
                    result.add(new ExportClass(so));
                    System.debug(':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::record after added:'+so);
                }
                
                // count the total records row
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
    }
    //same method with oofsetsize 0
    public void writeObjectFieldsDefault()
     {
        selectedObjectFields =null;
        totalRecs=0;
        OffSetSize=0;
        try
        {
            result = new List<ExportClass>();
            System.debug(':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::select object:'+selectedobject);
            if(selectedobject!= null)
            {
                String que='SELECT Id,Name FROM '+ selectedobject+' LIMIT '+LimitSize+' OFFSET '+OffSetSize;
                System.debug('::::::::::::::::::::::::::query:'+'SELECT Id,Name FROM '+ selectedobject+' LIMIT '+LimitSize+' OFFSET '+OffSetSize);
                // return id and name of selected object to result list
                for(sObject so: Database.query(que)) 
                {
                    result.add(new ExportClass(so));
                    System.debug(':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::record after added:'+so);
                }
                
                // count the total records row
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
    }
    public void setResultCheckboxes()
    {
        if(selectedObjectFields != null)
        {
            for(ExportClass exc : result) 
            {
                  for(sObject lis :selectedObjectFields) 
                  {
                       if(exc.sob.id == lis.id)
                       {
                         System.debug(':::::::::::::::::::::::::::::'+exc.sob.Id+'value set true');
                         exc.selected = true;
                       }
                  }
           }
       }
    }
     // pagination methods
    //view first page
    public void FirstPage()
    {
            OffsetSize = 0;
            addToSelectedList();
            writeObjectFields(OffSetSize);
            setResultCheckboxes();
    }
    //view previous
    public void previous()
    {
            OffsetSize = OffsetSize - LimitSize;
            addToSelectedList();
            writeObjectFields(OffSetSize);
            setResultCheckboxes();
    }
    // view next
    public void next()
    { 
            OffsetSize = OffsetSize + LimitSize;
            addToSelectedList();
            writeObjectFields(OffSetSize);
            setResultCheckboxes();
    }
    //view last page
    public void LastPage()
    {
            OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
            addToSelectedList();
            writeObjectFields(OffSetSize);
            setResultCheckboxes();
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
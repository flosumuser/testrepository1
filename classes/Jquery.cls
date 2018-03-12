public class Jquery{
  public list<Schema.SObjectType> gd {get;set;}
     public map<String, Schema.SObjectfield> getfields {get;set;}
     public list<SelectOption> options {get;set;}
     public String ObjectNameVal {get;set;}
     public String actionObjectName {get;set;}
     public list<String> fieldsName {get;set;} 
     public list<String> fieldsNameDup {get;set;}
     public list<String> fieldsRemoveName {get;set;} 
     public list<sObject> queryDataSObj {get;set;}
     public list<sObject> recordList {get;set;}
     public String firstField {get;set;}
     public String ev {get;set;}
     public String val {get;set;}
     public String soqlquery {get;set;}
     public list<String> addlist {get;set;}
     
     public Jquery(){
        gd=Schema.getGlobalDescribe().Values();
        options = new list<SelectOption>();
        getfields=new  map<String, Schema.SObjectfield>();
        fieldsName = new list<String>();
        queryDataSObj= new list<sObject>();
        recordList=new list<sObject>();
        addlist=new list<String>();
        fieldsNameDup=new list<String>();
        firstField=null;
        AllObjects(); 
     }  
     
     public void AllObjects() {
           try{
                 options = new List<SelectOption>();
                 options.add(new SelectOption('','--None--'));
                  for(Schema.SObjectType d : gd){
                    options.add(new SelectOption(d.getDescribe().getName(),d.getDescribe().getLabel()));
                  }
              }catch(Exception e){
                ApexPages.addMessages(e);
             }
          options.sort();       
      } 
    
    public void actionObjectName(){
         try{
              fieldsName=new List<String>();
              if(ObjectNameVal != null){
                    getfields = Schema.getGlobalDescribe().get(ObjectNameVal).getDescribe().Fields.getMap();
                    for(Schema.SObjectField sfield : getfields.Values()){ 
                       Schema.DescribeFieldResult F =  sfield.getDescribe();
                        if(f.isCreateable() && f.isSortable())
                            fieldsName.add(F.getName());
                    }
               }
            }catch(Exception e)
             {
                ApexPages.addMessages(e);
             }
           fieldsName.sort(); 
           showRecord();
    }  
    
      public void showRecord(){
            try{ 
                        System.debug('firstField++++++++++++++'+firstField);
                        recordList=new list<sObject>();
                        for(String p : fieldsName){
                                   if(p == 'name')
                                           firstField=p;
                                    if(firstField == null)
                                           firstField=p;   
                        } 
                         for(String p : fieldsName){
                                   if(firstField != p)
                                      fieldsNameDup.add(p);   
                        } 
                       fieldsName=new list<String>();
                       fieldsName=fieldsNameDup;
                      addlist.add(firstField);
                      System.debug('-----------firstField---addlist--'+firstField+addlist);   
                      if(firstField != null){ 
                           soqlquery = 'Select '+ firstField +' from '+ObjectNameVal;
                      }
                       System.debug('soqlquery++++++++++++++'+soqlquery);
                      if(soqlquery != null)
                           queryDataSObj=Database.query(soqlquery);
                        
                     System.debug('queryDataSObj>>>>>'+queryDataSObj);      
                      queryDataSObj.sort();
                     if(queryDataSObj != null){
                         for(sObject q : queryDataSObj){
                            recordList.add(q);
                         }
                     }
                     
            }catch(exception e){}  
                      
                      System.debug('----addlist-------recordList----'+addlist+recordList);             
    }
    
    public void actionFunctionVal(){
      try{  
                    System.debug('recordList++++++++++++++'+recordList+' fieldsName --- '+fieldsName);              
                    recordList=new list<sObject>();
                    System.debug('firstField++++++++++++++'+firstField+' New value Add --- '+val);
                    for(String p : fieldsName){
                                  if(p == val){
                                    addlist.add(p);
                                           firstField=firstField+','+p;
                                  }
                    }
                   
                    System.debug('AddwithNewfields++++++++++++++'+firstField);
                                    
                       
                      if(firstField != null){ 
                           soqlquery = 'Select '+firstField+' from '+ObjectNameVal;
                      }
                       System.debug('soqlquery++++++++++++++'+soqlquery);
                      if(soqlquery != null)
                           queryDataSObj=Database.query(soqlquery);
                           
                      
                     if(queryDataSObj != null){
                         for(sObject q : queryDataSObj){
                            recordList.add(q);
                         }
                     }
                      System.debug('-----------recordList----'+recordList+'---------fieldsName-'+fieldsName);
            }catch(exception e){}
      
    }

}
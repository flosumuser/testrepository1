public with sharing class JqueryController {
   
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
     public String dropFieldsValue{get;set;}
     public String dropableFiled {get;set;}
     public JqueryController(){
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
         	  addlist=new list<String>();
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
    	    	         fieldsNameDup=new list<String>();
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
      	      
                    System.debug('dropFieldsValue++++++++++++++'+dropFieldsValue);          	
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
                      map<string,string> mapfield=new map<string,string>();
                     System.debug('---------addlist-------'+addlist+'  '+fieldsName);
                     for(string alField : fieldsName)
                           mapfield.put(alField,alField);
                         
                        for(String p : addlist){
                             for(Integer i=0;i<fieldsName.size();i++){
                               if(mapfield.get(p) == p ){
                               	  if(p !='name'){	
                      	       	      System.debug('---------mapfield-------'+mapfield.get(p)+' <><><> '+p);   
                                      fieldsName.remove(i);
                                       mapfield.remove(p);
                               	  }
                               }
                           }
                     }
                     
                     for(string s : mapfield.values()){
                     	
                     }
                     
                      System.debug('---------addlist Again-------'+addlist+'  '+fieldsName);
                    /*
                           
                     list<string> tempList=new list<string>();
                    
                          for(String p : addlist){
                      	       if(mapfield.get(p) == p){
                                     tempList.add(p);
                               }
                          }
                    fieldsName = new list<String>();
	                for(string s : tempList){
	                	 if(mapfield.get(s)!= s)
	                           fieldsName.add(s);
	                }*/
                      System.debug('-----------recordList----'+recordList+'---------fieldsName-'+fieldsName);
    	    }catch(exception e){}
      
    }
    
    public void DragTableFunctionValue(){
    try{
    System.debug('dropFieldsValue++++++++++++++'+dropFieldsValue);          	
      	            recordList=new list<sObject>();
      	            fieldsNameDup=new list<String>();
      	            System.debug('firstField++++++++++++++'+firstField+' New value Add --- '+val);
 		            for(String drop : addlist){
	                   if(dropFieldsValue==drop)
	                     System.debug(drop+'=='+dropFieldsValue);
	                   else
	                    fieldsNameDup.add(drop);
	                }
	                addlist=new list<String>();
	                for(String s : fieldsNameDup)
	                        addlist.add(s);
	    	        System.debug('AddwithNewfields++++++++++++++'+firstField);
                                    
    	    	     firstField=null; 
    	    	     for(String p : fieldsNameDup){
	                      if(firstField == null)
	                      	 firstField=p;
	                       else
	                         firstField=firstField+','+p;
	                 } 
    	    	       
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
    public void DropableTableFunctionValue(){
    	 System.debug('----dropableFiled------'+dropableFiled+'-fieldsName-'+fieldsName);
    	fieldsName.add(dropableFiled);
    }
  
}
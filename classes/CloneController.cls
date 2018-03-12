// class to clone a record with its child
public  with sharing class CloneController
{ 	  
    
    // to get the particular Id of record 
    public Id recordId{get;set;}
    
    // name of sobject of record
    public String sObjName;
    
    // list of string for all fields of sobject
    public List<String> Allfields{get;set;}
    
    
    //clone list after clone a record
    public List<sObject> CloneList{get;set;}
    
    //sObjectType
    Schema.SObjectType sobjType;
    
    // new inserted recordId
    public Id newId;
    
    // cunstructor of CloneController class
	public CloneController(ApexPages.Standardcontroller controller)
	{
		sObject sObjectRecord = controller.getRecord();
		recordId = sObjectRecord.Id;
	}
    
    // to return a clone list of record
    public List<sObject> getCreateClone()
    {
    	try
    	{
	    	if(recordId != null) 
	    	{
	        	 //geting sobjecttype from recordId
				 sobjType =recordId.getSObjectType();
	             
	             Schema.DescribeSObjectResult sObjeResult  =sobjType.getDescribe();
	            
	             sObjName = sObjeResult.getName();
	            
	             // geting all creatable fields of the sobject
	             Allfields=new List<String>();
	            
	             Map<String, Schema.SObjectField> fieldMap =sObjeResult.fields.getMap();
	             for (Schema.SObjectField ft : fieldMap.values())
	             { 
	                Schema.DescribeFieldResult dfr = ft.getDescribe(); 
	                if (dfr.isCreateable())
	               	{
	                    Allfields.add(dfr.getName());
	               	}
	             }
	             CloneList = new List<sObject>();
	             if(Allfields.size() > 0)
	             {
		             // query for select all fields
		             String AllsObjectFieldQuery='SELECT ' + Allfields.get(0);
		             for(Integer index=1 ; index<Allfields.size() ; index++) 
		             {
		                  AllsObjectFieldQuery +=','+Allfields.get(index);    
		             }
		             AllsObjectFieldQuery +=' FROM '+sObjName +' WHERE ID = \'' + recordId +'\' LIMIT 1';
		 
		             List<sObject> sObjectClonelist = new List<sObject>();
		             sObjectClonelist = Database.query(AllsObjectFieldQuery);
		            
		             
		             //clone the record 
		             if(sObjectClonelist != null && sObjectClonelist.size()>0)
		             {  
		                     sObject cloned=sObjectClonelist.get(0).clone(false,true);
		                     //add to clone list
		                     CloneList.add(cloned); 
		                     return CloneList;
		             } 
		             else
		                 return null;
	             }
	             else
	             	return null;
	    	}
	    	else
	    	{
	    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Record Not Found.'));
	    		return null; 
	    	}
    	}
    	catch(Exception ex)
    	{
    		system.debug(' @@@@@ '+ex.getMessage());
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Failed Due To Limits.'));
    		return null;
    	} 
    }
    public void ChildClone()
    {
    	try
    	{
	       if(CloneList !=null && CloneList.size()>0)
	       {
	          insert CloneList.get(0); 
	            
	          newId = CloneList.get(0).Id; 
	          if(newId != null)
	          {    
	             //get child fields
	             Schema.DescribeSObjectResult R = sobjType.getDescribe();
	             List<Schema.ChildRelationship> C = R.getChildRelationships();
	             List<sObject> childList = new List<sObject>(); 
	             List<sObject> childObje = new List<sObject>();
	             List<String> relationshipNameList = new List<String>();
	             Map<String,String> relationshipNameFieldNameMap = new Map<String,String>();
	             String que='SELECT Id';
	             //updating updatable child fields of parent object with new record id
	             for(Schema.ChildRelationship cc : C)
	             {
	                 if( cc.getField().getDescribe().isUpdateable()&& cc.getRelationshipName()!=null )
	                 {
	                     String sof = cc.getField().getDescribe().getName();
	                     
	                     String relationshipname = cc.getRelationshipName();
	                     relationshipNameList.add(relationshipname);
	                     relationshipNameFieldNameMap.put(relationshipname, sof);
	                     
	                     //nested query for get childs of record
	                     que+=',(SELECT Id FROM '+relationshipname+')';
	                     
	                 }
	             }
	             
	             que+= ' FROM '+ sObjName + ' WHERE ID = \'' + recordId +'\'LIMIT 1';
	             
	             sObject Obj = Database.query(que);
	             if(obj !=null)
	             {
		             List<sObject> relationChildList = new List<sObject>();
		             List<sObject> childListToUpdate = new List<sObject>();
					 if(relationshipNameList != null)
					 {
				         for(String relationshipname : relationshipNameList)  
				         {     
			
				             String fieldName = relationshipNameFieldNameMap.get(relationshipname);
					         relationChildList=Obj.getSObjects(relationshipname); 
			
					         if(relationChildList != null)
					         {
						         for(sObject child : relationChildList)
						         {
						             child.put(fieldName,newId);
						             childListToUpdate.add(child);
						         }   
					         }
				        }
					}
			        if(childListToUpdate.size() > 0) 
			            update childListToUpdate;
	            }
	          }
	       }
    	}
    	catch(Exception ex)
    	{
    		system.debug(' @@@@@ '+ex.getMessage());
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Failed Due To Limits.'));
    	}
    }
    // method to insert clone record and update child records
    public PageReference saveClone()
    {
        ChildClone();
        if(newId != null)
        { 
	        PageReference pageRef = new PageReference('/'+newId);
	        return pageRef;
        }
        else
        	return null;
    }
    // cancel 
    public PageReference cancelClone()
    {
    	if(recordId != null)  
        { 
            PageReference pageRef = new PageReference('/'+recordId);
            return pageRef;
        }
        else
        	return null;
    }
}
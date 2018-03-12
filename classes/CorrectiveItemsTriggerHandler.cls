public with sharing class CorrectiveItemsTriggerHandler 
{
    //on undelete and insertion of records on Corrective_Item__c
    public void onInsertCorrectiveItems(List<Corrective_Item__c> correctiveItemsTriggerNewList)
    {
        //Set with parent recordId
        Set<Id> parentIdSet= new  Set<Id>();
        for(Corrective_Item__c correctiveItemRecord : correctiveItemsTriggerNewList)
        {
        	if(correctiveItemRecord.Building_Comp_Detail__c != null)
        	{
	        	// add recordParentId in Set
	            Id recordParentId = correctiveItemRecord.Building_Comp_Detail__c;
	            parentIdSet.add(recordParentId);
        	}
        } 
        correctiveItemTriggerUtility(parentIdSet);
    }
    //on update of  records on Corrective_Item__c
    public void onUpdateCorrectiveItems(List<Corrective_Item__c> correctiveItemsTriggerNewList, Map<Id,Corrective_Item__c> correctiveItemsTriggerOldMap)
    {
        //Set with parent recordId
        Set<Id> parentIdSet= new  Set<Id>();
        for(Corrective_Item__c correctiveItemRecord : correctiveItemsTriggerNewList)
        {
	        	// add recordParentId in Set
	        	Id oldParentId = correctiveItemsTriggerOldMap.get(correctiveItemRecord.Id).Building_Comp_Detail__c;
	        	Id newParentId = correctiveItemRecord.Building_Comp_Detail__c;
	        	Decimal oldExtendedCost = correctiveItemsTriggerOldMap.get(correctiveItemRecord.Id).Extended_Cost__c;
	        	Decimal newExtendedCost = correctiveItemRecord.Extended_Cost__c;
	
	        	if((oldParentId != newParentId) || (oldExtendedCost != newExtendedCost))
	        	{
	        		if(oldParentId != newParentId)
	        		{
	        			// add new parentid if it not null
	        			if(newParentId != null)
			            	parentIdSet.add(newParentId);
			            //add old parentid if it not null
			            if(oldParentId != null) 
			            	parentIdSet.add(oldParentId);
	        		}
	        		else
	        		{
	        			//add new parentid if the extended cost is different
	        			parentIdSet.add(newParentId);
	        		}
	        	}
        } 
        correctiveItemTriggerUtility(parentIdSet);
    }
    //on deletion of  records on Corrective_Item__c
    public void onDeleteCorrectiveItems(List<Corrective_Item__c> correctiveItemsTriggerOldList)
    {
    	//Set with parent recordId
        Set<Id> parentIdSet= new  Set<Id>();
        for(Corrective_Item__c correctiveItemRecord : correctiveItemsTriggerOldList)
        {
        	if(correctiveItemRecord.Building_Comp_Detail__c != null)
        	{
	        	// add recordParentId in Set
	        	Id recordParentId = correctiveItemRecord.Building_Comp_Detail__c;
	            parentIdSet.add(recordParentId);
        	}
        } 
        correctiveItemTriggerUtility(parentIdSet);
    }
    // utility method call with each insert,update and delete on Corrective_Item__c
    private void correctiveItemTriggerUtility(Set<Id> parentIdSet)
    {
        if(parentIdSet.size() > 0)
        {
        	// map with parentId and AggregateResultWrapper wraper which have sum and count of all parent child records
        	Map<Id,AggregateResultWrapper> buildingCompMap = new Map<Id,AggregateResultWrapper>();
			// query for calculate sum and count of child records
            AggregateResult[] groupResults = [SELECT  COUNT(Id)countno, SUM(Extended_Cost__c)total, Building_Comp_Detail__c  FROM Corrective_Item__c WHERE Building_Comp_Detail__c IN : parentIdSet Group By  Building_Comp_Detail__c];
           	if(groupResults.size() > 0)
           	{
		    	for(Integer index =0 ; index< groupResults.size() ; index++)
		        {
		                Decimal total = (Decimal)groupResults[index].get('total');
		                Decimal count = (Decimal)groupResults[index].get('countno');
		                Id ParentId = (Id)groupResults[index].get('Building_Comp_Detail__c');
		                if(ParentId != null)
		                {
		                	if(total == null)
		                		total =0;
		                	buildingCompMap.put(ParentId, new AggregateResultWrapper(total, count, ParentId));
		                	parentIdSet.remove(ParentId);
		                }
		    	}
		    	//run when parent some parents not have a single child after delete or after update(parent changed)
		    	if(parentIdSet.size() >0)
		    	{
			    	List<Id> parentIdList= new List<Id>(parentIdSet);
	           		for(Integer index =0 ; index< parentIdList.size() ; index++)
	           		{
	           			Decimal total = 0;
						Id ParentId = parentIdList.get(index); 
						Decimal count = 0;
					    buildingCompMap.put(ParentId, new AggregateResultWrapper(total, count, ParentId));
	           		}
		    	}
           	}
           	//run when a parent not have a single child after delete or after update(parent changed)
           	else
           	{
           		List<Id> parentIdList= new List<Id>(parentIdSet);
           		for(Integer index =0 ; index< parentIdList.size() ; index++)
           		{
           			Decimal total = 0;
					Id ParentId = parentIdList.get(index); 
					Decimal count = 0;
				    buildingCompMap.put(ParentId, new AggregateResultWrapper(total, count, ParentId));
           		}
           	}
            if(buildingCompMap.size() > 0)
            {
            	// final list of Building_Comp_Detail__c to update
	            List<Building_Comp_Detail__c> updateList = new List<Building_Comp_Detail__c>();
	            
	            updateList = [SELECT Differed_Costs__c, No_of_Corrective_Items__c,Id FROM Building_Comp_Detail__c WHERE Id IN :buildingCompMap.keyset()];
            	for(Building_Comp_Detail__c compDetailRecord : updateList)
            	{
            		if(buildingCompMap.containskey(compDetailRecord.Id))
            		{
            			AggregateResultWrapper updateValuesFromWraper = buildingCompMap.get(compDetailRecord.Id);
            			if(updateValuesFromWraper != null)
            			{
	            			compDetailRecord.Differed_Costs__c = updateValuesFromWraper.total;
	            			compDetailRecord.No_of_Corrective_Items__c = updateValuesFromWraper.count;
            			}
            		}
            	}
            	// update list of Building_Comp_Detail__c if size is greater than 0
            	if(updateList.size() > 0)
            		update updateList;
            }
        }
    }
    //wrapper class
    class AggregateResultWrapper
    {
    	Decimal total;
    	Decimal count;
    	Id ParentId;
    	public AggregateResultWrapper(Decimal total, Decimal count, Id ParentId)
    	{
    		this.total = total;
    		this.count = count;
    		this.ParentId = ParentId;
    	}
    }
}
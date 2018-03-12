@isTest
private class CorrectiveItemsTriggerHandlerTest 
{
	//test method for insert record in Corrective_Item__c
    static testMethod void insertCorrectiveItemTestMethod()
    {   
        Integer extendedCost = 3; 
        Integer childSize= 3;
        Integer parentSize= 3;
        Set<Id> parentIdSet = insertUtility(extendedCost, childSize, parentSize, false);
        if(parentIdSet.size() > 0)
        {
            List<Building_Comp_Detail__c> buildingCompList = [SELECT Differed_Costs__c, No_of_Corrective_Items__c FROM Building_Comp_Detail__c WHERE Id IN :parentIdSet];
            for(Building_Comp_Detail__c buildingCompRecord : buildingCompList)
            {
                System.assertEquals(buildingCompRecord.Differed_Costs__c,  (extendedCost * childSize));
                System.assertEquals(buildingCompRecord.No_of_Corrective_Items__c,  childSize);
            }
        }
        
    }
    // test method for update record in Corrective_Item__c
    static testMethod void updateCorrectiveItemTestMethod() 
    {
        Integer extendedCost = 3; 
        Integer childSize= 3;
        Integer parentSize= 3;
        Set<Id> parentIdSet = insertUtility(extendedCost, childSize, parentSize, false);
        //when extended cost updated
        Integer updatedCost = 5;
        updateUtility(parentIdSet,updatedCost);
        AggregateResult[] groupResults = [SELECT SUM(Extended_Cost__c)total, Building_Comp_Detail__c  FROM Corrective_Item__c WHERE Building_Comp_Detail__c IN : parentIdSet Group By  Building_Comp_Detail__c];
        if(groupResults.size() > 0)
        {
            for(Integer index =0 ; index< groupResults.size() ; index++)
            {
                Decimal total = (Decimal)groupResults[index].get('total');
                System.assertEquals(total,(updatedCost * childSize)); 
            }
        }
        // when parent updated to null
        List<Corrective_Item__c> correctiveItemList = [SELECT Extended_Cost__c, Building_Comp_Detail__c  FROM Corrective_Item__c WHERE Building_Comp_Detail__c IN : parentIdSet];
        for(Corrective_Item__c correctiveItemRecord : correctiveItemList)
        {
             correctiveItemRecord.Building_Comp_Detail__c = null; 
        }
        if(correctiveItemList.size() > 0)
        {
            update correctiveItemList;
            AggregateResult[] groupResultsSecond = [SELECT SUM(Extended_Cost__c)total, Building_Comp_Detail__c  FROM Corrective_Item__c WHERE Building_Comp_Detail__c IN : parentIdSet Group By  Building_Comp_Detail__c];
        	system.assertEquals(groupResultsSecond.size(),0);
        }    
    }
    //test method for delete record
    static testMethod void deleteCorrectiveItemTestMethod()
    {
    	Integer extendedCost = 3; 
        Integer childSize= 1;
        Integer parentSize = 3;
        Set<Id> parentIdSet = insertUtility(extendedCost, childSize, parentSize, true); 
        system.debug('---------------------------------------------main--------------parent id inserted---------------------------------'+parentIdSet);
        List<Corrective_Item__c> correctiveItemList = new List<Corrective_Item__c>();
        Set<Id> correctiveParentIdSet = new Set<Id>();
        for(Corrective_Item__c correctiveItemRecord : [SELECT Building_Comp_Detail__c,Name  FROM Corrective_Item__c WHERE Building_Comp_Detail__c IN : parentIdSet])
        {
            boolean condition = correctiveParentIdSet.contains(correctiveItemRecord.Building_Comp_Detail__c);
            if(!condition)
            {
                correctiveItemList.add(correctiveItemRecord);
                correctiveParentIdSet.add(correctiveItemRecord.Building_Comp_Detail__c);
            }
        }
        if(correctiveItemList.size() > 0)
        {
        	List<Building_Comp_Detail__c> buildCompbeforeList = [SELECT Differed_Costs__c, No_of_Corrective_Items__c,Id From Building_Comp_Detail__c WHERE Id IN :correctiveParentIdSet];
        	system.debug('---------------------------------------------main--------------list to be deleted---------------------------------'+correctiveItemList);
            delete correctiveItemList;
            List<Building_Comp_Detail__c> buildCompAfterList = [SELECT Differed_Costs__c, No_of_Corrective_Items__c,Id From Building_Comp_Detail__c WHERE Id IN :correctiveParentIdSet];
            System.assertNotEquals(buildCompbeforeList,buildCompAfterList);
            System.assertEquals(3,buildCompAfterList.size());
        }
    }
    // test method for delete and undelete record in Corrective_Item__c
    static testMethod void deleteAndUndeleteCorrectiveItemTestMethod() 
    {
        Integer extendedCost = 3; 
        Integer childSize= 1;
        Integer parentSize = 3;
        Set<Id> parentIdSet = insertUtility(extendedCost, childSize, parentSize, false); 
        List<Corrective_Item__c> correctiveItemDeleteList = deleteUtility(parentIdSet, childSize, extendedCost);
 		
        List<Corrective_Item__c> correctiveItemUnDeleteList = [SELECT Id From Corrective_Item__c WHERE Id IN : correctiveItemDeleteList ALL ROWS];
        undelete correctiveItemUnDeleteList;
        System.assertEquals(correctiveItemDeleteList.size(), correctiveItemUnDeleteList.size());
        Set<Id> undeleteListParentIdSet= new Set<Id>();
        for(Corrective_Item__c correnctiveItemRecord : correctiveItemUnDeleteList)
        {
        	undeleteListParentIdSet.add(correnctiveItemRecord.Id);
        }
        AggregateResult[] groupResults = [SELECT SUM(Extended_Cost__c)total, COUNT(Extended_Cost__c)countno, Building_Comp_Detail__c  FROM Corrective_Item__c WHERE Building_Comp_Detail__c IN : undeleteListParentIdSet Group By  Building_Comp_Detail__c];
        if(groupResults.size() > 0)
        {
            for(Integer index =0 ; index< groupResults.size() ; index++)
            {
                Decimal total = (Decimal)groupResults[index].get('total');
                Decimal count = (Decimal)groupResults[index].get('countno');
                System.assertEquals((extendedCost * childSize),total);   
                System.assertEquals(childSize,count); 
            }
        }
    }
    // insert utility method to insert record in Corrective_Item__c
    private static Set<Id> insertUtility(Integer extendedCost, Integer childSize, Integer parentSize, boolean incrementChild)
    {  
        Set<Id> correctiveItemIdSet = new Set<Id>();
        List<Building_Comp_Detail__c> buildingCompList = new List<Building_Comp_Detail__c>();
        for(Integer index = 0 ; index < parentSize; index++)
            buildingCompList.add(new Building_Comp_Detail__c(Name= 'Test Parent'+index));
        if(buildingCompList.size() > 0)
        {
            insert buildingCompList;
            
            List<Corrective_Item__c> correctiveItemList = new List<Corrective_Item__c>();
            if(incrementChild)
            {
            	childSize = 0;  
            }
            for(Building_Comp_Detail__c buildingCompRecord : buildingCompList)
            {
            	if(incrementChild)
            	{
            		childSize++; 
            		system.debug('----------------------------childSize---------------------------------'+childSize);
            	}
                for(Integer index = 0 ; index< childSize ; index++)
                {
                    correctiveItemList.add(new Corrective_Item__c(Name = 'Test Item'+index , Building_Comp_Detail__c = buildingCompRecord.Id,Extended_Cost__c = extendedCost));
                }
            }
            if(correctiveItemList.size() > 0)
            {
                insert correctiveItemList;
                for(Integer index = 0 ; index< correctiveItemList.size() ; index++)
                {
                    Corrective_Item__c correctiveItemRecord = correctiveItemList.get(index);
                    correctiveItemIdSet.add(correctiveItemRecord.Building_Comp_Detail__c);
                }
            }
        }
        return correctiveItemIdSet;
    }
    //update utiltiy to update record in Corrective_Item__c
    private static void updateUtility(Set<Id> parentIdSet,Integer updatedCost) 
    {
        List<Corrective_Item__c> correctiveItemList = [SELECT Extended_Cost__c, Building_Comp_Detail__c  FROM Corrective_Item__c WHERE Building_Comp_Detail__c IN : parentIdSet];
        for(Corrective_Item__c correctiveItemRecord : correctiveItemList)
        {
             correctiveItemRecord.Extended_Cost__c = updatedCost; 
        }
        if(correctiveItemList.size() > 0)
        {
            update correctiveItemList;
            
        }
    }
    // delete utility to delete record in Corrective_Item__c
    private static List<Corrective_Item__c> deleteUtility(Set<Id> parentIdSet, Integer childSize, Integer extendedCost) 
    {
        List<Corrective_Item__c> correctiveItemList = new List<Corrective_Item__c>();
        Set<Id> correctiveParentIdSet = new Set<Id>();
        for(Corrective_Item__c correctiveItemRecord : [SELECT Building_Comp_Detail__c,Name  FROM Corrective_Item__c WHERE Building_Comp_Detail__c IN : parentIdSet])
        {
            boolean condition = correctiveParentIdSet.contains(correctiveItemRecord.Building_Comp_Detail__c);
            if(!condition)
            {
                correctiveItemList.add(correctiveItemRecord);
                correctiveParentIdSet.add(correctiveItemRecord.Building_Comp_Detail__c);
            }
        }
        if(correctiveItemList.size() > 0)
        {
            delete correctiveItemList;
            
            
            AggregateResult[] groupResults = [SELECT SUM(Extended_Cost__c)total, Building_Comp_Detail__c, COUNT(Extended_Cost__c)countno  FROM Corrective_Item__c WHERE Building_Comp_Detail__c IN : parentIdSet Group By  Building_Comp_Detail__c];
            if(groupResults.size() > 0)
            {
                childSize= childSize-1;
                for(Integer index =0 ; index< groupResults.size() ; index++)
                {
                    
                    Decimal total = (Decimal)groupResults[index].get('total');
                    Decimal count = (Decimal)groupResults[index].get('countno');
                    System.assertEquals(total,(extendedCost * childSize));
                    System.assertEquals(count, childSize);
                }
            } 
        }
        return correctiveItemList;
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
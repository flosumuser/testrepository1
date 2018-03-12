public with sharing class ProjectTriggerHandler 
{
	public void onUpdateProject(List<Project__c> projectNewList, Map<Id,Project__c> projectOldMap)
    {
    	for(Project__c projectRecord : projectNewList)
    	{
    		Id oldParentId = projectOldMap.get(projectRecord.Id).PEO_Project_Lead__c;
    		Id newParentId = projectRecord.PEO_Project_Lead__c;
    		if(oldParentId != newParentId && newParentId != null)
    			projectRecord.OwnerId =  newParentId;  
    	}
    }
}
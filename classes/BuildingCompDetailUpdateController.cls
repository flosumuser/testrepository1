public with sharing class BuildingCompDetailUpdateController 
{
	Building_Comp_Detail__c buildCompRecord;
	ApexPages.Standardcontroller sController;
	
	public BuildingCompDetailUpdateController(ApexPages.Standardcontroller controller)
	{
		sController =  controller;
		buildCompRecord = (Building_Comp_Detail__c)controller.getRecord();
	}
	public PageReference myUpdate()
	{
		PageReference pref = sController.save();
		return null; 
	}
}
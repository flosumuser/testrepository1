public with sharing class NewBuildCompDetailController 
{
	public Id spaceId{get; set;}
	public Building_Comp_Detail__c buildCompRecord{get; set;}
	public String buildingId{get; set;}
	public String systemCompDetailId{get; set;}
	ApexPages.Standardcontroller sController;
	public NewBuildCompDetailController(ApexPages.Standardcontroller controller)
	{
		spaceId = controller.getRecord().Id;
	    newRecordWithSpace();
	}
	public void newRecordWithSpace()
	{
		buildCompRecord = new Building_Comp_Detail__c(Space__c = spaceId);
	}
	public List<SelectOption> getBuildings()
	{
		List<SelectOption> options = new List<SelectOption>();
		options.add(new SelectOption('None','None'));
		for(Building__c buildRecord :[SELECT Id,Name FROM Building__c])
			options.add(new SelectOption(buildRecord.Id,buildRecord.Name));
		return options;
	}
	public List<SelectOption> getSystemComponentDetails()
	{
		List<SelectOption> options = new List<SelectOption>();
		options.add(new SelectOption('None','None'));
		for(System_Component_Details__c systemCompRecord :[SELECT Id,Name FROM System_Component_Details__c])
			options.add(new SelectOption(systemCompRecord.Id,systemCompRecord.Name));
		return options;
	}
	public PageReference recordSave()
	{
		if(buildingId!= 'None' && systemCompDetailId != 'None' && buildCompRecord.Name != null)
		{
			buildCompRecord.Building__c = buildingId;
			buildCompRecord.System_Component_Details__c = systemCompDetailId;
			insert buildCompRecord;
			return new PageReference('/'+buildCompRecord.Id);
		}
		else
			return null;
	}
	public PageReference recordCancel()
	{
		return new PageReference('/'+spaceId);
	}
}
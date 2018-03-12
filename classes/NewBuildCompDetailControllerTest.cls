@isTest
private class NewBuildCompDetailControllerTest 
{
    static testMethod void spaceRelatedBuildCompTest() 
    {
    	        
        Space__c spaceRecord = new Space__c(Name = 'Test Space');
        insert spaceRecord;
    	
    	NewBuildCompDetailController controller = new NewBuildCompDetailController(new ApexPages.StandardController(spaceRecord));
    	
    	Building__c newBuilding = new Building__c(Name='Test Building');
        insert newBuilding;
        
        System_Component_Details__c newsystemCompDetail = new System_Component_Details__c(name='Test System Component Detail');
        insert newsystemCompDetail;
        
        for(Selectoption option :controller.getBuildings())
        {
        	if(option.getValue() != 'None')
        		controller.buildingId = option.getValue(); 
        }
        for(Selectoption option : controller.getSystemComponentDetails())
        {
        	if(option.getValue() != 'None')
        		controller.systemCompDetailId = option.getValue();
        }
                
        if(controller.buildingId != null && controller.systemCompDetailId != null)
        {
        	controller.buildCompRecord.Name = 'Test BuidComp';
        	PageReference pref = controller.recordSave();
        	if(pref != null)
        	{
	        	Building_Comp_Detail__c buildCompRecord = [SELECT Id,Building__c, System_Component_Details__c FROM Building_Comp_Detail__c LIMIT 1];
	        	System.assertNotEquals(null,buildCompRecord);
	        	System.assertEquals(buildCompRecord.Building__c, controller.buildingId);
	        	System.assertEquals(buildCompRecord.System_Component_Details__c, controller.systemCompDetailId);
        	}
        }
        
    }
}
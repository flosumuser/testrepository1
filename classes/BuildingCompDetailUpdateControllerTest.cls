@isTest
private class BuildingCompDetailUpdateControllerTest 
{
    static testMethod void onBuildCompRecordUpdateTest() 
    {
        Building_Comp_Detail__c buildRecord = new Building_Comp_Detail__c(Name =  'Test', Criticality_Factor__c= 2);
        insert buildRecord;
        Id recordId = buildRecord.Id;
        Decimal criticalFactorBefore = buildRecord.Criticality_Factor__c;
        Test.startTest();
        Test.setCurrentPage(Page.BuildingCompDetailsUpdatePage);
         
        Decimal criticalFactorAfter = 3;
        buildRecord.Criticality_Factor__c =criticalFactorBefore;
        BuildingCompDetailUpdateController controller = new BuildingCompDetailUpdateController(new ApexPages.StandardController(buildRecord));
        controller.myUpdate();
        for(Building_Comp_Detail__c bCompRecord : [SELECT Id, Criticality_Factor__c FROM Building_Comp_Detail__c WHERE Id = :recordId])
        {
        	System.assertEquals(recordId, bCompRecord.Id);
        	System.assertNotEquals(criticalFactorAfter, bCompRecord.Criticality_Factor__c);
        }  
        Test.stopTest(); 
    }  
}
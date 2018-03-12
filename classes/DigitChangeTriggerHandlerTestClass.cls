/**

 */
@isTest
private class DigitChangeTriggerHandlerTestClass {
    
    
    static testMethod void myUnitTest() {
     ClassNew__c cls=new ClassNew__c(TotalStudent__c=2,phoneNumber__c='1234567890',TextChangeValue__c='shailu19-20ti12-13');
     
     
     Test.startTest();
     insert cls;
     
     cls.TotalStudent__c=4;
     cls.phoneNumber__c='124323432';
     cls.TextChangeValue__c='shailu34-20ti34-13';
     update cls;
     Test.stopTest();
    }
}
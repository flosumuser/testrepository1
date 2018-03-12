@isTest
public class popupTestClass{

   static testMethod void popUp(){
   
   Test.startTest();
   popup p=new popup();
  
   SingleRequestMock fakeResponse = new SingleRequestMock(200, 'Complete', '[{"Name": "AccessToken"}]',null);
   Test.setMock(HttpCalloutMock.class, fakeResponse);
   
   p.accList=[Select AccessToken__c FROM  nativeCustomSetting__c limit 1];
   System.assertNotEquals(p.accList.size(),1);
   update p.accList;
 
   p.AccessToken();
  
  Test.stopTest();
 }
 
}
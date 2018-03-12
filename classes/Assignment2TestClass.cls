@isTest
public class Assignment2TestClass{

  static testMethod void validateAccount(){
       Account account=new Account();
       User user = [select id from User where id = :userInfo.getUserId()];
       account.Owner=user;
       account.Name='Test Class';
       account.accountNumber='78544554';
       account.Fax='512757-9000';
       account.Industry='Electronics';
       account.Rating='Hot';
       account.NumberofLocations__c=4;
       account.CriticalData__c=true;
       
       insert account;
       
   //After creting the data for test class then start 
   Test.startTest();
   
     
   //End your unit test by using
   Test.stopTest();
   
  }
 
}
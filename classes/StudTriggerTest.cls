@isTest
public class StudTriggerTest
{
     public static testMethod void studentRecord()
     {
         Student__c student=new Student__c();
         Class__c classObj=new Class__c();
         student.Name='TestStudent';
         student.CurrentAddress__c='The Rajasthan state';
         student.Class__c=classObj.Id;   
         insert student;
     }
     
}
@isTest
public class StudentTestCase 
{
     
    public static testMethod void myTestUnit()
     {
      ClassNew__c classBca=new ClassNew__c();
      classBca.Name='BCA';
      insert classBca;
      
      StudentNew__c studentFirst=new StudentNew__c();
      studentFirst.Name='TestStudentFirst';
      studentFirst.age__c=21;
      studentFirst.currentAddress__c='Rajasthan';
      studentFirst.DOB__c='July25,1990';
      studentFirst.ClassNewLookup__c=classBca.Id;
      insert studentFirst;
      
      List<ClassNew__c> classBcaList=[select TotalStudent__c from ClassNew__c where Id=:classBca.Id];
      System.AssertEquals(classBcaList.get(0).TotalStudent__c ,1);
      
      delete studentFirst;
      classBcaList=[select TotalStudent__c from ClassNew__c where Id=:classBca.Id];
      System.AssertEquals(classBcaList.get(0).TotalStudent__c,0);
      
      StudentNew__c studentSecond=new StudentNew__c();
      studentSecond.Name='TestSecondStudent';
      studentSecond.age__c=20;
      studentSecond.currentAddress__c='Gujrat';
      studentSecond.ClassNewLookup__c=classBca.Id;
      insert studentSecond;
      
      ClassNew__c classMca=new ClassNew__c();
      classMca.Name='MCA';
      insert classMca;
      
      studentSecond.ClassNewLookup__c=classMca.Id;
      update studentSecond;
      
      classBcaList=[select TotalStudent__c from ClassNew__c where Id=:classBca.Id];
      List<ClassNew__c> classMcaList=[select TotalStudent__c from ClassNew__c where Id=:classMca.Id];
      
      System.AssertEquals(classBcaList.get(0).TotalStudent__c ,0);
      System.AssertEquals(classMcaList.get(0).TotalStudent__c ,1);
      
      
      
          
     }    
}
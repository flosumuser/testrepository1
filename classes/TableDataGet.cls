global with sharing class TableDataGet
{

List<Student__c> students;

public List<Student__c> getStudents() 
        {
            if(students == null)
            students= [select Name,Class__c,CurrentAddress__c,Email_ID__c,Mobile_No__c FROM Student__c];
            return students;
        }


}
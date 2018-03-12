public class SchoolController
{
 
  Class__c classObj;
  
  public SchoolController()
  {
     classObj = new Class__c();
  }
  
  public Class__c getclassRecord()
  {
     return classObj;
  }
  
  public void setclassRecord(Class__c classobj)
  {
    this.classObj=classObj;
  }
  


}
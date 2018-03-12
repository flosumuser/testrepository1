public class StudentRecord
{
String message=null;
  Student__c student;
  
  public StudentRecord(){
      student = new student__c();
  }
  
  public Student__c getStudent()
  {
     return student;
  }
  
  public void setStudent(Student__c student)
  {
    this.student=student;
  }
  
   public String getMessage()
  {
     return message;
  }
  
  public void setMessage(String Message)
  {
    this.message=Message;
  }
  
  
  
  public void showRecord()
  {
     insert student;
     message='Data is successfully inserted.............';
     
 
  }
  
  public void deleteRecord(String name)
  {
  if(student.Name.equals(name))
  {
  //Student__c stud;
  
  //Stud=[delete from Student__c where Student__c.Name =:'name']
    message='Data is successfully Deleted.............';
  }
    message='invalid name Tru Again.............';
     
     
  }
  
   public void updateRecord()
  {
     update student;
     message='Data is successfully updated.............';
     
 
  }
  
 

}
public with sharing class QuickController
{
  public String schoolRecord {get ; set;}
  public List<SchoolNew__c> giveItems;
  public String classRecord {get; set;}
  public List<ClassNew__c> takeItems;
  public List<StudentNew__c> studentNewData;
  public String dropDownClassValue {get ; set;}
  public List<StudentNew__c> studentList;
  public List<wrapperClass> wrapperList;
  public List<StudentNew__c> studentdeleteList;
  public String enteredText1 {get; set;}
  public String studentEditId {get; set;} 
  public StudentNew__c studentEdit{get; set;}
  public String detailValue {get; set;}
  public StudentNew__c studentEditObj{get; set;}
  public String studentDeleteId {get; set;}
  public List<StudentNew__c> studentDelete {get; set;}
  public StudentNew__c studentEdited {get; set;} 
  public String studentEditIdValue {get; set;}
  public StudentNew__c studentUpdateRecord {get; set;}
  public String studentColorBoxId {get; set;}
  public StudentNew__c studentColorBoxRecord {get; set;} 
  public String ColorBoxId {get; set;}
  public String ColorBoxName {get; set;}  
  public QuickController(){
     giveItems =new List<SchoolNew__c>();
     giveItems=[Select Name from SchoolNew__c];
     takeItems =new List<ClassNew__c>();
     studentColorBoxRecord=new StudentNew__c();
  } 
  public void studentEditRecordValue(){
    studentEdited=[select age__c,Name,currentAddress__c,DOB__c,Id from StudentNew__c where Id=:studentEditIdValue];
    system.debug('studentEdited>>>>>'+studentEdited);
    system.debug('Student Name >>>>>>>>>>>>>>>>>>------'+studentEdited.Name);
  }
  public void updateStudentColorBox(){
    
  }
  
  public void updateStudentDataColorBoxFunction(){
    studentColorBoxRecord.Id=ApexPages.currentPage().getParameters().get('forthParam');
    studentColorBoxRecord.Name=ApexPages.currentPage().getParameters().get('nameBoxName');
    studentColorBoxRecord.age__c=Decimal.valueOf(ApexPages.currentPage().getParameters().get('AgeBox'));
    studentColorBoxRecord.currentAddress__c=ApexPages.currentPage().getParameters().get('AddressBox');
    studentColorBoxRecord.DOB__c=ApexPages.currentPage().getParameters().get('DOBBox');
    system.debug('+++++++++:'+studentColorBoxRecord.Name+'student Age - : ' +studentEdited.age__c);
    system.debug('I m calling updateDataColorBox......>>><<<..............Name>>>>'+ApexPages.currentPage().getParameters().get('nameBoxName')+' Age '+ApexPages.currentPage().getParameters().get('AgeBox')+' Address '+ApexPages.currentPage().getParameters().get('AddressBox')+'DOB'+ApexPages.currentPage().getParameters().get('DOBBox'));
    system.debug('>>>>>>>> colorbox value-----'+ApexPages.currentPage().getParameters().get('forthParam'));
    Boolean flag=false;
        try{
            if(studentColorBoxRecord.Name == null || studentColorBoxRecord.Name==''){
                  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Fill Name Value......'));
                  flag=true;
                }
                System.debug('Age Value>>>>>>>>>>>>>>>>>>>>>>'+studentColorBoxRecord.age__c);
                if(studentColorBoxRecord.age__c== null){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Fill Age Value......'));
                    flag=true;
                }
                if(studentColorBoxRecord.currentAddress__c==null || studentColorBoxRecord.currentAddress__c==''){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Fill CurrentAddress Value......'));
                    flag=true;
                }
                if(studentColorBoxRecord.DOB__c==null || studentColorBoxRecord.DOB__c==''){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Fill DOB Value......'));
                    flag=true;
                }
        }catch (DmlException e) {   
              ApexPages.addMessages(e);
              
       }
       
       if(flag==true){
             System.debug('Data donot Updated..........Error Shows');
       }
       else
       {
           update studentColorBoxRecord;
           //PageReference pageRef = new PageReference('https://c.na15.visual.force.com/apex/SchoolQuick_Page');
           //pageRef.setRedirect(true);
           //System.debug('>>>>>>>>>>>I m in PageReferece Call.....'+pageRef);
           //return pageRef;
        }
    }
  public void cancelDataColorBox()
  {
     system.debug('I m calling cancelDataColorBox..............');
  }
  
  public void dropDownChangeValue(){
        if(schoolRecord!=null){
            takeItems=[Select SchoolNewLookup__c,Name,TotalStudent__c FROM ClassNew__c where ClassNew__c.SchoolNewLookup__c=:schoolRecord];
            for(ClassNew__c classNew : takeItems)
            {
              System.debug('Class name ----------- '+classNew.Name);
            }
        }
  }
  
  public void dropDownClassValue(){
  }
  
    public List<SelectOption> getGiveItems(){
            List<SelectOption> selectedValue = new List<SelectOption>();
            selectedValue .add(new SelectOption('None','None'));
        for(SchoolNew__c schoolNew : giveItems){
                selectedValue.add(new SelectOption(schoolNew.ID,schoolNew.Name));
        }
    return selectedValue ;
 }
  public List<SelectOption> getTakeItems(){
       List<SelectOption> takeValue=new List<SelectOption>();
       takeValue.add(new SelectOption('None','None'));
       for(ClassNew__c classNew : takeItems)
       {
         takeValue.add(new SelectOption(classNew.ID,classNew.Name));
       }
  return takeValue;

}
  public List<wrapperClass> getStudentNewData(){
       wrapperList=new List<wrapperClass>();
       if(classRecord!=null){
            studentList = [select age__c,Name,currentAddress__c,DOB__c,Id from StudentNew__c where StudentNew__c.ClassNewLookup__c = :classRecord];
            for(StudentNew__c  st : studentList){
              wrapperList.add(new wrapperClass(st));
            }   
       }
    return wrapperList;
   }
    
    // Wrapper class codes
    
    public class wrapperClass{
      public boolean selected {get; set;}
      public StudentNew__c studentNew {get ; set;}
      public wrapperClass(StudentNew__c stud){
           this.studentNew=stud;
           this.selected=false;  
      } 
    }
    public void deleteStudentRecordData(){
        System.debug('delete fucntion is calling in That studentDelete ID----0000--->>>>>>'+studentDeleteId+'  '+ApexPages.currentPage().getParameters().get('thirdParam'));
        studentDelete=new List<StudentNew__c>();
        studentDelete=[select age__c,Name,currentAddress__c,DOB__c,Id from StudentNew__c where Id = : ApexPages.currentPage().getParameters().get('thirdParam')];
        try
        {
             if(studentDelete != null){
                delete studentDelete;
                }
        }catch (DmlException e){   
              System.debug(e.getMessage());
       }
        
      
  }
  
  public void deleteStudentData(){
  
  studentdeleteList=new List<StudentNew__c>();
      for(WrapperClass del : wrapperList){
           if(del.selected==true){
               studentdeleteList.add(del.studentNew);
         }
      }
    for(StudentNew__c stud:studentdeleteList){
        delete stud;
    }
  }
   public PageReference studentEditRecord(){
    
       System.debug('The Student Edit Record id >>>>>-------- '+studentEditId+' '+ ApexPages.currentPage().getParameters().get('firstParam'));
       PageReference pageRf = new PageReference('https://c.na15.visual.force.com/apex/DetailShowPage');
      try{
            pageRf.getParameters().put('studEditId',  ApexPages.currentPage().getParameters().get('firstParam'));
            pageRf.getParameters().put('isEditPage' ,'EditWorkCall');
            pageRf.setRedirect(true); 
        }catch (DmlException e){   
              System.debug(e.getMessage());
       }
     return pageRf;
   }
   
   public void saveRecord(){
      update studentEdit;    
   }
   
   public PageReference showDetailRefPage(){
     System.debug('The showDetailPage->>>----------------------'+detailValue+' SecondParam '+ ApexPages.currentPage().getParameters().get('secondParam'));
     
      PageReference pageRef = new PageReference('https://c.na15.visual.force.com/apex/DetailShowPage');
      try{
            pageRef.getParameters().put('studentId', detailValue);
            pageRef.getParameters().put('isShowPage', 'ShowWorkCall');
            pageRef.setRedirect(true); 
        }catch (DmlException e){   
              System.debug(e.getMessage());
       }
     return pageRef; 
    }
}
@isTest
public class nativeControllerTestClass{

  static testMethod void validateAccount(){
  Account acc=new Account();
  acc.Name='Test Name';
  acc.phone='8290029918';
  acc.fax='869569856';
  acc.Sic='856';
  acc.Industry='BMA';
  acc.Email__c='Shailendra@gmail.com';
   insert acc;

  //After creting the data for test class then start 
   Test.startTest();
   nativeController nCon=new nativeController();
   nCon.message='select fields';
   nCon.AllObjects();
   nCon.getFieldsName();
   nCon.sObjectName ='Account';
   nCon.ItemFieldsName();
   System.assertEquals(nCon.sObjectName,'Account');
   List<String> fld=new List<String>();
   fld.add('Name');
   fld.add('Phone');
   fld.add('fax');
   nCon.getfield=fld;
   nCon.recordShowData();
   
   nCon.UncheckBox();
   nCon.pagination();
   nCon.beginning();
   nCon.previous();
   nCon.next();
   nCon.end();
   nCon.getprev();
   nCon.getnxt();
   nCon.PageValue();
   nCon.totalNumberOfPage=5+'';
   nCon.PageNumber();
   nCon.FileNameOption();
   List<String> fileN=new List<String>();
   fileN.add('PDF');
   boolean sel=true;
   List<String> s=new List<String>();
   s.add('name');
   s.add('phone');
   nCon.Edit();
   nCon.del();
   List<sObject> sobj=new List<sObject>();
   sobj.add(acc);
   nCon.recordfileshow=sobj;
   nCon.exportFile();
   nCon.FileDescribeAction();
   nCon.updateDataFunction();
   nativeCustomSetting__c  custom=new nativeCustomSetting__c(AccessToken__c='Access Token',name='access token name');
   insert custom;
   nCon.getchkValue();
   nCon.accCustomSet=[Select AccessToken__c FROM  nativeCustomSetting__c limit 1];
   nCon.Drvfile=Blob.valueOf('fileRecords');
   nCon.Drvfiletype='text/csv';
   nCon.recordsFiles='.pdf';
   nCon.Drvfilename='PDF';
   nCon.fileNameValue='.csv';
   nCon.recordsFiles=null;
   system.assertEquals(nCon.fileNameValue,'.csv');
   nCon.fileNameValue='.pdf';
    
   nCon.fileNameValue='.xls';
    system.assertEquals(nCon.fileNameValue,'.xls');
   
   nCon.uploadGoogleDrive();
   
   //End your unit test by using
     Test.stopTest();
   
  }
 
}
@isTest
private class useInLineControllerTestClass {
     
    static testMethod void myUnitTest() {
        ApexPages.StandardController controller;
         
        Account acc=new Account(name='Acct1');
        insert acc;
        RecordType typ=new RecordType(name='PGT');
        Contact con=new Contact(accountid=acc.Id,RecordTypeid=typ.Id);
        
        ApexPages.currentPage().getParameters().put('qp', 'yyyy');
        useInlineController testcl=new useInlineController(controller);
        
       
       
        Id recordId=con.Id;
    }
}
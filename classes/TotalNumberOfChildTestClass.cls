/**

 */
@isTest
private class TotalNumberOfChildTestClass {
   
    static testMethod void myUnitTest() {
             //It's use for account insert with parentId So we use
             List<Account> accList=new List<Account>();
             Account a=new Account();
             a.TotalNumberOfChild__c=1;
             a.name='Hello';
             a.TotalNumberOfChild__c=null;
             //for Record insert of Account type
             insert a;
             
             Account accDel=new Account();
             accDel.TotalNumberOfChild__c=1;
             accDel.ParentID= a.Id;
             accDel.name='Vicky';
             accDel.TotalNumberOfChild__c=1;
             accList.add(accDel);  
            //for Record insert of Account type with parentId
            insert accList;
           
             //System.assertEquals(a.TotalNumberOfChild__c,null);
            //work on Account Record update
            update accList;
            //Account type of totalchild account not equal null
           //
            //work on Account Record delete
            delete a;
            //work on account record undelete
            undelete a ;
        
    }
}
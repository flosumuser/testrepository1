@isTest
private class JQueryPageTestClass {
    
    static testMethod void myUnitTest() {
      
      Account acc=new Account();
      acc.name='ramkishan';
      acc.phone='829025918';
      insert acc;
      //gd=Schema.getGlobalDescribe().Values();
      Test.startTest();
     
      JqueryController jqueryObj=new JqueryController();
      jqueryObj.AllObjects();
      jqueryObj.fieldsName.add(acc.name);
      jqueryObj.fieldsName.add(acc.phone);
    
      jqueryObj.actionObjectName();
      System.debug('------------jqueryObj.ObjectNameVal------1'+jqueryObj.ObjectNameVal);
      jqueryObj.ObjectNameVal='Account';
      system.assertNotEquals(jqueryObj.ObjectNameVal,null);
       System.debug('------------jqueryObj.ObjectNameVal------2'+jqueryObj.ObjectNameVal);
      jqueryObj.getfields=Schema.getGlobalDescribe().get('Account').getDescribe().Fields.getMap();
     
      System.debug('------------jqueryObj.ObjectNameVal'+jqueryObj.ObjectNameVal);
     
      jqueryObj.firstField=null;
      system.assertEquals(jqueryObj.firstField,null);
      jqueryObj.firstField='Name';
      jqueryObj.showRecord();
      list<String> l=new list<String>();
      l.add('name');
      jqueryObj.fieldsName=l;
      jqueryObj.actionFunctionVal(); 
      jqueryObj.val='name';
      system.assertNotEquals(jqueryObj.val,'phone');
      jqueryObj.DragTableFunctionValue();
      jqueryObj.DropableTableFunctionValue();
      String soqlquery='select name from Account';
      jqueryObj.queryDataSObj=Database.query(soqlquery);
      System.debug('------------jqueryObj.queryDataSObj---------'+jqueryObj.queryDataSObj);
      system.assertNotEquals(jqueryObj.queryDataSObj,null);
      
      Test.stopTest();
    }
}
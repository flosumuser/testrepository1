@isTest
private class CloneControllerTest 
{
    static testMethod void testClone() 
    {
    	Account ac= new Account(Name='Test Name');
    	insert ac;
    	Id accountId = ac.Id;
    	Contact c = new Contact(LastName = 'Contact LastName',AccountId = accountId);
        insert c;
        CloneController controller = new CloneController(new ApexPages.StandardController(ac));
        
        controller.getCreateClone();
        
        controller.saveClone();
        List<Account> acountList = [SELECT Id  From Account LIMIT 5];
        system.assertEquals(acountList.size(),2);
        
        List<contact> contactList = [SELECT Id From Contact LIMIT 5] ;
        system.assertEquals(1, contactList.size());
        
        List<contact> contList = [SELECT Id From Contact WHERE AccountId = :controller.newId LIMIT 5] ;
        system.assertEquals(1, contList.size());
        
    }
}
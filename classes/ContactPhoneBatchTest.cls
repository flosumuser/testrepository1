@isTest
private class ContactPhoneBatchTest 
{
    static testMethod void testUpdatePhone() 
    {
    	List<Contact> conList = new List<Contact>();
        conList.add(new Contact(LastName='Test1',Phone='1234567890'));
        conList.add(new Contact(LastName='Test2',Phone='1234599890'));
        conList.add(new Contact(LastName='Test3',Phone='1232567890'));
        insert conList;
        
        Test.startTest();
        
        ContactPhoneBatch ba = new ContactPhoneBatch();
        Database.executeBatch(ba);
        
        Test.stopTest();
        
        for(Contact con : [SELECT Phone FROM Contact WHERE Phone != null])
        {
        	String ph_no = con.Phone;
	    	    
	    	system.assertEquals(ph_no.length(), 13);
	    	system.assertEquals(0,ph_no.indexOf('('));
	    	system.assertEquals(4,ph_no.indexOf(')'));
	    	system.assertEquals(8,ph_no.indexOf('-'));

        }

    }
}
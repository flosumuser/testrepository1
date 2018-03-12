public with sharing class ContactUpdateBatch implements Database.batchable<sobject>
{
    private String query = 'SELECT Id, MobilePhone,ContactId, Phone FROM User';
 
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<User> scope)
    {
    	map<Id,User> contactIdUserMap = new map<Id,User>();
    	for(User use : scope)
    	{
    		if(use.ContactId != null && use.Phone != null && use.MobilePhone != null)
    			contactIdUserMap.put(use.ContactId,use); 
    	}
    	if(contactIdUserMap.size() > 0)
    	{
    		List<Contact> conList = new List<Contact>();
    		conList = [SELECT Id, MobilePhone, Phone FROM Contact WHERE Id IN : contactIdUserMap.keyset()];
    		if(conList.size() > 0 )
    		{
    			for(Contact con : conList)
    			{
    				User use = contactIdUserMap.get(con.Id);
    				con.MobilePhone = use.MobilePhone;
    				con.Phone = use.Phone;
    			}
    			update conList;
    		}
    	}
    }
    public void finish(Database.BatchableContext BC)
    {      
	}
}
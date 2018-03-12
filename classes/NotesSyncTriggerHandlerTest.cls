@isTest
private class NotesSyncTriggerHandlerTest 
{
	static List<Contact_Attachment_Sync__c> contactAttachmentRecordList = new List<Contact_Attachment_Sync__c>();
	// insert with null fields
    static testMethod void insertWithNullFields() 
    {
    	// insert without contact lookup and without Note
        for(Integer i = 0; i < 3 ; i++)
        {
        	contactAttachmentRecordList.add(new Contact_Attachment_Sync__c());
        } 
        if(contactAttachmentRecordList.size() > 0)
        {
	        insert contactAttachmentRecordList;
	        for(Integer i = 0; i < contactAttachmentRecordList.size() ; i++)
		    {
		    	System.assertEquals(contactAttachmentRecordList.get(i).Contact__c , null);
		    	System.assertEquals(contactAttachmentRecordList.get(i).Notes__c , null);
		    }
	        contactAttachmentRecordList.clear();
        }
    	// insert without contact lookup
        for(Integer i = 0; i < 3 ; i++)
        {
        	contactAttachmentRecordList.add(new Contact_Attachment_Sync__c(Notes__c= 'Hi Hello'));
        } 
        if(contactAttachmentRecordList.size() > 0)
        {
	        insert contactAttachmentRecordList;
	        for(Integer i = 0; i < contactAttachmentRecordList.size() ; i++)
		    {
		    	System.assertEquals(contactAttachmentRecordList.get(i).Contact__c , null); 
		    }
	        contactAttachmentRecordList.clear();
        }
    }	
    // insert with contact lookup and Note
	static testMethod void insertWtihParentAndNote() 
    {	
		// create new contact records for lookup 
        List<Contact> contactList = new List<Contact>();
        for(Integer i = 0; i < 3 ; i++)
        {
        	Contact cont = new Contact(LastName = 'Kumar'+i);
        	contactList.add(cont);
        }
        // insert with contact lookup and Note
		if(contactList.size() > 0)
		{
			insert contactList;
			List<Id> contactIdList = new List<Id>();
			String noteBody = 'Hi Hello';
	        for(Integer i = 0; i < contactList.size() ; i++)
	        {
	        	Id contactId = contactList.get(i).Id;
	        	contactIdList.add(contactId);
	        	contactAttachmentRecordList.add(new Contact_Attachment_Sync__c(Contact__c = contactId, Notes__c= noteBody));
	        }
	        if(contactAttachmentRecordList.size() > 0) 
	        {
		        insert contactAttachmentRecordList;
		        List<Id> recordIdList = new List<Id>();
		        for(Integer i = 0; i < contactAttachmentRecordList.size() ; i++)
		        	recordIdList.add(contactAttachmentRecordList.get(i).Id);
		        	
		        List<Note> newlyCreatedNotes = [SELECT Body, ParentId, Title FROM Note WHERE ParentId IN : contactIdList];
		        
		        System.assertEquals(newlyCreatedNotes.size() , contactAttachmentRecordList.size());
		        if(newlyCreatedNotes.size() == contactAttachmentRecordList.size()) 
		        {
			        for(Integer i = 0; i < contactAttachmentRecordList.size() ; i++)
			        {
			        	System.assertEquals(newlyCreatedNotes.get(i).Body, noteBody );
			        }
		        }
		        contactAttachmentRecordList.clear();
	        }
		}
    }
}
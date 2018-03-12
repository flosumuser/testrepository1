public with sharing class NotesSyncTriggerHandler 
{
	// method to sync note on contacts on insert record in Contact_Attachment_Sync__c
	// use in NoteSyncTrigger
	public void insertRecordSynchNote(List<Contact_Attachment_Sync__c> triggerNewList)
	{
		Map<Id,String> parentIdNoteStringMap = new Map<Id,String>();
		Map<Id,String> parentIdMap = new Map<Id,String>();
		for (Contact_Attachment_Sync__c cascRecord : triggerNewList)
		{
			Id recordId = cascRecord.Id;
			Id parentContactId = cascRecord.Contact__c;
			String noteString = cascRecord.Notes__c; 
			String recordName = cascRecord.Name;
 
			if(parentContactId != null && noteString != null && noteString.trim().length() > 0)
			{
				System.debug('::::::::::::::::::::::::::::::::::::in if Statement::::::::::::::::::::::::::'); 
				parentIdNoteStringMap.put(parentContactId , noteString);
				parentIdMap.put(parentContactId,recordName);
			}
	
		}
		if(parentIdNoteStringMap.size() > 0)
		{
			List<Note> contactNotesList = new List<Note>();
			for(Id parentContactId : parentIdNoteStringMap.keyset())
			{
				String noteString = parentIdNoteStringMap.get(parentContactId); 
				String recordName = parentIdMap.get(parentContactId);
				if(recordName != null)
					contactNotesList.add(new Note(Body = noteString , ParentId = parentContactId , Title = recordName));
			}
			if(contactNotesList.size() > 0)
				insert contactNotesList;
		}
	}
}
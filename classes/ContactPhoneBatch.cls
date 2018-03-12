public with sharing class ContactPhoneBatch implements Database.Batchable<sObject>
{
	private String LEFT_BRACKET ='(';
	private String RIGHT_BRACKET = ')';
	private String FINAL_STRING = '-';
	public Database.QueryLocator start(Database.BatchableContext BC)  
	{
    	return Database.getQueryLocator('SELECT Phone FROM Contact WHERE Phone != null');
    }
    public void execute(Database.BatchableContext BC, List<Contact> scope)
    {
    	List<Contact> listToUpdate = new List<Contact>();
	    for(Contact con : scope)
	    {
	    	String ph_no = con.Phone;
	    	if(ph_no.isNumeric())     
	    	{
	    		if(ph_no.length() == 10)
	    		{
	    			con.Phone = LEFT_BRACKET + ph_no.substring(0,3)+  RIGHT_BRACKET  +ph_no.substring(3,6)+  FINAL_STRING  +ph_no.substring(6);
	    			listToUpdate.add(con);
	    		}
	    	}	     	
	    }
	    if(listToUpdate.size() > 0)
	    	update listToUpdate;
    }
    public void finish(Database.BatchableContext BC){} 
}
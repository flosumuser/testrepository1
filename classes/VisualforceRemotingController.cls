public with sharing class VisualforceRemotingController 
{
	public VisualforceRemotingController()
	{
		
	}
	
	@RemoteAction
	public static List<Account> showRecord()
	{
		List<Account> li = new List<Account>();
		li = [SELECT Id,Name From Account LIMIT 10];
		
		return li;
	}
}
@isTest
private class ProjectTriggerHandlerTest 
{

    static testMethod void updateProjectTest() 
    {
        List<Project__c> projectRecordList = new List<Project__c>();
        	projectRecordList.add(new Project__c(Name = 'Test Project', PEO_Project_Lead__c = UserInfo.getUserId()));
        if(projectRecordList.size() > 0)
        {
        	insert projectRecordList;
        	Id userId = createUser();
        	for(Project__c projectRecord : projectRecordList)
        	{
        		projectRecord.PEO_Project_Lead__c = userId;
        	}
        	update projectRecordList;
        }
    }
    private static Id createUser()
    {
		User mike = new User();
		mike.Username= 'mike.white_test@company.com';
		mike.Email = 'mike.white@company.com';
		mike.Lastname = 'mike';
		mike.Firstname = 'white';
		mike.Alias = 'mwhite';
		mike.DefaultGroupNotificationFrequency = 'N';
		mike.CommunityNickname = 'mwhite01';
		mike.ProfileId = [ select id from profile where name = 'System Administrator' Limit 1 ].Id;
		mike.TimeZoneSidKey = 'GMT';
		mike.LocaleSidKey = 'en_US';
		mike.EmailEncodingKey = 'UTF-8';
		mike.LanguageLocaleKey = 'en_US';
		mike.UserPermissionsMobileUser = false;
		mike.UserPermissionsMarketingUser = false;
		mike.UserPermissionsOfflineUser = false;
		insert mike;
		return mike.Id;
    }
}
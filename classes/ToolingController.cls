public with sharing class ToolingController 
{
	public String metaType{get;set;}
	public List<SelectOption> metTypeList{get;set;}
	public String itemName{get;set;}
	public String Content{get;set;}
	public String body{get;set;}
	
	private String session;
	private String instance;
	
	public static final Set<String> metaDataTypeFilterSet = new Set<String>{'ApexClass',
                                                                            'ApexComponent',
                                                                            'ApexPage',
                                                                            'ApexTrigger',
                                                                            'AppMenu',
                                                                            'ApprovalProcess',
                                                                            'AssignmentRule',
                                                                            'AutoResponseRules',
                                                                            'CompactLayout',
                                                                            'CustomApplication',
                                                                            'CustomApplicationComponent',
                                                                            'CustomField',
                                                                            'CustomLabel',
                                                                            'CustomObject',
                                                                            'CustomPageWebLink',
                                                                            'CustomTab',
                                                                            'Dashboard',
        																	'Document',
        																	'DocumentFolder',
                                                                            'EmailTemplate',
                                                                            'FlexiPage',
                                                                            'FieldSet',
        																	'Folder',
        																	'Group',
                                                                            'HomePageComponent',
                                                                            'HomePageLayout',
                                                                            'Layout',
                                                                            'ListView',
                                                                            'PermissionSet',
                                                                            'Picklist',
                                                                            'Profile',
                                                                            'Queue',
                                                                            'RecordType',
                                                                            'RemoteSiteSetting',
                                                                            'Report',
                                                                            'ReportType',
                                                                            'Role',
                                                                            'SearchLayouts',
                                                                            'StaticResource',
                                                                            'ValidationRule',
                                                                            'WebLink',
                                                                            'Workflow',
                                                                            'ActionOverride',
                                                                            'BaseSharingRule',
                                                                            'CriteriaBasedSharingRule',
                                                                            'CustomPermission'};
		
	public ToolingController()
	{
		metTypeList = new List<SelectOption>();
		metTypeList.add(new SelectOption('','--None--'));
		for(String type : metaDataTypeFilterSet)
		{
			metTypeList.add(new SelectOption(type,type));
		}
		metTypeList.sort();
		session= UserInfo.getSessionId();
		instance = Url.getSalesforceBaseUrl().toExternalForm();
	}
	
	public void retrieveMetaItem()
	{
		if(this.metaType != null && this.itemName != null)
		{
			String query = 'select Id from '+String.escapeSingleQuotes(this.metaType)+' where Name =\''+String.escapeSingleQuotes(this.itemName)+'\' LIMIT 1';
			List<sObject> csList =Database.query(query);
	        if(csList.size() == 1)
	        {
				String endpoint = instance + '/services/data/v28.0/tooling/sobjects';
				Http h = new Http();
				
			    // create a Http request with get method
			    HttpRequest req = new HttpRequest();
			    req.setMethod('GET');
			    req.setEndpoint(endpoint+'/'+this.metaType+'/'+csList[0].Id);
			    //req.setBody( '{"Name":"NewApexClass1","Body":"public class NewApexClass1 {}"}');
			    // send request and receive response
			    System.debug('Session--------:'+session);
				System.debug('endpoing-----:'+req.getEndpoint());
				
			    req.setHeader('Authorization', 'Bearer ' + session);
				//req.setHeader('Content-Type', 'application/json');
			    HttpResponse response = h.send(req);
			    //Map<String,Object> rmp = (Map<String,Object>)JSON.deserializeuntyped(response.getBody());
			    //content = (String)rmp.get('Body');
			    content = response.getBody();
			    System.Debug('content---------:'+content);
	        }
		}
		else
		{
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Fill all field.'));
		}
	}
	
	public void createMetaItem()
	{
		if(this.metaType != null && this.body != null)
		{
			String endpoint = instance + '/services/data/v28.0/tooling/sobjects';
			Http h = new Http();
			
		    // create a Http request with get method
		    HttpRequest req = new HttpRequest();
		    req.setMethod('POST');
		    req.setEndpoint(endpoint+'/'+this.metaType);
		    req.setBody( '{"Name":"NewApexClass1","Body":"'+body+'"}');
		    // send request and receive response
		    System.debug('Session--------:'+session);
			System.debug('endpoing-----:'+req.getEndpoint());
			
		    req.setHeader('Authorization', 'Bearer ' + session);
			//req.setHeader('Content-Type', 'application/json');
		    HttpResponse response = h.send(req);
		    //Map<String,Object> rmp = (Map<String,Object>)JSON.deserializeuntyped(response.getBody());
		    //content = (String)rmp.get('Body');
		    content = response.getBody();
		    System.Debug('content---------:'+content);
		}
		else
		{
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Fill all field.'));
		}
	}
}
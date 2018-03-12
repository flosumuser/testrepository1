public class GoogleDriveController 
{
	private String code{set;get;}
	private String client_id = '45903939900-1t2fm3e3n65tamen3kn71ojlogsvsmvs.apps.googleusercontent.com';
	private String secret_key = 'dIPKbaffsGMd9dcFwyn3qmFQ';
	private String redirect_uri = 'https://c.ap1.visual.force.com/apex/GoogleDrivePage'; 
	private String accessToken;
	private String accessTokenType;
	private String refreshToken;
	// public fields to set and get
	public transient blob fileToUpload{set; get;}   
	public String file_name{set; get;}  
	public String folder_name{set;get;}   
	public String file_content_type{set; get;}
	public String selectedParentFolder{set; get;}      
	public String selectedFileToDownload{set; get;}  
	public String selectedParentFolderForFile{set; get;}  
	public String selectedFileToDelete{set; get;}   
	
	public List<SelectOption> downloadFileOptions {set; get;}
	public List<SelectOption> folderListOptions {set; get;}
	public List<SelectOption> fileListptions {set; get;}
	
	public boolean fileUploadRender{set; get;}
	public boolean createFolderRender{set; get;}
	public boolean downloadFileRender{set; get;}
	public boolean deleteFileRender{set; get;}
	//http
	private transient HttpResponse res;
	private transient HttpRequest req;
	private transient Http h;
	private transient String resp;
	//cunstructor
	public GoogleDriveController()
	{
		fileUploadRender = false;
		createFolderRender = false;
		downloadFileRender = false;
		deleteFileRender = false;
	}
	public void pageBlockAction()
	{
		googleDriveTokenCaller();
		downloadFileOptions = new List<SelectOption>();
		folderListOptions = new List<SelectOption>();
		fileListptions = new List<SelectOption>();
		downloadFileOptions = getDownloadFileList();      
		folderListOptions = getFolderList();      
		fileListptions = getFileList();   
	}
	// for render page block
	public boolean getdisplayBlock()
	{
		if(accessToken != null && accessToken != '')
			return true;
		else
			return false;
	}
	// for render page block sections
	
	public void renderFileUpload()
	{
			fileUploadRender = true;
			createFolderRender = false;
			downloadFileRender = false;
			deleteFileRender = false;
	}
	public void renderCreateFolder()
	{
			fileUploadRender = false;
			createFolderRender = true;
			downloadFileRender = false;
			deleteFileRender = false;
	}
	public void renderDownloadFile()
	{
			fileUploadRender = false;
			createFolderRender = false;
			downloadFileRender = true;
			deleteFileRender = false;
	}
	public void renderDeleteFile()
	{
			fileUploadRender = false;
			createFolderRender = false;    
			downloadFileRender = false;
			deleteFileRender = true;
	}
	// token caller
	public void googleDriveTokenCaller()
	{
		code = Apexpages.currentPage().getParameters().get('code');
		if(code != null && code != '')
		{
			System.debug('::::::::::::::::::::::::::::::::::::::::::::::: code value= '+code);
			accessGoogleDriveToken(); 
		}
		else
		{
			System.debug(':::::::::::::::::::::::::::::::::::::::::::::::code null code value= '+code);
			String que = ' SELECT Access_Token__c , Refresh_Token__c , Token_Type__c FROM Google_Drive_Token__c ' 
			+ 'WHERE Client_Id__c = \''      
			+ client_id +'\'LIMIT 1';
			List<Google_Drive_Token__c> gd = new List<Google_Drive_Token__c>() ;
			gd = Database.query(que);
    
			if( gd != null && gd.size() >0 )
			{
				accessToken = gd.get(0).Access_Token__c;
				accessTokenType = gd.get(0).Token_Type__c;
				refreshToken = gd.get(0).Refresh_Token__c;
				//refreshGoogleDriveToken(refreshToken , client_id , secret_key);
			}
		}	
	}
	public List<SelectOption> getDownloadFileList()
	{   
        transient List<SelectOption> options = new List<SelectOption>();
		options.add(new SelectOption('None','None'));  
		req = new HttpRequest(); 
		req.setEndpoint('https://www.googleapis.com/drive/v2/files/');  
		req.setMethod('GET'); 
		req.setTimeOut(60*1000*2);
		req.setHeader('Authorization', accessTokenType + ' ' + accessToken); 
		h = new Http();  
        res = h.send(req);
        resp = res.getBody();
        System.debug('response downloadfilelist::::::::::'+res);
        transient Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(resp);
        if(root != null && root.size() >0)
	    {
		    transient List<Object> items = (List<Object>)root.get('items');
		    if(items != null && items.size() >0)
		    {
			    for (Object item : items)
			    {
			        transient Map<String, Object> i = (Map<String, Object>)item;
			        if(i.get('webContentLink') != null && i.get('webContentLink')+'' != '')
			        {
			        	options.add(new SelectOption(i.get('webContentLink')+'',i.get('title')+''));
			        }
			    }
		    }
	    }
	    return options;
	}
	public List<SelectOption> getFolderList()
	{
        transient List<SelectOption>  options = new List<SelectOption>();
			options.add(new SelectOption('None','None'));  
			req = new HttpRequest(); 
			req.setEndpoint('https://www.googleapis.com/drive/v2/files/');  
			req.setMethod('GET'); 
			req.setTimeOut(60*1000*2);
			req.setHeader('Authorization', accessTokenType + ' ' + accessToken); 
			h = new Http();  
	        res = h.send(req);
	        System.debug('response filelist::::::::::'+res);
	        resp = res.getBody();
	        Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(resp);
	        if(root != null && root.size() >0)
	        {
			    List<Object> items = (List<Object>)root.get('items');
			    if(items != null && items.size() >0)
			    {
				    for (Object item : items)
				    {
				        Map<String, Object> i = (Map<String, Object>)item;
				       if(i.get('fileExtension')== null && i.get('exportLinks')== null)
				        {
				        	//System.debug()
				        	System.debug(':::::'+i.get('fileExtension')+':::::Object Folder List::'+i.get('title')+':::::::::::::'+i);
				        	options.add(new SelectOption(i.get('id')+'',i.get('title')+''));
				        }
				    }          
			    }
	       }
	    return options;
	}
	//delete file from google drive
	public void deleteFileFromGoogleDrive()
	{
		req = new HttpRequest(); 
		req.setEndpoint('https://www.googleapis.com/drive/v2/files/'+selectedFileToDelete);  
		req.setMethod('DELETE'); 
		req.setTimeOut(60*1000*2);
		req.setHeader('Authorization', accessTokenType + ' ' + accessToken); 
		h = new Http();  
        res = h.send(req);
        System.debug('delete File Response::::::::::::::::::::::::::::::::::'+res.getBody());
	}
	//get file meta data from GoogleDrive
	public List<SelectOption> getFileList()
	{
			transient List<SelectOption>  options = new List<SelectOption>();
			options.add(new SelectOption('None','None'));  
			req = new HttpRequest(); 
			req.setEndpoint('https://www.googleapis.com/drive/v2/files/');  
			req.setMethod('GET'); 
			req.setTimeOut(60*1000*2);
			req.setHeader('Authorization', accessTokenType + ' ' + accessToken); 
			h = new Http();  
	        res = h.send(req);
	        System.debug('response filelist::::::::::'+res);
	        resp = res.getBody();
	        Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(resp);
	        if(root != null && root.size() >0)
	        {
			    List<Object> items = (List<Object>)root.get('items');
			    if(items != null && items.size() >0)
			    {
				    for (Object item : items)
				    {
				        Map<String, Object> i = (Map<String, Object>)item;
				        if(i.get('webContentLink') != null && i.get('webContentLink')+'' != '')
				        {
				        	options.add(new SelectOption(i.get('id')+'',i.get('title')+''));
				        }
				    }          
			    }
	       }
	    return options;
	}
	// download a file
	public PageReference getFileFromGoogleDrive()
	{
		
		if(selectedFileToDownload != null && selectedFileToDownload !='' && selectedFileToDownload != 'None')
		{
        		PageReference pref = new PageReference(selectedFileToDownload);
        		return pref;
		} 
		else
		{
			return null;
		}
	}
	// creates a google drive folder
	public void createGoogleDriveFolder()
	{ 
		String url = 'https://www.googleapis.com/drive/v2/files'; 
        req = new HttpRequest(); 
        req.setEndpoint(url);
        req.setMethod('POST'); 
        req.setTimeOut(60*1000);
        
        //set header 
        req.setHeader('Content-Type','application/json');  
        req.setHeader('Authorization', accessTokenType + ' ' + accessToken); 
        //body to send
        String body =     '{"title" : "'+folder_name+'",'				
		        		+ '"mimeType" : "application/vnd.google-apps.folder"' ;
		        		
		        if(selectedParentFolder != null && selectedParentFolder != 'None' && selectedParentFolder != '' )
        		{
	        		body+= + ',"parents": [{"id":"0B_Ob_p3gQhoSNWdqZjFpVldTTDg"}]}';
        		}
        		else  
        		{
        			body+='}';
        		}
        
        req.setBody(body);
        System.debug(body);
        h = new Http();
        res = h.send(req);
        resp = res.getBody(); 
        System.debug('create folder response::::::::::::::::::::::::::::::::::::::::::::::'+res);
        System.debug('create folder response::::::::::::::::::::::::::::::::::::::::::::::'+resp);
	}
	// upload file to google drive 
	public void uploadFileToGoogleDrive()
    {
    	if(file_name != null && file_name != '')
    	{
	    	//refreshGoogleDriveToken(accessToken , client_id , secret_key);
	        String val = EncodingUtil.base64Encode(fileToUpload); 
	        //String val = fileToUpload.toString();
	        System.debug(':::::::::::file name:::::::::::::::::::::'+file_name+'::'+val);
	        String url = 'https://www.googleapis.com/upload/drive/v2/files?uploadType=multipart'; 
	        req = new HttpRequest(); 
	        req.setEndpoint(url);
	        req.setMethod('POST'); 
	        req.setTimeOut(60*1000);
	        
	        //set header 
	        String boundary = 'foo_bar_baz';
	        req.setHeader('Content-Type','multipart/related; boundary="'+boundary+'"');  
	        req.setHeader('Authorization', accessTokenType + ' ' + accessToken); 
	        //body to send
	        System.debug('file_content_type::::::::::::::::::::::::::::'+file_content_type);
	        //String contentType = 'text/plain';
	        
			String delimiter = '\r\n--' + boundary + '\r\n';
			String close_delim = '\r\n--' + boundary + '--';
	        String body = 	  delimiter
	        		+ 'Content-Type: application/json\r\n\r\n'
	        		+ '{"title" : "'+file_name+'",'				
	        		+ '"mimeType" : "'+file_content_type+'"' ;
	        		if(selectedParentFolderForFile != null && selectedParentFolderForFile != 'None' && selectedParentFolderForFile != '' )
	        		{
		        		body+= ',"parents": [{'
						+ '"kind": "drive#fileLink",'
						+ '"id": "'+selectedParentFolderForFile+'"'
						+ '}]}';
	        		}
	        		else
	        		{
	        			body+='}';
	        		}
	        body+= delimiter
	        		+ 'Content-Type: ' + file_content_type + '\r\n'
	        		+ 'Content-Transfer-Encoding: base64\r\n'
	        		+ '\r\n'
	        		+ val    
	        		+ close_delim;
	        
	        req.setHeader('Content-Length', String.valueOf(body.length()));
	        //'Authorization:'+ accessTokenType + ' ' + accessToken+','+
	        
	        req.setBody(body);
	        System.debug(body);
	        System.debug(':header upload file::::::::::::::::::::::::::::::::::'+req.getHeader('Authorization')+'::::'+req.getHeader('Content-Type')+'::::'+req.getHeader('Content-Length'));
	        
	        h = new Http();
	        res = h.send(req);
	        resp = res.getBody(); 
	        System.debug('uploadfile method response::::::::::::::::::::::::::::::::::::::::::::::'+res);
	        System.debug('uploadfile method response::::::::::::::::::::::::::::::::::::::::::::::'+resp);
    	}
	}
	
	//User information
	public void googleDriveUserInfo()
	{
			String base_url = 'https://www.googleapis.com/plus/v1/people/'+client_id+'?access_token='+accessToken ;
			req = new HttpRequest();
			req.setEndpoint(base_url);
			req.setMethod('GET');
			req.setHeader('Authorization',accessTokenType +' '+ accessToken);
			req.setTimeOut(60*1000);
			System.debug('::::::::::header is:::::::::::::::::Authorization:::::'+req.getHeader('Authorization'));
			h = new Http();
			
			res = h.send(req);
			resp = res.getBody();
			System.debug(':::User Info:::::::::::::::::::::::::::user info:::::'+res);
			System.debug(':::User Info:::::::::::::::::::::::::::user info:::::'+resp);
	}
	// refresh a token
	public void refreshGoogleDriveToken(String refresh_Token , String client_id , String secret_key)
	{
			String base_url = 'https://accounts.google.com/o/oauth2/token' ;
			String parameter_url = 'refresh_token=' + refresh_Token
							 + '&client_id=' + client_id
							 + '&client_secret=' + secret_key
							 + '&grant_type=refresh_token';
							  
			req = new HttpRequest();
			req.setEndpoint(base_url);
			req.setMethod('POST');
			req.setHeader('content-type', 'application/x-www-form-urlencoded'); 
			
			req.setHeader('Content-length', String.valueOf(parameter_url.length()) );
			req.setBody(parameter_url);
			req.setTimeOut(60*1000);
			System.debug('refresh token uri::::::::'+parameter_url);
			h = new Http();
			
			res = h.send(req);
			resp = res.getBody();
			System.debug('::::::::::::::::::::::::::refresh token response:::::::::::::::::::::::'+res);
			System.debug('::::::::::::::::::::::::::refresh token response string:::::::::::::::::::::::'+resp);
			TokenResponse tr = (TokenResponse)System.JSON.deserialize(resp , TokenResponse.class);
			if(tr.access_token != null && tr.access_token != '')
			{
				System.debug(':::::::::::::::token refreshed:::::::::::::::::::::');
			}
	}
	// to get authorization from google drive
	public PageReference googleAuth()
	{
		transient Pagereference pref = new Pagereference(googleAuthUri(client_id , redirect_uri));
		return pref;
	}
	// method for return ful uri for authorization 
	public String googleAuthUri(String cid,String callback_uri)
	{
		String key = EncodingUtil.urlEncode(cid , 'UTF-8');
		String uri = EncodingUtil.urlEncode(callback_uri , 'UTF-8');
		String base_url = 'https://accounts.google.com/o/oauth2/auth?' ;
		String final_uri;
			final_uri= base_url 
			+ 'response_type=code'
			+ '&scope=https://www.googleapis.com/auth/drive'
			+ '&access_type=offline'
			+ '&state=MyState' 
			+ '&approval_prompt=force'
			+ '&client_id=' + key
			+ '&redirect_uri=' + uri;
		System.debug(':::::authorization final_uri:::::::::::::::::::::::::::::::::::::::::::::::::::'+final_uri); 
		return final_uri;
	}
	// method to get token from google drive
	public void accessGoogleDriveToken() 
	{
			String base_url = 'https://accounts.google.com/o/oauth2/token?' ;
			String parameter_url = 'code=' + code
							 + '&client_id=' + client_id
							 + '&client_secret=' + secret_key
							 + '&redirect_uri=' + redirect_uri
							 + '&grant_type=authorization_code';
			req = new HttpRequest();
			req.setEndpoint(base_url);
			req.setMethod('POST');
			req.setHeader('content-type', 'application/x-www-form-urlencoded'); 
			
			req.setHeader('Content-length', String.valueOf(parameter_url.length()) );
			req.setBody(parameter_url);
			req.setTimeOut(60*1000);
			
			h = new Http();
			
			res = h.send(req);
			resp = res.getBody();
			System.debug('::::::::::hi:::::::::::::::::::::token Response::::::::'+resp);
			TokenResponse tr = (TokenResponse)System.JSON.deserialize(resp , TokenResponse.class);
			if(tr.access_token != null && tr.access_token != '')
			{
				accessToken = tr.access_token;
				accessTokenType = tr.token_type;  
				refreshToken = tr.refresh_token;
				System.debug('::::::::::::::::::::::::::::::::::::::refresh token found::::::::::::::::::::::::::'+tr.refresh_token);
				if(client_id != null && client_id != '') 
				{
					String que = ' SELECT Access_Token__c ,Token_Type__c, Refresh_Token__c FROM Google_Drive_Token__c ' 
					+ 'WHERE Client_Id__c = \'' 
					+ client_id +'\''
					+' LIMIT 1';
					System.debug('::::::found token in database:::query:::'+que); 
					List<Google_Drive_Token__c> gd = new List<Google_Drive_Token__c>() ;
					gd = Database.query(que);
					if( gd != null && gd.size() >0 ) 
					{
						gd.get(0).Access_Token__c = accessToken;
						gd.get(0).Token_Type__c = accessTokenType;
						if(tr.refresh_token != null)
							gd.get(0).Refresh_Token__c = refreshToken;
						update gd;
						System.debug('::::::::::::::::::::::::::::::token updated in database '+tr.access_token);
					}
					else
					{
						system.debug(':::::::::::::::::::::::::::client not inserted with this id in database before:::::::::::::::::::');
						Google_Drive_Token__c gdtc;
						if(refreshToken == null || refreshToken == '')
						{
							gdtc = new Google_Drive_Token__c(Access_Token__c= accessToken , Client_Id__c = client_id , Token_Type__c = accessTokenType);
							System.debug('::::::::::::::::::::::::::::::::::::::inserting without refresh token::::::::::::::::::::::::::'+tr.refresh_token);
						}
						else
						{
							gdtc = new Google_Drive_Token__c(Access_Token__c= accessToken , Client_Id__c = client_id , Refresh_Token__c = refreshToken , Token_Type__c = accessTokenType);
							System.debug(' insert with refresh token.......................'+tr.refresh_token);					
						}
						insert gdtc;
					}
				}
			}
			else
			{
				String que = ' SELECT Access_Token__c , Refresh_Token__c , Token_Type__c FROM Google_Drive_Token__c ' 
				+ 'WHERE Client_Id__c = \''      
				+ client_id +'\'LIMIT 1';
				List<Google_Drive_Token__c> gd = new List<Google_Drive_Token__c>() ;
				gd = Database.query(que);
				if( gd != null && gd.size() >0 )
				{
					accessToken = gd.get(0).Access_Token__c;
					accessTokenType = gd.get(0).Token_Type__c;
					refreshToken = gd.get(0).Refresh_Token__c;
				}
			}
			System.debug(':::accessToken::::::::::::accessTokenType::: :::refreshToken'+accessToken+'::::::::::::'+accessTokenType+'::: :::'+refreshToken);
	}
	//wraper class to get token
	class TokenResponse
	{
		String access_token;
		String id_token;
		String expires_in;
		String token_type;
		String refresh_token;
	}
	//wraper class for response of folder
	class FolderResponseWraper
	{
		String id;
		String title;
		public FolderResponseWraper()
		{
		}
	}
	//wraper class for insert file response
	class FileResponseWraper
	{
		String id;
		//String title;
		//String mimeType;
		String webContentLink;
		String downloadUrl;
		String originalFilename;
		//String fileExtension;
		Integer fileSize;
		public FileResponseWraper()
		{
		}
	}
}
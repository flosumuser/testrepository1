public class DropboxController
{
    // class variables
    public String code{get; set;} 
    public Blob fileToUpload{get; set; } 
    public String accessToken{get; set;} 
    public String resuid; 
    public boolean renderAuthorization{get;set;}
    public String aapid;
    public String appsecret;
    public String token_type;
    public String file_name{get; set; }
    public String download_file_text{get; set;} 
    public String folder_name{get; set;}
    public String selectedFile{get; set;}

    //cunstructor
    public DropboxController()
    { 
            renderAuthorization = false;
            aapid = '9d9uol1tch5t12e';
            appsecret = '0994ic0jji7vvno';  
            System.debug('In Cunstructer:::::::::::::::::::::::::::::::::');     
    }
    // get token from custom setting or call accessToken method
    public void tokenCaller() 
    {
        List<Token_Temp__c> ttc = Database.query('SELECT Token_Value__c , UID__c , Token_Type__c FROM Token_Temp__c');
            System.debug('Selected row of custom setting::::::::::::::::::'+ttc+'::: size'+ttc.size());
            //delete ttc;
           if(ttc == null || ttc.size() < 1) 
            {
                System.debug('token is not in custom setting ');
                code=Apexpages.currentPage().getParameters().get('code');
                if(code != null && code != '')
                {
                    System.debug('calling the accesToken to get Fresh Token'); 
                    AccesToken();
                }
                else
                {
                	System.debug('::::::::::token not exist in database and Code not found in url:::::::::::::::::::::::::');
                }
            }   
            else
            {
                System.debug('accessToken Found in Custom setting :::::::::::::::::::::::::::::::::::::::::::::');
                accessToken = ttc.get(0).Token_Value__c;
                token_type = ttc.get(0).Token_Type__c;
                resuid = ttc.get(0).UID__c;
            }
            System.debug(' Access token in tokenCaller method ::::::::::::::::::::::::::::::::::: ::: ' + accessToken);
    }
    // authorization process
    public PageReference dropAuth()
    {
    	PageReference pref;
    	List<Token_Temp__c> ttc = Database.query('SELECT Token_Value__c , UID__c , Token_Type__c FROM Token_Temp__c');
            if(ttc == null || ttc.size() < 1) 
            {
            		pref = new PageReference('https://www.dropbox.com/1/oauth2/authorize?response_type=code&client_id='+aapid+'&redirect_uri=https://c.ap1.visual.force.com/apex/DropboxPage&state=Mytesting&force_reapprove=true&disable_signup=true');
            }
            else
            	pref = new PageReference('https://c.ap1.visual.force.com/apex/DropboxPage');
            return pref;
    }
    // get token from dropbox
    public void AccesToken()
    {
        String tokenuri = 'https://api.dropbox.com/1/oauth2/token?grant_type=authorization_code&code='+code+'&redirect_uri=https://c.ap1.visual.force.com/apex/DropboxPage&client_id='+aapid+'&client_secret='+appsecret;
        HttpRequest req = new HttpRequest();
        req.setEndpoint(tokenuri); 
        req.setMethod('POST');
        req.setTimeOut(60*1000);

        Http h = new Http();
        String resp; 
        HttpResponse res = h.send(req); 
        resp = res.getBody();
        WraperToken wrapt = (WraperToken) System.JSON.deserialize(resp, WraperToken.class);
        accessToken = wrapt.access_token;
        resuid = wrapt.uid;
        token_type = wrapt.token_type ; 
        //do first later capital of token_type
        token_type = token_type.substring(0, 1).toUpperCase() + token_type.substring(1);
        System.debug('acces token to save'+accessToken); 
        //store in custom setting 
        Token_Temp__c temp = new Token_Temp__c(Name='Acces_Token' , Token_Value__c=accessToken , UID__c=resuid , Token_Type__c=token_type);
        insert temp;
        System.debug(' Access token method::::::::::::::::::::::::::::::::::: ::: ' + wrapt.access_token);
    }
    //to refresh a token 
    public PageReference refreshToken(String Token)
    {
        PageReference pref;
        pref = new PageReference('https://www.dropbox.com/1/oauth2/authorize?response_type=code&client_id='+aapid+'&redirect_uri=https://c.ap1.visual.force.com/apex/DropboxPage&state=Mytesting&force_reapprove=true');
        List<Token_Temp__c> ttc = Database.query('SELECT Token_Value__c , UID__c , Token_Type__c FROM Token_Temp__c');
        System.debug('Deleted Tokens:::::::::::::::::::::::::::::::'+ttc); 
		delete ttc;
        return pref;
    }
    // to get user info
    public void userInfo()
    {
        String url = 'https://api.dropbox.com/1/account/info'; 
        HttpRequest req = new HttpRequest();  
        req.setEndpoint(url);
        req.setMethod('GET'); 
        req.setTimeOut(60*1000);
        System.debug(':header user info::::::::::::::::::::::::::::::::::'+token_type+' '+ accessToken);
        //set header
        //accessToken = 'jyXYXSMzvoIAAAAAAAAAfWyr_vdrOXmeXl7X0A-wxzIhCHmKA86Ny84bIOMoSHBp';
         
        req.setHeader('Authorization', token_type+' '+ accessToken);
        Http h = new Http();
        HttpResponse res = h.send(req);
        System.debug('user info method response::::::::::::::::::::::::::::::::::::::::::::::'+res.getBody());
    }
    // to upload a file
    public void uploadFile() 
    {
        String val = EncodingUtil.base64Encode(fileToUpload); 
        //String val = fileToUpload.toString();
        String root = 'dropbox';
        String path = file_name;

        String url = 'https://api-content.dropbox.com/1/files_put/'+root+'/'+path+'?param=val&overwrite=false'; 
        HttpRequest req = new HttpRequest(); 
        req.setEndpoint(url);
        req.setMethod('PUT'); 
        req.setTimeOut(60*1000);
        //set header
        req.setHeader('Content-Type','application/json'); 
        System.debug(':header upload file::::::::::::::::::::::::::::::::::'+token_type+' '+ accessToken);
        req.setHeader('Authorization', token_type+' '+ accessToken); 
        req.setHeader('Content-length', String.valueOf(val.length()));
        req.setBody(val);
        Http h = new Http();
        HttpResponse res = h.send(req);
        System.debug('uploadfile method response::::::::::::::::::::::::::::::::::::::::::::::'+res.getBody());
        String resp = res.getBody();
        WraperFileInfo wrapfilinfo = (WraperFileInfo) System.JSON.deserialize(resp, WraperFileInfo.class);
        String filepath = wrapfilinfo.path;
        String fileroot = wrapfilinfo.root;
        if(filepath != null && filepath.length() > 0 && fileroot != null && fileroot.length() > 0)
        { 
	        Dropbox_File_List__c dflc = new Dropbox_File_List__c(Name = filepath , File_Url__c = fileroot + '' + filepath); 
	        insert dflc;
        } 
    }
    //to write list of file options
    public List<SelectOption> getFileList()
    {
    	
    	List<SelectOption> options = new List<SelectOption>();
    	//List<Dropbox_File_List__c> dflc = Database.query();
    	for(Dropbox_File_List__c df: [SELECT File_Url__c FROM Dropbox_File_List__c])
    	{
    		options.add(new SelectOption(df.File_Url__c,df.File_Url__c));
    	}
    	return options;
    }
    //to get file
    public void getFileFromDropbox()
    {
        //String root = 'dropbox';
        //String path = 'Document1.txt';
        String rootpath = selectedFile;
        String url = 'https://api-content.dropbox.com/1/files/'+rootpath; 
        HttpRequest req = new HttpRequest();  
        req.setEndpoint(url);
        req.setMethod('GET'); 
        req.setTimeOut(60*1000);
        //set header
        System.debug(':header get file::::::::::::::::::::::::::::::::::'+token_type+' '+ accessToken);
        req.setHeader('Authorization', token_type+' '+ accessToken); 
        Http h = new Http();
        HttpResponse res = h.send(req); 
        download_file_text = res.getBody();
        //Blob file = EncodingUtil.base64Decode(download_file_text);
        System.debug('getfile method response::::::::::::::::::::::::::::::::::::::::::::::'+res.getBody());
    }
    //create a folder
    public void createFolder()
    {
    	String root = 'dropbox';
        String path = '/'+folder_name;
        
        String url = 'https://api.dropbox.com/1/fileops/create_folder?root='+root+'&path='+path+'&locale'; 
        HttpRequest req = new HttpRequest(); 
        req.setEndpoint(url);
        req.setMethod('POST'); 
        req.setTimeOut(60*1000);
        //set header
        req.setHeader('Authorization', token_type+' '+ accessToken); 
        Http h = new Http(); 
        HttpResponse res = h.send(req);
        System.debug('createfolder method response::::::::::::::::::::::::::::::::::::::::::::::'+res.getBody());
    }
    //wraper class for token information
    class WraperToken
    {
        String access_token;
        String token_type;
        String uid;
        public WraperToken()
        {
        } 
    }
    // wraper class for uploadfile information
    class WraperFileInfo
    {
	    String size;
	    String rev;
	    boolean thumb_exists;
	    String bytes;
	    String modified;
	    String path;
	    boolean is_dir;
	    String icon;
	    String root;
	    String mime_type;
	    String revision;
	    public WraperFileInfo()
	    {
	    	
	    }
	}
	class TokenError
	{
		String error;
		public TokenError()
		{
			
		}
	}
}
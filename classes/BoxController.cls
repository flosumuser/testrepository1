public class BoxController 
{
    //private class fields
    private String code;
    private String client_id = 'g7zmufolv6jzqi1sxqd4lgbwe06930xd';
    private String secret_key = 'vQQ0IvcFnwwEO4e56lsNSNXUZQnHmsR8';
    private String redirect_uri = 'https://c.ap1.visual.force.com/apex/BoxIntegrationPage'; 
    private String state='MyState';
    @TestVisible private String accessToken;
    @TestVisible private String accessTokenType;
    private String refreshToken;
    // public class fields
    public String selectedParentFolderForFile{set; get;} 
    public transient blob fileToUpload{set; get;} 
    public String file_content_type{set; get;}  
    public String file_name{set; get;}
    public String selectedParentFolder{set; get;} 
    public String folder_name{set;get;}   
    public String selectedFileToDownload{set; get;}
    public String selectedFileToDelete{set; get;} 
    public String selectedFolderToOpen{set; get;}
    
    //class fields for render pageblocksections
    public boolean fileUploadRender{set; get;}
    public boolean createFolderRender{set; get;}
    public boolean downloadFileRender{set; get;}
    public boolean deleteFileRender{set; get;}  
    public boolean renderAll{set; get;}
    //http
    private transient HttpResponse res;
    private transient HttpRequest req;
    private transient Http h;
    private transient String resp;    
    //cunstructor 
    public BoxController(ApexPages.standardController con)
    {
        fileUploadRender = false;
        createFolderRender = false;
        downloadFileRender = false;
        deleteFileRender = false;
        renderAll = false;
    }
    public boolean getrenderAuthBlock()
    {
        if(accessToken != null && accessToken != '')
            return false;
        else
            return true;
    }
    
    
    // creates a box.com folder
    public void createBoxFolder()
    { 
        String url = 'https://api.box.com/2.0/folders'; 
        req = new HttpRequest(); 
        req.setEndpoint(url);
        req.setMethod('POST'); 
        req.setTimeOut(60*1000);
        
        //set header 
        req.setHeader('Content-Type','application/json');  
        req.setHeader('Authorization', accessTokenType + ' ' + accessToken); 
        //body to send
        String body =     '{"name":"'+ folder_name +'",';
                        
                if((selectedParentFolder != null) && (selectedParentFolder != 'None') && (selectedParentFolder != '') )
                {
                    body+= '"parent": {"id": "'+  selectedParentFolder +'"}}' ;
                }
                else  
                {
                    body+= '"parent": {"id": "0"}}' ;
                }
        
        req.setBody(body);
        System.debug(body);
        h = new Http();
        res = h.send(req);
        resp = res.getBody(); 
    }
    // get file from box.com
    public PageReference getFileFromBox()
    {
        if(selectedFileToDownload != null && selectedFileToDownload !='' && selectedFileToDownload != 'None')
        {
            String url = 'https://api.box.com/2.0/files/'+ selectedFileToDownload +'/content'; 
            req = new HttpRequest(); 
            req.setEndpoint(url);
            req.setMethod('GET'); 
            req.setTimeOut(60*1000);  
            req.setHeader('Authorization', accessTokenType + ' ' + accessToken); 
            h = new Http();
            res = h.send(req);
            System.debug('::::::::::::::getFileResponse::'+res.getBody());
            String resp= res.getHeader('Location');
            PageReference pref = new PageReference(resp);
            return pref;
        }
        else
            return null;
    }
    //delete file from box.com
    public void deleteFileFromBox()
    {
        if(selectedFileToDelete != null && selectedFileToDelete !='' && selectedFileToDelete != 'None')
        {
            String url = 'https://api.box.com/2.0/files/'+ selectedFileToDelete; 
            req = new HttpRequest(); 
            req.setEndpoint(url);
            req.setMethod('DELETE'); 
            req.setTimeOut(60*1000);  
            req.setHeader('Authorization', accessTokenType + ' ' + accessToken); 
            h = new Http();
            res = h.send(req);
        }
    }
    //delete folder from box.com
    public void deleteFolderFromBox()
    {
        if(selectedFileToDelete != null && selectedFileToDelete !='' && selectedFileToDelete != 'None')
        {
            String url = 'https://api.box.com/2.0/folders/'+ selectedFileToDelete + '?recursive=true'; 
            req = new HttpRequest(); 
            req.setEndpoint(url);
            req.setMethod('DELETE'); 
            req.setTimeOut(60*1000);  
            req.setHeader('Authorization', accessTokenType + ' ' + accessToken); 
            h = new Http();
            res = h.send(req);
        }
    }
    
    //upload a file
    public void uploadFileToBox()
    {
        if(file_name != null && file_name != '')
        {
            String val = EncodingUtil.base64Encode(fileToUpload);
 
            String url = 'https://upload.box.com/api/2.0/files/content';    
            req = new HttpRequest(); 
            req.setEndpoint(url);    
            req.setMethod('POST'); 
            req.setTimeOut(60*1000);
            String boundary = 'foo_bar_baz';
            req.setHeader('Content-Type','multipart/form-data; boundary="'+boundary+'"');  
            req.setHeader('Authorization', accessTokenType + ' ' + accessToken);
            
            String delimiter = '\r\n--' + boundary + '\r\n';
            String close_delim = '\r\n--' + boundary + '--';
            String body =     delimiter
                    + 'Content-Disposition: form-data; name="filename"; filename="'+ file_name +'"\r\n'
                    + 'Content-Type: ' + file_content_type + '\r\n\r\n' 
                    + 'Content-Transfer-Encoding: base64\r\n'
                    +  val +'\r\n';
            body+= delimiter   
                    + 'Content-Disposition: form-data; name="parent_id"\r\n\r\n';
                    
                    if(selectedParentFolderForFile == 'None')
                        body += '0';   
                    else 
                        body += selectedParentFolderForFile;
                    
            body += close_delim;
            req.setHeader('Content-Length', String.valueOf(body.length()));
            System.debug('request body::::'+body);
            req.setHeader('Content-Encoding','base64'); 
            req.setBody(body);
            system.debug(body);      
            h = new Http();
            res = h.send(req);
            resp = res.getBody(); 
        }
    }
    // token caller
    public void boxTokenCaller()
    {
            String que = ' SELECT Access_Token__c , Refresh_Token__c , Token_Type__c FROM Google_Drive_Token__c ' 
            + 'WHERE Client_Id__c = \''      
            + client_id +'\'LIMIT 1';
            List<Google_Drive_Token__c> gd = new List<Google_Drive_Token__c>() ;
            gd = Database.query(que);
    
            if( gd != null && gd.size() >0 )
            {
                system.debug('-------------------token found in database-------------------------------');
                accessToken = gd.get(0).Access_Token__c;
                accessTokenType = gd.get(0).Token_Type__c;
                refreshToken = gd.get(0).Refresh_Token__c;
                if(refreshToken != null && refreshToken != '')
                    refreshToken(refreshToken ,client_id ,secret_key);
            }
            else
            {
                code = Apexpages.currentPage().getParameters().get('code');
  
                if(code != null && code != '')
                {
                    if(Apexpages.currentPage().getParameters().get('state') == state)
                        boxToken();
                }
            }
    }
    //get token form box.com
    public void boxToken() 
    {
            String base_url = 'https://www.box.com/api/oauth2/token?' ;
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
            TokenResponse tr = (TokenResponse)System.JSON.deserialize(resp , TokenResponse.class);
            if(tr.access_token != null && tr.access_token != '')
            {
                accessToken = tr.access_token;
                accessTokenType = tr.token_type;  
                accessTokenType = accessTokenType.substring(0, 1).toUpperCase() + accessTokenType.substring(1);
                refreshToken = tr.refresh_token;
                if(client_id != null && client_id != '') 
                {
                        Google_Drive_Token__c gdtc;
                        if(refreshToken == null || refreshToken == '')
                        {
                            gdtc = new Google_Drive_Token__c(Access_Token__c= accessToken , Client_Id__c = client_id , Token_Type__c = accessTokenType);
                        }
                        else
                        {
                            gdtc = new Google_Drive_Token__c(Access_Token__c= accessToken , Client_Id__c = client_id , Refresh_Token__c = refreshToken , Token_Type__c = accessTokenType);      
                        }
                        insert gdtc;
                }
            }
    }
    // refresh a token
    public void refreshToken(String refresh_Token , String client_id , String secret_key)
    {
            String base_url = 'https://www.box.com/api/oauth2/token?' ;
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
            h = new Http();
            
            res = h.send(req);
            resp = res.getBody();

            TokenResponse tr = (TokenResponse)System.JSON.deserialize(resp , TokenResponse.class);

            if(tr.access_token != null && tr.access_token != '')
            {
                String que = ' SELECT Access_Token__c , Refresh_Token__c , Token_Type__c FROM Google_Drive_Token__c ' 
                + 'WHERE Client_Id__c = \''      
                + client_id +'\''
                + 'AND Refresh_Token__c = \''
                + refresh_Token
                + '\' LIMIT 1';   
                List<Google_Drive_Token__c> gd = new List<Google_Drive_Token__c>() ;
                gd = Database.query(que);
        
                if( gd != null && gd.size() >0 )
                {
                    tr.token_type = tr.token_type.substring(0, 1).toUpperCase() + tr.token_type.substring(1);
                    accessToken = tr.access_token;
                    accessTokenType = tr.token_type;
                    
                    refreshToken = tr.refresh_token;
                    gd.get(0).Access_Token__c = tr.access_token;
                    gd.get(0).Refresh_Token__c = tr.refresh_token;
                    gd.get(0).Token_Type__c = tr.token_type;
                    update gd;
                }
            }
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
    // box.com authorization method
    public PageReference boxAuth()
    {
        transient Pagereference pref = new Pagereference(boxAuthUri(client_id , redirect_uri));
        return pref;
    }
    // method for return ful uri for authorization 
    public String boxAuthUri(String cid,String callback_uri)
    {
        String key = EncodingUtil.urlEncode(cid , 'UTF-8');
        String uri = EncodingUtil.urlEncode(callback_uri , 'UTF-8');
        String base_url = 'https://www.box.com/api/oauth2/authorize?' ;
        String final_uri;
            final_uri= base_url 
            + 'response_type=code'
            + '&state=' + state
            + '&client_id=' + key
            + '&redirect_uri=' + uri; 
        return final_uri;
    }
    /////////////////
    public List<SelectOption> getFolderList()
    {
        transient List<SelectOption>  options = new List<SelectOption>();
            options.add(new SelectOption('None','None'));  
            req = new HttpRequest(); 
            req.setEndpoint('https://api.box.com/2.0/folders/0/items');  
            req.setMethod('GET'); 
            req.setTimeOut(60*1000*2);
            req.setHeader('Authorization', accessTokenType + ' ' + accessToken); 
            h = new Http();  
            res = h.send(req);
            resp = res.getBody();
            Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(resp);
            if(root != null && root.size() >0)
            {
                List<Object> items = (List<Object>)root.get('entries');
                if(items != null && items.size() >0)
                {
                    for (Object item : items)
                    {
                        Map<String, Object> i = (Map<String, Object>)item;
                        if(i.get('type')== 'folder')
                        {
                            options.add(new SelectOption(i.get('id')+'',i.get('name')+''));
                        }
                    }          
                }
           }
        return options;
    }
    public List<SelectOption> getDownloadFileList()
    {   
        transient List<SelectOption>  options = new List<SelectOption>();
            options.add(new SelectOption('None','None'));  
            req = new HttpRequest(); 
            req.setEndpoint('https://api.box.com/2.0/folders/0/items');  
            req.setMethod('GET'); 
            req.setTimeOut(60*1000*2);
            req.setHeader('Authorization', accessTokenType + ' ' + accessToken); 
            h = new Http();  
            res = h.send(req);
            resp = res.getBody();
            Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(resp);
            if(root != null && root.size() >0)
            {
                List<Object> items = (List<Object>)root.get('entries');
                if(items != null && items.size() >0)
                {
                    for (Object item : items)
                    {
                        Map<String, Object> i = (Map<String, Object>)item;
                        if(i.get('type')== 'file')
                        {
                            options.add(new SelectOption(i.get('id')+'',i.get('name')+''));
                        }
                    }          
                }
           }
        return options;
    }
    //mehod for render pageblock sections
    public void renderFileUpload()
    {
            fileUploadRender = true;
            createFolderRender = false;
            downloadFileRender = false;
            deleteFileRender = false;
            renderAll = false;
    }
    public void renderCreateFolder()
    {
            fileUploadRender = false;
            createFolderRender = true;
            downloadFileRender = false;
            deleteFileRender = false;
            renderAll = false;
    }
    public void renderDownloadFile()
    {
            fileUploadRender = false;
            createFolderRender = false;
            downloadFileRender = true;
            deleteFileRender = false;
            renderAll = false;
    }
    public void renderDeleteFile()
    {
            fileUploadRender = false;
            createFolderRender = false;    
            downloadFileRender = false;
            deleteFileRender = true;
            renderAll = false;
    }
    public void renderAllBlock()
    {
            renderAll = true;
            fileUploadRender = false;
            createFolderRender = false;    
            downloadFileRender = false;
            deleteFileRender = false;
    }
    //wraper class for table rows
    public class TableRow
    {
        public TableRow(String id,String name,String typeof,String parentid)
        {
            this.id = id;
            this.name = name;
            this.typeof = typeof.toUpperCase();
            this.parentid = parentid;
        }
        public String id{set; get;}
        public String name{set; get;}
        public String typeof{set; get;}
        public String parentid{set; get;}
    }
    // to get list of box.com drive
    public List<TableRow> getDropList() 
    {
        if(selectedFolderToOpen == null || selectedFolderToOpen == '')
            selectedFolderToOpen = '0';
        List<TableRow> tr = new List<TableRow>();  
        req = new HttpRequest(); 
        req.setEndpoint('https://api.box.com/2.0/folders/'+ selectedFolderToOpen +'/items');  
        req.setMethod('GET'); 
        req.setTimeOut(60*1000*2);
        req.setHeader('Authorization', accessTokenType + ' ' + accessToken); 
        h = new Http();  
        res = h.send(req);
        resp = res.getBody();
        System.debug(':::'+resp);
        Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(resp);
        if(root != null && root.size() >0)
        {
                List<Object> items = (List<Object>)root.get('entries');
                
                List<Object> parents = (List<Object>)root.get('parent');
                if(items != null && items.size() >0)
                {
                    for (Object item : items)
                    {
                        Map<String, Object> i = (Map<String, Object>)item;
                        tr.add(new TableRow(i.get('id')+'',i.get('name')+'',i.get('type')+'','0'));
                    }          
                }      
        }
        return tr;
    }
}
public  with sharing class popup{

   public boolean displayPopup {get; set;}
   
    public String code {get; set;}
    public string key = '170768363119-qlh82nh9nn5cane749p1apo2fgcs2gkj.apps.googleusercontent.com';  
    public string secret = 'JvjyEElZphq8JumevRtdQ91j';  
    public string redirect_uri = 'https://c.na15.visual.force.com/apex/popUpPage';  
    public String resp {get; set;}
    public String messageBody {get; set;}
    public Integer expIn {get; set;}
    public String tokenAcc {get; set;} 
    public String toktype {get; set;}
    public String AccessToken{get; set;}
    public String fieldName{get; set;}
    public nativeCustomSetting__c customSettingObject {get;set;}
    
    public List<nativeCustomSetting__c> accList{get;set;}
    
    public popup(){ 
        accList=new List<nativeCustomSetting__c>();
        System.debug('controller......');
        code = ApexPages.currentPage().getParameters().get('code');
        System.debug('-------------------code------'+code);
         
    }
 
   
    public void showData(){
        
       AccessToken();
     }
    
  public void AccessToken()  
    {
       code = ApexPages.currentPage().getParameters().get('code');
       System.debug('-----------Call an AccessToken function-----------'+code+key);
        //Getting access token from google  
          HttpRequest req = new HttpRequest();
          HttpResponse response=new HttpResponse();
          //if(code !=null){
                req.setMethod('POST');  
                req.setEndpoint('https://accounts.google.com/o/oauth2/token');  
                req.setHeader('content-type','application/x-www-form-urlencoded');  
                messageBody = 'code='+code+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';  
                req.setHeader('Content-length', String.valueOf(messageBody.length()));  
                req.setBody(messageBody);  
                req.setTimeout(60000);  
           
           
             Http h = new Http();
             response = h.send(req);
             System.debug('========'+response.getBody());
        //}
          //--------------------------
        JSONParser parser;
        if(response != null)
           parser = JSON.createParser(response.getBody());
        
         System.debug('--------Name-->'+parser.getCurrentName()+'----'+parser.getCurrentName()+parser.nextValue());
         while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                 fieldName = parser.getText();
                 parser.nextToken();
                if(fieldName == 'access_token') {
                    tokenAcc = parser.getText();
                    System.debug('access Token-----TTTTTTT-----'+tokenAcc);
                } 
                
            }
           
         system.debug('Token Type------' + tokenAcc );
        }
        try{
        	 System.debug('--------------code12------'+code);
            customSettingObject=new nativeCustomSetting__c();
            accList=[Select AccessToken__c,Id FROM  nativeCustomSetting__c];
            if(accList.size() > 0){ 
                if(accList.get(0).AccessToken__c != tokenAcc){
                    accList.get(0).AccessToken__c=tokenAcc;
                    accList.get(0).name='Access Token';
                }
                if(accList.size() > 0){
                  update accList;
                }
                System.debug('-------------------TokenGetList------'+accList);
             }else{
              
                customSettingObject.AccessToken__c=String.valueOf(tokenAcc); 
                customSettingObject.name='Access_Token';
                insert customSettingObject;   
                 System.debug('-------------------customSettingObject------'+customSettingObject);
            }
         
        }catch(Exception e){
          
        }
    } 
   
      
}
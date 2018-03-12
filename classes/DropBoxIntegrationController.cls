public Class DropBoxIntegrationController {
    
    public string key = 'bki9wbt10qejt7v';  
    public string secret = 'wzveepmax5con5v';  
    public string redirect_uri = 'https://c.na15.visual.force.com/apex/DropBoxIntegration';
     private String code;  

    public DropBoxIntegrationController () {
        
        HttpRequest req = new HttpRequest();  
        req.setMethod('GET');  
        req.setEndpoint('https://www.dropbox.com/1/oauth2/authorize?client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri);  
        //String messageBody =   
       // req.setHeader('Content-length', String.valueOf(messageBody.length()));  
       // req.setBody(messageBody);  
        req.setTimeout(60*1000);  
  
        Http h = new Http();  
        String resp;  
        HttpResponse res = h.send(req);  
        resp = res.getBody();  
          
        System.debug(' You can parse the response to get the access token ::: ' + resp); 
    
    
    }

}
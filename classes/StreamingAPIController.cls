public class StreamingAPIController  
    {  
     public String msgValue{get;set;}
     public StreammingObj__c streamObj;
    
        //Everytime page is reRendered it will get refreshed values of account  
        public List<Account> getRefreshedAccount  
        {  
            get  
            {  
                return [select Id, Name from Account LIMIT 50000] ;  
            }  
            set;  
        }  
          
        public StreamingAPIController()  
        { 
      
        }
        public void sendBtn(){
         streamObj=new StreammingObj__c();
         streamObj.msgValue__c=msgValue;  
          System.debug('msgValue>>>>>>'+msgValue);
          insert streamObj;
        }  
    }
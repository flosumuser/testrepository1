public with sharing class nativeController{
   
    //for retrive an All Objects and filed's Name related to Native & custom object
    public Map<String, Schema.SObjectType> globalSchemaDesc= Schema.getGlobalDescribe();
    public String nativeAndCustomObject{get ; set; }
    public String objectValues{get; set;}
    
    //for retrive an All Objects
    public List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values(); 
    public List<SelectOption> options{get; set;}
    public List<SelectOption> ListfieldName {get; set;}
    public List<String> getfield {get; set;}
    public String ItemFieldsName { set;}
    public List<sObject> recordfileFormat{get;set;}
   
    public String sObjectName;
   
        
          
     public List<sObject> queryData;
    
    //It is use for wrapperList with pageBlockTable for show a record in table
    public Map<String,String> mapValuesField{set; get;}
    public String selectedCount{set;}
    public String commString;
    public String soqlquery; 
    private integer totalRecs = 0;     
    private integer index = 0;
    private integer blockSize = 5;         
    public List<SelectOption> pageList {get;set;}
    public String getPageValue{get; set;}
    public String totalNumberOfPage {get; set;}
    public String getPageNumber { set;}
    public List<SelectOption> fileOption {get; set;}
    public String fileNameValue{get; set;}
    public  List<String> fl;
    
    //for wrapper class list use sObjects data with Checkbox & commandLik Button
    public List<wrapperClass> wrapperClassList {get; set;}
    public String Edit {get; set;} 
    public String RecordId {get; set;}    
    public String Record {get; set;}
    public boolean flag=false;
    public boolean chkValue{get; set;}
    
    //sObject list use for seleted record for print on file like Excel and PDF
    public List<sObject> recordfileshow{get; set;}
    public String delId{get; set;}
    public String myId {get;set;}
    public String del {get; set;}
    public String message{get;set;}
    private String accToken=null;
    public String valAccToken{get;set;}
    public String acToken{get;set;}
    //file upload 
    public String code {get; set;}
    public string key = '170768363119-qlh82nh9nn5cane749p1apo2fgcs2gkj.apps.googleusercontent.com';  
    public string secret = 'JvjyEElZphq8JumevRtdQ91j';  
    public string redirect_uri = 'https://c.na15.visual.force.com/apex/popUpPage';  
    public String Drvfiletype {get; set;}
    public String Drvfilename {get; set;} 
    public Blob Drvfile {get;set;}
    public String recordsFiles {get;set;}
    public List<nativeCustomSetting__c> accCustomSet {get; set;}
    
   
    public nativeController(){
         recordfileFormat=new List<sObject>(); 
        
         getfield=new List<String>();
         mapValuesField=new Map<String,String>();
         wrapperClassList =new List<wrapperClass>();
         getfield =new List<String>();
         
         fileOption=new List<SelectOption>();
         queryData =new List<sObject>();
         pageList=new List<SelectOption>();
         ListfieldName=new List<SelectOption>();
         options = new List<SelectOption>();
         recordfileshow=new List<sObject>();
         accCustomSet=new List<nativeCustomSetting__c>();
         System.debug('-----------'+ApexPages.currentPage().getParameters());
         valAccToken= ApexPages.currentPage().getParameters().get('access_token');
         System.debug('--------------'+valAccToken);
         AllObjects();
         PageValue();
         FileNameOption();
    }
      
      //For Add all Native and Custom objects
      public void AllObjects() {
           try{
                options = new List<SelectOption>();
                ListfieldName=new List<SelectOption>();
                wrapperClassList =new List<wrapperClass>();
                options.add(new SelectOption('','--None--'));
                for(Schema.SObjectType d : gd){
                    options.add(new SelectOption(d.getDescribe().getName(),d.getDescribe().getLabel()));
                  }
                
             }catch(Exception e){
                ApexPages.addMessages(e);
             }
                
          options.sort();       
      }
     
      //Get a selected Object and call a ItemFieldsName() method for retrive a fields
      public void getFieldsName(){
              
              /* queryData =new List<sObject>();
              
               mapValuesField=new Map<String,String>();
               
               ListfieldName=new List<SelectOption>();
               wrapperClassList =new List<wrapperClass>();*/
               sObjectName = nativeAndCustomObject;
               ItemFieldsName();
    }
    
    //Get all fields related to Object
    public void ItemFieldsName(){
         try{
             message=null;
             ListfieldName=new List<SelectOption>();
             wrapperClassList =new List<wrapperClass>();
              if(sObjectName !=null){
                    Map<String, Schema.SObjectfield> getfields = Schema.getGlobalDescribe().get(sObjectName).getDescribe().Fields.getMap();
                    for(Schema.SObjectField sfield : getfields.Values()){ 
                       Schema.DescribeFieldResult F =  sfield.getDescribe();
                        if(f.isCreateable() && f.isSortable())
                            ListfieldName.add(new SelectOption(F.getName(),F.getLabel()));
                    }
               }
               
               if(ListfieldName.size() == 0)
                    message=' * Record Not Found..';
           }catch(Exception e)
             {
                ApexPages.addMessages(e);
             }
           ListfieldName.sort();
    }
    
   //Record show on pageBlockTable when we seleted on multipick list 
   public void recordShowData(){
         try{ 
                 message=null; 
                 if(getfield.size() == 0 || getfield == null)
                        message='* Select fields name...';
                 getfield.sort();
                mapValuesField=new Map<String,String>();
                wrapperClassList =new List<wrapperClass>();
                 if(ListfieldName !=null){     
                       commString=null;      
                        for(String p : getfield){
                               if(commString==null)
                                   commString=p+','+'Id';
                               else
                                 commString=commString+','+p;
                        }
                
                     soqlquery = 'Select '+commString+' from '+sObjectName+' LIMIT :blockSize OFFSET:index';
                     totalRecs=Database.countQuery('Select COUNT() from '+sObjectName+'');
                     queryData=Database.query(soqlquery);
                     queryData.sort();
                     if(queryData != null ){
                         for(sObject q : queryData){
                          
                           if(q != null)
                               wrapperClassList.add(new wrapperClass(q,false));
                         }
                         for(String p : getfield){
                              mapValuesField.put(p,p);
                          }
                          mapValuesField.put('Id','Id');
                     }
                       
                     // wrapperClassList.sort();
                }
                if(queryData.size()==0)
                     message=' * Record Not Found..';
           }catch(exception e){
            System.debug(e);
           }
           getchkValue(); 
    }
    
    public void UncheckBox(){
          for(wrapperClass cls :  wrapperClassList){
               if(cls.selected!=true)
                    getchkValue();
           }
    }
    
    //Wrapper Class for add Edit,Delete & CheckBox value with Sobject values
    public class wrapperClass{
      public boolean selected {get; set;}
      public String ed {get; set;}
      public String del {get; set;}
      public sObject record{get ; set;}
      public wrapperClass(sObject sobj,boolean chk){
           this.record=sobj;
           this.selected=chk;  
      } 
    }
    
   // This is use for pagination on Change commandButton
   public void pagination(){
        if(index >= 0){
               
                    for(wrapperClass cls :  wrapperClassList){
                      if(cls.selected==true)
                            recordfileshow.add(cls.record);
                   }
                   for(wrapperClass cls :  wrapperClassList){
                        for(Integer i =0; i<recordfileshow.size(); i++){
                         if(cls.record.id == recordfileshow[i].id){
                            if(cls.selected==false)
                              recordfileshow.remove(i);
                           }
                       } 
                   }
                  if(ListfieldName !=null){     
                        commString=null;      
                        for(String p : getfield){
                               if(commString==null)
                                   commString=p+','+'Id';
                               else
                                 commString=commString+','+p;
                        }
                     wrapperClassList =new List<wrapperClass>();
                     System.debug('for blockSize is check ----------------------'+blockSize+'+++++  '+index+'%%%%%%%%%%%%%%'+totalRecs); 
                     totalRecs=Database.countQuery('Select COUNT() from '+sObjectName+'');
                     soqlquery = 'Select '+commString+' from '+sObjectName+' LIMIT :blockSize OFFSET:index';
                     
                     queryData=Database.query(soqlquery);
                     system.debug('--------------------'+queryData);
                     for(sObject q : queryData){
                         wrapperClassList.add(new wrapperClass(q,false));
                     }
                     System.debug('C335c 6n Next+++++++'+wrapperClassList);
                     if(queryData != null ){
                         for(wrapperClass wrapper : wrapperClassList){
                            for(sObject cl :  recordfileshow){  
                               if(wrapper.record.id == cl.id)
                                   wrapper.selected =true;
                            }
                         }
                     }
                     System.debug('C335c Selecrted Records +++++++'+recordfileshow); 
              } 
       }     
    }
   
   //for a Pagination function begin with other pervious,next,first etc.
   public void beginning(){
        index = 0;
        getchkValue();
        pagination();
    }
    
    public void previous(){
         index = index - blockSize;
         getchkValue();
         pagination();
    }
    
    public void next(){   
        index = index + blockSize;
        getchkValue();
        pagination();
    }

    public void end(){
        
        index =math.mod(totalRecs,blockSize)==0? totalrecs - blockSize:totalrecs -math.mod(totalRecs,blockSize);
        System.debug('index value Of End function --------'+index);
        getchkValue();
        pagination();
        
    }        
    
    public boolean getprev() {
       if(index == 0)
        return true;
       else
        return false;
    }  
    
    public boolean getnxt(){
       if((index + blockSize) >= totalRecs)
        return true;
       else
        return false;
    } 
    
    //for Header check box is true/false on Condition like as first to next the Header check box false
    public boolean getchkValue(){
         this.chkValue=false;
         return false;
    }
    
    //Add value of picklist for show record in UI
    public void PageValue(){
      pageList=new List<SelectOption>();
      List<Integer> no= new List<Integer>{5,10,15};
      for(Integer i : no){
         pageList.add(new SelectOption(String.valueOf(i),String.valueOf(i)));
      }
   }
   
   //select value on Picklist It's show on pageblocktable on UI default It's Set on 5 
   public void PageNumber(){
      blockSize=Integer.valueOf(totalNumberOfPage);
      getchkValue();
      pagination();
   }
    
    //select a file format for Export like PDF,Excel and CSV format 
    public void FileNameOption(){
      fileOption.clear();
      fileOption.add(new SelectOption('','--None--'));
      fileOption.add(new SelectOption('.pdf','PDF'));
      fileOption.add(new SelectOption('.xls','EXCEL'));
      fileOption.add(new SelectOption('.csv','CSV'));
   }
    
   //Show a Record of selective Its check on Checkbox
   public List<wrapperClass> exportFile(){
      soqlquery = 'Select '+commString+' from '+sObjectName+' LIMIT :blockSize OFFSET:index';
      totalRecs=Database.countQuery('Select COUNT() from '+sObjectName+'');
      queryData=Database.query(soqlquery);
      System.debug('---------------------recordfileshow'+recordfileshow);
        if(queryData != null ){
                 for(sObject q : recordfileshow){
                   if(q != null)
                       wrapperClassList.add(new wrapperClass(q,true));
                 }
                 for(String p : getfield){
                   mapValuesField.put(p,p);
                 }
                   mapValuesField.put('Id','Id');
       }    
     return wrapperClassList;
   }
    
   //Create a wizard for refere for different-2 file format like pdf,excel & csv 
   public PageReference FileDescribeAction(){
          for(wrapperClass cls :  wrapperClassList){
                  if(cls.selected==true)
                        recordfileshow.add(cls.record);
          }
          if(recordfileshow.size()!=0){
               wrapperClassList.clear();
               for(sObject q : recordfileshow){
                   
                   if(q != null)
                       wrapperClassList.add(new wrapperClass(q,true));
               }
               for(String p : getfield){ 
                       mapValuesField.put(p,p);
               }
                       mapValuesField.put('Id','Id');
              if('.xls'==fileNameValue)
                 return new Pagereference('/apex/ExcelSheet');
              if('.pdf'==fileNameValue)
                 return new Pagereference('/apex/PDFShowRecord');
              if('.csv'==fileNameValue)
                 return new Pagereference('/apex/CSVShowRecord');
        }
        return new Pagereference('/apex/PDFShowRecord'); 
    } 

    //It's bind with  file format 
    public void Edit(){
        myId = ApexPages.currentPage().getParameters().get('recordId');
    }
   
   //record delete It's get Id with bind del commandLinkButton
   public void del(){
       myId = ApexPages.currentPage().getParameters().get('recordId');
   }
   
   //It's call on Delete commandLinkButton call By Action function call
   public void updateDataFunction(){
      List<sObject> delList=new List<sObject>();
      String myId = ApexPages.currentPage().getParameters().get('recordId');
      System.debug('>>>>>>>>>>>>>>'+myId);
      String query = 'Select id from '+sObjectName+' where  Id =:myId';
       try{    
         delList=Database.query(query);
         delete delList;
         wrapperClassList = new List<wrapperClass>();
         wrapperClassList.clear();
             soqlquery = 'Select '+commString+' from '+sObjectName+' LIMIT :blockSize OFFSET:index';
             totalRecs=Database.countQuery('Select COUNT() from '+sObjectName+'');
             queryData=Database.query(soqlquery);
         for(sObject q : queryData){
            if(myId != q.Id){
                if(q != null)
                    wrapperClassList.add(new wrapperClass(q,false));
            }
         }
      }catch(exception e){
         System.debug('-----exception----------'+e);
      }
  }
  
  //File upload for google Drive 
  public void uploadGoogleDrive(){
     try{
        message=null;
        recordfileFormat=new List<sObject>();
        recordsFiles=null;
         Attachment att = new Attachment(name =''+System.now());
           for(wrapperClass cls :  wrapperClassList){
                      if(cls.selected==true)
                            recordfileFormat.add(cls.record);
            }
           for(sObject cl : recordfileshow){
                  recordfileFormat.add(cl); 
           }
                 
                   
            if(fileNameValue==null || fileNameValue==''){
                message='* Select file Format...';
            }
             if(fileNameValue =='.csv'){
             recordsFiles=null;   
             for(String str: getfield){
                  if(recordsFiles == null)
                     recordsFiles=str+'   ';
                  else
                     recordsFiles +=str+'   ';   
            }  
               recordsFiles +=' \n ';
              
              for(sObject acc : recordfileFormat){
                  for(String field : getfield){
                    recordsFiles +=acc.get(field)+'         ';
                 }
                    recordsFiles +=' \n ';
              }
              
              System.debug('recordfileshow:::::::::'+recordsFiles);
              Drvfile=blob.valueOf(recordsFiles);
              Drvfiletype='text/csv';
              Drvfilename=att.name+'CSV';
          }
            
          if(fileNameValue =='.pdf'){
            
             recordsFiles=null;   
             for(String str: getfield){
                  if(recordsFiles == null)
                     recordsFiles=str+'   ';
                  else
                     recordsFiles +=str+'   ';   
            }  
               recordsFiles +=' \n ';
              
              for(sObject acc : recordfileFormat){
                  for(String field : getfield){
                    recordsFiles +=acc.get(field)+'         ';
                 }
                    recordsFiles +=' \n ';
              }
              
              System.debug('recordfileshow:::::::::'+recordsFiles);
              Drvfile=blob.valueOf(recordsFiles);
              Drvfiletype='application/pdf';
              Drvfilename=att.name+'PDF';
          }
          
          
          if(fileNameValue=='.xls'){
             recordsFiles=null;   
             for(String str: getfield){
                  if(recordsFiles == null)
                     recordsFiles=str+'   ';
                  else
                     recordsFiles +=str+'   ';   
            }  
               recordsFiles +=' \n ';
              
              for(sObject acc : recordfileshow){
                  for(String field : getfield){
                    recordsFiles +=acc.get(field)+'         ';
                 }
                    recordsFiles +=' \n ';
              }
              
              System.debug('recordfileshow:::::::::'+recordsFiles);
              Drvfile=blob.valueOf(recordsFiles);
              Drvfiletype='application/vnd.ms-excel';
              Drvfilename=att.name+'EXCEL';
          }
           //System.debug(table+'-------------FileUploadFunction is calling--------'+att+'\natt.body='+att.body+'\nDrvfilename='+Drvfilename+'\nDrvfiletype='+Drvfiletype+'\nDrvfile='+Drvfile);

        
        
         accCustomSet=[Select AccessToken__c FROM  nativeCustomSetting__c limit 1];
         if(accCustomSet.size() > 0)
            accToken=accCustomSet.get(0).AccessToken__c;
           System.debug('-------------accToken->>>-------'+accToken);
         if(accToken  !=null){
         
                 System.debug('tokenAcc???????????'+accToken);
               
                 String fileContains;
                 
                 HttpRequest req= new HttpRequest();  
                 String boundary = '----WebKitFormBoundaryp7MA4YWxkTrZu0gW';
                 String delimiter = '\r\n--' + boundary + '\r\n';
                 String close_delim = '\r\n--' + boundary + '--';
                 System.debug('file------token----'+Drvfilename+'-----type-----'+Drvfiletype+'------Records----'+Drvfile);
                 fileContains=EncodingUtil.base64Encode(Drvfile);
                 System.debug('Records------------'+fileContains);
                     String multipartRequestBody =
                        delimiter +
                   'Content-Type: application/json\r\n\r\n' + 
                   '{ "title" : "'+ Drvfilename+'",' +
                    ' "mimeType" : "'+ Drvfiletype+ '" }'  + 
                    delimiter + 
                   'Content-Type: ' + Drvfiletype+ '\r\n' +
                   'Content-Transfer-Encoding: base64\r\n' +
                   '\r\n' +
                    fileContains+
                    close_delim;
                   
                    System.debug('-------------accToken->>> for Request-------'+accToken);
                    req.setEndpoint('https://www.googleapis.com/upload/drive/v2/files');    
                    req.setMethod('POST');  
                    req.setHeader('Authorization','Bearer '+accToken);
                    req.setHeader('Content-Type','multipart/related; boundary="'+boundary+'"');
                    req.setHeader('Content-Length',String.valueOf(multipartRequestBody.length()));
                    req.setBody(multipartRequestBody);
                   
                   
                    Http h = new Http();  
                    HttpResponse res = h.send(req); 
                    System.debug('System.HttpResponse[Status=Unauthorized, StatusCode=401]>>>>'+res.getbody()); 
                  
               }   
            }catch(Exception e){ 
                System.debug('-----exception----------'+e);
            }               
   }
   
 
}
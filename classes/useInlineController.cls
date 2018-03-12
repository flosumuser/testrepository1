public class useInlineController {
 
 //record type field show in visualforce page
 public String recordField {get;set;}

 //controller for get a record type name related to contact
 public useInlineController(ApexPages.StandardController controller) {   
 	 Id recordId; 
 	 String idURL=null;
   if(ApexPages.currentPage().getParameters().get('id') != null) {
      idURL=ApexPages.currentPage().getParameters().get('id'); 
      
      // for get a record type Id
      for(Contact con : [select id,accountid,RecordTypeid from contact where id = :idURL])
             recordId=con.RecordTypeid;
       //for get a record name  
      for(RecordType soqlquery : [SELECT Id,Name FROM RecordType WHERE id=:recordId]){
            recordField=soqlquery.name; 
      }
   }
 }
}
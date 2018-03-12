public class accountTriggerHandler{
  
   public void accountRecordUpdate(Account[] accountNew,Account[] accountOld){
   Schema.DescribeSObjectResult objSchema = Account.sObjectType.getDescribe();
        //This map is get Dynamic fields of Account Object
        Map<String, Schema.SObjectField> fieldMap = objSchema.fields.getMap();
        //This is hold a Trigger.new values
       Map<ID,Account> mapOld=new Map<ID,Account>(); 
       Integer flag=0;
       String temp=null;
       String table=null;
        try{
                for(Account acc : accountOld){
                   mapOld.put(acc.id,acc);
                 }
                 table = '<table border="1">';
                 table +='<tr><th>ID</th><th>Field Name</th><th>New Value</th><th>Old Value</th></tr>';
                 //It's get a record from Trigger.new
                 for(Account acc : accountNew){
                     //This is check a Critical Data Yes / No
                      if(acc.CriticalData__c == true || mapOld.get(acc.id).get('CriticalData__c')==true){
                          //This is a get a fields information related to Account Object       
                            for (Schema.SObjectField fieldN : fieldMap.values()){
                                 Schema.DescribeFieldResult F =  fieldN.getDescribe();
                                 String  fieldName=F.getName();
                                 if(f.isCreateable() && f.isSortable()){
                                        if(acc.get(fieldName) != mapOld.get(acc.id).get(fieldName)){
                                                 if(temp != acc.ID){
                                                   //Change records are add in row but is't work only first time for ID Add & Print  
                                                    table=table +'<tr width="30"><td>'+acc.ID+'</td><td>'+fieldName+'</td><td>'+acc.get(fieldName)+'</td><td>'+mapOld.get(acc.ID).get(fieldName)+'</td></tr>';
                                                    flag=1;
                                                    temp=acc.ID;
                                                  }else{ 
                                                    //Other records for add in Rows
                                                    table = table +'<tr width="30"><td></td><td>'+fieldName+'</td><td>'+acc.get(fieldName)+'</td><td>'+mapOld.get(acc.ID).get(fieldName)+'</td></tr>'; 
                                                 }   
                                            }
                                 }
                            }
                          temp=null; 
                      }
                }
                table=table+'</table>';
         }catch(System.QueryException e){
               System.debug('ERROR:' +e);
          }
          //this is flag for use mail condition check if Record is updated then send E-mail
          if(flag==1){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            String[] toAddresses = new String[] {'shailendra@briskminds.com'}; 
            mail.setToAddresses(toAddresses); 
            mail.setSubject('Automated email: Contact created');
            mail.setHtmlBody(table);
            Messaging.sendEmail(new Messaging.SingleEMailMessage[]{mail});
          } 
    }
}
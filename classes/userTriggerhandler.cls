public class userTriggerhandler{

    public void sendEmail(list<Contact> conRecord){
    String UName='';
    
    UName=(String)conRecord.get(0).CustomUser__c;
    
    for(user u :[select FirstName,email from user])
        if(UName==u.FirstName){
            system.debug('debug........'+u.FirstName);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            String[] toAddresses = new String[] {u.email}; 
            mail.setToAddresses(toAddresses); 
            mail.setSubject('Automated email: Contact created');
            mail.setHtmlBody('Send email by contant object');
            System.debug('send email by Contact record>>>>>>>>');
            Messaging.sendEmail(new Messaging.SingleEMailMessage[]{mail});
        }
      }
}
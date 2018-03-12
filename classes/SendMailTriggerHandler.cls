public class SendMailTriggerHandler{
    
    public void sendEmail(list<Contact> ConRecord){
     String NameEmail='';
     
     NameEmail=ConRecord.get(0).CustomUser__c;
     Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
     
     System.debug('>>>>'+NameEmail) ;
      for(user u :[select name,email from user])
           if(u.Name==NameEmail){
                 System.debug('>>>>'+NameEmail) ;
                    mail.setCharset('inputValue') ; 
                    mail.setInReplyTo('inputValue'); 
                    mail.setWhatId(u.Id);
                    String[] toAddresses = new String[] {u.email}; 
                    String[] ccAddresses = new String[] {'shailendra@briskminds.com'};
                    mail.setToAddresses(toAddresses);
                    mail.setSenderDisplayName('Shailendra Tiwari');
                    mail.setSubject('New Case Created : ');
                    mail.setBccSender(false);
                    mail.setUseSignature(false);
                      
                    mail.setPlainTextBody('Your Case:  has been created.');
                    mail.setHtmlBody('Your case:<b>  </b>has been created.<p>'+'To view your case <a href=https://na1.salesforce.com/click here.</a>');
                      
                    // Send the email you have created.
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                    System.debug('email is successfully Send please check'+u.email);
                      
           }     
     }
}
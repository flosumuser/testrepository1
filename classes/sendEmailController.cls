public with sharing class sendEmailController {
	
	public String inputValue{get;set;}
	
	public sendEmailController(){
	  
	}  
	
	public void SendEmail(){
		ID str;
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		if(inputValue != null){
			for(OrgWideEmailAddress owea : [select Id,Address,displayName from OrgWideEmailAddress where Address =: inputValue]){
			  system.debug('---what id'+owea.Address);
			  mail.setCharset(inputValue) ; 
			  mail.setInReplyTo(inputValue); 
			  mail.setWhatId(owea.Id); 
			}
			 
			
			String[] toAddresses = new String[] {'shailendra@briskminds.com'}; 
			//String[] ccAddresses = new String[] {'smith@gmail.com'};
			
			mail.setToAddresses(toAddresses);
			
			
			//mail.setCcAddresses(ccAddresses); 
			//mail.setWhatId();  
			mail.setReplyTo(str);
			
			mail.setSenderDisplayName('Shailendra Tiwari');
			mail.setSubject('New Case Created : ');
			mail.setBccSender(false);
			mail.setUseSignature(false);
			
			mail.setPlainTextBody('Your Case:  has been created.');
			mail.setHtmlBody('Your case:<b>  </b>has been created.<p>'+'To view your case <a href=https://na1.salesforce.com/click here.</a>');
			
			// Send the email you have created.
			Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		}
	}

}
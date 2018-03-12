public with sharing class DetailShowPage
{
	public StudentNew__c student{get; set;}
	public StudentNew__c studentEdit {get; set;}
	public StudentNew__c studentUpdate{get;set;}
	public String studEditId {get; set;}
	public String isEdit {get; set;}
	public String isShow {get; set;}
	public StudentNew__c validate {get; set;}
	public DetailShowPage(){
		studentEdit=new StudentNew__c();
		student=new StudentNew__c();
		isEdit=ApexPages.currentPage().getParameters().get('isEditPage');
   		isShow=ApexPages.currentPage().getParameters().get('isShowPage');
   	    System.debug(studEditId+'The Student edit record id DetailShoPage>>>>>>>>>'+ApexPages.currentPage().getParameters().get('studEditId')+' '+studEditId);
   		
   		if(isEdit=='EditWorkCall'){
   			studentEdit=[select age__c,Name,currentAddress__c,DOB__c,Id from StudentNew__c where Id=:ApexPages.currentPage().getParameters().get('studEditId')];
   		}
   		if(isShow=='ShowWorkCall'){
   			student=[select age__c,Name,currentAddress__c,DOB__c,Id from StudentNew__c where Id=: ApexPages.currentPage().getParameters().get('studentId')];
   		}
   		
   }		
	public PageReference updateData(){
		 studentUpdate=new studentNew__c();
		 Boolean flag=false;
		try{
			System.debug('updated name show-------------------------->>>>>>>>Name='+studentEdit.Name+' Update After Value of Name-->>>>>>'+studentUpdate.Name);
			   if(studentEdit.Name == null || studentEdit.Name==''){
				  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Fill Name Value......'));
				  flag=true;
				}
				
				System.debug('Age Value>>>>>>>>>>>>>>>>>>>>>>'+studentEdit.age__c);
			  	if(studentEdit.age__c== null){
			  		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Fill Age Value......'));
			  		flag=true;
			  	}
			  	if(studentEdit.currentAddress__c==null || studentEdit.currentAddress__c==''){
			  		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Fill CurrentAddress Value......'));
			  		flag=true;
			  	}
			  	if(studentEdit.DOB__c==null || studentEdit.DOB__c==''){
			  		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Fill DOB Value......'));
			  		flag=true;
			    		
			  	}
			    
		 
		}catch (DmlException e) {   
	          ApexPages.addMessages(e);
	          
	   }
	   
	   if(flag==true){
	   	return null;
	   }
	   else
	   {
	       update studentEdit;
		   PageReference pageRef = new PageReference('https://c.na15.visual.force.com/apex/DetailShowPage?isShowPage=ShowWorkCall&studentId='+studentEdit.Id+'');
		   pageRef.setRedirect(true);
		   System.debug('>>>>>>>>>>>I m in PageReferece Call.....'+pageRef);
		   return pageRef; 
	   }
	}
    public pageReference  cancelData(){
        PageReference pageRef = new PageReference('https://c.na15.visual.force.com/apex/DetailShowPage?isShowPage=ShowWorkCall&studentId='+studentEdit.Id+'');
        pageRef.setRedirect(true);
        return pageRef; 
    }

}
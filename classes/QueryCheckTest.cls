/**

 */
@isTest
private class QueryCheckTest {

    static testMethod void myUnitTest() {
        /*List<Account> acc=[Select Name,(select Id From contacts)from Account limit 1];
        insert acc;
        System.debug([Select Name,(select Id From contacts)from Account limit 1]+'Account>>'+acc);
        
        //Invoice_Statement__c mobileCust=[select Description__c,Name,status__c from Invoice_Statement__c limit 1];
        System.debug('>>>>'+mobileCust.Description__c);
        
        List<Account> acc1=[Select Name from Account limit 1];
        System.debug('account Record>>>>'+acc1[1].Name);
        */
        
        List<Candidate__c> can=[select Name,Id,City__c,fax__c from Candidate__c ];
        insert can;
        
        System.debug('can++++'+can);
        
        //Candidate__c can1=(Candidate__c)[select Name,Id,City__c,fax__c from Candidate__c LIMIT 1];
    	 
    	//System.debug('can----'+can1.City__c); 
    	
    	 for(Integer i=0;i<110;i++)
				System.debug([Select Name,(select Id From contacts)from Account limit 1000]+'After Test.startTest()>>');
			 
		   
    }
}
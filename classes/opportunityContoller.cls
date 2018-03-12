public with sharing class opportunityContoller {
	public List<oppertunityProductAmountCalculation__c> productList {get; set;}
	public oppertunityProductAmountCalculation__c  productObject {get; set;}
	public oppertunityProductAmountCalculation__c  oppertunityProduct {get; set;}
	public Savepoint sp {get; set;} 
	public String productName {get; set;}
	public Decimal max;
	public Decimal min;
	public String SavedId;
   
    public opportunityContoller()
    {
    	min=0;
    	max=0;
     	oppertunityProduct=new oppertunityProductAmountCalculation__c();
     	
    }
    public PageReference saveRecordValue(){
    	
 	     System.debug('>>>>> I saveRecordValue'+oppertunityProduct.Max__c);
 	     Boolean flag=false;
 	     try{
         	productName=oppertunityProduct.Product__c;
         	System.debug('>>>>> I productName>>++'+productName);
	       	if(productName!=null){
		        productList = [select Name,Product__c,Min__c,Max__c,Price__c,Id from oppertunityProductAmountCalculation__c where oppertunityProductAmountCalculation__c.Product__c = : productName ORDER BY oppertunityProductAmountCalculation__c.Min__c ];
		        for(oppertunityProductAmountCalculation__c op : productList){
			        	 min=op.Min__c;
			        	 max=op.Max__c;
			        	 SavedId=op.id;
			        	 System.debug('DB_minValue inside for compaire>>>> '+ min+' MaxDB '+max +'Record Id '+SavedId);
			        	
		        }
		      System.debug('>>>>>MinDB '+min+'>>>>MaxDB '+max);
		       if(oppertunityProduct.Min__c!=null || oppertunityProduct.Min__c!=null || oppertunityProduct.Price__c!=null){
		       
		        	 if(min==0 && max==0)
		        	 {
		        	 	System.debug('0000000 Min Value i/p  '+ oppertunityProduct.Min__c+'Min DA>> '+min);
		        	 	 if(min <= oppertunityProduct.Min__c){
		                	  min=min+1;
		                	System.debug('>>>>>>>>>>>>>>>>>>>>>>> min '+min);
		                	if(min!=oppertunityProduct.Min__c){
			                	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Cannot use Minimum Value of Exits value ......'));
			                	System.debug('00 validation add in oBject>>>');
				        	    flag=true;	
		                	}
			        	}
			        	if(max>=oppertunityProduct.Max__c){
			        		flag=true;
			        		System.debug('01 validation add in oBject>>>');
			 				  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Cannot use Minimum Value of Exits value ......'));       	
			        	}
		            }
		               if(min!=0 && max!=0){
		            	System.debug('111111111111');
		            	 if(max>=oppertunityProduct.Min__c ){
		            	 	max=max+1;
		            	 	if(max!=oppertunityProduct.Min__c){
		            	 		System.debug('111111111111 '+max);
		                		System.debug('11 validation add in oBject>>>');
				        		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Cannot use Minimum Value of Exits value ......'));
				        	    flag=true;
		                	}
		                	
				        	}
				        	 if(max>=oppertunityProduct.Max__c){
					        		flag=true;
					        		System.debug('12 validation add in oBject>>>');
					 				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Cannot use Minimum Value of Exits value ......'));       	
				        	}
				        }
			            if(oppertunityProduct.Min__c==oppertunityProduct.Max__c){
	            	 	 	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Cannot be use Minimum & maximum Same value......'));
	            	 	 	flag=true;
	            	    }
	            	    System.debug('>>>max After a validation in use +++'+max);
	            	     
	            	     if((max+1)!=oppertunityProduct.Min__c){
	            	     	if(flag!=true){
	            	     	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Cannot be Value skip......'));
	            	 	 	flag=true;
	            	     	}
	            	     }
	            	     
	            	     
	            	     
		         }else{
		         	if(oppertunityProduct.Max__c==null){
		              		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please fill Maximum Field ......'));
		              	}
		              	if(oppertunityProduct.Min__c==null){
		              		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please fill Minimum Field ......'));
		              	}
		              	if(oppertunityProduct.Price__c==null){
		              		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please fill Price Field ......'));
		              	}
		         }  
		         
		         System.debug('Already Saved Values - : '+SavedId+' oppertunityProduct '+oppertunityProduct.Id);
		        
		                 if(flag==true){
		                 	       	
		                 	return null;
			   		     }else{
			   		     	try{
			   		     		if(oppertunityProduct!=null && oppertunityProduct.Price__c!=null && oppertunityProduct.Min__c!=null && oppertunityProduct.Max__c!=null){
			   		     		   			/*if(SavedId!=oppertunityProduct.Id){
										         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Record Already in here,Please fill Again ......'));
										        flag=true;
										        return null;
									         }*/
			   		     		   			insert oppertunityProduct;
			   		     		   	}
			   		     		
			   		        }catch (Exception e) {   
	                            ApexPages.addMessages(e);
	                             	
	                        }
	 		             }
			}else{
		  	  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Fill All Values ......'));
		  	}
		  
      }catch (DmlException e) {   
	          ApexPages.addMessages(e);
	   }
	 return null;
 }
 public List<oppertunityProductAmountCalculation__c> getProductData(){
       productName=oppertunityProduct.Product__c;
       
       productList = [select Name,Product__c,Min__c,Max__c,Price__c from oppertunityProductAmountCalculation__c where oppertunityProductAmountCalculation__c.Product__c = : productName ORDER BY oppertunityProductAmountCalculation__c.Min__c ];
       return productList;
  }
}
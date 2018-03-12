public with sharing class Calculate_Forecast_AmountHandler {

	//Opportunity in Record Insert after insert a Forecast_Amount_c records 
    public void afterInser(List<Opportunity> newRecords)    
    {
        List<Forecast_Amount__c> insertForecastList = new List<Forecast_Amount__c>() ;
        Forecast_Amount__c forecast ;
        for(Opportunity opp : newRecords)
        {
           if(opp.Amount != null && opp.Amount != 0)
           {
	            Integer endLoop = Integer.valueOf(opp.Duration__c) ;
	            for(Integer i=0; i < endLoop; i++)
	            {
	            	forecast = new Forecast_Amount__c() ;
		            forecast.Amount__c =(Decimal)opp.Amount/endLoop ;
		            forecast.Category__c = opp.ForecastCategoryName ;
		            forecast.Year__c = opp.CloseDate.year() ;
		            forecast.Month__c = String.valueOf(opp.CloseDate.month()+i);
		            if((opp.CloseDate.month()+i) > 12 )
		            {
		            	forecast.Month__c = String.valueOf((opp.CloseDate.month()+i)-12) ;
		            	forecast.Year__c = opp.CloseDate.year()+1;
		            	if((opp.CloseDate.month()+i) > 24)
		            	{
		            		forecast.Month__c = String.valueOf((opp.CloseDate.month()+i)-24) ; 
		            		forecast.Year__c = opp.CloseDate.year()+2;
		            	}
		            }
		            else
		            	forecast.Month__c = String.valueOf(opp.CloseDate.month()+i)	;
		            	
	            	forecast.Opportunity__c = opp.Id;
	            	insertForecastList.add(forecast) ;
		         }
            }
        }
        if(insertForecastList.size() > 0)
        	insert insertForecastList ;
        
    }
    
    //Opportunity Object in Record Update after change Forecast_Amount_c Fields 
    public void afterUpdate(Map<Id,Opportunity> newRecords)
    {
    	List<Forecast_Amount__c> updateForecastList = new List<Forecast_Amount__c>() ;
		Integer i=0;
		List<Opportunity> listOpp = new List<Opportunity>() ; 
		for(Opportunity opptunty : newRecords.Values()){
			listOpp.add(opptunty) ; 
		}
		
		if(newRecords.size() > 0)
			deleteRecord(newRecords.keySet());
		if(listOpp.size() > 0)
			afterInser(listOpp);  
		
        /*for(Forecast_Amount__c forecast :  [SELECT Id,Amount__c,Category__c,Year__c,Month__c,Opportunity__c FROM Forecast_Amount__c where Opportunity__c IN: newRecords.keySet()])
        {
        	Opportunity opp = newRecords.get(forecast.Opportunity__c) ;
 			if(forecast.Amount__c != opp.Amount || forecast.Category__c != opp.ForecastCategoryName)
		    {
	     		Integer endLoop = Integer.valueOf(opp.Duration__c) ;
	     	    forecast.Amount__c = (Decimal)opp.Amount/endLoop ;  
	            forecast.Category__c = opp.ForecastCategoryName ;
	            forecast.Year__c = opp.CloseDate.year() ;
	            if((opp.CloseDate.month()+i) > 12 )
	            {
            		forecast.Month__c = String.valueOf((opp.CloseDate.month()+i)-12) ;
            		forecast.Year__c = opp.CloseDate.year()+1;
            		if((opp.CloseDate.month()+i) > 24)
            		{
            			forecast.Month__c = String.valueOf((opp.CloseDate.month()+i)-24) ; 
            			forecast.Year__c = opp.CloseDate.year()+2;
            		}
	            }
	            else
	            	forecast.Month__c = String.valueOf(opp.CloseDate.month()+i)	;
	            i++;
	            updateForecastList.add(forecast) ;	
		   	}
         }*/
        
         
    }
    //update before delete records
    public void deleteRecord(Set<Id> Id)
    {
    	 List<Forecast_Amount__c> deleteForecastList = new List<Forecast_Amount__c>() ;
    	 for(Forecast_Amount__c forecast :  [SELECT Id FROM Forecast_Amount__c where Opportunity__c IN: Id]){
    	 	deleteForecastList.add(forecast); 
    	 }
    	 if(deleteForecastList.size() > 0)
    	 	delete deleteForecastList;
    }
 }
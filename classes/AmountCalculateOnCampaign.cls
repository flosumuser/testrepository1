public with sharing class AmountCalculateOnCampaign {
    
     public void amountCalcuate(CampaignMember[] comp){
         
                 map<id,Campaign> campaignMap=new map<id,Campaign>([select Id,AmountAllOpportunities from Campaign]);
                 
                 for(Campaign ky : campaignMap.values()){
                    System.debug('Campaign key------>'+ky.id);
                 }
                 Campaign cm;
                 for(CampaignMember campAmount : comp){
                    System.debug('trigeer Values'+campAmount.TotalAmount__c+campAmount.CampaignId);
                    System.debug('>===>>'+campaignMap.get(campAmount.CampaignId));
                    cm=campaignMap.get(campAmount.CampaignId);
                    System.debug('AmountAllOpportunities<><><>'+cm.AmountAllOpportunities);
                    //cm.AmountAllOpportunities+=campAmount.TotalAmount__c;
                     
                    //amount+=Integer.valueOf(campAmount.TotalAmount__c);
                    
                    //campaignMap.get(campAmount.CampaignId).AmountAllOpportunities+=campAmount.TotalAmount__c;
                 }
    }
}
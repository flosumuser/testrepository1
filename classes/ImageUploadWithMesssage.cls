public with sharing class ImageUploadWithMesssage {
    public String txtMessage {get; set;}
    public msgSendToFB__c messageSaveObj {get; set;}
    public ImageUploadWithMesssage(){
      messageSaveObj= new msgSendToFB__c(); 
    }
    public void MessageSave(){
       insert messageSaveObj;
    }
}
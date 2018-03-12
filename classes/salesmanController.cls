public class salesmanController{
    public Salesman__c salesman{get;set;}
    private String message{get;set;}
     public salesmanController(){
       salesman=new Salesman__c();
     }
     public String getMessage(){
       return message;
     }
     
     public void dataSave(){
      insert salesman;
       message='Data is successfully submited.....';
     }

}
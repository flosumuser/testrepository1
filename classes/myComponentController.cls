public class myComponentController {
  
  public string ConId {get;set;}
  public String productID {get;set;}
  public Contact contactObj  {get;set;}
  
  public Contact mycomponent {
      get{
           contactObj = [select Id from Contact where Id =: ConId];
           return contactObj;}
      set;}
  
  public myComponentController(){
      System.debug('------------conId------componnentController'+ConId);
  }
  
  public string getproductID(){
    return productID=mycomponent.Id;
  }
}
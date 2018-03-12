public class myController 
{

 String name;
 
  public String getName() {
        return name;
    }

    public void setName(String name)
     {
        this.name = name;
    }

 public void Save()
 {
    // String name=ApexPages.currentPage().getParameters().get('name');
    // System.debug(name);
   System.debug('I am : ' + name);
 }
 

//String name=ApexPages.currentPage().getParameters().get('name');
// System.debug(name);
   
}
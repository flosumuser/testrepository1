public class ClassTest
{
public String optionSelect {get ; set;}
public String ClassOption {get ; set;}
List<School__c> items;
List<Class__c> ClassItems;
List<Student__c> student; //{get ; set;}
List<Wstudent> wsList; 
List<Wstudent> studentToDeleteList;
List<Student__c> studentList;
 
public ClassTest()
{
      
      student=new List<Student__c>();
    
      items =[select address__c,ID,Name from School__c];
 
       ClassItems =[select NoOfStudent__c,School__c,Name from Class__c where School__c = :optionSelect]; 
         
 }
         
    public void refreshContacts()
     {
       if(optionSelect!=null)
       {
         //  ClassItems =[select NoOfStudent__c,School__c,Name from Class__c where School__c = :optionSelect]; 
       }
         System.debug('The select option value is ---'+optionSelect);   
          
     }

 public void classAction()
     {
       
      if(ClassItems!=null)
         {
             for(Class__c l : ClassItems)
             {
             // classObj.add(l);
               System.debug('The classoption values items ---:' +l.Name);
               
             }
         }

         System.debug('The select option value is ---'+ClassOption);   
          
     }

    public List<SelectOption> getItems() 
    {
   
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Select','Select'));
        for(School__c c : items)
        {
            options.add(new SelectOption(c.ID,c.Name));
        }
        return options;
    }
    
   public void setItems(List<School__c> items)
   {
      this.items=items;  
   }
  
   
   public List<SelectOption> getClassItems() 
    {
        List<SelectOption> optCls = new List<SelectOption>();
        optCls.add(new SelectOption('Select','Select'));
        for(Class__c c : ClassItems)
        {
            optCls.add(new SelectOption(c.ID,c.Name));
        }
        return optCls;
    }
    
  public void setClassItems(List<School__c> items)
  {
     this.items=items;  
  }
  
  public List<Wstudent> getStudent()
  {
      if(ClassOption!=null)
      {
            wsList = new List<Wstudent>();
            student= [select Name,Class__c,CurrentAddress__c,Email_ID__c,Mobile_No__c,Permanent_Address__c,DOB__c FROM Student__c where Class__c= :ClassOption];
      
            for(Student__c st : student){
            
                wsList.add(new Wstudent(st));
            
            }
            
            return wsList ;
      }
      return null;
        
  }
  
 
  
  
  
  //wrapper class in....
 
 public class Wstudent
 {
    public boolean isSelected{ get ; set ;}
    public Student__c std {get ; set ;}
     
     public Wstudent(Student__c stud)
     {
        this.std =stud;
        isSelected=false;
     }
     
      
 }
 
 
 public void deleteRecord()
 {
  studentToDeleteList=new List<Wstudent>();
  studentList=new List<Student__c>();
  System.debug('The list of value-------------------------');
     
   for(Wstudent wr: wsList)
   {
     if(wr.isSelected==true)
     {
        studentList.add(wr.std);
     }
     
   }
   if(studentList!=null)
   {
       for(Student__c studObj : studentList)
       {
          delete studObj;
       }
   }
   
   
   
 }
  
  
}
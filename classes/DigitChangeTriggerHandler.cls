public  with sharing class DigitChangeTriggerHandler{
  public list<ClassNew__c> listClass {get;set;}
  public String patVal {get;set;}
  public map<Id,ClassNew__c> mapClassObj {get;set;}
  public list<string> str {get;set;}
  public list<Integer> val {get;set;}
  public String result{get;set;}
  public String patternVal {get;set;}
  public string regexFormat{get;set;}
  
  public DigitChangeTriggerHandler(){
    listClass=new list<ClassNew__c>();
    mapClassObj=new map<Id,ClassNew__c>();
    str=new list<string>();
    val=new list<Integer>();
  }
 
  public void changeFieldInsert(ClassNew__c[] classNew){
      try{
            str=new list<string>();
            val=new list<Integer>();
            result=null;
            for(ClassNew__c patterChange : classNew){
                 patternVal=patterChange.TextChangeValue__c;
                 regexFormat='(?![\\w]+[0-9]+$)[\\w]+[0-9]+$)';
                 
                 if(!Pattern.matches('[a-zA-Z]+[0-9]+[a-zA-Z]+[0-9]', patternVal)){
                    str=patternVal.split('[a-zA-Z]');
                 }
            
              for(String s : str){ 
                    if(s != ''){
                        val.add(Integer.valueOf(s.subString(0,2))+1);
                        val.add(Integer.valueOf(s.subString(3,5))+1);
                    }
              }
               
                str=patternVal.split('[0-9]');
                 for(String s : str){
                            if(s != ''){
                                   if(result==null)
                                       result=s;
                                   else
                                       result+=s; 
                                  for(Integer j : val){         
                                       for(Integer i=0; i<=val.size();i++){
                                         result+=j;
                                         val.remove(i);
                                         break;
                                        }
                                         break;
                                  }
                             }
                 }
                 patterChange.TextChangeValue__c=result;
              }
        }catch(exception e){}
  }
  
  public void changeFieldUpdate(ClassNew__c[] classNew,ClassNew__c[] classOld){
    try{
         str=new list<string>();
         val=new list<Integer>();
         mapClassObj=new map<Id,ClassNew__c>();
         result=null;
         patternVal=null;
         regexFormat=null;
         
         for(ClassNew__c fmat : classOld){
            mapClassObj.put(fmat.Id,fmat);
          }
          for(ClassNew__c patterChange : classNew){
            if(patterChange.TextChangeValue__c != mapClassObj.get(patterChange.Id).TextChangeValue__c){
                     patternVal=patterChange.TextChangeValue__c;
                     regexFormat='(?![\\w]+[0-9]+$)[\\w]+[0-9]+$)';
                     List<string> str;
                     if(!Pattern.matches('[a-zA-Z]+[0-9]+[a-zA-Z]+[0-9]', patternVal)){
                        str=patternVal.split('[a-zA-Z]');
                     }
                
                    list<Integer> val=new list<Integer>();
                    for(String s : str){
                        if(s != ''){
                            val.add(Integer.valueOf(s.subString(0,2))+1);
                            val.add(Integer.valueOf(s.subString(3,5))+1);
                        }
                    }
                   
                     str=patternVal.split('[0-9]');
                     for(String s : str){
                                if(s != ''){
                                       if(result==null)
                                           result=s;
                                       else
                                           result+=s; 
                                      for(Integer j : val){         
                                           for(Integer i=0; i<=val.size();i++){
                                             result+=j;
                                             val.remove(i);
                                             break;
                                            }
                                             break;
                                      }
                                 }
                     }
                     patterChange.TextChangeValue__c=result;
              }
              update patterChange;
             }
        }catch(exception e){}
  }
}
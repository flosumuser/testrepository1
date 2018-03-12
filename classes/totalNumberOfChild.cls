public class totalNumberOfChild{
    public set<Id> accSet;
    public list<Account> accListRecords;
    public Account RecordOld;
    public list<Account> accList; 
   
    public totalNumberOfChild(){
       accSet=new set<Id>();
       RecordOld=new Account();
       accListRecords=new list<Account>();
       accList=new list<Account>();
       }
       
    //It's work on Recrod Insert
    public void BeforeInsertChildCalculate(Account[] accNew){
         accListRecords=new list<Account>();
         accSet=new set<Id>();
         accList=new list<Account>();
         for(Account a : accNew){
              accSet.add(a.ParentId); 
              System.debug('AccSet'+accSet);
         }
       
          for(Account a : [select ParentID,Id,TotalNumberOfChild__c,phone,Name from Account]){
              if(a.TotalNumberOfChild__c == null){
              	 a.TotalNumberOfChild__c=0;
                 accList.add(a);
              }
          }
          
          accListRecords= [select ParentID,Id,TotalNumberOfChild__c,phone,Name from Account where Id IN: accSet];
         			for(Account ac : accListRecords){
         				if(ac.TotalNumberOfChild__c!=0 || ac.TotalNumberOfChild__c!=null){
                            ac.TotalNumberOfChild__c+=1;
                            accList.add(ac);
                         }
                         else{
                            ac.TotalNumberOfChild__c=0;
                            accList.add(ac);
                         }
                     }
               update accList;
   }     
   
    //It's work on Record Delete    
   public void BeforeDeleteChildCalculate(Account[] accOld){
      accSet=new set<Id>();
      accListRecords=new list<Account>();
      accList=new list<Account>();
      for(Account a : accOld){
         accSet.add(a.ParentId);
      }
      accListRecords=[select ParentID,Id,TotalNumberOfChild__c,phone,Name from Account where Id IN : accSet];
       for(Account a : accListRecords){
           if(a.TotalNumberOfChild__c == null || a.TotalNumberOfChild__c==0){
               a.TotalNumberOfChild__c=0;
               accList.add(a);
            }
            else{
               a.TotalNumberOfChild__c=a.TotalNumberOfChild__c-1;
               accList.add(a);
            }
        }
          update accList;   
    }
    
  //It's work on Update Record 
  public void BeforeUpdateChildCalculate(Account[] accNew, map<id,Account> accOld){
         accSet=new set<Id>();
         accList=new List<Account>();
         RecordOld=new Account();
         accListRecords=new List<Account>();    
          for(Account a : accNew){
           RecordOld=accOld.get(a.Id);
          System.debug('Old map values-------------'+RecordOld);
          if(a.ParentId !=RecordOld.parentId){
          	  if(a.ParentId !=null  ){
	             accSet.add(a.parentId);
          	  }
	          if( RecordOld.parentId !=null){
	             accSet.add(RecordOld.parentId);
          	  }
          }
       }
       	  AccList = [Select Id,TotalNumberOfChild__c,(Select id from ChildAccounts), ParentId From Account where Id IN : accSet]; 
          for(Account a : AccList){
          List<Account> acc = a.getSObjects('ChildAccounts'); 
         	if(acc !=null)
         	   a.TotalNumberOfChild__c=acc.size();
         	else
         	   a.TotalNumberOfChild__c=0;
         	
         	update a;
         }
   }
   
     //It's work on After UnDelete Record
     public void AfterUnDeleteChildCalculate(Account[] accNew){
          accList=new List<Account>();
          Account[] acc=[select TotalNumberOfChild__c from Account where id in :accNew]; 
          for(Account a : acc){
             accList.add(a);
          }
            update accList;
     }    
}
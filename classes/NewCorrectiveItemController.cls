public with sharing class NewCorrectiveItemController 
{
	public String removeIndex{get;set;}
	public List<WraperCorrective> newCorrectiveList{get;set;}
	public Integer indexing;
	public Map<String,Corrective_Item__c> correctiveMap{get;set;}
	public NewCorrectiveItemController(ApexPages.StandardController controller)
	{
		//newCorrectiveList = new List<WraperCorrective>();
		correctiveMap = new Map<String,Corrective_Item__c>();
		indexing=0;
	}
	public NewCorrectiveItemController()
	{
		newCorrectiveList = new List<WraperCorrective>();
	}
	public void addCorrective()
	{
		indexing++;
		correctiveMap.put('key'+indexing,new Corrective_Item__c());
		//newCorrectiveList.add(new WraperCorrective(new Corrective_Item__c(),indexing));
	}
	public class WraperCorrective
	{
		public Integer index{get;set;}
		public Corrective_Item__c c{get;set;}
		public WraperCorrective(Corrective_Item__c c,Integer indexing)
		{
			this.c=c;
			this.index=indexing;
		}
	}
	public Integer getIndex()
	{
		if(correctiveMap.containsKey(removeIndex))
		{
			correctiveMap.remove(removeIndex);
			/*for(Integer i=0; i< newCorrectiveList.size(); i++) 
			{
				WraperCorrective w = newCorrectiveList.get(i);
				if(w.index == removeIndex)
				{
					return i;
				}
			}*/
		}
		return null;
	}
	public void removeCall()
	{
		if(correctiveMap.containsKey(removeIndex))
		{
			correctiveMap.remove(removeIndex);
		}
		//Integer i = getIndex();
		//if(i!= null)
			//newCorrectiveList.remove(i);
	}
}
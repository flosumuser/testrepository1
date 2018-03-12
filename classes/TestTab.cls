public with sharing class TestTab
{
	public List<acWedgeData> acData{ get; set; }
	public List<Account> liAccount{ get; set; }
	
	public List<AreaSeriesWraper> data{ get; set; }
	
    public TestTab(Apexpages.standardcontroller con)
    {
    	data = new List<AreaSeriesWraper>(); 
    	acData = new List<acWedgeData>();
    	for(Account ac: [SELECT Name,NumberOfEmployees From Account WHERE Name != null AND NumberOfEmployees != null LIMIT 5])
    		acData.add(new acWedgeData(ac.Name, ac.NumberOfEmployees));
    	System.debug('--acData--:'+acData);
    	liAccount = [SELECT Name,NumberOfEmployees From Account WHERE Name != null AND NumberOfEmployees != null LIMIT 5];
    	
    	data.add(new AreaSeriesWraper(120,10,2,'One'));
    	data.add(new AreaSeriesWraper(20,10,3,'Two'));
    	data.add(new AreaSeriesWraper(60,15,2,'Three'));
    	data.add(new AreaSeriesWraper(40,20,1,'Four'));
    	
    	/*data.add(new AreaSeriesWraper(10,10,2,'1'));
    	data.add(new AreaSeriesWraper(20,13,3,'2'));
    	data.add(new AreaSeriesWraper(12,17,2,'3'));
    	data.add(new AreaSeriesWraper(9,8,1,'4'));
    	data.add(new AreaSeriesWraper(5,20,1,'5'));*/
    }
    
    public List<PieWedgeData> getPieData() {
        List<PieWedgeData> data = new List<PieWedgeData>();
        data.add(new PieWedgeData('Jan', 30));
        data.add(new PieWedgeData('Feb', 15));
        data.add(new PieWedgeData('Mar', 10));
        data.add(new PieWedgeData('Apr', 20));
        data.add(new PieWedgeData('May', 20));
        data.add(new PieWedgeData('Jun', 100));
        return data;
    }

    // Wrapper class
    public class PieWedgeData 
    {
        public String name { get; set; }
        public Integer data { get; set; }

        public PieWedgeData(String name, Integer data) 
        {
            this.name = name;
            this.data = data;
        }
    }
    
    //Wraper class
    public class acWedgeData
    {
    	public String name { get; set; }
        public Integer data { get; set; }
        
    	public acWedgeData(String name, Integer data) 
        {
            this.name = name;
            this.data = data;
        }
    }
    
    public class AreaSeriesWraper
    {
    	public Integer data1{ get; set; }
    	public Integer data2{ get; set; }
    	public Integer data3{ get; set; }
    	public String name{ get; set; }
    	
    	public AreaSeriesWraper(Integer data1,Integer data2,Integer data3,String name )
    	{
    		this.data1 = data1;
    		this.data2 = data2;
    		this.data3 = data3;
    		this.name = name;
    	}
    }
}
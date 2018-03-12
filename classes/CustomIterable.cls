global class CustomIterable implements Iterator<Account>
{ 

    List<Account> accs {get; set;} 
    Integer i {get; set;} 

    public CustomIterable(List<Account> accs)
    { 
       	this.accs = accs;
       	/*[SELECT Id, Name, 
       	NumberOfEmployees 
       	FROM Account 
       	WHERE Name = 'false']; */
       	i = 0; 
    }   

    global boolean hasNext()
    { 
       	if(i >= accs.size()) 
       	{
        	return false; 
       	} 
       	else 
       	{
        	return true; 
       	}
    }    

	global Account next()
	{ 
		// 8 is an arbitrary 
        // constant in this example
        // that represents the 
        // maximum size of the list.
        if(i >= accs.size())
        {
       		return null;
        } 
        i++; 
        return accs[i-1]; 
   	} 
}
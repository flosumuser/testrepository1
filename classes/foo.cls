global class foo implements iterable<Account>
{
	global List<Account> accList;
	
	public foo(List<Account> accList)
	{
		this.accList = accList;
	}
	
	global Iterator<Account> Iterator()
	{
		return new CustomIterable(accList);
	}
}
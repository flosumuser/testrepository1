global with sharing class MyWebService 
{
    webService static String getBase64() 
    {   
        return JSON.serialize([SELECT Id,Name FROM Account]);
    }
}
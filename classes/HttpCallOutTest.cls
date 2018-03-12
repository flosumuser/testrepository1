@isTest
global class HttpCallOutTest implements HttpCalloutMock
{
	global HttpResponse respond(HTTPRequest req)
	{
	    HttpResponse res = new HttpResponse();
	    
	    res.setStatus('OK');
	    res.setStatusCode(200);
	    String requestEndPoint = req.getEndpoint();
	    String body = '';
	    String tokenUrl = 'https://www.box.com/api/oauth2/token';
	    String fileUploadUrl = 'https://upload.box.com/api/2.0/files/content';
	    String fileUrl ='https://api.box.com/2.0/';
	    String downloadUrl = 'https://api.box.com/2.0/files/';
	    if(requestEndPoint.contains(tokenUrl))
	    {
		    res.setHeader('Content-Type', 'application/json');
		    body= '{"access_token": "T9cE5asGnuyYCCqIZFoWjFHvNbvVqHjl",' +
					    '"expires_in": 3600,' +
					    '"restricted_to": [],' +
					    '"token_type": "bearer",' +
					    '"refresh_token": "J7rxTiWOHMoSC1isKZKBZWizoRXjkQzig5C6jFgCVJ9bUnsUfGMinKBDLZWP9BgR"}';  
	    }
	    if(requestEndPoint.contains(fileUploadUrl))
	    {
	    	res.setHeader('Content-Type', 'application/json');
	    	body='{     "total_count": 1,     "entries": [         {             "type": "file",             "id": "5000948880",             "sequence_id": "3",             "etag": "3",             "sha1": "134b65991ed521fcfe4724b7d814ab8ded5185dc",             "name": "Test.txt",             "description": "a picture of tigers",             "size": 629644,             "path_collection": {                 "total_count": 2,                 "entries": [                     {                         "type": "folder",                         "id": "0",                         "sequence_id": null,                         "etag": null,                         "name": "All Files"                     },                     {                         "type": "folder",                         "id": "11446498",                         "sequence_id": "1",                         "etag": "1",                         "name": "Pictures"                     }                 ]             },             "created_at": "2012-12-12T10:55:30-08:00",             "modified_at": "2012-12-12T11:04:26-08:00",             "trashed_at": null,             "purged_at": null,             "content_created_at": "2013-02-04T16:57:52-08:00",             "content_modified_at": "2013-02-04T16:57:52-08:00",             "created_by": {                 "type": "user",                 "id": "17738362",                 "name": "sean rose",                 "login": "sean@box.com"             },             "modified_by": {                 "type": "user",                 "id": "17738362",                 "name": "sean rose",                 "login": "sean@box.com"             },             "owned_by": {                 "type": "user",                 "id": "17738362",                 "name": "sean rose",                 "login": "sean@box.com"             },             "shared_link": null,             "parent": {                 "type": "folder",                 "id": "11446498",                 "sequence_id": "1",                 "etag": "1",                 "name": "Pictures"             },             "item_status": "active"         }     ] }';
	    	
	    } 
	    if(requestEndPoint.contains(fileUrl))
	    {
	    	if(requestEndPoint.contains('files/'))
	    	{
	    		if(req.getMethod() == 'GET')
	    		{
			    	res.setHeader('Location', 'raw');
			    	res.setStatus('Found');
			    	res.setStatusCode(302);
	    		}
	    		else if(req.getMethod() == 'DELETE')
	    		{
	    		 
	    		}
	    	}
	    	else if(requestEndPoint.contains('folders'))
	    	{
	    		if(requestEndPoint.contains('/items') && req.getMethod() == 'POST')
		    	{  
		    		res.setHeader('Content-Type', 'application/json');
		    		body='{     "total_count": 24,     "entries": [         {             "type": "folder",             "id": "192429928",             "sequence_id": "1",             "etag": "1",             "name": "Stephen Curry Three Pointers"         },         {             "type": "file",             "id": "818853862",             "sequence_id": "0",             "etag": "0",             "name": "Warriors.jpg"         }     ],     "offset": 0,     "limit": 2,     "order": [         {             "by": "type",             "direction": "ASC"         },         {             "by": "name",             "direction": "ASC"         }     ] }';
		    	}
		    	else if(req.getMethod() == 'GET')
		    	{	    		
		    		res.setHeader('Content-Type', 'application/json');
		    		body='{"total_count":10,"entries":[{"type":"folder","id":"2004779767","sequence_id":"0","etag":"0","name":"Kumar"},{"type":"folder","id":"2007342195","sequence_id":"0","etag":"0","name":"yahoo"},{"type":"file","id":"17577515557","sequence_id":"1","etag":"1","sha1":"d9362b68157e3045cd8f1987df0822beac1c2110","name":"ClonAssignment.docx"},{"type":"file","id":"17615207892","sequence_id":"0","etag":"0","sha1":"f447c76ba5ce1069e27c6eeedd36804c119cfa64","name":"event.doc"},{"type":"file","id":"17586640313","sequence_id":"0","etag":"0","sha1":"a73bbb18f26fdbef044fc76820b9c9cc8f374cf4","name":"New Text Document ff.txt"},{"type":"file","id":"17586646189","sequence_id":"0","etag":"0","sha1":"2d0b77f0303d0444a168151cece33e50198edcf9","name":"Page (1).txt"},{"type":"file","id":"17586655251","sequence_id":"0","etag":"0","sha1":"69350c334c3ab6d8d0e8ff320d7ac4eb24000831","name":"Page 2.txt"},{"type":"file","id":"17586656675","sequence_id":"0","etag":"0","sha1":"2d0b77f0303d0444a168151cece33e50198edcf9","name":"Page.txt"},{"type":"file","id":"17615078534","sequence_id":"0","etag":"0","sha1":"1dc17debdf1433994b415eec44ca104304b21644","name":"Postman_UploadFileExample.png"},{"type":"file","id":"17815968638","sequence_id":"0","etag":"0","sha1":"6ea54271c7d36320ebe2c853e56fca676bb4eca2","name":"test7123.txt"}],"offset":0,"limit":100,"order":[{"by":"type","direction":"ASC"},{"by":"name","direction":"ASC"}]}';
		    	}
		    	else if(req.getMethod() == 'DELETE')
	    		{
	    		 
	    		}
	    	}
	    }
	   
	    res.setBody(body);
	    return res;
    }
}
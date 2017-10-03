var VJSUtil = {
	cleanSFMessage: function(msg) {
		var commaIndex = msg.indexOf(',');
    	if(commaIndex > -1) {
        	msg = msg.substring(commaIndex+1);
    	}

    	return msg;
	}
};
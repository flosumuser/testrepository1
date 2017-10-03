jQuery(document).ready(function() {
	if(navigator.userAgent && navigator.userAgent.indexOf('WebKit') > -1) {
		var stylesheet = document.styleSheets[0],
            selector = "select", 
            rule = "{ border-color: #999; }";

        if (stylesheet.insertRule) {
            stylesheet.insertRule(selector + rule, stylesheet.cssRules.length);
	    }
    }
});
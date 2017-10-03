/* Style for placeholders(required text displyed within input text)*/
/* webkit browsers */
::-webkit-input-placeholder {font-style: italic; }
/* firefox 19+ */
::-moz-placeholder {font-style: italic; } 
/* ie */
:-ms-input-placeholder {font-style: italic; }
/* firefox */ 
input:-moz-placeholder {font-style: italic; }

/* Style to make drop down look and feel as text box*/
select { 
    /* this hides the select's background making any styling visible from the div */
    background-color:white !important;
    background-image:none !important; 
    -webkit-appearance: none !important; /* this is required for Webkit browsers */ 
    border:solid 1px #BBB;
    border-radius:4px;
    box-shadow:none; 
    padding:0.35em 0.3em !important; /* padding should be added to the select, not the div */
}
#main {
    margin:10px;
    font-size:14px;
    line-height:20px;
}   
.location-section {
    box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.5); 
    border: 1px solid rgba(255, 255, 255, 0.2); 
    border-radius: 3px; 
    background: linear-gradient(rgb(232, 232, 232), rgb(250, 250, 250));
    padding: 10px;
}
tr.field-section td {
    padding:5px; vertical-align:middle;
}
tr.field-section td:first-child {
    text-align:right;
    width: 50%
}
tr.field-section td:last-child {
    text-align:left;
    width: 50%
}
tr.field-section td input, tr.field-section td select, tr.field-section td textarea {
    width:250px;
}
.submit-span {
    display:block; text-align:center; margin: 10px 5px 10px 5px; padding-top: 10px;
}
input[type=submit], input[type=submit]:hover, input[type=submit]:active, input[type=button], input[type=button]:active, input[type=button]:hover {
    background: #7cafcc; 
    /* Old browsers */ 
    background: -moz-linear-gradient(top, #7cafcc 0%, #7cafcc 100%); 
    /* FF3.6+ */ 
    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #7cafcc), color-stop(100%, #7cafcc)); 
    /* Chrome,Safari4+ */ 
    background: -webkit-linear-gradient(top, #7cafcc 0%, #7cafcc 100%); 
    /* Chrome10+,Safari5.1+ */ 
    background: -o-linear-gradient(top, #7cafcc 0%, #7cafcc 100%); 
    /* Opera 11.10+ */ 
    background: -ms-linear-gradient(top, #7cafcc 0%, #7cafcc 100%); 
    /* IE10+ */ 
    background: linear-gradient(to bottom, #7cafcc 0%, #7cafcc 100%); 
    /* W3C */ 
    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#7cafcc', endColorstr='#7cafcc', GradientType=0); 
    /* IE6-9 */ 
    padding: 5px 15px 5px 15px !important;
    font-weight: bold;
    color: white;
}
.redborder, .k-invalid {
    border:solid 2px red; /* This will display red border around fields that are required */
    border-radius:5px;
}
span.k-tooltip {
    display:none !important;  /* This will hide kendo error message tooltip */
}
a:link, a:visited, a:active {color: #0B7CCF;}
a:hover {color:#005580;}
a.button, a.button:active, a.button:hover {
    background: #7cafcc; 
    /* Old browsers */ 
    background: -moz-linear-gradient(top, #7cafcc 0%, #7cafcc 100%); 
    /* FF3.6+ */ 
    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #7cafcc), color-stop(100%, #7cafcc)); 
    /* Chrome,Safari4+ */ 
    background: -webkit-linear-gradient(top, #7cafcc 0%, #7cafcc 100%); 
    /* Chrome10+,Safari5.1+ */ 
    background: -o-linear-gradient(top, #7cafcc 0%, #7cafcc 100%); 
    /* Opera 11.10+ */ 
    background: -ms-linear-gradient(top, #7cafcc 0%, #7cafcc 100%); 
    /* IE10+ */ 
    background: linear-gradient(to bottom, #7cafcc 0%, #7cafcc 100%); 
    /* W3C */ 
    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#7cafcc', endColorstr='#7cafcc', GradientType=0); 
    /* IE6-9 */ 
    padding: 5px 15px 5px 15px !important;
    text-decoration: none !important;
    color: white;
}
.subtitle{
    background-color: #316989; 
    padding: 9px 8px 9px 8px; 
    margin: 10px 0px 15px 0px; 
    color: white; 
    border-radius: 5px; 
    font-weight: bold; 
    box-shadow: 0px 1px 6px rgb(150, 150, 150); 
}

.caption 
{
    text-align: left;
    padding: 5px 5px;
    margin-bottom: 5px;
    color: #ffffff;
    background-color: rgb(55, 124, 163);
    border-radius: 3px;
}

.k-window-titlebar 
{
    background: #316989; /* Old browsers */ 
    background: -moz-linear-gradient(top, #316989 0%, #4a7187 100%); /* FF3.6+ */ 
    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #316989), color-stop(100%, #4a7187)); /* Chrome,Safari4+ */ 
    background: -webkit-linear-gradient(top, #316989 0%, #4a7187 100%); /* Chrome10+,Safari5.1+ */ 
    background: -o-linear-gradient(top, #316989 0%, #4a7187 100%); /* Opera 11.10+ */ 
    background: -ms-linear-gradient(top, #316989 0%, #4a7187 100%); /* IE10+ */ 
    background: linear-gradient(to bottom, #316989 0%, #4a7187 100%); /* W3C */ 
    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#316989', endColorstr='#4a7187', GradientType=0); /* IE6-9 */ 
    color: white; 
    text-shadow: 0px 0px 1px #000;
}

.message ul { margin: -15px 0px 0px 0px !important;list-style-type: none;}
   
#checks {
    list-style-type: none; margin: 0; padding: 0; text-align: center;
}
#checks li {
    margin: 15px 0 0 0;
}
#checks li:first-child {
    margin: 15px 85px 0 0;
}
.grey-button, .grey-button:active, .grey-button:hover, .grey-button:disabled {
    background: #AAAAAA !important;
    /* Old browsers */ 
    background: -moz-linear-gradient(top, #AAAAAA 0%, #AAAAAA 100%);
    /* FF3.6+ */ background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #AAAAAA), color-stop(100%, #AAAAAA)); 
    /* Chrome,Safari4+ */ 
    background: -webkit-linear-gradient(top, #AAAAAA 0%, #AAAAAA 100%); 
    /* Chrome10+,Safari5.1+ */
    background: -o-linear-gradient(top, #AAAAAA 0%, #AAAAAA 100%);
    /* Opera 11.10+ */ 
    background: -ms-linear-gradient(top, #AAAAAA 0%, #AAAAAA 100%);
    /* IE10+ */
    background: linear-gradient(to bottom, #AAAAAA 0%, #AAAAAA 100%);
    /* W3C */
    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#AAAAAA', endColorstr='#AAAAAA', GradientType=0);
    /* IE6-9 */
    padding: 5px 15px 5px 15px !important;
    color:#fff;
}

/*-----------------------------------------------*/
/*             RAMP UI 13 CSS Starts                */
/*-----------------------------------------------*/
#v-training {
	width:922.313px;
	height: auto;
	margin: -9px 0px 0px .5cm;
	padding:0px 0px 0px 0px;
	border:none;
}

#v-training .subtitle {
	
	font-family: Arial,Helvetica,sans-serif;
	display: block;
	text-align: left;
	margin-top: 10px;
	margin-bottom: 10px;
	border-right: 1px solid rgb(74, 126, 187);
	border-left: 1px solid rgb(74, 126, 187);
	border-width: 1px;
	border-style: solid;
	border-radius: 5px;
	font-weight: bold;
	padding: 6px 5px;
	border-color: rgb(74, 126, 187);
	background-color: #377ca3;
	box-shadow: 0px 2px 6px rgb(150, 150, 150);
	color: white;
	font-size:15px;
}

#v-training #main-header {

	font-family: Arial,Helvetica,sans-serif;
	font-size:14px;
}

#v-training #tabstrip {
    border:none;
	font-size:13px !important;
}

#tabstrip .k-content{
	padding: 0px !important;
}

#tabstrip .k-header {
	text-align:center;
}

.k-tabstrip-items .k-state-active {
    background: #377CA3; /* Old browsers */ background: -moz-linear-gradient(top, #377CA3 0%, #377CA3 100%); /* FF3.6+ */ background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#377CA3), color-stop(100%,#377CA3)); /* Chrome,Safari4+ */ background: -webkit-linear-gradient(top, #377CA3 0%,#377CA3 100%); /* Chrome10+,Safari5.1+ */ background: -o-linear-gradient(top, #377CA3 0%,#377CA3 100%); /* Opera 11.10+ */ background: -ms-linear-gradient(top, #377CA3 0%,#377CA3 100%); /* IE10+ */ background: linear-gradient(to bottom, #377CA3 0%,#377CA3 100%); /* W3C */ filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#377CA3', endColorstr='#377CA3',GradientType=0 ); /* IE6-9 */ color:white;
}

.k-tabstrip-items .k-state-active .k-link {
    color:white;
}

.k-state-active, .k-state-active:hover, .k-active-filter {
    background-color: #fff; border-color: #316989; color: #2e2e2e;
}

#v-training .k-window-titlebar {
    background: rgb(55, 124, 163); color: white; text-shadow: 0px 0px 1px #000;
}

#v-training .submit-button, .submit-button:active, #v-training .submit-button:hover, #v-training .k-button:hover {
    background: #7cafcc; 
    /* Old browsers */ 
	 background: -moz-linear-gradient(top, #7cafcc 0%, #7cafcc 100%);
	/* FF3.6+ */ 
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #7cafcc), color-stop(100%, #7cafcc)); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top, #7cafcc 0%, #7cafcc 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top, #7cafcc 0%, #7cafcc 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top, #7cafcc 0%, #7cafcc 100%); /* IE10+ */
	background: linear-gradient(to bottom, #7cafcc 0%, #7cafcc 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#7cafcc', endColorstr='#7cafcc', GradientType=0); /* IE6-9 */
	padding: 4px 14px 4px 14px; font-size:15px;outline:none;border:none; */
}

#v-training .message {
	margin-top:10px;
	margin-bottom: -5px;
}

#v-training .message .messageText h4 {
	font-weight: bold;
	display: none !important;
}

#v-training .messageCell {
	font-size:12px;
}

#v-training .confirmM3 .msgIcon, .confirmMedium {
	background-image: url(/img/msg_icons/confirm32.png) !important;
	background-position: 0 0 !important;
	width: 32px !important;
	height: 32px !important;
}

#v-training .large-content-block {
	margin: 10px auto;
	padding: 10px 10px 10px 10px;
	box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.5);
	border: 1px solid rgba(255, 255, 255, 0.2);
	border-radius: 3px;
	background: linear-gradient(#E8E8E8, #FAFAFA);
}

/*-----------------------------------------------*/
/*X            RAMP UI 13 CSS Finished             X*/
/*-----------------------------------------------*/
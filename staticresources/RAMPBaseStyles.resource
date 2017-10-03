#main {
    width: 800px;
    font-size: 12px;
}

#main a {
    color: rgb(0, 104, 154);
}

#main-header {
    font-size: 14px;
}

#page-title {
    font-family:Arial, Helvetica, sans-serif;
    display: block;
    text-align: left;
    margin-bottom: 10px;
    border-right: solid 1px black;
    border-left: solid 1px black;
    border-bottom: solid 1px black;
    border-top: solid 1px black;
    border-radius: 5px 5px 5px 5px;
    font-weight:600;
    padding: 6px 11px 6px 11px;
    border-color:#4A7EBB;
    background-color: #377ca3;
    box-shadow: 0px 2px 6px rgb(150, 150, 150);
    color:white;
    width: 100%;
}

#page-title h1 {
    font-size: 14px;
}

.subtitle{
    font-family:Arial, Helvetica, sans-serif;
    display: block;
    text-align: left;
    margin-bottom: 10px;
    border-right: solid 1px black;
    border-left: solid 1px black;
    border-bottom: solid 1px black;
    border-top: solid 1px black;
    border-radius: 5px 5px 5px 5px;
    font-weight:600;
    padding: 6px 11px 6px 11px;
    border-color:#4A7EBB;
    background-color: #377ca3;
    box-shadow: 0px 2px 6px rgb(150, 150, 150);
    color:white;
    width: 100%;
    font-size: 14px;
}

.large-content-block {
    width: 800px;
    margin: 10px auto;
    padding: 10px 10px 10px 10px;
    box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.5);
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 3px;
    background: linear-gradient(rgb(232, 232, 232), rgb(250, 250, 250));
}

.small-content-block {
    width: 600px;
    margin: 10px auto;
    padding: 10px 10px 10px 10px;
    box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.5);
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 3px;
    background: linear-gradient(rgb(232, 232, 232), rgb(250, 250, 250));
}

div.section-title {
    text-align: left;
    padding: 5px 0px 5px 5px;
    margin-bottom: 5px;
    color: #ffffff;
    background-color: rgb(55, 124, 163);
    border-radius: 3px;
    width: 99.5%;
}

table.checkbox-table {
	margin: 0 auto;
}

table.form-table {
    width: 100%;
    font-size: 14px;
    word-wrap: break-word;
}

table.form-table caption {
    text-align: left;
    padding: 5px 5px;
    margin-bottom: 5px;
    color: #ffffff;
    background-color: rgb(55, 124, 163);
    border-radius: 3px;
}

table.form-table th, table.form-table td {
    padding: 0px 0px 10px 0px;
}


table.form-table td.label {
    width: 40%;
    text-align: right;
    padding-right: 10px;
}

table.form-table colgroup col.center {
    text-align: center;
}

table.form-table input[type=text], table.form-table select, table.form-table textarea {
    width: 80%;
}

table.form-table select {
	font-size: 14px;
}

/* hack required because Salesforce deletes styles on
   dependent picklists */
select[webkit=webkit] {
    border-color: #999;
}

input.k-textbox {
    height: 1.75em;
}

.k-ff input.k-textbox {
	height: 1.75em;
}

.k-ie input.k-textbox {
	height: 1.75em;
}

table.form-table td.button-block {
	vertical-align: middle;
	text-align: center;
	padding: 0px 0px;
}


.k-button:active, .k-button:focus:active {
    background-image: none, linear-gradient(to bottom,  0px, rgb(169, 159, 154) 100%);
    box-shadow: 0px 0px 3px 1px rgb(169, 159, 154) inset;
    border-color: rgb(197, 197, 197);
}

.v-save-button, .v-save-button:hover, .v-save-button:focus, .v-save-button:active,
.v-save-button:focus:active {
    background-image: none;
    border-color: rgb(124, 175, 204) !important;
    background-color: rgb(124, 175, 204);
    color: #ffffff;
}

.v-cancel-button, .v-cancel-button:hover, .v-cancel-button:focus, .v-cancel-button:active,
.v-cancel-button:focus:active  {
    border-color: rgb(233, 63, 63) !important;
    background-color: rgb(233, 63, 63) !important;
    background-image: none;
    color: #ffffff;
}

#v-save-dialog {
    display: none;
}

#v-save-dialog div {
    margin: 0 auto;
    position: relative;
    top: 25px;
    text-align: center;
}

#v-processing-text {
    font-size: 16pt;
    top: -0.25em;
    position: relative;
}

.k-window {
    border-color: #377ca3;
    background-color: #377ca3;
}

.k-window-titlebar {
    color: #fff;
    background-image: none/*, linear-gradient(to bottom, rgb(55, 124, 163) 0px, rgb(74, 126, 187) 100%)*/;
    border-color: rgb(55, 124, 163);
    background-color: rgb(55, 124, 163);
}

.redborder, .k-invalid {
    border: solid 2px red;
}
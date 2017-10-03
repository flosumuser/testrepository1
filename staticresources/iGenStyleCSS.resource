@charset "utf-8";
/* CSS Document */




body{
	width: 1200px;
	margin:auto !important;
}

/* START OF HEADER and NAV */

.headermain {
	/*background:url("/resource/iGenImages/headerbg.png");*/
	width: 1200px;
	height: 189px;
}


.logo {
	background-image:url("/resource/iGenImages/logo.png");
	width: 220px;
	height: 93px;
	padding-top: 51px;
	background-repeat: no-repeat;
	background-position: left bottom;
	margin-left: 34px;
}

.utilLink {
     margin-top: -110px; 
     background-image:url("/resource/iGenImages/logoutarrow.png"); 
     background-repeat: no-repeat;
     background-position: right top;
     padding-right: 40px;
     height: 31px;
     padding-top: 8px;
     text-transform: uppercase;
     margin-right: 30px;
}

.utilLink a {
     text-decoration: none;
     font-weight: normal; 
     color: #000;  
}

.utilLink a:hover {
   text-decoration: underline;  
}

.tabNavigation {
    /*border-radius: 5px;
    background-image: -webkit-linear-gradient(top, #c9d34e, #a7c057);
    background-image: -moz-linear-gradient(top, #c9d34e, #a7c057);
    background-image: -ms-linear-gradient(top, #c9d34e, #a7c057);
    background-image: -o-linear-gradient(top, #c9d34e, #a7c057);
    background-image: linear-gradient(top, #c9d34e, #a7c057);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#c7d251', endColorstr='#a7c057' ,GradientType=0);
	width: 1160px;
	margin-left: 15px;
	height: 25px;
	padding: 5px;*/
	
	margin-top: 45px;
	margin-left: 13px;
	margin-top: 45px;
	
	background-image: url(/resource/iGenImages/menu-bg.png) !important;
	background-repeat: no-repeat;
	background-color: transparent !important;
	
	height: 22px;
	width: 1150px;
	padding: 5px;
}

.tab .currentTab div {
     background: none !important;
     text-transform: uppercase;
     
        
}

.tab td div, .tab .last div {
    background: none !important;
    text-transform: uppercase;
    
        
}

.tab .currentTab {
     background: none;
     text-transform: uppercase;
     text-decoration: underline;
        
}

.tab td {
   background: none;
   border: none;
   font-weight: bold;
   text-transform: uppercase;
    
   
}

body .tab, body .tab a {
      color: #fff !important;  
}

/* END OF HEADER and NAV */

/* START OF BODY */


.bodyDiv {
    /*background-image:url("/resource/iGenImages/bodybg.png"); */
    background-repeat: repeat-x;
    margin-top: 74px;
    padding-top: 33px;
    border-bottom: none !important;
    
   
}

.bPageHeader{
	position: absolute !important;
	top: 127px !important;
	z-index: 1 !important;		
} 



#bodyTable {
     margin-left: 15px !important; 
    
}


/* SIDEBAR */

.sidebarModule {
	border: none;
	background: none;

}

.sidebarCell .imageModule {
     display: none !important;   
}

.sidebarModuleHeader  {
     background: none !important;
     color:  #595a5c !important;
     font-size: 16px; 
}


.sidebarCell .searchModule select {
     height: 25px !important;   
}

.searchTextBox {
     height: 18px !important;
     width: 165px !important;   
}


.btn {
    background: #aaaaaa;
    border: none;
    height: 23px;
    text-transform: uppercase;
    margin-top: 10px;
    /*width: 35px;*/
}

.searchFooter {
     border: none !important;   
}

.searchFooter a {
      color: #00689a;
      font-size: 12px; 
}

#sidebarCell {
    height: 780px !important;
    border: solid 2px #fff;
    background-image: -webkit-linear-gradient(top, #e8e8e8, #fafafa);
    background-image: -moz-linear-gradient(top, #e8e8e8, #fafafa);
    background-image: -ms-linear-gradient(top, #e8e8e8, #fafafa);
    background-image: -o-linear-gradient(top, #e8e8e8, #fafafa);
    background-image: linear-gradient(top, #e8e8e8, #fafafa);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#e8e8e8', endColorstr='#fafafa' ,GradientType=0);
	border-radius: 8px;
	-moz-box-shadow:     0 0 10px #d2d2d2;
	-webkit-box-shadow:  0 0 10px #d2d2d2;
	box-shadow:          0 0 10px #d2d2d2;
}
.sidebarCell .sidebarModuleHeader .brndPrmFg label {
	background-image: url("/resource/iGenImages/icnsearch.png");
	background-repeat: no-repeat;
	padding-left: 30px;
	padding-bottom: 8px;
	padding-top: 3px;	
	
}

.sidebarCell .recentItemModule .brndPrmFg {
    background-image: url("/resource/iGenImages/icnrecent.png");
	background-repeat: no-repeat;
	padding-left: 30px;
	padding-bottom: 8px;
	padding-top: 5px;	
}

.sidebarModulePortalWelcomeContainer .sidebarModuleHeader h2 {
    font-size: 15px !important;
    font-weight: bold !important;
    color: #484848; 
     
}

span.currentUser {
    color: #000;
    font-weight: normal;
}

.sidebarModuleBody .sidebarModulePortalWelcome {
     color: #00689a;
     font-size: 12px; 
}

.mruItem a{
    color: #000 !important;
    text-decoration: none;
} 


.bPageTitle {
	width: 965px !important;	
}

.bPageBlock, .individualPalette .bPageBlock {
	width: 965px !important;	
}    



/*CONTENT BUTTONS*/

.listHeader .btn {
    /*width: 90px !important;*/
}

.listHeader span .btn {
    /*width: 150px !important;*/
}

.pbBottomButtons .btn {
    /*width: 60px !important;*/
}

.pbButton .btn {
    /*width: 90px !important;*/
	padding-left: 10px; 
	padding-right: 10px;
}

.pbButtonb .btn {
    /*width: 90px !important;*/
}

#container_bubble {
	width: 979px !important;	
}

.buttons .btn {
   /*width: 90px !important;*/
   height: 30px; 
}


#hotlist .pbButton .btn {
  /*width: 220px !important; */
}

.listRelatedObject .listHeader .btn {
     width: 180px !important;
}

#sidebarSearchButton {
   width: 50px;
}

#workspaceViewMembers .btn {
   width: 50px;  
}

/* END CONTENT BUTTONS*/



#workspacePopularTags {
	margin-top: 281px;
	margin-left: -977px;
}

#workspaceRecentActivity {
	margin-left: -977px;
	
}

#workspaceTopContributors {
	margin-left: -977px;
}


.bPageTitle .ptBody .pageType {
     font-size: 12px !important;
     font-family:   Arial,Helvetica,sans-serif;  
}

.noRowsHeader {
     font-size: 12px !important;
     font-family:   Arial,Helvetica,sans-serif;	
}

#bodyDiv {
     font-size: 12px !important;
     font-family:   Arial,Helvetica,sans-serif; 
}

.bPageBlock .pbTitle {
     font-size: 12px !important;
     font-family:   Arial,Helvetica,sans-serif; 
}


.detailList label {
     font-size: 11px !important;
     font-family:   Arial,Helvetica,sans-serif;
     width: 400px;   
}

.detailList {
     font-size: 12px !important;
     font-family:   Arial,Helvetica,sans-serif; 
}


/* END OF BODY */




/* START OF FOOTER */

.footer{
     background: #dfdfdf;
     border-radius: 5px;
     height: 30px; 
     margin-bottom: 15px;
     line-height: 2.5;
     color: #abc25f;
     text-align: right;
     padding-right: 20px;
     margin-top: 30px;
}
/* END OF FOOTER */
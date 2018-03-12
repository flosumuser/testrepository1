@isTest
private class BoxControllerTest  
{
	private static BoxController controller;
	private static void tokenUtility()
	{
		controller = new BoxController();
		controller.accessToken='T9cE5asGnuyYCCqIZFoWjFHvNbvVqHjl';
		controller.accessTokenType='bearer';
	}
	static testMethod void refreshTokenTest()
	{
    	tokenUtility();
    	Test.setMock(HttpCalloutMock.class, new HttpCallOutTest());
		controller.refreshToken('Test','Test','Test');
	}
	static testMethod void accessTokenTest()
    {
    	Test.setMock(HttpCalloutMock.class, new HttpCallOutTest());
    	Test.setCurrentPage(Page.BoxIntegrationPage);
    	Apexpages.currentPage().getParameters().put('code','wQpgfxjdXvcXXaRoAYZ3DHjLFnG8erVX');
    	Apexpages.currentPage().getParameters().put('state','MyState');
    	
    	controller = new BoxController();
		controller.boxTokenCaller();
    }
    static testMethod void authorizationTest()
    {
    	Test.setCurrentPage(Page.BoxIntegrationPage);
    	
    	controller = new BoxController();
    	PageReference pref = controller.boxAuth();
    	System.assertEquals('https://www.box.com/api/oauth2/authorize?client_id=g7zmufolv6jzqi1sxqd4lgbwe06930xd&redirect_uri=https%3A%2F%2Fc.ap1.visual.force.com%2Fapex%2FBoxIntegrationPage&response_type=code&state=MyState', pref.getUrl());
    	
    	Apexpages.currentPage().getParameters().put('code','wQpgfxjdXvcXXaRoAYZ3DHjLFnG8erVX');
    	Apexpages.currentPage().getParameters().put('state','MyState');

    	
    }
    static testMethod void createBoxFolderTest()
    {
    	tokenUtility();
    	Test.setMock(HttpCalloutMock.class, new HttpCallOutTest());
    	
    	
    	controller.folder_name = 'Test Folder';
    	controller.selectedParentFolder = '0';
    	controller.createBoxFolder();
    	
    	//system.assertEquals();
    }
    static testMethod void downloadFileTest()
    {
    	tokenUtility();
    	Test.setMock(HttpCalloutMock.class, new HttpCallOutTest());
    	
    	controller.selectedFileToDownload = '34534534543';
    	controller.getFileFromBox(); 
    	
    }
    static testMethod void allListMethodTest()
    {
		tokenUtility();
    	Test.setMock(HttpCalloutMock.class, new HttpCallOutTest());
    	
		controller.selectedFolderToOpen = '34534534543';
		controller.selectedFolderToOpen = '0';
    	controller.getDropList();
    	controller.getFolderList();
    	controller.getDownloadFileList();
    }  
    static testMethod void uploadFileTest()
    {
    	tokenUtility();
    	Test.setMock(HttpCalloutMock.class, new HttpCallOutTest());
    	
		controller.accessToken='T9cE5asGnuyYCCqIZFoWjFHvNbvVqHjl';
		controller.accessTokenType='bearer';
		controller.file_content_type='text/plain';
    	controller.file_name='Test.txt';
    	controller.fileToUpload=Blob.valueOf('Test Blob');
		
    	controller.uploadFileToBox();
    	
    }
    static testMethod void deleteTest()
    {
    	tokenUtility();
    	Test.setMock(HttpCalloutMock.class, new HttpCallOutTest());
		
		controller.selectedFileToDelete ='34242';
    	controller.deleteFileFromBox();
    	controller.deleteFolderFromBox();
    	
    }
    static testMethod void allRenderMethodTest()
    {
    	controller = new BoxController();
    	controller.getrenderAuthBlock();
    	tokenUtility();
    	controller.getrenderAuthBlock();
    	controller.renderFileUpload();
    	controller.renderAllBlock();
    	controller.renderCreateFolder();
    	controller.renderDeleteFile();
    	controller.renderDownloadFile();
    	
    }
}
public class ITRequestServices {

    String ServiceStatusText;
    List<IT_Service_Request__c> ServiceGridData;
    Boolean ServiceInsertFlag;
    Integer ServiceInsertCount;
    IT_Request__c IT_Request;
    String requestId;

    // Constuctor for extending the standard controller
    public ITRequestServices () {
        //system.debug('!!!Controller Start!!!');
        IT_Request = [select Id, Name from IT_Request__c where Id = :ApexPages.currentPage().getParameters().get('id')];
        requestId = IT_Request.id;
        ServiceStatusText = '';
        ServiceGridData = ServiceGridDataList();
        ServiceInsertFlag = false;
        ServiceInsertCount = 0;
        //system.debug('!!!Controller End!!!');
    }

    // Fill Service list with data
    public List<IT_Service_Request__c> ServiceGridDataList(){
        //system.debug('!!!GridData List Start!!!');
        List<IT_Service_Request__c> gl;
        try {
            gl = [Select i.SystemModstamp, i.Price__c, i.Name, i.LastModifiedDate, i.LastModifiedById, i.IsDeleted, i.Id, i.IT_Service__c, i.IT_Request__c, i.CreatedDate, i.CreatedById, i.IT_Service__r.IT_Asset_Group__c From IT_Service_Request__c i where i.IT_Request__c = :IT_Request.id];
        } catch (QueryException e){
            system.debug(e.getMessage());
            ServiceStatusText = e.getMessage();
        }
        //system.debug('!!!GridData List Stop!!!');
        return gl;
    }


    // Called from Grid to get List of Servcice requests
    public List<IT_Service_Request__c> getServiceGridData () {
        ServiceGridData = ServiceGridDataList();
        if (ServiceInsertFlag){
           ServiceGridData.add(new IT_Service_Request__c(IT_Request__c = IT_Request.id));
           ServiceInsertFlag = false;
        }
        return ServiceGridData;
    }

    // Called from Page to pass values from Service grid to controller
    public void setServiceGridData(List<IT_Service_Request__c> gd) {
        ServiceGridData = gd;
    }

    // Called from Page to get Service StatusText
    public String getServiceStatusText() {
        return ServiceStatusText;
    }
    
    // Called from Page to get IT Request id
    public String getRequestId() {
        return requestId;
    }
    
    public String getServiceInsertFlag() {
        if(ServiceInsertCount > 0){
            return 'true';
        }
        else {
            return 'false';
        }
    }

    
    // Called from Service Grid "Save" Button
    public PageReference saveServiceRequest () {
        try {
            upsert ServiceGridData;
        } catch (DMLException e) {
            system.debug(e.getMessage());
            ServiceStatusText = e.getMessage();
        }   
        ServiceGridData = ServiceGridDataList();
        ServiceInsertCount = 0;
        return null;
    }

    // Called from Service Grid "Add" Button
    public PageReference addServiceRequest () {
        ServiceInsertCount++;
        ServiceInsertFlag = true;
        return null;
    }

    // Called from Service Grid "Cancel" Button
    public PageReference CancelServiceRequest () {
        ServiceGridData = ServiceGridDataList();
        ServiceInsertFlag = false;
        ServiceInsertCount = 0;
        return null;
    }
}
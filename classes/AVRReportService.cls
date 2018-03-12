@restResource(urlMapping='/avrreport/*')
global class AVRReportService {

  @httpGet
  global static User authenticate() {

    // check if the use have create permission on the AVR report object.
    if (!Schema.sObjectType.AVR_Report_Audit__c.isCreateable()) {
      return null;
    }

    return [SELECT id, firstName, lastName, email from User where id=:UserInfo.getUserId()];
  }
}
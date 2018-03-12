<?xml version="1.0" encoding="UTF-8"?>
<Workflow    xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_Log</fullName>
        <description>Send Log</description>
        <protected>false</protected>
        <recipients>
            <field>Email_Id__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Temp_Folder/Test_Log</template>
    </alerts>
    <rules>
        <fullName>Send Log</fullName>
        <actions>
            <name>Send_Log</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Target_Hello_Object__c.Send_Email__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
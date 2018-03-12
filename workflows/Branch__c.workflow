<?xml version="1.0" encoding="UTF-8"?>
<Workflow    xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>BBC</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Branch__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Jumbo</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Branch Rule</fullName>
        <actions>
            <name>Alert</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Alert</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>This is branch workflow rule.</description>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
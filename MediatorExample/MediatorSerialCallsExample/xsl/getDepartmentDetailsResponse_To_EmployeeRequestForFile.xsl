<?xml version="1.0" encoding="UTF-8" ?>
<?oracle-xsl-mapper
  <!-- SPECIFICATION OF MAP SOURCES AND TARGETS, DO NOT MODIFY. -->
  <mapSources>
    <source type="WSDL">
      <schema location="../DepartmentFinderPort.wsdl"/>
      <rootElement name="getDepartmentDetailsResponse" namespace="http://departmentfinder/"/>
    </source>
    <source type="WSDL">
      <schema location="../Mediator1.wsdl"/>
      <rootElement name="EmployeeRequest" namespace="http://www.example.org"/>
      <param name="initial.request" />
    </source>
  </mapSources>
  <mapTargets>
    <target type="WSDL">
      <schema location="../WriteEmployeeDetails.wsdl"/>
      <rootElement name="EmployeeRequest" namespace="http://www.example.org"/>
    </target>
  </mapTargets>
  <!-- GENERATED BY ORACLE XSL MAPPER 11.1.1.5.0(build 110406.1400.11) AT [SAT FEB 04 10:54:32 EST 2012]. -->
?>
<xsl:stylesheet version="1.0"
                xmlns:bpws="http://schemas.xmlsoap.org/ws/2003/03/business-process/"
                xmlns:xp20="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.Xpath20"
                xmlns:bpel="http://docs.oasis-open.org/wsbpel/2.0/process/executable"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:inp1="http://www.example.org"
                xmlns:bpm="http://xmlns.oracle.com/bpmn20/extensions"
                xmlns:mf="http://www.oracle.com/XSL/Transform/java/com.example.reusable.asset"
                xmlns:ns1="http://xmlns.oracle.com/pcbpel/adapter/file/SimpleWebServices/MediatorSerialCallsExample/WriteEmployeeDetails"
                xmlns:plt="http://schemas.xmlsoap.org/ws/2003/05/partner-link/"
                xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
                xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
                xmlns:ora="http://schemas.oracle.com/xpath/extension"
                xmlns:socket="http://www.oracle.com/XSL/Transform/java/oracle.tip.adapter.socket.ProtocolTranslator"
                xmlns:geo="http://www.oracle.com/XSL/Transform/java/com.example.reusable.asset.CheckDept"
                xmlns:mhdr="http://www.oracle.com/XSL/Transform/java/oracle.tip.mediator.service.common.functions.MediatorExtnFunction"
                xmlns:oraext="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.ExtFunc"
                xmlns:dvm="http://www.oracle.com/XSL/Transform/java/oracle.tip.dvm.LookupValue"
                xmlns:hwf="http://xmlns.oracle.com/bpel/workflow/xpath"
                xmlns:jca="http://xmlns.oracle.com/pcbpel/wsdl/jca/"
                xmlns:med="http://schemas.oracle.com/mediator/xpath"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ids="http://xmlns.oracle.com/bpel/services/IdentityService/xpath"
                xmlns:xdk="http://schemas.oracle.com/bpel/extension/xpath/function/xdk"
                xmlns:xref="http://www.oracle.com/XSL/Transform/java/oracle.tip.xref.xpath.XRefXPathFunctions"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:bpmn="http://schemas.oracle.com/bpm/xpath"
                xmlns:ns0="http://xmlns.oracle.com/SimpleWebServices/MediatorSerialCallsExample/Mediator1"
                xmlns:tns="http://departmentfinder/"
                xmlns:ldap="http://schemas.oracle.com/xpath/extension/ldap"
                exclude-result-prefixes="xsi xsl inp1 soap wsdl xsd ns0 tns ns1 plt jca bpws xp20 bpel bpm mf ora socket geo mhdr oraext dvm hwf med ids xdk xref bpmn ldap">
  <xsl:param name="initial.request"/>
  <xsl:template match="/">
    <inp1:EmployeeRequest>
      <inp1:eNumber>
        <xsl:value-of select="$initial.request/inp1:EmployeeRequest/inp1:eNumber"/>
      </inp1:eNumber>
      <inp1:eFirstName>
        <xsl:value-of select="$initial.request/inp1:EmployeeRequest/inp1:eFirstName"/>
      </inp1:eFirstName>
      <inp1:eLastName>
        <xsl:value-of select="$initial.request/inp1:EmployeeRequest/inp1:eLastName"/>
      </inp1:eLastName>
      <inp1:eUserId>
        <xsl:value-of select="$initial.request/inp1:EmployeeRequest/inp1:eUserId"/>
      </inp1:eUserId>
      <inp1:eDeptNum>
        <xsl:value-of select="$initial.request/inp1:EmployeeRequest/inp1:eDeptNum"/>
      </inp1:eDeptNum>
      <inp1:eDeptName>
        <xsl:value-of select="/tns:getDepartmentDetailsResponse/return/departmentName"/>
      </inp1:eDeptName>
      <inp1:eDeptOrg>
        <xsl:value-of select="/tns:getDepartmentDetailsResponse/return/departmentOrg"/>
      </inp1:eDeptOrg>
      <inp1:eDeptCostCtr>
        <xsl:value-of select="/tns:getDepartmentDetailsResponse/return/departmentCostCenter"/>
      </inp1:eDeptCostCtr>
    </inp1:EmployeeRequest>
  </xsl:template>
</xsl:stylesheet>

This Application contains a project that illustrate a mediator 
that calls a web service, combines the response from the web service with the 
initial mediator request data and calls another service.


Web Service Dependency
----------------------
This project has a dependency on the DepartmentDetails Service created in this
blog entry.  

https://blogs.oracle.com/bwb/resource/webservices/Create_a_simple_Web_Service_from_Java_Code_using_JDeveloper.html

See the GitHub link at the bottom of the post for a download of the completed service.
Download and extract the zip, open the Application and deploy it to a WebLogic Server.
Test the Service using EM as detailed in the blog post.
Record the url for the Service WSDL which will be required for the Partner link in this project.



Setup SOA Composite Project
---------------------------
The SOA project is also complete.
But 2 changes may be needed to localise to the new environment.

Change 1
--------
The project contains a copy of the wsdl for the web service above.
This file must be changed to point the new location of the web service in your environment.
Open the file DepartmentFinderPort.wsdl
find the name below
<soap:address location="http://localhost:7001/MyDemo-DepartmentFinder-context-root/DepartmentFinderPort"/>
Ensure that the location url matches the url location for testing the service retrieved from EM .
Remove the ?wsdl suffix if necessary

Change 2
--------
The directory used by the file adapter may not exist locally.
Open the composite.xml file and double click on the file adapter.
Follow the wizard steps and in step 5 make sure the directory specified exists in the local file system
Finish and save the wizard.

After making the changes, 

Testing
-------
Build and deploy the project.

Test with EM, see the "Testing using EM" section below in this ReadMe



STEPS to Build the SOA Project from Scratch (optional)
------------------------------------------------------

Setup a SOA Application
--------------------------------

Create a SOA application, with a new Project, select Empty Project (ie NO mediator and  NO bpel)
Click on the New project and select add new XSD file
Call the a new XSD file EmployeeRequest.xsd and paste in the XSD contents from the end of this document.

Open the composite.xml file
Drag in a Mediator control 
Choose One way interface
In input field select and find EmployeeRequest Schema in the project (we just added it in the previous set), expand and select EmployeeRequest
Press OK to create mediator

Add web service call partner link
---------------------------------
Next in composite, drag WebService into right swim lane
Name it: departmentFinder
in WSDL url field paste
http://localhost:7001/MyDemo-DepartmentFinder-context-root/DepartmentFinderPort?wsdl    (USE the WSDL noted during testing with EM above)
DO NOT PRESS green finder icon

Next press Port dropdown, should auto fill in based on wsdl resolution
Check copy wsdl into project, to avoid annoying errors in future when opening the jdev project without the web service being available.
Select NEVER for transaction and hit OK
Press OK to localize files to point to local wsdl now imported into project.

Next in composite.xml
connnct wire from departmentfinder partner link to Mediator.

Add file adapter partner link
-----------------------------
Next drag a File Adapter to the right swim lane.
set value of ServiceName to  WriteEmployeeDetails and press next
select define from operation and schema later
choose write file
pick a file location like /tmp  or c:\temp
set pattern as emp_%SEQ%.txt
At step 6 in wizard click magnifying glass
select EmployeeRequest
Then select finish
Back in the Composite editor wire the File adapter partner link to the mediator


Configure Mediator Rules
------------------------

Open mediator and notice rule 1 has a Request section, Synchronous reply section and a Fault section.
Click on create Transform in rule in the First Rule Request section

Dialog pops up:  
Select Create new Mapper File and accept name   "EmployeeRequest_To_getDepartmentDetails.xsl"

In XSL mapper map eDept on left to arg0 on right
Save and Close the transform.

Now still on rule 1, click the gear icon beside the Synchronous Reply step
Choose Invoke a service, then select expand WriteEmployeeDetails and choose the Write operation.
This instruction mediator to call another service after receiving the response from the first service.

Next click the create XSL transform in the Sync Response Section
Check Create new mapper file and name it  getDepartmentDetailsResponse_To_EmployeeRequestForFile.xsl
IMPORTANT: Check the box "Include Request in the Reply Payload"

Now in xform editor you will see two sources, the originial request sent to the mediator and 
the response from the web service the mediator called

<sources>
 initialRequest
     inp1:EmployeeRequest          (the initial request into the mediator)
       eNumber
       eFirstName
       eLastName
       eUserId
       eDeptNum
       eDeptName
       eDeptOrg
       eDeptCostCtr
  
 tns:getDepartmentDetailsResponse
     return
       departmentCostCetner
       departmentManagerEmail 
       departmentName
       departmentNumber
       departmentOrg
       
Using the Mapper map the following fields

LHS                    RHS
Number               - Number
eFirstName           - eFirstName
eLastName            - eLastName
eUserId              - eUserId
eDeptNum             - eDeptNum

departmentCostCenter - eDeptCostCtr
deparmentName        - eDeptName
departmentOrg        - eDeptOrg

then save and close transform editor

Finally back in the mediator definition
we need to delete the second rule.
We wont be calling the File adapter without first calling the web service.
click on the second rule which is not needed
and choose the red X icon top right to delete it

Compile and Deploy to SOA Partition.


Testing using EM
----------------
Locate the mediatorSerialCallsExample composite in Enterprise Manager.
Press the test button.

Supply the mandatory fields (prefixed with *), use a dept number value of 1,2 or 3
Do not enter values for depname, org and cost ctr
they will be added by data returned by the web service

For example
  eNumber:    123
  eFirstName: Bob
  eLastName:  Webster
  eDeptNum:   3

Press the "Test Web Service"

Note: Mediator is one way a response will not be returned in EM.
After the test see the file created by file adapter in /tmp

for example

[/tmp] $ more emp_1.txt 
<?xml version="1.0" encoding="UTF-8" ?><inp1:EmployeeRequest xmlns:inp1="http://
www.example.org" xmlns="http://www.example.org">
   <inp1:eNumber>123</inp1:eNumber>
   <inp1:eFirstName>Bob</inp1:eFirstName>
   <inp1:eLastName>Webster</inp1:eLastName>
   <inp1:eUserId/>
   <inp1:eDeptNum>2</inp1:eDeptNum>
   <inp1:eDeptName>Inside Sales</inp1:eDeptName>
   <inp1:eDeptOrg>Sales</inp1:eDeptOrg>
   <inp1:eDeptCostCtr>22</inp1:eDeptCostCtr>
</inp1:EmployeeRequest>


  
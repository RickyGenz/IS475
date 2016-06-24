/*
Select				tw.EmpID,
					emp.lastname + ',' + emp.firstname EmployeeName,
					jt.title JobTitle,
					ISNULL(empm.lastname + ',' + empm.firstname, 'No Manager') ManagerName,
					cl.name ClientName,
					SUM(minutes/60) TotalHoursWorked
From				labtimeworked tw
Inner Join			labemp emp
On					tw.empid = emp.empid
Left Outer Join		labjobtitle jt
On					jt.jobtitleid = emp.jobtitleid
Inner Join			labcontract ct
On					ct.contractid = tw.contractid
Inner Join			labclient cl
On					cl.clientid = ct.clientid
Left Outer Join		labemp empm
On					emp.managerid = empm.empid
Group By			tw.empid, tw.contractid,
					emp.lastname + ',' + emp.firstname,
					title,
					empm.lastname + ',' + empm.firstname,
					name
Order By			tw.empid;


Select			empid,
				lastname + ', ' + firstname EmployeeName,
				jt.title JobTitle,
				(Select AVG(billingrate)
				 From	labemp empSelect
				 Where	empOuter.jobtitleid = empSelect.jobtitleid) AverageBillingRate,
				billingrate EmployeeBillingRate
From			labemp empOuter
Left Outer Join labjobtitle jt
On				empOuter.jobtitleid = jt.jobtitleid
Where			billingrate > 
				(Select AVG(billingrate)
				 From	labemp empInner
				 Where	empOuter.jobtitleid = empInner.jobtitleid);

--VIEWS
/*
Drop View		vAvgRateByTitle;
Create View		vAvgRateByTitle AS
Select			jobtitleid,
				AVG(billingrate) AverageBillingRate
From			labemp
Group By		jobtitleid;
*/

Select			emp.empid,
				lastname + ', ' + firstname EmployeeName,
				jt.title JobTitle,
				v.averagebillingrate,
				emp.billingrate EmployeeBillingRate
From			labemp emp
Inner Join		vAvgRateByTitle v
On				emp.jobtitleid = v.jobtitleid
Left Outer Join labjobtitle jt
On				emp.jobtitleid = jt.jobtitleid
Where			emp.billingrate > v.averagebillingrate;
*/
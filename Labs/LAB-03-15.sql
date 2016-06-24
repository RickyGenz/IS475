--VIEWS
/* Average Billing Rate By Job Title
Drop View		vAvgRateByTitle;
Create View		vAvgRateByTitle AS
Select			jobtitleid,
				AVG(billingrate) AverageBillingRate
From			labemp
Group By		jobtitleid;
*/
/* Time Worked By Employee 
Drop View		vEmpTime;
Create View		vEmpTime As
Select			emp.empid,
				emp.lastname,
				tw.contractid,
				contract.clientid,
				client.name ClientName,
				contract.datesigned,
				contract.datedue,
				tw.startwork,
				tw.worktypeid,
				work.description,
				ISNULL(convert(decimal(6,2),minutes)/60,0) HoursWorked
From			labemp emp
Left Outer Join labtimeworked tw
On				emp.empid = tw.empid
Left Outer Join	labwork work
On				tw.worktypeid = work.worktypeid
Left Outer Join labcontract contract
On				tw.contractid = contract.contractid
Left Outer Join	labclient client
On				contract.clientid = client.clientid;
*/
/* Total Time Worked By Employee By Month By Year
Drop View		vEmpHours;
Create View		vEmpHours As
Select			empid,
				month(startwork) MonthWork,
				year(startwork) YearWork,
				SUM(convert(decimal(6,2),minutes)/60) TotalHours
From			labtimeworked
Group By		empid, month(startwork), year(startwork);
*/
/* Total Time Worked By Employee By Month By Year For a Specific Month & Year (View within a View)
Drop View		vFebHours;
Create View		vFebHours As
Select			*
From			vEmpHours
Where			monthwork = 2 and yearwork = year(getdate());
*/
/*
--SELECTS
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

Select	*
From	vEmpTime;

Select	* 
From	vEmpHours;

Select	*
From	vFebHours;
*/
Select			vFeb.empid,
				firstname + ' ' + lastname 'Employee Name',
				officephone,
				title,
				totalhours
From			vFebHours vFeb
Left Outer Join	labemp emp
On				vFeb.empid = emp.empid
Left Outer Join labjobtitle jt
On				jt.jobtitleid = emp.jobtitleid
Where			totalhours =
				(Select		MAX(totalhours)
				 From		vFebHours);

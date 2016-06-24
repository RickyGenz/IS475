/*
--Task 1 (2)
Select	*
From	labtimeworked
Where	empid NOT IN
		(Select		empid
		 From		labemp);
Select	*
From	labemp
Where	empid NOT IN
		(Select		empid
		 From		labtimeworked);
Select	*
From	labemp
Where	jobtitleid NOT IN
		(Select		jobtitleid
		 From		labjobtitle);
Select	*
From	labjobtitle
Where	jobtitleid NOT IN
		(Select		jobtitleid
		 From		labemp);

--Task 1 (3)
Select			emp.empid,
				emp.lastname,
				emp.firstname,
				tw.startwork,
				tw.minutes,
				emp.billingrate
From			labtimeworked tw
Right Outer Join	labemp emp
On				emp.empid = tw.empid
Order By		emp.empid;

--Task 1 (4)
Select		*
From		labtimeworked
Inner Join	labContract
On			labtimeworked.contractID = labcontract.contractID;

--Task 1 (5)
Select				*
From				labtimeworked
Right Outer Join	labcontract
On					labtimeworked.contractID = labcontract.contractID;

--Task 1 (6)
Select			*
From			labtimeworked
Left Outer Join	labcontract
On				labtimeworked.contractID = labcontract.contractID;

--Task 1 (7)
Select			*
From			labtimeworked
Full Outer Join	labcontract
On				labtimeworked.contractID = labcontract.contractID;

--Task 1 (8)
Select			emp.empid,
				emp.lastname,
				emp.firstname,
				jt.title JobTitle,
				tw.startwork,
				tw.minutes,
				emp.billingrate
From			labtimeworked tw
Inner Join		labemp emp
On				emp.empid = tw.empid
Left Outer Join	labjobtitle jt
On				jt.jobtitleid = emp.jobtitleid
Order By		emp.empid;

--Task 1 (9)
Select			emp.empid,
				emp.lastname,
				emp.firstname,
				ISNULL(jt.title, '**Missing**') JobTitle,
				tw.startwork,
				tw.minutes,
				emp.billingrate
From			labtimeworked tw
Inner Join		labemp emp
On				emp.empid = tw.empid
Left Outer Join	labjobtitle jt
On				jt.jobtitleid = emp.jobtitleid
Order By		emp.empid;


--Task 2
Select			emp.empid,
				emp.lastname,
				emp.firstname,
				jt.title
From			labemp emp
Left Outer Join	labjobtitle jt
On				jt.jobtitleid = emp.jobtitleid
Order By		emp.empid;


--Task 3
Select			emp.empid,
				emp.lastname,
				emp.firstname,
				ISNULL(jt.title, '**Missing**') JobTitle
From			labemp emp
Left Outer Join	labjobtitle jt
On				jt.jobtitleid = emp.jobtitleid
Order By		emp.empid;


--Task 4
Select			emp.empid,
				emp.lastname,
				emp.firstname,
				ISNULL(jt.title, '**Missing**') JobTitle,
				tw.startwork,
				(tw.minutes / 60) HoursWorked
From			labemp emp
Left Outer Join	labjobtitle jt
On				jt.jobtitleid = emp.jobtitleid
Inner Join		labtimeworked tw
On				tw.empid = emp.empid
Order By		tw.empid;


--Task 5
Select			emp.empid,
				emp.lastname,
				emp.firstname,
				ISNULL(jt.title, '**Missing**') JobTitle,
				tw.startwork,
				(tw.minutes / 60) HoursWorked
From			labemp emp
Left Outer Join	labjobtitle jt
On				jt.jobtitleid = emp.jobtitleid
Left Outer Join	labtimeworked tw
On				tw.empid = emp.empid
Order By		emp.empid;


--Task 6
Select			emp.empid,
				emp.lastname,
				emp.firstname,
				ISNULL(jt.title, '**Missing**') JobTitle,
				tw.startwork,
				(tw.minutes / 60) HoursWorked
From			labemp emp
Left Outer Join	labjobtitle jt
On				jt.jobtitleid = emp.jobtitleid
Inner Join		labtimeworked tw
On				tw.empid = emp.empid
Where			YEAR(tw.startwork) = YEAR(GETDATE()) and (MONTH(tw.startwork) = 3)
Order By		emp.empid;


--Task 7
Select			emp.empid,
				emp.lastname,
				emp.firstname,
				ISNULL(jt.title, '**Missing**') JobTitle,
				tw.startwork,
				wt.description,
				(tw.minutes / 60) HoursWorked
From			labemp emp
Left Outer Join	labjobtitle jt
On				jt.jobtitleid = emp.jobtitleid
Inner Join		labtimeworked tw
On				tw.empid = emp.empid
Inner Join		labwork wt
On				wt.worktypeid = tw.worktypeid
Where			YEAR(tw.startwork) = YEAR(GETDATE()) and (MONTH(tw.startwork) = 3)
Order By		emp.empid;


--Task 8
Select			emp.empid,
				emp.lastname,
				emp.firstname,
				ISNULL(jt.title, '**Missing**') JobTitle,
				tw.startwork,
				wt.description,
				ct.contractid,
				CONVERT(VARCHAR, ct.datedue, 107) DateDue,
				(tw.minutes / 60) HoursWorked
From			labemp emp
Left Outer Join	labjobtitle jt
On				jt.jobtitleid = emp.jobtitleid
Inner Join		labtimeworked tw
On				tw.empid = emp.empid
Inner Join		labwork wt
On				wt.worktypeid = tw.worktypeid
Inner Join		labcontract ct
On				ct.contractid = tw.contractid
Where			YEAR(tw.startwork) = YEAR(GETDATE()) and (MONTH(tw.startwork) = 3)
Order By		emp.empid;


--Task 9
Select			emp.empid,
				emp.lastname,
				emp.firstname,
				ISNULL(jt.title, '**Missing**') JobTitle,
				tw.startwork,
				wt.description,
				ct.contractid,
				CONVERT(VARCHAR, ct.datedue, 107) DateDue,
				cl.name,
				(tw.minutes / 60) HoursWorked
From			labemp emp
Left Outer Join	labjobtitle jt
On				jt.jobtitleid = emp.jobtitleid
Inner Join		labtimeworked tw
On				tw.empid = emp.empid
Inner Join		labwork wt
On				wt.worktypeid = tw.worktypeid
Inner Join		labcontract ct
On				ct.contractid = tw.contractid
Inner Join		labclient cl
On				cl.clientid = ct.clientid
Where			YEAR(tw.startwork) = YEAR(GETDATE()) and (MONTH(tw.startwork) = 3)
Order By		emp.empid;


--Task 10
Select			emp.empid,
				emp.lastname,
				(SUM(tw.minutes) / 60) TotalHoursWorked
From			labemp emp
Inner Join		labtimeworked tw
On				tw.empid = emp.empid
Group By		emp.empid, emp.lastname;


--Task 11
Select			emp.empid,
				emp.lastname,
				ISNULL((SUM(tw.minutes) / 60), 0) TotalHoursWorked
From			labemp emp
Left Outer Join	labtimeworked tw
On				tw.empid = emp.empid
Group By		emp.empid, emp.lastname;


--Task 12
Select			emp.empid,
				emp.lastname,
				COUNT(tw.empid) CountOfRows,
				(AVG(tw.minutes) / 60) AverageHoursPerRow,
				(SUM(tw.minutes) / 60) TotalHoursWorked
From			labemp emp
Left Outer Join	labtimeworked tw
On				tw.empid = emp.empid
Group By		emp.empid, emp.lastname;


--Task 13
Select			emp.empid,
				emp.lastname,
				COUNT(tw.empid) CountOfRows,
				ISNULL((AVG(tw.minutes) / 60), 0) AverageHoursPerRow,
				ISNULL((SUM(tw.minutes) / 60), 0) TotalHoursWorked
From			labemp emp
Left Outer Join	labtimeworked tw
On				tw.empid = emp.empid
Group By		emp.empid, emp.lastname;


--Task 14
Select			emp.empid,
				(emp.lastname + ', ' + SUBSTRING(emp.firstname,1,1) + '.') EmployeeName,
				emp.billingrate
From			labemp emp
Where			emp.billingrate =
				(Select		MAX(billingrate) 
				 From		labemp);


--Task 15
Select			emp.empid,
				(emp.lastname + ', ' + SUBSTRING(emp.firstname,1,1) + '.') EmployeeName,
				ISNULL(jt.title, '**Missing**') JobTitle,
				emp.billingrate
From			labemp emp
Left Outer Join	labjobtitle jt
On				emp.jobtitleid = jt.jobtitleid
Where			emp.billingrate =
				(Select		MAX(billingrate) 
				 From		labemp);
*/
SELECT *
FROM emp1;

SELECT ename, salary, hiredate, deptno
FROM emp1;

SELECT	ename		AS	'employee name',
		salary		AS	'Current Salary',
		hiredate	AS	'Date Hired',
		deptno		AS  'department Number'
FROM emp1;

SELECT	ename		'employee name',
		salary		'Current Salary',
		hiredate	'Date Hired',
		deptno		'department Number'
FROM emp1
ORDER BY deptno;

SELECT	LOWER(ename)'employee name',
		salary		'Current Salary',
		hiredate	'Date Hired',
		deptno		'department Number'
FROM emp1
ORDER BY deptno;

SELECT	ename		'Employee Name',
		Salary,
			Commission,
		Salary + Commission 'Total Remuneration'
FROM	emp1
ORDER BY ename;

SELECT	ename		'Employee Name',
		Salary,
			ISNULL(Commission,0)	'Commission',
		Salary + ISNULL(Commission,0) 'Total Remuneration'
FROM	emp1
ORDER BY ename;

SELECT	ename		'Employee Name',
		Salary,
		Commission,
		Salary + isnull(Commission, 0) 'Current remuneration',
		(Salary + isnull(Commission, 0)) * 1.20 'New remuneration'
FROM	emp1
ORDER BY ename;

SELECT	ename		'Employee Name',
		Salary,
		Commission,
		Salary + isnull(Commission, 0) 'Current remuneration',
		CAST(((Salary + isnull(Commission, 0)) * 1.20) as MONEY) 'New remuneration'
FROM	emp1
ORDER BY ename;

SELECT	ename		'employee name',
		salary		'Current Salary',
		hiredate	'Date Hired',
		deptno		'department Number'
FROM emp1
WHERE deptno = 20
ORDER BY ename;

SELECT	ename		'employee name',
		salary		'Current Salary',
		hiredate	'Date Hired',
		deptno		'department Number'
FROM emp1
WHERE deptno = 20 or deptno = 30
ORDER BY ename;

SELECT	ename		'employee name',
		salary		'Current Salary',
		hiredate	'Date Hired',
		deptno		'department Number'
FROM emp1
WHERE deptno in (20, 30)
ORDER BY ename;

-- Syntaxes for other date displays
SELECT	ename	'employee name',
			salary		'Current Salary',
			hiredate	'Date Hired',
			deptno		'department Number'
FROM		emp1
ORDER BY	deptno;
SELECT	ename	'Employee Name',
			Salary,
			Deptno						'Department Number',
			CAST(Hiredate AS VARCHAR)	'Date Hired'
FROM		emp1
ORDER BY	deptno;
SELECT	ename	'Employee Name',
			Salary,
			Deptno						'Department Number',
			CONVERT(VARCHAR, Hiredate, 107)	'Date Hired'
FROM		emp1
ORDER BY	deptno;
SELECT	ename	'Employee Name',
			Salary,
			Deptno						'Department Number',
			CONVERT(VARCHAR, Hiredate, 101)	'Date Hired'
FROM		emp1
ORDER BY	deptno;

-- Doing calculations with dates using DATEDIFF and GETDATE()
SELECT	empno	'Employee Number',
		ename	'Employee Name',
		hiredate 'Date Hired',
		DATEDIFF(day, hiredate, getdate())	'Number of Days Employed',
		DATEDIFF(month, hiredate, getdate()) 'Number of Months Employed',
		DATEADD(day, 90, hiredate) 'Date 90 days After Hire Date'
FROM	emp1
ORDER BY empno;

-- Concatenate multiple attributes into an alias
SELECT	ename + ' earns ' + '$' +
		CAST(Salary as varchar) +
		' in the number ' +
		deptno + ' department' 'Employee Information'
FROM	emp1;

-- Learning to parse data (First and Last Name)
SELECT SUBSTRING(ename,1,6) 'Employee Last Name'
FROM	emp1;
SELECT CHARINDEX(',', ename)
FROM EMP1
SELECT SUBSTRING(ename,1,CHARINDEX(',' , ename)) 'Employee Last Name'
FROM emp1;
SELECT SUBSTRING(ename,1,CHARINDEX(',' , ename) - 1) 'Employee Last Name'
FROM emp1;
SELECT SUBSTRING(ename,1,CHARINDEX(',' , ename) - 1) 'Employee Last Name',
		SUBSTRING(ename,CHARINDEX(',' , ename) + 1, LEN(ename)) 'Employee First Name'
FROM emp1;

-- Concatenate and Parse Date for Phone Number
SELECT ename 'Employee Name',
		'(' + SUBSTRING(Phone,1,3) + ') ' +
		SUBSTRING(Phone,4,3) + '-' +
		SUBSTRING(Phone,7,4) 'Phone Number'
FROM emp1
ORDER BY ename

-- Learning about CASE
SELECT	ename,
		salary,
		CASE
			WHEN salary > 5000 THEN 'Really Big Salary'
			WHEN salary <= 5000 and salary >= 3500 THEN 'Big Salary'
			WHEN salary < 3500 and salary >= 2000 THEN 'Mediocre Salary'
			ELSE 'Pittance Pay'
			END	 SalaryRating
FROM	emp1

-- Access only unique attributes in table
SELECT DISTINCT deptno
FROM emp1;
SELECT DISTINCT Salary
FROM emp1;

-- Using the WHERE clause to limit rows returned
SELECT	ename, Salary, deptno
FROM	emp1
WHERE	Salary > 3000;
SELECT	ename, Salary, deptno
FROM	emp1
WHERE	Salary > 3000
AND		deptno = 10;
SELECT	ename, Salary, deptno
FROM	emp1
WHERE	Salary > 3000
AND		deptno = 10 or deptno = 20;

-- WHERE options to access a range
SELECT	ename, Salary, hiredate, deptno
FROM	emp1
WHERE	hiredate BETWEEN ('01-jan-2015') AND ('31-dec-2015');
SELECT	ename, Salary, hiredate, deptno
FROM	emp1
WHERE	hiredate >= ('01-jan-2015') AND
		hiredate <= ('31-dec-2015');
SELECT	ename, Salary, hiredate, deptno
FROM	emp1
WHERE	YEAR(hiredate) = '2015';

-- WHERE options to access a value from a group
SELECT	ename, Salary, deptno
FROM	emp1
WHERE	deptno IN (10, 20);
SELECT	ename, Salary, deptno
FROM	emp1
WHERE	deptno = 10 OR deptno = 20;
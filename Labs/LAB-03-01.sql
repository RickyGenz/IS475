/*
SELECT ename 'Employee Name',
	   Salary,
	   ISNULL(CONVERT(varchar, Commission), 'No Commission') Commission,
	   Salary + ISNULL(Commission, 0) TotalRemuneration
FROM		emp1
ORDER BY	ename;

SELECT	ROUND(AVG(Salary), 2)
FROM	emp1
WHERE	deptno = 20;

SELECT	MAX(DATEDIFF(mm, hiredate, GETDATE()))
FROM	emp1;

SELECT		deptno, SUM(Salary)
FROM		emp1
GROUP BY	deptno
HAVING		AVG(Salary) > 2000;

SELECT		ename, salary
FROM		emp1
WHERE		salary = (SELECT MAX(salary) FROM emp1);

SELECT		ename, salary, hiredate
FROM		emp1
WHERE		hiredate = (SELECT MIN(hiredate) FROM emp1);

SELECT		*
FROM		emp1
WHERE		deptno NOT IN (SELECT deptno FROM dept1);

SELECT		empno, ename, deptno, salary,
			(SELECT		AVG(salary)
			 FROM		emp1 sq
			 WHERE		sq.deptno = outq.deptno) AverageSalary
FROM		emp1 outq
WHERE		salary >
			(SELECT		AVG(salary)
			 FROM		emp1 inq
			 WHERE		outq.deptno = inq.deptno);

SELECT		ename, deptno, LEN(ename) NameLength,
			(SELECT		AVG(LEN(ename))
			 FROM		emp1) NameAvgLength
FROM		emp1
WHERE		LEN(ename) >
			(SELECT		AVG(LEN(ename))
			 FROM		emp1)
ORDER BY	ename;

*/

--SELECT *
--INTO #t1
--FROM emp1

SELECT *
FROM #t1
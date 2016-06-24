/*
Select *
From ord, cust;

--Order First
Select		*
From		ord
Inner Join	cust
On			ord.custID = cust.custID
Order By	ord.orderID;

--Customer First
Select		*
From		cust
Inner Join	ord
On			ord.custID = cust.custID
Order By	ord.orderID;

--Cleaned Up
Select		ord.orderID, ord.orderDate, ord.dueDate, cust.customerName
From		ord
Inner Join	cust
On			ord.custID = cust.custID
Order By	ord.orderID;

--Contains Null Results (INNER JOIN)
Select		cust.CustomerName,
			ISNULL(ord.OrderID, 'No Order') OrderID,
			ord.DueDate
From		ord
Inner Join	cust
On			ord.custID = cust.custID
Order By	cust.customerName;

--Contains Null Results (OUTER JOIN)
Select				cust.CustomerName,
					ISNULL(ord.OrderID, 'No Order') OrderID,
					ord.DueDate
From				ord
Right Outer Join	cust
On					ord.custID = cust.custID
Order By			cust.customerName;

--Select ord1
Select	*
From	ord1, cust;

--ord1 Inner Join
Select		*
From		ord1
Inner Join	cust
On			ord1.custID = cust.custID;

--ord1 Right Outer Join
Select				*
From				ord1
Right Outer Join	cust
On					ord1.custID = cust.custID;

--ord1 Left Outer Join
Select				*
From				ord1
Left Outer Join		cust
On					ord1.custID = cust.custID;

--Make NULL more meaningful
Select			ord1.OrderID,
				ord1.OrderDate,
				ord1.CustID,
				ord1.DueDate,
				ISNULL(cust.CustID, 'N/A') CustID,
				ISNULL(cust.CustomerName, 'Missing Name') CustomerName
From			ord1
Left Outer Join	cust
On				ord1.custID = cust.custID;

--FULL Outer Join
Select			*
From			ord1
Full Outer Join	cust
On				ord1.custID = cust.custID;

--My Own Query
Select			ord1.OrderID,
				CONVERT(varchar, ord1.OrderDate, 101) OrderDate,
				ord1.CustID,
				ISNULL(cust.CustomerName, 'Missing Name') CustomerName
From			ord1
Left Outer Join	cust
On				ord1.custID = cust.custID;

--My NEW Own Query
Select			ord1.OrderID,
				CONVERT(varchar, ord1.OrderDate, 101) OrderDate,
				CONVERT(varchar, ord1.DueDate, 101) DueDate
From			ord1
Left Outer Join	cust
On				ord1.custID = cust.custID
Where			cust.CustomerName = 'Jane Doe';

--Another Query of My Own
Select			ord1.OrderID,
				CONVERT(varchar, ord1.OrderDate, 101) OrderDate,
				ord1.CustID,
				CONVERT(varchar, ord1.DueDate, 101) DueDate,
				ISNULL(cust.CustID, 'N/A') 'C.CustID',
				ISNULL(cust.CustomerName, 'Missing Name') CustomerName
From			ord1
Left Outer Join	cust
On				ord1.custID = cust.custID
Where			cust.CustID IS NULL;

--First of the Last Two Queries
Select				cust.CustID,
					cust.CustomerName,
					COUNT(ord1.orderID) CountofOrders
From				ord1
Left Outer Join		cust
On					ord1.custID = cust.custID
Group By			cust.custID, cust.CustomerName
Having				cust.custID IS NOT NULL
Order By			cust.custID;

--Second of the Last Two Queries
Select				cust.CustID,
					cust.CustomerName,
					COUNT(ord1.orderID) CountofOrders
From				ord1
Right Outer Join	cust
On					ord1.custID = cust.custID
Group By			cust.custID, cust.CustomerName
Order By			cust.custID;
*/
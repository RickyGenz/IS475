--One
Select		(FirstName + ' ' + LastName) CustomerName,
			Phone CustomerPhone,
			City,
			State,
			FirstBuyDate
From		tblCustomer
Where		State = 'NV'
Order By	LastName;

--Two
Select		(LastName + ', ' + SUBSTRING(FirstName,1,1) + '.') 'Customer Name',
			'(' + SUBSTRING(Phone,1,3) + ') ' + SUBSTRING(Phone,4,3) + '-' + SUBSTRING(Phone,7,4) 'Phone Number',
			UPPER(City) City,
			UPPER(State) State,
			CONVERT(VARCHAR, FirstBuyDate, 107) FirstBuyDate
From		tblCustomer
Where		State = 'NV'
Order By	LastName;

--Three
Select		CONVERT(VARCHAR, OrderDate, 101) 'Date of Order',
			OrderID 'Order Number',
			CustomerID 'Customer Number',
			CreditCode 'Credit Code'
From		tblOrder
Where		DiscountCode IS NULL
Order By	OrderDate;

--Four
Select		OrderID OrderNumber,
			ItemID ItemNumber,
			Quantity QuantitiyOrdered,
			Price PricePaid,
			(Price * Quantity) ExtendedPrice
From		tblOrderLine
Where		ItemID = 'A34665'
Order By	OrderID;

--Five
Select		OrderID OrderNumber,
			ItemID ItemNumber,
			Quantity QuantitiyOrdered,
			Price PricePaid,
			(Price * Quantity) ExtendedPrice
From		tblOrderLine
Where		(Price * Quantity) > 800
Order By	OrderID, ItemID;

--Six
Select		OrderID OrderNumber,
			ItemID ItemNumber,
			Quantity QuantitiyOrdered,
			Price PricePaid,
			(Price * Quantity) ExtendedPrice,
			CASE
				WHEN (Price * Quantity) >= 5000 THEN '***Closely Watch the Status***'
				WHEN (Price * Quantity) >= 2000 and (Price * Quantity) < 5000 THEN 'Very Large Order - Watch Dates'
				WHEN (Price * Quantity) >= 1500 and (Price * Quantity) < 2000 THEN 'Large Order - Monitor'
				WHEN (Price * Quantity) >= 1000 and (Price * Quantity) < 1500 THEN 'Medium Order'
				ELSE NULL
			END	 OrderStatusMessage
From		tblOrderLine
Where		(Price * Quantity) > 800
Order By	OrderID, ItemID;

--Seven
Select		OrderID,
			ItemID,
			CONVERT(VARCHAR, DateShipped, 101) DateShipped,
			QtyShipped,
			UPPER(MethodShipped) MethodShipped
From		tblShipLine
Where		YEAR(DateShipped) = YEAR(GETDATE()) and (MONTH(DateShipped) = 1)
Order By	OrderID, ItemID;

--Eight
Select		CONVERT(VARCHAR, MIN(FirstBuyDate), 107) 'Earliest First Buy Date'
From		tblCustomer;

--Nine
Select		ROUND(AVG(Price), 2) 'Average Selling Price'
From		tblOrderLine
Where		ItemID = 'A34665';

--Ten
Select		ItemID itemid,
			Count(ItemID) NumberOfRows,
			SUM(Quantity) QuantitySold,
			MIN(Price) MinimumPrice,
			MAX(Price) MaximumPrice,
			AVG(Price) AveragePrice
From		tblOrderLine
Group By	ItemID;

--Eleven
Select		ItemID itemid,
			Count(ItemID) NumberOfRows,
			SUM(Quantity) QuantitySold,
			MIN(Price) MinimumPrice,
			MAX(Price) MaximumPrice,
			ROUND(AVG(Price), 2) AveragePrice,
			FORMAT(((MAX(Price) - MIN(Price)) / MIN(Price)), 'p') Diff
From		tblOrderLine
Group By	ItemID
Having		(MAX(Price) - MIN(Price)) / MIN(Price) > 0.5

--Twelve
Select		OrderID 'Order Number',
			CustomerID 'Customer Number',
			CONVERT(VARCHAR, OrderDate, 107) 'Date Ordered',
			CONVERT(VARCHAR, DATEADD(day, 40, OrderDate), 107) '40 Days After Date Ordered',
			DATEDIFF(day, OrderDate, GETDATE()) 'Number of Days Difference',
			GETDATE() 'Current Date and Time'
From		tblOrder
Where		DATEDIFF(day, OrderDate, GETDATE()) > 40;

--Thirteen
Select		OrderID,
			ItemID,
			COUNT(*) NumberOfShipments,
			SUM(QtyShipped) TotalShipped
From		tblShipLine
Group By	OrderID, ItemID
Having		COUNT(*) > 1
Order By	OrderID, ItemID;

--Fourteen
Select		CustomerID,
			(LastName + ', ' + SUBSTRING(FirstName,1,1) + '.') CustomerName,
			'(' + SUBSTRING(Phone,1,3) + ') ' + SUBSTRING(Phone,4,3) + '-' + SUBSTRING(Phone,7,4) PhoneNumber,
			UPPER(City) City,
			UPPER(State) State
From		tblCustomer
Where		CustomerID NOT IN
			(Select		CustomerID 
			 From		tblOrder);

--Fifteen
Select		CustomerID,
			(LastName + ', ' + SUBSTRING(FirstName,1,1) + '.') 'Customer Name',
			'(' + SUBSTRING(Phone,1,3) + ') ' + SUBSTRING(Phone,4,3) + '-' + SUBSTRING(Phone,7,4) 'Phone Number',
			UPPER(City) City,
			UPPER(State) State,
			CONVERT(VARCHAR, FirstBuyDate, 107) 'First Purchase Date'
From		tblCustomer
Where		FirstBuyDate =
			(Select		MAX(FirstBuyDate)
			 From		tblCustomer);
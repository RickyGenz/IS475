-- IS 475/675 - HW #7
-- Team 4 - Ricky Genz | David Rhodes

/* User Defined Functions 
-- Format Phone Number According to USA Standard
	-- Drop Function dbo.FormatPhoneUSA;
	Create Function FormatPhoneUSA
	( @pn char(15) ) Returns varchar(15)
	Begin Return
		'(' + SUBSTRING(@pn,1,3) + ') ' + SUBSTRING(@pn,4,3) + '-' + SUBSTRING(@pn,7,4)
	End
-- Formats Order Phone Number based on the Order Country (if Order Shipping Data is NULL, Customer Data is used)
	-- Drop Function dbo.FormatPhoneBasedOnCountry;
	Create Function FormatPhoneBasedOnCountry
	( @sc varchar(30), @sp char(15), @cc varchar(15), @cp char(15) ) Returns varchar(15)
	Begin Return
		IIF((@sc IS NOT NULL),
			IIF((@sc = 'USA'),
				IIF((@sp IS NOT NULL),
					(dbo.FormatPhoneUSA(@sp)),
					IIF(((@cc = 'USA') Or (@cc IS NULL)),
						(dbo.FormatPhoneUSA(@cp)),
						@cp
					)
				),
				@sp
			),
			IIF(((@cc = 'USA') Or (@cc IS NULL)),
				(dbo.FormatPhoneUSA(@cp)),
				@cp
			)
		);
	End
*/

/* Tasks (1-15) */
--One
Select		CONVERT(varchar, ord.OrderDate, 101) OrderDate,
			ord.OrderID OrderNumber,
			(cus.LastName + ', ' + SUBSTRING(cus.FirstName,1,1) + '.') CustomerName,
			'(' + SUBSTRING(cus.Phone,1,3) + ') ' + SUBSTRING(cus.Phone,4,3) + '-' + SUBSTRING(cus.Phone,7,4) PhoneNumber
From		tblOrder ord
Inner Join	tblCustomer cus
On			ord.CustomerID = cus.CustomerID
Where		YEAR(ord.OrderDate) = YEAR(GETDATE()) and (MONTH(ord.OrderDate) = 1)
Order By	ord.OrderDate Desc;

--Two
Select		CONVERT(varchar, ord.OrderDate, 101) OrderDate,
			ord.OrderID OrderNumber,
			(cus.LastName + ', ' + SUBSTRING(cus.FirstName,1,1) + '.') CustomerName,
			ISNULL(ord.ShipAddress, cus.Address) ShippingAddress,
			ISNULL(ord.ShipZip, cus.Zip) ShippingCode,
			ISNULL(ord.ShipCountry, ISNULL(cus.Country, 'Unknown')) ShippingCountry,
			dbo.FormatPhoneBasedOnCountry(ord.ShipCountry, ord.ShipPhone, cus.Country, cus.Phone) PhoneNumber
From		tblOrder ord
Inner Join	tblCustomer cus
On			ord.CustomerID = cus.CustomerID
Where		YEAR(ord.OrderDate) = YEAR(GETDATE()) and (MONTH(ord.OrderDate) = 1)
Order By	ord.OrderDate Desc;

--Three
Select		CONVERT(varchar, ord.OrderDate, 101) OrderDate,
			ord.OrderID OrderNumber,
			(cus.LastName + ', ' + SUBSTRING(cus.FirstName,1,1) + '.') CustomerName,
			ISNULL(ord.ShipAddress, cus.Address) ShippingAddress,
			ISNULL(ord.ShipZip, cus.Zip) ShippingCode,
			ISNULL(ord.ShipCountry, ISNULL(cus.Country, 'Unknown')) ShippingCountry,
			dbo.FormatPhoneBasedOnCountry(ord.ShipCountry, ord.ShipPhone, cus.Country, cus.Phone) PhoneNumber,
			ol.ItemID ItemID,
			ol.Quantity Quantitiy,
			ol.Price Price,
			(ol.Quantity * ol.Price) ExtendedPrice
From		tblOrder ord
Inner Join	tblCustomer cus
On			ord.CustomerID = cus.CustomerID
Inner Join	tblOrderLine ol
On			ord.OrderID = ol.OrderID
Where		YEAR(ord.OrderDate) = YEAR(GETDATE()) and (MONTH(ord.OrderDate) = 1)
Order By	ord.OrderDate Desc;

--Four
Select		CONVERT(varchar, ord.OrderDate, 101) OrderDate,
			ord.OrderID OrderNumber,
			(cus.LastName + ', ' + SUBSTRING(cus.FirstName,1,1) + '.') CustomerName,
			ISNULL(ord.ShipAddress, cus.Address) ShippingAddress,
			ISNULL(ord.ShipZip, cus.Zip) ShippingCode,
			ISNULL(ord.ShipCountry, ISNULL(cus.Country, 'Unknown')) ShippingCountry,
			dbo.FormatPhoneBasedOnCountry(ord.ShipCountry, ord.ShipPhone, cus.Country, cus.Phone) PhoneNumber,
			ol.ItemID ItemID,
			ite.Description Description,
			ol.Quantity Quantitiy,
			ol.Price Price,
			(ol.Quantity * ol.Price) ExtendedPrice
From		tblOrder ord
Inner Join	tblCustomer cus
On			ord.CustomerID = cus.CustomerID
Inner Join	tblOrderLine ol
On			ord.OrderID = ol.OrderID
Inner Join	tblItem ite
On			ol.ItemID = ite.ItemID
Where		YEAR(ord.OrderDate) = YEAR(GETDATE()) and (MONTH(ord.OrderDate) = 1)
Order By	ord.OrderDate Desc;

--Five
Select		CONVERT(varchar, ord.OrderDate, 101) OrderDate,
			ord.OrderID OrderNumber,
			(cus.LastName + ', ' + SUBSTRING(cus.FirstName,1,1) + '.') CustomerName,
			ISNULL(ord.ShipAddress, cus.Address) ShippingAddress,
			ISNULL(ord.ShipZip, cus.Zip) ShippingCode,
			ISNULL(ord.ShipCountry, ISNULL(cus.Country, 'Unknown')) ShippingCountry,
			dbo.FormatPhoneBasedOnCountry(ord.ShipCountry, ord.ShipPhone, cus.Country, cus.Phone) PhoneNumber,
			ol.ItemID ItemID,
			ite.Description Description,
			it.CategoryDescription,
			ol.Quantity Quantitiy,
			ol.Price Price,
			(ol.Quantity * ol.Price) ExtendedPrice
From		tblOrder ord
Inner Join	tblCustomer cus
On			ord.CustomerID = cus.CustomerID
Inner Join	tblOrderLine ol
On			ord.OrderID = ol.OrderID
Inner Join	tblItem ite
On			ol.ItemID = ite.ItemID
Inner Join	tblItemType it
On			ite.TypeID = it.TypeID
Where		YEAR(ord.OrderDate) = YEAR(GETDATE()) and (MONTH(ord.OrderDate) = 1)
Order By	ord.OrderDate Desc;

--Six
Select		ol.ItemID 'Item ID',
			ite.Description 'Item Desc',
			SUM(ol.Quantity) 'Total Qty Sold',
			COUNT(ol.OrderID) 'Count of Orders',
			MIN(ol.Price) 'Minimum Price',
			MAX(ol.Price) 'Maximum Price',
			AVG(ol.Price) 'Average Price'
From		tblOrderLine ol
Inner Join	tblItem ite
On			ol.ItemID = ite.ItemID
Group By	ol.ItemID, ite.Description
Order By	ol.ItemID;

--Seven
Select			ite.ItemID 'Item ID',
				ite.Description 'Item Desc',
				ISNULL(SUM(ol.Quantity), 0) 'Total Qty Sold',
				COUNT(ol.OrderID) 'Count of Orders',
				ISNULL(MIN(ol.Price), 0) 'Minimum Price',
				ISNULL(MAX(ol.Price), 0) 'Maximum Price',
				ISNULL(AVG(ol.Price), 0) 'Average Price'
From			tblItem ite
Left Outer Join	tblOrderLine ol
On				ite.ItemID = ol.ItemID
Group By		ite.ItemID, ite.Description
Order By		ite.ItemID;

--Eight
Select			ite.ItemID ItemID,
				ite.Description Description,
				ISNULL(CONVERT(varchar, ich.LastCostDate, 107), 'No Date Recorded') 'Last Cost Date',
				ISNULL(ich.LastCost, 0) 'Last Cost Paid'
From			tblItem ite
Left Outer Join	tblItemCostHistory ich
On				ite.ItemID = ich.ItemID
Order By		ite.ItemID Asc, ich.LastCostDate Desc;

--Nine
Select			ite.ItemID ItemID,
				ite.Description Description,
				ISNULL(CONVERT(varchar, ich.LastCostDate, 107), 'No Date Recorded') 'Last Cost Date',
				ISNULL(ich.LastCost, 0) 'Last Cost Paid'
From			tblItem ite
Left Outer Join	tblItemCostHistory ich
On				ite.ItemID = ich.ItemID
Where			ich.LastCostDate = (Select	MAX(LastCostDate)
									From	tblItemCostHistory ichInner
									Where	ich.ItemID = ichInner.ItemID)
									Or LastCostDate IS NULL
Order By		ite.ItemID Asc, ich.LastCostDate Desc;

--Ten
Select			ite.ItemID ItemID,
				ite.Description Description,
				ISNULL(CONVERT(varchar, ich.LastCostDate, 107), 'No Date Recorded') 'Last Cost Date',
				(Select	COUNT(ItemID)
				 From	tblItemCostHistory ichInner
				 Where	ich.ItemID = ichInner.ItemID) 'Count of Purchases',
				ISNULL(ich.LastCost, 0) 'Last Cost Paid',
				ISNULL(ROUND((Select	AVG(LastCost)
							  From		tblItemCostHistory ichInner
							  Where		ich.ItemID = ichInner.ItemID), 2), 0) 'Average Last Cost'
From			tblItem ite
Left Outer Join	tblItemCostHistory ich
On				ite.ItemID = ich.ItemID
Where			ich.LastCostDate = (Select	MAX(LastCostDate)
									From	tblItemCostHistory ichInner
									Where	ich.ItemID = ichInner.ItemID)
									Or LastCostDate IS NULL
Group By		ite.ItemID, ite.Description, ich.LastCostDate, ich.ItemID, ich.LastCost
Order By		ite.ItemID Asc, ich.LastCostDate Desc;

--Eleven
Select			ol.OrderID,
				ol.ItemID,
				ol.Price,
				ol.Quantity,
				ISNULL((SUM(QtyShipped)), 0) TotalQtyShipped,
				ol.Quantity - ISNULL((SUM(QtyShipped)), 0) LeftToShip
From			tblOrderLine ol
Left Outer Join	tblShipLine sl
On				ol.OrderID = sl.OrderID And ol.ItemID = sl.ItemID
Group By		ol.OrderID, ol.ItemID, ol.Price, ol.Quantity, sl.OrderID, sl.ItemID
Order By		ol.OrderID, ol.ItemID;

--Twelve
Select			ol.OrderID,
				(cus.LastName + ', ' + cus.FirstName) CustomerName,
				ol.ItemID,
				ol.Price,
				ol.Quantity,
				ISNULL((SUM(QtyShipped)), 0) TotalQtyShipped,
				ol.Quantity - ISNULL((SUM(QtyShipped)), 0) LeftToShip
From			tblOrderLine ol
Left Outer Join	tblShipLine sl
On				ol.OrderID = sl.OrderID And ol.ItemID = sl.ItemID
Inner Join		tblOrder ord
On				ol.OrderID = ord.OrderID
Inner Join		tblCustomer cus
On				ord.CustomerID = cus.CustomerID
Group By		ol.OrderID, cus.LastName, cus.FirstName, ol.ItemID, ol.Price, ol.Quantity, sl.OrderID, sl.ItemID
Order By		ol.OrderID, ol.ItemID;

--Thirteen
Select			ol.OrderID,
				(cus.LastName + ', ' + cus.FirstName) CustomerName,
				ol.ItemID,
				ite.Description,
				it.CategoryDescription,
				ite.ListPrice,
				ol.Price,
				ol.Quantity,
				ISNULL((SUM(QtyShipped)), 0) TotalQtyShipped,
				ol.Quantity - ISNULL((SUM(QtyShipped)), 0) LeftToShip
From			tblOrderLine ol
Left Outer Join	tblShipLine sl
On				ol.OrderID = sl.OrderID And ol.ItemID = sl.ItemID
Inner Join		tblOrder ord
On				ol.OrderID = ord.OrderID
Inner Join		tblCustomer cus
On				ord.CustomerID = cus.CustomerID
Inner Join		tblItem ite
On				ol.ItemID = ite.ItemID
Inner Join		tblItemType it
On				ite.TypeID = it.TypeID
Group By		ol.OrderID, cus.LastName, cus.FirstName, ol.ItemID, ite.Description, it.CategoryDescription, ite.ListPrice, ol.Price, ol.Quantity, sl.OrderID, sl.ItemID
Order By		ol.OrderID, ol.ItemID;

--Fourteen
Select			ol.OrderID,
				(cus.LastName + ', ' + cus.FirstName) CustomerName,
				ol.ItemID,
				ite.Description,
				it.CategoryDescription,
				ite.ListPrice,
				ol.Price,
				ol.Quantity,
				ISNULL((Select	SUM(QtyShipped)
					    From	tblShipLine slInner
					    Where	sl.OrderID = slInner.OrderID And sl.ItemID = slInner.ItemID), 0) TotalQtyShipped,
				ol.Quantity - ISNULL((Select	SUM(QtyShipped)
					    From	tblShipLine slInner
					    Where	sl.OrderID = slInner.OrderID And sl.ItemID = slInner.ItemID), 0) LeftToShip
From			tblOrderLine ol
Left Outer Join	tblShipLine sl
On				ol.OrderID = sl.OrderID And ol.ItemID = sl.ItemID
Inner Join		tblOrder ord
On				ol.OrderID = ord.OrderID
Inner Join		tblCustomer cus
On				ord.CustomerID = cus.CustomerID
Inner Join		tblItem ite
On				ol.ItemID = ite.ItemID
Inner Join		tblItemType it
On				ite.TypeID = it.TypeID
Group By		ol.OrderID, cus.LastName, cus.FirstName, ol.ItemID, ite.Description, it.CategoryDescription, ite.ListPrice, ol.Price, ol.Quantity, sl.OrderID, sl.ItemID
Having			(ol.Quantity - ISNULL((Select	SUM(QtyShipped)
					    From	tblShipLine slInner
					    Where	sl.OrderID = slInner.OrderID And sl.ItemID = slInner.ItemID), 0)) < 0
Order By		ol.OrderID, ol.ItemID;

--Fifteen
Select		(cus.LastName + ', ' + cus.FirstName) CustomerName,
			sl.OrderID,
			sl.ItemID,
			ite.Description
From		tblCustomer cus
Inner Join	tblOrder ord
On			cus.CustomerID = ord.CustomerID
Inner Join	tblOrderLine ol
On			ord.OrderID = ol.OrderID
Inner Join	tblShipLine sl
On			ol.OrderID = sl.OrderID And ol.ItemID = sl.ItemID
Inner Join	tblItem ite
On			ol.ItemID = ite.ItemID
Where		UPPER(sl.MethodShipped) = 'FEDEX'
Order By	cus.LastName;
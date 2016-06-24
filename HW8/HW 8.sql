-- IS 475/675 - HW #8
-- Team 4 - Ricky Genz | David Rhodes

/* User Defined Views
-- Total Shipped By OrderID and ItemID
Drop View	vShipTotal;
Create View	vShipTotal As
	Select		OrderID,
				ItemID,
				SUM(QtyShipped) TotalShipped
	From		tblShipLine
	Group By	OrderID, ItemID;
*/

/* Tasks (1-11) 
-- One
Update	tblOrder
Set		OrderDate = '1/15/2016'
Where	OrderID = '567123';

Update	tblOrder
Set		OrderDate = '2/10/2016'
Where	OrderID = '671100';

Update	tblShipLine
Set		MethodShipped = LOWER(MethodShipped);

Update	tblCustomer
Set		State = UPPER(State);

Delete	From tblOrder
Where	OrderID Not In (Select	ol.OrderID
						From	tblOrderLine ol);

-- Two
Select			ol.OrderID,
				ord.OrderDate,
				(cus.LastName + ', ' + SUBSTRING(cus.FirstName,1,1) + '.') CustomerName,
				ol.ItemID,
				ite.Description,
				ol.Quantity QtyOrdered,
				ISNULL(vst.TotalShipped, 0) TotalShipped,
				(ol.Quantity - ISNULL(vst.TotalShipped, 0)) QtyRemaining,
				Case
					When ISNULL(vst.TotalShipped, 0) = 0 Then 'Not Shipped'
					When (ol.Quantity - ISNULL(vst.TotalShipped, 0)) = 0 Then 'Completely Shipped'
					When (ol.Quantity - ISNULL(vst.TotalShipped, 0)) < 0 Then 'Over Shipped'
					When (ol.Quantity - ISNULL(vst.TotalShipped, 0)) > 0 Then 'Partially Shipped'
					Else 'Unknown'
				End ShippingStatus
From			tblOrderLine ol
Left Outer Join	vShipTotal vst
On				ol.OrderID = vst.OrderID And ol.ItemID = vst.ItemID
Inner Join		tblOrder ord
On				ol.OrderID = ord.OrderID
Inner Join		tblCustomer cus
On				ord.CustomerID = cus.CustomerID
Inner Join		tblItem ite
On				ol.ItemID = ite.ItemID
Order By		ol.OrderID, ol.ItemID;

-- Three
Select			ol.OrderID,
				ord.OrderDate,
				(cus.LastName + ', ' + SUBSTRING(cus.FirstName,1,1) + '.') CustomerName,
				ol.ItemID,
				ite.Description,
				ol.Quantity QtyOrdered,
				ISNULL(vst.TotalShipped, 0) TotalShipped,
				(ol.Quantity - ISNULL(vst.TotalShipped, 0)) QtyRemaining,
				Case
					When ISNULL(vst.TotalShipped, 0) = 0 Then 'Not Shipped'
					When (ol.Quantity - ISNULL(vst.TotalShipped, 0)) = 0 Then 'Completely Shipped'
					When (ol.Quantity - ISNULL(vst.TotalShipped, 0)) < 0 Then 'Over Shipped'
					When (ol.Quantity - ISNULL(vst.TotalShipped, 0)) > 0 Then 'Partially Shipped'
					Else 'Unknown'
				End ShippingStatus
From			tblOrderLine ol
Left Outer Join	vShipTotal vst
On				ol.OrderID = vst.OrderID And ol.ItemID = vst.ItemID
Inner Join		tblOrder ord
On				ol.OrderID = ord.OrderID
Inner Join		tblCustomer cus
On				ord.CustomerID = cus.CustomerID
Inner Join		tblItem ite
On				ol.ItemID = ite.ItemID
Where			(ol.Quantity - ISNULL(vst.TotalShipped, 0)) < 0
Order By		ol.OrderID, ol.ItemID;
*/
-- Four
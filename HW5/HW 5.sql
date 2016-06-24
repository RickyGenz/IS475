-- Drop Tables
	-- Four
	Drop Table tblReview;
	Drop Table tblShipLine;
	-- Three
	Drop Table tblItemCostHistory;
	Drop Table tblItemLocation;
	Drop Table tblOrderLine;
	-- Two
	Drop Table tblItem;
	Drop Table tblOrder;
	-- One
	Drop Table tblItemType;
	Drop Table tblCustomer;

-- Create Tables
	-- One
	Create Table tblCustomer
	(	CustomerID		char(5),
		LastName		varchar(30) NOT NULL,
		FirstName		varchar(20),
		Address			varchar(30) NOT NULL,
		City			varchar(20) NOT NULL,
		State			char(2) NOT NULL,
		Zip				varchar(12) NOT NULL,
		Country			varchar(15),
		FirstBuyDate	datetime,
		Email			varchar(60),
		Phone			char(15) NOT NULL,
		Constraint		pkCustomer Primary Key (CustomerID)
	);
	Create Table tblItemType
	(	TypeID				int,
		CategoryDescription	varchar(50),
		Constraint			pkType Primary Key (TypeID)
	);
	-- Two
	Create Table tblOrder
	(	OrderID			char(6),
		CustomerID		char(5) NOT NULL,
		PrimaryOrderID	char(6),
		OrderDate		datetime NOT NULL,
		DiscountCode	char(2) Check (DiscountCode IN ('02', '03', '04', '06', '08', '10', 'A1', 'B3')),
		CreditCode		char(3) NOT NULL,
		ShipName		varchar(30),
		ShipAddress		varchar(30),
		ShipZip			varchar(12),
		ShipCountry		varchar(30),
		ShipPhone		varchar(15),
		Constraint		pkOrder Primary Key (OrderID),
		Constraint		fkCustomer Foreign Key (CustomerID) References tblCustomer (CustomerID),
		Foreign Key		(PrimaryOrderID) References tblOrder (OrderID)
	);
	Create Table tblItem
	(	ItemID		char(6),
		TypeID		int NOT NULL,
		Description	varchar(300),
		ListPrice	money NOT NULL Check (ListPrice > 5),
		Constraint	pkItem Primary Key (ItemID),
		Constraint	fkType Foreign Key (TypeID) References tblItemType (TypeID)
	);
	-- Three
	Create Table tblOrderLine
	(	OrderID		char(6),
		ItemID		char(6),
		Quantity	int NOT NULL Check (Quantity > 0),
		Price		money NOT NULL Check (Price > 0),
		Constraint	pkOrderLine Primary Key (OrderID, ItemID),
		Constraint	fkOrder Foreign Key (OrderID) References tblOrder (OrderID),
		Constraint	fkIte Foreign Key (ItemID) References tblItem (ItemID)
	);
	Create Table tblItemLocation
	(	ItemID		char(6),
		LocationID	char(2),
		QtyOnHand	int,
		Constraint	pkItemLocation Primary Key (ItemID, LocationID),
		Constraint	fkItem4Location Foreign Key (ItemID) References tblItem (ItemID)
	);
	Create Table tblItemCostHistory
	(	ItemID			char(6),
		LastCostDate	datetime,
		LastCost		money NOT NULL,
		Constraint		pkItemCostHistory Primary Key (ItemID, LastCostDate),
		Constraint		fkItem4History Foreign Key (ItemID) References tblItem (ItemID)
	);
	-- Four
	Create Table tblShipLine
	(	DateShipped		datetime,
		OrderID			char(6),
		ItemID			char(6),
		LocationID		char(2),
		QtyShipped		int NOT NULL,
		MethodShipped	varchar(30) NOT NULL,
		Constraint		pkShipLine Primary Key (DateShipped, OrderID, ItemID, LocationID),
		Constraint		fkOrderLine4ShipLine Foreign Key (OrderID, ItemID) References tblOrderLine (OrderID, ItemID),
		Constraint		fkItemLocation Foreign Key (ItemID, LocationID) References tblItemLocation (ItemID, LocationID)
	);
	Create Table tblReview
	(	ReviewID	int Identity(1,1),
		OrderID		char(6) NOT NULL,
		ItemID		char(6) NOT NULL,
		ReviewDate	datetime,
		Rating		int Check (Rating >= 1 and Rating <= 5),
		ReviewText	varchar(500),
		Constraint	pkReview Primary Key (ReviewID),
		Constraint	fkOrderLine4Review Foreign Key (OrderID, ItemID) References tblOrderLine (OrderID, ItemID)
	);

-- Populate Tables
	-- One
	Insert Into tblCustomer Values
		('00405', 'Barrington', 'Margaret', '1765 Roundtree Pkwy', 'reno', 'nv', '89509-1454', 'USA', '07/12/2006', 'barry@hotmail.com', '7757464561'),
		('00625', 'Dao', 'Phong', '341 West Park', 'Fresno', 'CA', '96137', null, '09/02/2015', 'daop@gmail.com', '8582138982'),
		('06774', 'Phillips', 'Kendall', '44512 Sawbuck Path', 'SPARKS', 'nv', '89432', 'USA', '08/12/2000', 'flipper@gmail.com', '7753324636'),
		('07831', 'Rodriguez', 'Karen', '4589 Marthiam', 'Chico', 'CA', '97111', null, '11/06/2008', 'rodriguez@aol.com', '8193821828'),
		('08892', 'Twillers', 'Bethany', 'P.O.Box 5661', 'san jose', 'ca', '98123', 'USA', '04/01/2000', 'twillbeth@yahoo.com', '8098291838'),
		('12001', 'Cranston', 'Brittany', '12 Sandstone', 'Sparks', 'NV', '89431', null, '04/12/2014', 'britters@ccb.com', '7753312199'),
		('12006', 'Martinez', 'Guadalupe', '223 North Pinetree Drive', 'Reno', 'NV', '89511', null, '02/14/2012', 'gmartinez@ccu.edu', '7758837612'),
		('21142', 'Candriller', 'Kathy', '2 Sedgeway', 'Laguna Beach', 'CA', '94567', null, '12/11/2015', 'kriller@mbu.edu', '6198813929'),
		('21143', 'Jackson', 'Janice', '2341 Bramble Bush Drive', 'Sparks', 'NV', '89431-0112', null, '05/06/2014', 'jj@isp.all.com', '7753317188'),
		('29188', 'Polanski', 'Tiffany', '5778 Battlemount Ct.', 'RENO', 'NV', '89507', null, '08/23/2011', 'skipole@gmail.com', '7757465771'),
		('30192', 'Chen', 'Lian', '2319 Crest Dr', 'REno', 'Nv', '89503-0113', null, '08/30/1999', 'jester@here.com', '7757218991'),
		('32018', 'Jones', 'Martin', '10 South Wilders', 'reno', 'nv', '89503-8912', 'USA', '02/12/2016', 'mmm@hard.com', '7753314838'),
		('32817', 'Foster', 'Ben', '318 Western Ave', 'SAN diego', 'ca', '92381', null, '08/15/1999', 'fosterben@aol.com', '8583284483'),
		('38817', 'Argiento', 'Bud', '1001 Catchway', 'Anaheim', 'CA', '95113', null, '03/12/2015', 'bud@cservices.com', '8037718991'),
		('78112', 'Guili', 'Mary Anne', '4457 Meridith St', 'Irvine', 'CA', '97128', null, '10/09/2012', 'ma@san.rr.com', '6195621334');
	Insert Into tblItemType Values
		(10,  'Classic Board Games'),
		(11,  'Word Games'),
		(12,  'Science Fiction and Fantasy'),
		(15,  'Mystery and Thrillers'),
		(16,  'Romance'),
		(17,  'Comedy and Jokes'),
		(18,  'Risque and Adult Material'),
		(20,  'Office and Team Building');
	-- Two
	Insert Into tblOrder Values
		('123000', '00405', null, '02/02/2016', 'A1', '111', null, null, null, null, null),
		('200335', '07831', '567123', '01/26/2016', null, '111', 'Cordwin', 'Arch 162 Stamford Brook', 'W6 0SE', 'UK', '441817417500'),
		('223344', '21142', null, '02/09/2016', null, '231', null, null, null, null, null),
		('300221', '07831', '567123', '01/26/2016', '03', '231', 'Baron Mancos', '251 Western Avenue Suite 1a', '8776', 'USA', '2109003005'),
		('400001', '32018', null, '02/20/2016', 'B3', '111', null, null, null, null, null),
		('445511', '32018', null, '02/15/2016', '02', '444', null, null, null, null, null),
		('450137', '07831', null, '12/29/2015', null, '444', 'Frandsen LLC', '435 Caminito Corriente', '92129', 'USA', '6551223298'),
		('567123', '07831', null, '01/26/2016', null, '444', 'Jenkins Corporation', '2276 Brentell Street Suite 201', '92128', 'USA', '8583440669'),
		('651222', '12006', null, '01/29/2016', null, '111', null, null, null, null, null),
		('671100', '32018', null, '02/19/2016', null, '111', null, null, null, null, null),
		('675990', '00625', '892211', '12/28/2015', null, '111', 'Karen Nelson', '601 Comet View Ct.', '90056', 'USA', '7018902330'),
		('781206', '38817', null, '02/15/2016', '06', '231', 'Carrington-Smythe', '231 Dulwich St. Wellington', 'TA21 0AB', 'UK', '2088887009'),
		('892211', '00625', null, '12/28/2015', null, '111', null, null, null, null, null),
		('980001', '78112', null, '01/22/2016', '04', '444', null, null, null, null, null),
		('983983', '32018', '671100', '02/19/2016', null, '111', 'Ender Industries', '3011 Marsh Dr.', '67455', 'USA', '3558992111');
	Insert Into tblItem Values
		('A23441',  10,  'New York City Monopoly Game Collector''s Edition',  29.95),
		('A23771',  12,  'Mysterium',  132.99),
		('A34665',  10,  'Boggle Deluxe 5x5',  34.95),
		('A34882',  10,  'Perudo',  10.95),
		('A45111',  15,  'How to Host a Murder - An Affair to Dismember',  28.95),
		('B67123',  12,  'Tiny Epic Galaxies',  39.99),
		('B67466',  20,  'Diplomacy: Game of Negotiation, Cunning and Deceit.',  43.95),
		('B78244',  15,  'Code Names',  19.95),
		('B78500',  12,  'Pandemic Legacy',  59.99),
		('C26133',  20,  'Knowledge Management: Create a Learning Organization',  395.95),
		('C29179',  20,  'Managing Change: The Game for an Executive Retreat',  259.95),
		('C34122',  20,  'A Game of Strategy, Negotiation and Excitement for Office Retreats',  169.95);
	-- Three
	Insert Into tblOrderLine Values
		('123000', 'A23441', 8, 29.95),
		('123000', 'A34665', 30, 37.95),
		('123000', 'B67123', 5, 389.99),
		('200335', 'A23441', 1, 29.95),
		('200335', 'A34665', 1, 34.95),
		('200335', 'B67123', 1, 39.99),
		('200335', 'B67466', 1, 43.95),
		('223344', 'A23441', 55, 29.95),
		('223344', 'A23771', 15, 122.99),
		('223344', 'A34665', 100, 23.95),
		('223344', 'A34882', 35, 7.95),
		('223344', 'B67123', 25, 34.95),
		('223344', 'B67466', 15, 40.95),
		('300221', 'A23771', 1, 145.99),
		('300221', 'A34665', 1, 35.95),
		('300221', 'A34882', 1, 10.95),
		('300221', 'B67123', 1, 39.99),
		('300221', 'B78244', 1, 19.95),
		('400001', 'C26133', 1, 395.95),
		('445511', 'C34122', 3, 269.95),
		('450137', 'A23771', 16, 135.99),
		('450137', 'A34665', 10, 31),
		('450137', 'A34882', 50, 9.95),
		('450137', 'B67123', 21, 14.95),
		('450137', 'B67466', 9, 41.95),
		('450137', 'C26133', 4, 398.95),
		('450137', 'C34122', 6, 167.95),
		('567123', 'C26133', 1, 395.95),
		('651222', 'A34665', 5, 37.95),
		('651222', 'A34882', 16, 11.95),
		('651222', 'B78244', 21, 17.99),
		('671100', 'C29179', 1, 259.95),
		('781206', 'B67466', 1, 43.95),
		('781206', 'C29179', 2, 280),
		('892211', 'C26133', 15, 380),
		('892211', 'C29179', 10, 259.95),
		('892211', 'C34122', 8, 200),
		('980001', 'C29179', 3, 275.99),
		('980001', 'C34122', 2, 169.95),
		('983983', 'A23771', 1, 135.99),
		('983983', 'B78244', 18, 18.95);
	Insert Into tblItemLocation Values
		('A23441', '10', 11),
		('A23441', '20', 23),
		('A23441', '30', 25),
		('A23771', '10', 6),
		('A23771', '20', 4),
		('A23771', '30', 5),
		('A34665', '10', 141),
		('A34882', '10', 40),
		('A34882', '30', 55),
		('A45111', '10', 2),
		('A45111', '20', 3),
		('A45111', '30', 2),
		('B67123', '10', 22),
		('B67123', '20', 28),
		('B67123', '30', 6),
		('B67123', '40', 4),
		('B67466', '10', 0),
		('B67466', '20', 3),
		('B67466', '30', 4),
		('B78244', '20', 22),
		('B78500', '20', 8),
		('B78500', '30', 1),
		('C29179', '10', 15),
		('C29179', '20', 15),
		('C34122', '10', 16),
		('C34122', '20', 21);
	Insert Into tblItemCostHistory Values
		('A23441', '01/06/2013', 10.25),
		('A23441', '05/12/2013', 10.5),
		('A23441', '09/23/2014', 10.88),
		('A23441', '07/07/2015', 11.15),
		('A23441', '01/05/2016', 10.35),
		('A23441', '02/02/2016', 12.5),
		('A23771', '07/23/2013', 8.5),
		('A34665', '01/12/2015', 15),
		('A34665', '07/15/2015', 14.5),
		('A34665', '12/28/2015', 14.35),
		('A34882', '02/19/2014', 6.5),
		('A34882', '02/05/2016', 12.5),
		('B67123', '08/08/2015', 14.5),
		('B67123', '10/21/2015', 18.8),
		('B67123', '01/10/2016', 14.5),
		('B67123', '02/02/2016', 21.8),
		('B67466', '07/07/2014', 22.5),
		('B67466', '06/28/2015', 28.9),
		('B67466', '09/12/2015', 31),
		('B78244', '07/15/2015', 14.5),
		('B78500', '03/21/2015', 18.95),
		('B78500', '07/15/2015', 18),
		('B78500', '11/25/2015', 21),
		('B78500', '02/10/2016', 22.35),
		('C26133', '07/13/2014', 200),
		('C26133', '07/23/2015', 225),
		('C26133', '09/18/2015', 215),
		('C26133', '02/15/2016', 212.25),
		('C29179', '08/07/2015', 160),
		('C29179', '01/17/2016', 158.85),
		('C34122', '02/06/2013', 45),
		('C34122', '02/06/2014', 48),
		('C34122', '02/06/2015', 51),
		('C34122', '02/02/2016', 58.5);
	-- Four
	Insert Into tblShipLine Values
		('01/19/2016', '450137', 'B67123', '20', 8, 'ups'),
		('01/23/2016', '892211', 'C29179', '10', 6, 'UPS'),
		('01/23/2016', '892211', 'C34122', '10', 2, 'UPS'),
		('01/23/2016', '892211', 'C34122', '20', 3, 'UPS'),
		('01/27/2016', '450137', 'B67123', '20', 3, 'UPS'),
		('01/27/2016', '450137', 'B67123', '30', 14, 'Ups'),
		('01/27/2016', '450137', 'B67123', '40', 4, 'ups'),
		('02/05/2016', '300221', 'A23771', '20', 1, 'Ups'),
		('02/05/2016', '300221', 'B78244', '20', 1, 'UPS'),
		('02/05/2016', '980001', 'C34122', '10', 2, 'FEDEX'),
		('02/06/2016', '980001', 'C29179', '10', 3, 'FEDex'),
		('02/10/2016', '223344', 'A23441', '10', 3, 'UPS'),
		('02/10/2016', '223344', 'A23441', '20', 20, 'UPS'),
		('02/10/2016', '223344', 'A23771', '10', 8, 'ups'),
		('02/10/2016', '223344', 'A23771', '20', 2, 'UPS'),
		('02/10/2016', '223344', 'A34665', '10', 45, 'UPs'),
		('02/10/2016', '223344', 'A34882', '10', 15, 'fedEX'),
		('02/10/2016', '223344', 'B67123', '10', 13, 'UPS'),
		('02/10/2016', '300221', 'A34665', '10', 1, 'UPS'),
		('02/11/2016', '223344', 'A23771', '30', 5, 'UPS'),
		('02/12/2016', '223344', 'A23441', '20', 5, 'Ups'),
		('02/12/2016', '223344', 'A34665', '10', 65, 'ups'),
		('02/12/2016', '223344', 'A34882', '10', 20, 'UPS'),
		('02/12/2016', '300221', 'A34882', '10', 1, 'UPs'),
		('02/15/2016', '123000', 'A23441', '20', 8, 'UPS'),
		('02/15/2016', '123000', 'A34665', '10', 32, 'UPS'),
		('02/16/2016', '445511', 'C34122', '10', 3, 'FeDEX'),
		('02/19/2016', '200335', 'A23441', '20', 6, 'UPS'),
		('02/19/2016', '781206', 'B67466', '30', 4, 'Delta Freight'),
		('02/20/2016', '300221', 'B67123', '10', 1, 'UpS'),
		('02/21/2016', '200335', 'B67466', '10', 1, 'Delta Freight'),
		('02/21/2016', '450137', 'A34665', '10', 10, 'FeDeX'),
		('02/22/2016', '223344', 'B67123', '10', 12, 'UPS'),
		('02/22/2016', '651222', 'A34882', '30', 32, 'UPS'),
		('02/22/2016', '892211', 'C29179', '10', 4, 'UPS'),
		('02/25/2016', '123000', 'B67123', '10', 5, 'UPS'),
		('02/25/2016', '671100', 'C29179', '10', 1, 'UPS'),
		('02/29/2016', '651222', 'A34882', '30', 10, 'UPS'),
		('03/01/2016', '223344', 'A23771', '30', 30, 'UPS'),
		('03/01/2016', '450137', 'B67466', '20', 9, 'FedEx'),
		('03/01/2016', '651222', 'A34882', '30', 10, 'UPS'),
		('03/02/2016', '450137', 'A34882', '30', 15, 'UpS'),
		('03/02/2016', '651222', 'A34665', '10', 2, 'UPS'),
		('03/02/2016', '651222', 'A34882', '10', 5, 'UPS'),
		('03/04/2016', '651222', 'A34665', '10', 3, 'UPS'),
		('03/05/2016', '651222', 'A34882', '10', 10, 'FedEX'),
		('03/06/2016', '651222', 'B78244', '20', 21, 'ups'),
		('03/19/2016', '651222', 'A34882', '10', 1, 'UPS');
	Insert Into tblReview Values
		('200335', 'A34665', '02/12/2016', 1, 'This is the worst company I''ve ever dealt with. They still have not shipped my order and it was placed on January 26. I will never buy anything from them again. Ever.'),
		('450137', 'C34122', '02/14/2016', 1, 'I don''t know how this company stays in business. They can''t ship anything on time, and their game selection isn''t all that great'),
		('300221', 'A23771', '02/18/2016', 5, 'Shipping was fast, the game was in great shape, and I will order from them again. Highly recommend'),
		('223344', 'A23771', '02/16/2016', 4, 'This is one of the few companies that will ship internationally fairly cost effectively. They are slow, but at least shipping isn''t a ridiculous amount.'),
		('445511', 'C34122', '01/15/2016', 3, 'They are slow. They overship. They undership. They have the best shipping internationally, but nothing spectacular if you are shipping to the U.S. Buyer beware.');

-- Display Tables
	-- One
	Select * From tblCustomer;
	Select * From tblItemType;
	-- Two
	Select * From tblOrder;
	Select * From tblItem;
	-- Three
	Select * From tblOrderLine;
	Select * From tblItemLocation;
	Select * From tblItemCostHistory;
	-- Four
	Select * From tblShipLine;
	Select * From tblReview;
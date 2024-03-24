use Sales1

create schema Person

CREATE TABLE Person.Address(
	[AddressID] [int] NOT NULL primary key,
	[AddressLine1] [nvarchar](60) not NULL,
	[AddressLine2] [nvarchar](60) NULl,
	[city] [nvarchar](30) NULL,
	[StateProvinceID] [int] NULL,
	[PostalCode] [nvarchar](15) NUlL,
	[SpatialLocation] [geography] not NULL,
	[rowguid] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL
	)

create schema Purchasing

CREATE TABLE Purchasing.ShipMethod (
	[ShipMethodID] [int] NOT NULL primary key,
	[ShipBase] [money] not NULL,
	[ShipRate] [money] not NULL,
	[rowguid] [uniqueidentifier] not NULL,
	[ModifiedDate] [datetime] not NULL,
	)

create schema Sales
CREATE TABLE Sales.CreditCard (
	[CreditCardID] [int] NOT NULL primary key,
	[CardType] [nvarchar](50) not NULL ,
	[CradNumber] [nvarchar](25) not NUll,
	[ExpMonth] [tinyint] not NULL,
	[ExpYear] [smallint] not NULL,
	[ModifiedDate] [datetime] not NULL,
	)

CREATE TABLE Sales.CurrencyRate(
	[CurrencyRateID] [int] NOT NULL primary key,
	[CurrencyRateDate] [datetime] not NULL,
	[FromCurrencyCode] [nchar](3) not NULL,
	[ToCurrencyCode] [nchar](3) not NULL,
	[AverageRate] [money] not NULL,
	[EndOfDayRate] [money] not NULL,
	[ModifiedDate] [datetime] not NULL,
	)

CREATE TABLE Sales.Customer (
	[CustomerID] [int] NOT NULL primary key ,
	PersonID int null,
	[StoreID] [int] NULL,
	[TerritoryID] int NULL,
	[rowguid] [uniqueidentifier] not NULL,
	[ModifiedDate] [datetime] not NULL, 
	)
	
CREATE TABLE Sales.SalesOrderHeader (
	[SalesOrderID] [int] NOT NULL primary key,
	[RevisionNumber] [tinyint] not NULL,
	[OrderDate] [datetime] not NULL,
	[DueDate] [datetime] not NULL,
	[ShipDate] [datetime] NULL,
	[Status] [tinyint] not NULL,
	[CustomerID] [int] not NULL,
	[SalesPersonID] [int] NULL,
	[TerritoryID] [int] NULL,
	[BillToAddressID] [int] not NULL,
	[ShipToAddressID] [int] not NULL,
	[ShipMethodID] [int] not NULL,
	[CreditCardID] [int] NULL,
	[CreditCardApprovalCode] [varchar](15) NULL,
	[CurrencyRateID] [int] NULL,
	[SubTotal] [money] not NULL,
	[TaxAmt] [money] not NULL,
	[Freight] [money] not NULL),
	foreign key(territoryid) references sales.salesterritory (territoryid),
	foreign key (CreditCardID) references [Sales].[CreditCard] (CreditCardID),
	foreign key (CustomerID) references [Sales].[Customer](CustomerID),
	)


CREATE TABLE Sales.SalesPerson (
	[BusinessEntityID] [int]primary key not null,
	[TerritoryID] [int] NULL,
	[SalesQuota] [money] NULL,
	[Bonus] [money]not null,
	[CommissionPct] [smallmoney]not null,
	[SalesYTD] [money] not null,
	[SalesLastYear] [money] not null,
	[rowguid] [uniqueidentifier] not null,
	[ModidfiedDate] [datetime] not null,
	foreign key (territoryid) references [Sales].[SalesTerritory](territoryid)
	)

CREATE TABLE Sales.SalesTerritory (
	[TerritoryID] [int] primary key not null,
	[CountryRegionCode] [nvarchar](3) not null,
	[GROUP] [nvarchar](50) not null,
	[SalesYTD] [money] not null,
	[SalesLastYear] [money] not null,
	[CostYTD] [money] not null,
	[CostLastYear] [money] not null,
	[rowguid] [uniqueidentifier] not null,
	[ModifiedDate] [datetime] not null
	)

CREATE TABLE Sales.SpecialOfferProduct(
	[SpecialOfferID] [int]  not null,
	[ProductID] [int]  not null,
	[rowguid] [uniqueidentifier] not null,
	[ModifiedDate] [datetime] not null,
	primary key (ProductID,SpecialOfferID)
	)

create table Sales.SalesOrderDetail(
	SalesOrderID int  not null,
	SalesOrderDetailID int not null,
	CarrierTrackingNumber nvarchar(25) null,
	OrderQty smallint not null,
	ProductID int not null,
	SpecialOfferID int not null,
	UnitPrice money not null,
	UnitPriceDiscount money not null,
	rowguid uniqueidentifier not null,
	ModifiedDate datetime not null,
	primary key (SalesOrderID,SalesOrderDetailID),
	constraint specialDetail foreign key (ProductID,specialofferid) references Sales.SpecialOfferProduct (ProductID,specialofferid)
	)

ALTER TABLE [Sales].[Customer]
ADD CONSTRAINT FK_SalesTerritory_Customers FOREIGN KEY (TerritoryID) REFERENCES sales.SalesTerritory(TerritoryID)

alter table sales.salesorderheader
add foreign key (BillToAddressID) references person.address (addressid)

alter table sales.salesorderheader
add foreign key (shipmethodid) references purchasing.shipmethod (shipmethodid)

alter table sales.salesorderheader
add foreign key (ShipToAddressID) references person.address (addressid)

alter table sales.salesorderheader
add foreign key (CurrencyRateID) references sales.currencyrate (CurrencyRateID)

alter table Sales.SalesOrderDetail
add foreign key(salesorderid) references Sales.SalesOrderHeader (salesorderid)

alter table Sales.salesorderheader
add foreign key (salespersonid) references sales.salesperson (businessentityid)


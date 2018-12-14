CREATE DATABASE HappyCarrot;

CREATE TABLE Clients(
	Id int NOT NULL,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	BirthDate datetime NULL,
	FromDate datetime NOT NULL,
	OrdersCount int NOT NULL,
	OrdersAmount decimal(9,2) NOT NULL,
	Country nvarchar(50) NULL);


DECLARE @birthStart DATE = '1920-01-01'
DECLARE @birthEnd DATE = '2002-12-31';

DECLARE @fromStart DATE = '2014-01-01'
DECLARE @fromEnd DATE = '2018-12-12';

WITH
	L0 AS (SELECT 1 AS c UNION ALL SELECT 1),
	L1 AS (SELECT 1 AS c FROM L0 A CROSS JOIN L0 B),
	L2 AS (SELECT 1 AS c FROM L1 A CROSS JOIN L1 B),
	L3 AS (SELECT 1 AS c FROM L2 A CROSS JOIN L2 B),
	L4 AS (SELECT 1 AS c FROM L3 A CROSS JOIN L3),
	L5 AS (SELECT 1 AS c FROM L4 A CROSS JOIN L4),
	NUMS AS (SELECT 1 AS NUM FROM L5)   
INSERT INTO Clients(Id, FirstName, LastName, BirthDate, FromDate, OrdersCount, OrdersAmount, Country)
SELECT TOP 10000000
  CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS INT) [ID]
, 'FN' + CAST(ROUND(10000 * RAND(CHECKSUM(NEWID())), 0)  AS VARCHAR(100)) FirstName
, 'LN' + CAST(ROUND(10000 * RAND(CHECKSUM(NEWID())), 0)  AS VARCHAR(100)) LastName
, DATEADD(DAY, FLOOR(RAND(CHECKSUM(NEWID())) * DATEDIFF(DAY, @birthStart, @birthEnd)), @birthStart) AS BirthDate
, DATEADD(DAY, FLOOR(RAND(CHECKSUM(NEWID())) * DATEDIFF(DAY, @fromStart, @fromEnd)), @fromStart) AS FromDate
, ROUND(50 * RAND(CHECKSUM(NEWID())), 0) AS OrdersCount
, ROUND(1000000 * RAND(CHECKSUM(NEWID())), 2) AS OrdersAmount
, CASE 
	WHEN t.RandCountry <= 20 THEN 'Poland'
	WHEN t.RandCountry <= 22 THEN 'Hungary'
	WHEN t.RandCountry <= 23 THEN 'Czech Republic'
	WHEN t.RandCountry <= 24 THEN 'Slovakia'
	ELSE 'Romania'
  END AS Country 
FROM NUMS CROSS JOIN (
	SELECT 
		FLOOR(25 * RAND(CHECKSUM(NEWID()))) AS RandCountry) t;
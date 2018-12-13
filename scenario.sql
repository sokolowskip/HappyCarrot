SET STATISTICS IO ON;

 -- 1. Select by Id
 SELECT * FROM Clients WHERE Id = 9999999;
































-- 2. Create primary key
ALTER TABLE Clients
ADD CONSTRAINT PK_Clients PRIMARY KEY CLUSTERED (Id);

































-- 3. Select by Id again
SELECT * FROM Clients WHERE Id = 9999999;

































-- 4. Select by FirstName
SELECT ID, FirstName, LastName FROM Clients WHERE FirstName = 'FN3680';



































-- 5. Create index 
CREATE INDEX IDX_FirstName ON Clients(FirstName);


































-- 6. Select by FirstName  again
SELECT ID, FirstName, LastName FROM Clients WHERE FirstName = 'FN3680';


































-- 7. Create another index
CREATE INDEX IDX_FirstName_LastName ON Clients(FirstName, LastName);


































-- 8. Select by FirstName  again
SELECT ID, FirstName, LastName FROM Clients WHERE FirstName = 'FN3680';


































-- 9. Create an index with include
CREATE INDEX IDX_FirstName_LastName2 ON Clients(FirstName) INCLUDE (LastName);


































-- 10. Select by FirstName  again
SELECT ID, FirstName, LastName FROM Clients WITH(INDEX(IDX_FirstName_LastName2)) WHERE FirstName = 'FN3680';


































-- 11. Select by two columns
SELECT ID, FirstName, LastName FROM Clients WITH(INDEX(PK_Clients)) WHERE FirstName = 'FN3680' AND LastName = 'LN4020';
SELECT ID, FirstName, LastName FROM Clients WITH(INDEX(IDX_FirstName)) WHERE FirstName = 'FN3680' AND LastName = 'LN4020';
SELECT ID, FirstName, LastName FROM Clients WITH(INDEX(IDX_FirstName_LastName2)) WHERE FirstName = 'FN3680' AND LastName = 'LN4020';
SELECT ID, FirstName, LastName FROM Clients WITH(INDEX(IDX_FirstName_LastName)) WHERE FirstName = 'FN3680' AND LastName = 'LN4020';
































-- 12. SELECT by second column of an index
SELECT ID FROM Clients WITH(INDEX(IDX_FirstName_LastName)) WHERE FirstName = 'FN3680' AND LastName = 'LN4020';
SELECT ID FROM Clients WITH(INDEX(IDX_FirstName_LastName)) WHERE FirstName = 'FN3680';
SELECT ID FROM Clients WITH(INDEX(IDX_FirstName_LastName)) WHERE LastName = 'LN4020';


-- 
SELECT ID FROM Clients  WHERE LastName = 'LN4020';































-- 13. Create index by country
CREATE INDEX IDX_Country ON Clients(Country);
SELECT Id, FirstName, Country FROM Clients WHERE FirstName = 'FN3680' AND Country = 'Poland';
SELECT Id, FirstName, Country FROM Clients WITH(INDEX(IDX_Country)) WHERE FirstName = 'FN3680' AND Country = 'Poland';
































-- 14. sp_executesql
DBCC FREEPROCCACHE WITH NO_INFOMSGS;
EXECUTE sp_executesql N'SELECT * FROM Clients WHERE Country = @country', N'@country varchar(50)', @country = 'Slovakia';
INSERT INTO Clients(Id, FirstName, LastName, BirthDate, FromDate, OrdersCount, OrdersAmount, Country)
VALUES(-1, 'Zinedine', 'Zidan', '19720623', '20181201', 1, 2000.50, 'France')
EXECUTE sp_executesql N'SELECT * FROM Clients WHERE Country = @country', N'@country varchar(50)', @country = 'France';
EXECUTE sp_executesql N'SELECT * FROM Clients WHERE Country = @country', N'@country varchar(50)', @country = 'Slovakia';




















































-- 16. FK
CREATE TABLE Countries(Name varchar(50) NOT NULL PRIMARY KEY);
INSERT INTO Countries(Name) Values('Poland'), ('Hungary'), ('Czech Republic'), ('Slovakia'), ('France'), ('Germany'), ('Spain');

DROP INDEX IDX_Country ON Clients;

ALTER TABLE Clients ADD CONSTRAINT FK_Clients_Country 
FOREIGN KEY (Country) 
REFERENCES Countries(Name);

DELETE Countries WHERE Name = 'Germany';

CREATE INDEX  IDX_Country ON Clients(Country);

DELETE Countries WHERE Name = 'Spain';
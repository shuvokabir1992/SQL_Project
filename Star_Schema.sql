
#Example of a Star Schema
#Table created for SSMS

USE Database_Name

CREATE TABLE Product (
 ProductID INT PRIMARY KEY,
 Article VARCHAR(50),
 ProductGroup VARCHAR(50),
 ProductCategory VARCHAR(50)
 );	

INSERT INTO Product (ProductID, Article, ProductGroup, ProductCategory)
VALUES
  (1, 'Laptop', 'Electronics', 'Computers'),
  (2, 'Refrigerator', 'Appliances', 'Kitchen'),
  (3, 'Running Shoes', 'Apparel', 'Footwear'),
  (4, 'Smartphone', 'Electronics', 'Mobile Devices'),
  (5, 'Coffee Maker', 'Appliances', 'Kitchen');

------------------------

USE Star_Schema --Defining the Database Name

CREATE Table Geography (

GeographyID INT PRIMARY KEY,
Branch VARCHAR(50),
City VARCHAR(50),
State VARCHAR(50),

);

INSERT INTO Geography (GeographyID, Branch, City, State)
VALUES
  (1, 'BranchA', 'CityA', 'StateA'),
  (2, 'BranchB', 'CityB', 'StateB'),
  (3, 'BranchC', 'CityC', 'StateC'),
  (4, 'BranchD', 'CityD', 'StateD'),
  (5, 'BranchE', 'CityE', 'StateE');

  Select * from Geography



---------------------------
 USE Star_Schema

CREATE TABLE Time (
    TimeID INT PRIMARY KEY,
    Day INT,
    Week INT,
    Month Varchar(50),
    Quarter INT,
    Year INT
)

INSERT INTO Time (TimeID, Day, Week, Month, Quarter, Year)
VALUES
  (1, 5, 3, 'January', 2, 2023),
  (2, 12, 8, 'November', 4, 2022),
  (3, 25, 15, 'May', 1, 2023),
  (4, 3, 2, 'September', 3, 2022),
  (5, 18, 10, 'June', 2, 2022);

  Select * from Time

  -------------------

  USE Star_Schema

CREATE TABLE Sales (
    ProductID INT,
    TimeID INT,
    GeographyID INT,
    Sales DECIMAL(18, 2),
    Turnover DECIMAL(18, 2),
    PRIMARY KEY (ProductID, TimeID, GeographyID),
    FOREIGN KEY (ProductID) REFERENCES ProductTable(ProductID),
    FOREIGN KEY (TimeID) REFERENCES TimeTable(TimeID),
    FOREIGN KEY (GeographyID) REFERENCES GeographyTable(GeographyID)
);

INSERT INTO Sale (ProductID, TimeID, GeographyID, Sales, Turnover)
VALUES
  (1, 1, 1, 1000.50, 750.25),
  (2, 2, 2, 1500.75, 1200.60),
  (3, 3, 1, 800.25, 600.15),
  (1, 4, 3, 1200.30, 900.22),
  (2, 5, 2, 950.50, 720.75);

Select * from Sale


--------------------------
--Star Schema Query to Retrieve

 SELECT G.Branch, T.Year, sum(Sales) as Sales
 FROM Sale V
 JOIN Geography G ON (V.GeographyID = G.GeographyID)
 JOIN Product P ON (V.ProductID = P.ProductID)
 JOIN Time T ON (V.TimeID = T.TimeID)
 WHERE P.Article = 'Laptop'
 GROUP BY G.Branch, T.Year


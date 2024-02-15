USE SQL_Extension

CREATE TABLE Location(
	CityID	VARCHAR(50),
	City	VARCHAR(50),
	Region	VARCHAR(50),
	Country	VARCHAR(50),
	PRIMARY KEY (CityID)
);

CREATE TABLE SportsDiscipline(
	DisciplineID	VARCHAR(50),
	Distance		VARCHAR(50),
	KM				INT,
	PRIMARY KEY(DisciplineID)
);

CREATE TABLE Participants(
	DisciplineID VARCHAR(50),
	CityID VARCHAR(50),
	Date DATE,
	NumberOfPart INT,
	PRIMARY KEY(DisciplineID,CityID),
	FOREIGN KEY(DisciplineID) REFERENCES SportsDiscipline(DisciplineID),
	FOREIGN KEY(CityID) REFERENCES Location(CityID) 

);

---------------------------------

USE SQL_Extension

INSERT INTO Location(CityID,City,Region,Country)
VALUES
	('C1','Rostock','MV','Germany'),
	('C2','Schwerin','MV','Germany'),
	('C3','Leipzig','Sachsen','Germany'),
	('C4','Dresden','Sachsen','Germany'),
	('C5','Prague','Chez','Chez Republic');



INSERT INTO SportsDiscipline(DisciplineID,Distance,KM)
VALUES
	('D1','Marathon',42),
	('D2','Half Marathon',21);



INSERT INTO Participants(DisciplineID,CityID,Date,NumberOfPart)
VALUES
	('D1','C1','2024-12-23',280),
	('D1','C2','2024-12-12',100),
	('D1','C3','2024-12-14',120),
	('D1','C4','2024-12-15',200),
	('D1','C5','2024-12-15',500),
	('D2','C1','2024-12-21',420),
	('D2','C2','2024-12-22',130),
	('D2','C3','2024-12-24',180),
	('D2','C4','2024-12-21',300),
	('D2','C5','2024-12-26',500);

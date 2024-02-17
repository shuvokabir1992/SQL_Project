
CREATE Table Subjects (

	FieldOfStudy_ID INT,
	FieldOfStudy VARCHAR(50),
	Term_No INT,

	PRIMARY KEY(FieldOfStudy_ID)

);
Go


CREATE Table Students (

	Students_No INT,
	FamilyName VARCHAR(50),
	FirstName VARCHAR(50),
	FieldOfStudy_ID INT,
	Term INT,

	PRIMARY KEY(Students_NO),
	FOREIGN KEY(FieldOfStudy_ID) REFERENCES Subjects (FieldOfStudy_ID)
	

);
Go

INSERT INTO Students(Students_No,FamilyName,FirstName,FieldOfStudy_ID,Term )
VALUES
	(0449387,'Schmidt','Holger',0003,4),
	(0543872, 'Schulz', 'Anja', 0002, 1);

INSERT INTO Subjects(FieldOfStudy_ID,FieldOfStudy,Term_No)
VALUES
 (0002, 'BMI', 6),
 (0003, 'DPh', 7),
 (0004, 'CSI', 7);

SELECT
	Students_No AS Matricle_No, FamilyName AS Name, FirstName, Subjects.FieldOfStudy AS Subject, Term
FROM
	Students JOIN Subjects
	ON Students.FieldOfStudy_ID = Subjects.FieldOfStudy_ID


	INSERT INTO Persons(Perssons_Number,Name,FirstName,City,ZIP,Gender,Birthday)
VALUES
    (123, 'Schmidt', 'Annem', 'Rostock', 18055, 'F', '2004-01-01'),
    (124, 'sCHULZ', 'Anne', 'G strow', 18069, 'F', '2006-02-02'),
    (125, 'Meier', 'Manu', 'Schwerin', 18057, 'M', '2008-03-03');


SELECT 
    Perssons_Number AS Person_number, 
    Name AS FamilyName, 
    FirstName, 
    CONCAT(ZIP,' ',City) AS Address, 
    DATEDIFF(YEAR, Birthday, GETDATE()) - 
        CASE
            WHEN DATEADD(YEAR, DATEDIFF(YEAR, Birthday, GETDATE()), Birthday) > GETDATE() THEN 1 
            ELSE 0 
        END AS Age
FROM Persons -- assuming Persons is the name of your table
WHERE Age 

<= 18
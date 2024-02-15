USE [5_NF]

CREATE TABLE Preferred_Brands_By_Person (
 Person VARCHAR(50),
 Brand VARCHAR(50),
 PRIMARY KEY (Person,Brand),
 );	

INSERT INTO Preferred_Brands_By_Person (Person,Brand)
VALUES
  ('Jason','Frosty'),
  ('Jason', 'Alpine'),
  ('Suzy','Alpine'),
  ('Suzy', 'Ice Queen');


 

USE [5_NF]

CREATE TABLE Available_Flavors_By_Brand (
 Brand VARCHAR(50),
 Flavor VARCHAR(50),
 PRIMARY KEY (Brand,Flavor),
 ); 

INSERT INTO Available_Flavors_By_Brand (Brand,Flavor)
VALUES
  ('Frosty','Vanila'),
  ('Frosty','Strawberry'),
  ('Frosty','Chocolate'),
  ('Alpine','Vanila'),
  ('Alpine','Raisin'),
  ('Ice Queen','Vanila'),
  ('Ice Queen','Strawberry'),
  ('Ice Queen','Chocolate');




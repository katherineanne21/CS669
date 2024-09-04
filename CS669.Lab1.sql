-- Database: CS 669

-- DROP DATABASE IF EXISTS "CS 669";

-- Section 1-1
CREATE TABLE Cars(
CarBrand VARCHAR(64),
CarModel VARCHAR(50),
AcquiredDate DATE,
Price DECIMAL(10,2)
);

-- Section 1-2
INSERT INTO Cars (CarBrand, CarModel, AcquiredDate, Price) 
VALUES ('Ford', 'Econoline Full-Size Van', '2021-08-15', 29995.00);

-- Section 1-3
SELECT *
FROM Cars;

-- Section 1-4
UPDATE Cars
SET Price = 28000;

SELECT *
FROM Cars;

-- Section 1-5
DELETE FROM Cars;

SELECT *
FROM Cars;

-- Section 1-6
DROP TABLE Cars;

SELECT *
FROM Cars;

-- Section 2-7
CREATE TABLE Apartments(
ApartmentNum DECIMAL(12) PRIMARY KEY,
ApartmentName VARCHAR(64) NOT NULL,
Description VARCHAR(64) NULL,
CleanedDate DATE NOT NULL,
AvailableDate DATE NOT NULL);

-- Section 2-8
INSERT INTO Apartments(ApartmentNum, ApartmentName, Description, CleanedDate, AvailableDate)
VALUES (498, 'Deer Creek Crossing', 'Great view of Riverwalk', '2022-04-19', '2022-04-25');

INSERT INTO Apartments(ApartmentNum, ApartmentName, Description, CleanedDate, AvailableDate)
VALUES (128, 'Town Place Apartments', 'Convenient walk to Parking', '2022-05-20', '2022-05-25');

INSERT INTO Apartments(ApartmentNum, ApartmentName, Description, CleanedDate, AvailableDate)
VALUES (316, 'Paradise Palms', NULL, '2022-06-02', '2022-06-08');

SELECT *
FROM Apartments;

-- Section 2-9
INSERT INTO Apartments(ApartmentNum, ApartmentName, Description, CleanedDate, AvailableDate)
VALUES (252, NULL, 'Close to Downtown shops', '2020-07-17', '2020-07-13');

-- Section 2-10
INSERT INTO Apartments(ApartmentNum, ApartmentName, Description, CleanedDate, AvailableDate)
VALUES (252, 'The Glenn', 'Close to Downtown shops', '2020-07-17', '2020-07-13');

SELECT *
FROM Apartments;

-- Section 2-11
SELECT ApartmentName, Description
FROM Apartments
WHERE ApartmentNum = 498;

-- Section 2-12
UPDATE Apartments
SET Description = 'A mile walk to the beach'
WHERE ApartmentNum = 316;

SELECT *
FROM Apartments;

-- Section 2-13
UPDATE Apartments
SET Description = NULL
WHERE ApartmentNum = 128;

SELECT *
FROM Apartments;

-- Section 2-14
DELETE FROM Apartments
WHERE CleanedDate > '2022-04-01';

SELECT *
FROM Apartments;

-- Section 3-15
CREATE TABLE Friends(
FriendName VARCHAR(64),
Birthday DATE,
FavColor VARCHAR(64)
);

INSERT INTO Friends(FriendName, Birthday, FavColor)
VALUES ('Maddie', '2002-09-23', 'Red');

INSERT INTO Friends(FriendName, Birthday, FavColor)
VALUES ('Collin', '2001-10-09', 'Green');

INSERT INTO Friends(FriendName, Birthday, FavColor)
VALUES ('Amy', '2005-11-18', 'Yellow');

INSERT INTO Friends(FriendName, Birthday, FavColor)
VALUES ('Laura', '2001-09-24', 'Blue');

INSERT INTO Friends(FriendName, Birthday, FavColor)
VALUES ('Josie', '2003-09-09', 'Red');

INSERT INTO Friends(FriendName, Birthday, FavColor)
VALUES ('Josie F', '2003-09-09', 'Red');

SELECT *
FROM Friends;

DELETE FROM Friends
WHERE Birthday = '2003-09-09';

SELECT *
FROM Friends;

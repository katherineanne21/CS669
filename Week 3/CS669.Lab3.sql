-- Step 1
CREATE TABLE Dinos(
dinos_id DECIMAL(12) NOT NULL PRIMARY KEY,
dino_dig_location VARCHAR(64) NOT NULL);

CREATE TABLE Dino_Dig(
dino_dig_id DECIMAL(12) NOT NULL PRIMARY KEY,
dinos_id DECIMAL(12) NOT NULL,
dig_name VARCHAR(64) NOT NULL,
dig_cost DECIMAL(10,2),
paleontologist VARCHAR(64) NOT NULL,
FOREIGN KEY (dinos_id) REFERENCES Dinos(dinos_id));

CREATE TABLE Dino_Type(
dino_type_id DECIMAL(12) NOT NULL PRIMARY KEY,
dino_dig_id DECIMAL(12) NOT NULL,
dinosaur_common_name VARCHAR(128) NOT NULL,
weight DECIMAL(12) NOT NULL,
FOREIGN KEY (dino_dig_id) REFERENCES Dino_Dig(dino_dig_id));

INSERT INTO Dinos(dinos_id, dino_dig_location)
VALUES
(1, 'Stonesfield'),
(2, 'Utah'),
(3, 'Arizona');

INSERT INTO Dino_Dig(dino_dig_id, dinos_id, dig_name, dig_cost, paleontologist)
VALUES
(101, 1, 'Great British Dig', 8000, 'William Buckland'),
(102, 2, 'Parowan Dinosaur Tracks', 10000, 'John Ostrom'),
(103, 3, 'Dynamic Desert Dig', 3500, 'John Ostrom'),
(104, 1, 'Mission Jurassic Dig', NULL, 'Henry Osborn'),
(105, 1, 'Ancient Site Dig', 5500, 'Henry Osborn'),
(106, 3, 'Grand Canyon Dig', 11000, 'Katherine Rein');

INSERT INTO Dino_Type(dino_type_id, dino_dig_id, dinosaur_common_name, weight)
VALUES
(1001, 101, 'Megalosaurus', 3000),
(1002, 101, 'Apatosaurus', 4000),
(1003, 101, 'Triceratops', 4500),
(1004, 101, 'Stegosaurus', 3500),
(1005, 102, 'Parasaurolophus', 6000),
(1006, 102, 'Tyrannosaurus Rex', 5000),
(1007, 102, 'Velociraptor', 7000),
(1008, 103, 'Tyrannosaurus Rex', 6000),
(1009, 104, 'Spinosaurus', 8000),
(1010, 104, 'Diplodocus', 9000),
(1011, 105, 'Tyrannosaurus Rex', 7500),
(1012, 106, 'Spinosaurus', 8500);

-- Step 2
SELECT COUNT(dinosaur_common_name)
FROM Dino_Type
WHERE weight >= 4200;

-- Step 3
SELECT 
MIN(dig_cost) AS least_expensive,
MAX(dig_cost) AS most_expensive
FROM Dino_Dig;

-- Step 4
SELECT dig_name, dig_cost, COUNT(dinosaur_common_name) as dino_discoveries
FROM Dino_Dig
JOIN Dino_Type ON Dino_Type.dino_dig_id = Dino_Dig.dino_dig_id
GROUP BY Dino_Type.dino_dig_id, dig_name, dig_cost;

-- Step 5
SELECT dig_name, COUNT(dinosaur_common_name) as dino_discoveries
FROM Dino_Dig
JOIN Dino_Type ON Dino_Type.dino_dig_id = Dino_Dig.dino_dig_id
GROUP BY Dino_Type.dino_dig_id, dig_name
HAVING COUNT(dinosaur_common_name) >= 6;

-- Step 6
SELECT dig_name, SUM(weight) as dino_pounds
FROM Dino_Dig
JOIN Dino_Type ON Dino_Type.dino_dig_id = Dino_Dig.dino_dig_id
GROUP BY Dino_Type.dino_dig_id, dig_name
HAVING SUM(weight) >= 15000;

-- Step 7
SELECT paleontologist, COUNT(dig_name) as stonesfield_digs
FROM Dinos
JOIN Dino_Dig ON Dino_Dig.dinos_id = Dinos.dinos_id
	AND Dino_Dig.dinos_id = 1.0
GROUP BY Dino_Dig.dinos_id, paleontologist
ORDER BY stonesfield_digs DESC;

-- Step 9
SELECT dig_name, SUM(weight) as dino_pounds
FROM Dino_Dig
JOIN Dino_Type ON Dino_Type.dino_dig_id = Dino_Dig.dino_dig_id
GROUP BY Dino_Type.dino_dig_id, dig_name;
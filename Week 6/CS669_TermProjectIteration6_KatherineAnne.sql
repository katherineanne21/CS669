-- Prep Work
-- Drop tables
Rollback;
DROP TABLE IF EXISTS Advise CASCADE;
DROP TABLE IF EXISTS ValidationData CASCADE;
DROP TABLE IF EXISTS Create2 CASCADE;
DROP TABLE IF EXISTS Depict CASCADE;
DROP TABLE IF EXISTS "Alter" CASCADE;
DROP TABLE IF EXISTS Depict2 CASCADE;
DROP TABLE IF EXISTS "Create" CASCADE;
DROP TABLE IF EXISTS Bar_Chart CASCADE;
DROP TABLE IF EXISTS Histogram CASCADE;
DROP TABLE IF EXISTS Scatterplot CASCADE;
DROP TABLE IF EXISTS Line_Graph CASCADE;
DROP TABLE IF EXISTS APN CASCADE;
DROP TABLE IF EXISTS "Polygon" CASCADE;
DROP TABLE IF EXISTS Purchase CASCADE;
DROP TABLE IF EXISTS Valuation CASCADE;
DROP TABLE IF EXISTS WorksWith CASCADE;
DROP TABLE IF EXISTS Transfer CASCADE;
DROP TABLE IF EXISTS "Map" CASCADE;
DROP TABLE IF EXISTS Graph CASCADE;
DROP TABLE IF EXISTS Grantee CASCADE;
DROP TABLE IF EXISTS Grantor CASCADE;
DROP TABLE IF EXISTS Contact_Status CASCADE;
DROP TABLE IF EXISTS Cities CASCADE;
DROP TABLE IF EXISTS "Transaction" CASCADE;
DROP TABLE IF EXISTS Researcher CASCADE;
DROP TABLE IF EXISTS LandConservationCompany CASCADE;
DROP TABLE IF EXISTS ResearcherChange CASCADE;

-- Drop sequences
DROP SEQUENCE IF EXISTS land_conservation_company_seq CASCADE;
DROP SEQUENCE IF EXISTS advise_seq CASCADE;
DROP SEQUENCE IF EXISTS researcher_seq CASCADE;
DROP SEQUENCE IF EXISTS validation_data_seq CASCADE;
DROP SEQUENCE IF EXISTS create2_seq CASCADE;
DROP SEQUENCE IF EXISTS map_seq CASCADE;
DROP SEQUENCE IF EXISTS depict_seq CASCADE;
DROP SEQUENCE IF EXISTS contact_status_seq CASCADE;
DROP SEQUENCE IF EXISTS alter_seq CASCADE;
DROP SEQUENCE IF EXISTS depict2_seq CASCADE;
DROP SEQUENCE IF EXISTS graph_seq CASCADE;
DROP SEQUENCE IF EXISTS create_seq CASCADE;
DROP SEQUENCE IF EXISTS purchase_seq CASCADE;
DROP SEQUENCE IF EXISTS cities_seq CASCADE;
DROP SEQUENCE IF EXISTS valuation_seq CASCADE;
DROP SEQUENCE IF EXISTS grantee_seq CASCADE;
DROP SEQUENCE IF EXISTS workswith_seq CASCADE;
DROP SEQUENCE IF EXISTS grantor_seq CASCADE;
DROP SEQUENCE IF EXISTS transfer_seq CASCADE;
DROP SEQUENCE IF EXISTS apn_seq CASCADE;
DROP SEQUENCE IF EXISTS researcher_change_seq CASCADE;

-- TABLES
CREATE TABLE LandConservationCompany (
    LandConservationCompanyID DECIMAL(12) PRIMARY KEY NOT NULL,
    Company_Name VARCHAR(100) NOT NULL
);

CREATE TABLE Researcher (
    ResearcherID DECIMAL(12) PRIMARY KEY NOT NULL,
    Researcher_first_name VARCHAR(64) NOT NULL,
    Researcher_last_name VARCHAR(64),
    Researcher_Type VARCHAR(25) NOT NULL
);

CREATE TABLE Contact_Status (
    Contact_Status_ID DECIMAL(12) PRIMARY KEY NOT NULL,
    Contact_Status DECIMAL(2,0) UNIQUE NOT NULL,
    Responded BOOLEAN NOT NULL
);

CREATE TABLE Cities (
    Cities_ID DECIMAL(12) PRIMARY KEY NOT NULL,
    Closest_City VARCHAR(64) UNIQUE NOT NULL,
    City_Center_x DECIMAL(10,6) NOT NULL,
	City_Center_y DECIMAL(10,6) NOT NULL
);

CREATE TABLE "Transaction" (
    ct_id DECIMAL(8) PRIMARY KEY NOT NULL UNIQUE,
    Acreage DECIMAL(10,4),
    Price_per_Acre DECIMAL(10,4),
    "Date" DATE,
    Protection_Type VARCHAR(50),
    Public_Spending DECIMAL(10,2),
    Contact_Status DECIMAL(2,0),
    Center_of_Transaction_x DECIMAL(10,6) NOT NULL,
	Center_of_Transaction_y DECIMAL(10,6) NOT NULL,
    Distance_from_City DECIMAL(10,2),
    Closest_City VARCHAR(64),
	FOREIGN KEY (Contact_Status) REFERENCES Contact_Status(Contact_Status),
	FOREIGN KEY (Closest_City) REFERENCES Cities(Closest_City)
);

CREATE TABLE "Map" (
    MapID DECIMAL(12) PRIMARY KEY NOT NULL,
    Projection VARCHAR(64) NOT NULL,
    Map_Type VARCHAR(64) NOT NULL,
    Color_Scheme VARCHAR(64) NOT NULL,
    Lower_Bound DECIMAL(10,4) NOT NULL,
    Upper_Bound DECIMAL(10,4) NOT NULL
);

CREATE TABLE Graph (
    GraphID DECIMAL(12) PRIMARY KEY NOT NULL,
    x_axis VARCHAR(50),
    y_axis VARCHAR(50),
    title VARCHAR(100),
    Type_Flag VARCHAR(20) NOT NULL,
    Lower_Bound DECIMAL(10,4) NOT NULL,
    Upper_Bound DECIMAL(10,4) NOT NULL
);

CREATE TABLE Grantee (
    GranteeID DECIMAL(12) PRIMARY KEY NOT NULL,
    Grantee_First_Name VARCHAR(50),
    Grantee_Last_Name VARCHAR(50)
);

CREATE TABLE Grantor (
    GrantorID DECIMAL(12) PRIMARY KEY NOT NULL,
    Grantor_First_Name VARCHAR(50),
    Grantor_Last_Name VARCHAR(50)
);

CREATE TABLE Advise (
    AdviseID DECIMAL(12) PRIMARY KEY NOT NULL,
    LandConservationCompanyID DECIMAL(12),
    ResearcherID DECIMAL(12),
	FOREIGN KEY (LandConservationCompanyID) REFERENCES LandConservationCompany(LandConservationCompanyID),
	FOREIGN KEY (ResearcherID) REFERENCES Researcher(ResearcherID)
);

CREATE TABLE ValidationData (
    ValidationDataID DECIMAL(12) PRIMARY KEY NOT NULL,
    ResearcherID DECIMAL(12) NOT NULL,
    ct_id DECIMAL(8) NOT NULL,
    Validate_Purchase_Price DECIMAL(10,2),
    Validate_Acreage DECIMAL(10,4),
    Validate_Date DATE,
    Validate_Protection_Type VARCHAR(50),
    Validate_Public_Spending DECIMAL(10,2),
	FOREIGN KEY (ResearcherID) REFERENCES Researcher(ResearcherID),
	FOREIGN KEY (ct_id) REFERENCES "Transaction"(ct_id)
);

CREATE TABLE Create2 (
    Create2ID DECIMAL(12) PRIMARY KEY NOT NULL,
    MapID DECIMAL(12) NOT NULL,
    ResearcherID DECIMAL(12) NOT NULL,
	FOREIGN KEY (MapID) REFERENCES "Map"(MapID),
	FOREIGN KEY (ResearcherID) REFERENCES Researcher(ResearcherID)
);

CREATE TABLE Depict (
    DepictID DECIMAL(12) PRIMARY KEY NOT NULL,
    MapID DECIMAL(12) NOT NULL,
    ct_id DECIMAL(8) NOT NULL,
	FOREIGN KEY (MapID) REFERENCES "Map"(MapID),
	FOREIGN KEY (ct_id) REFERENCES "Transaction"(ct_id)
);

CREATE TABLE "Alter" (
    AlterID DECIMAL(12) PRIMARY KEY NOT NULL,
    ct_id DECIMAL(8) NOT NULL,
    ResearcherID DECIMAL(12) NOT NULL,
	FOREIGN KEY (ct_id) REFERENCES "Transaction"(ct_id),
	FOREIGN KEY (ResearcherID) REFERENCES Researcher(ResearcherID)
);

CREATE TABLE Depict2 (
    Depict2ID DECIMAL(12) PRIMARY KEY NOT NULL,
    GraphID DECIMAL(12) NOT NULL,
    ct_id DECIMAL(8) NOT NULL,
	FOREIGN KEY (GraphID) REFERENCES Graph(GraphID),
	FOREIGN KEY (ct_id) REFERENCES "Transaction"(ct_id)
);

CREATE TABLE "Create" (
    CreateID DECIMAL(12) NOT NULL PRIMARY KEY,
    GraphID DECIMAL(12) NOT NULL,
    ResearcherID DECIMAL(12) NOT NULL,
	FOREIGN KEY (GraphID) REFERENCES Graph(GraphID),
	FOREIGN KEY (ResearcherID) REFERENCES Researcher(ResearcherID)
);

CREATE TABLE Bar_Chart (
    GraphID DECIMAL(12) NOT NULL PRIMARY KEY REFERENCES Graph
);

CREATE TABLE Histogram (
    GraphID DECIMAL(12) NOT NULL PRIMARY KEY REFERENCES Graph
);

CREATE TABLE Scatterplot (
    GraphID DECIMAL(12) NOT NULL PRIMARY KEY REFERENCES Graph
);

CREATE TABLE Line_Graph (
    GraphID DECIMAL(12) NOT NULL PRIMARY KEY REFERENCES Graph
);

CREATE TABLE APN (
	APN_id DECIMAL(12) PRIMARY KEY NOT NULL,
    ct_id DECIMAL(8) NOT NULL REFERENCES "Transaction"(ct_id),
    APN VARCHAR(50)
);

CREATE TABLE "Polygon" (
    ct_id DECIMAL(8) PRIMARY KEY REFERENCES "Transaction"(ct_id),
    "polygon" VARCHAR(200) NOT NULL
);

CREATE TABLE Purchase (
    PurchaseID DECIMAL(12) PRIMARY KEY NOT NULL,
    GranteeID DECIMAL(12) NOT NULL,
    ct_id DECIMAL(8) NOT NULL,
    Purchase_Price DECIMAL(10,2),
    Purchase_Date DATE,
    Normalized_Purchase_Price DECIMAL(10,2),
	FOREIGN KEY (GranteeID) REFERENCES Grantee(GranteeID),
	FOREIGN KEY (ct_id) REFERENCES "Transaction"(ct_id)
);

CREATE TABLE Valuation (
    Valuation_id DECIMAL(10) PRIMARY KEY NOT NULL,
    ct_id DECIMAL(8) NOT NULL,
    PurchaseID DECIMAL(12) NOT NULL,
    Appraised_Value DECIMAL(10,2),
    Percent_Difference_Cost DECIMAL(3,5),
	FOREIGN KEY (ct_id) REFERENCES "Transaction"(ct_id),
	FOREIGN KEY (PurchaseID) REFERENCES Purchase(PurchaseID)
);

CREATE TABLE WorksWith (
    WorksWithID DECIMAL(12) PRIMARY KEY NOT NULL,
    GrantorID DECIMAL(12) NOT NULL,
    GranteeID DECIMAL(12) NOT NULL,
	FOREIGN KEY (GrantorID) REFERENCES Grantor(GrantorID),
	FOREIGN KEY (GranteeID) REFERENCES Grantee(GranteeID)
);

CREATE TABLE Transfer (
    TransferID DECIMAL(12) PRIMARY KEY NOT NULL,
    GrantorID DECIMAL(12) NOT NULL,
    ct_id DECIMAL(8) NOT NULL,
    Transfer_Date DATE,
	FOREIGN KEY (GrantorID) REFERENCES Grantor(GrantorID),
	FOREIGN KEY (ct_id) REFERENCES "Transaction"(ct_id)
);

CREATE TABLE ResearcherChange (
    ResearcherChangeID DECIMAL(12) PRIMARY KEY NOT NULL,
    ct_id DECIMAL(8) NOT NULL,
    Old_Researcher_first_name VARCHAR(64),
    New_Researcher_first_name VARCHAR(64),
    ChangeDate DATE,
    FOREIGN KEY (ct_id) REFERENCES "Transaction"(ct_id)
);

--SEQUENCES
--All tables that need them should have an associated sequence.
CREATE SEQUENCE land_conservation_company_seq START WITH 1;
CREATE SEQUENCE advise_seq START WITH 1;
CREATE SEQUENCE researcher_seq START WITH 1;
CREATE SEQUENCE validation_data_seq START WITH 1;
CREATE SEQUENCE create2_seq START WITH 1;
CREATE SEQUENCE map_seq START WITH 1;
CREATE SEQUENCE depict_seq START WITH 1;
CREATE SEQUENCE alter_seq START WITH 1;
CREATE SEQUENCE depict2_seq START WITH 1;
CREATE SEQUENCE graph_seq START WITH 1;
CREATE SEQUENCE create_seq START WITH 1;
CREATE SEQUENCE purchase_seq START WITH 1;
CREATE SEQUENCE cities_seq START WITH 1;
CREATE SEQUENCE valuation_seq START WITH 1;
CREATE SEQUENCE grantee_seq START WITH 1;
CREATE SEQUENCE workswith_seq START WITH 1;
CREATE SEQUENCE grantor_seq START WITH 1;
CREATE SEQUENCE transfer_seq START WITH 1;
CREATE SEQUENCE apn_seq START WITH 1;
CREATE SEQUENCE researcher_change_seq START WITH 1;

--INDEXES
-- Foreign Key Indexes for Transaction table
CREATE INDEX idx_transaction_contact_status ON "Transaction"(Contact_Status);
CREATE INDEX idx_transaction_closest_city ON "Transaction"(Closest_City);

-- Foreign Key Indexes for Advise table
CREATE INDEX idx_advise_landconservationcompanyid ON Advise(LandConservationCompanyID);
CREATE INDEX idx_advise_researcherid ON Advise(ResearcherID);

-- Foreign Key Indexes for ValidationData table
CREATE INDEX idx_validationdata_researcherid ON ValidationData(ResearcherID);
CREATE UNIQUE INDEX idx_validationdata_ct_id ON ValidationData(ct_id);

-- Foreign Key Indexes for Create2 table
CREATE INDEX idx_create2_mapid ON Create2(MapID);
CREATE INDEX idx_create2_researcherid ON Create2(ResearcherID);

-- Foreign Key Indexes for Depict table
CREATE INDEX idx_depict_mapid ON Depict(MapID);
CREATE INDEX idx_depict_ct_id ON Depict(ct_id);

-- Foreign Key Indexes for Alter table
CREATE INDEX idx_alter_ct_id ON "Alter"(ct_id);
CREATE INDEX idx_alter_researcherid ON "Alter"(ResearcherID);

-- Foreign Key Indexes for Depict2 table
CREATE INDEX idx_depict2_graphid ON Depict2(GraphID);
CREATE INDEX idx_depict2_ct_id ON Depict2(ct_id);

-- Foreign Key Indexes for Create table
CREATE INDEX idx_create_graphid ON "Create"(GraphID);
CREATE INDEX idx_create_researcherid ON "Create"(ResearcherID);

-- Foreign Key Indexes for Bar_Chart table
CREATE UNIQUE INDEX idx_bar_chart_graphid ON Bar_Chart(GraphID);

-- Foreign Key Indexes for Histogram table
CREATE UNIQUE INDEX idx_histogram_graphid ON Histogram(GraphID);

-- Foreign Key Indexes for Scatterplot table
CREATE UNIQUE INDEX idx_scatterplot_graphid ON Scatterplot(GraphID);

-- Foreign Key Indexes for Line_Graph table
CREATE UNIQUE INDEX idx_line_graph_graphid ON Line_Graph(GraphID);

-- Foreign Key Indexes for APN table
CREATE INDEX idx_apn_ct_id ON APN(ct_id);

-- Foreign Key Indexes for Polygon table
CREATE UNIQUE INDEX idx_polygon_ct_id ON "Polygon"(ct_id);

-- Foreign Key Indexes for Purchase table
CREATE INDEX idx_purchase_granteeid ON Purchase(GranteeID);
CREATE UNIQUE INDEX idx_purchase_ct_id ON Purchase(ct_id);

-- Foreign Key Indexes for Valuation table
CREATE INDEX idx_valuation_ct_id ON Valuation(ct_id);
CREATE INDEX idx_valuation_purchaseid ON Valuation(PurchaseID);

-- Foreign Key Indexes for WorksWith table
CREATE INDEX idx_workswith_grantorid ON WorksWith(GrantorID);
CREATE INDEX idx_workswith_granteeid ON WorksWith(GranteeID);

-- Foreign Key Indexes for Transfer table
CREATE INDEX idx_transfer_grantorid ON Transfer(GrantorID);
CREATE INDEX idx_transfer_ct_id ON Transfer(ct_id);

-- Query Indexes
CREATE INDEX idx_public_spending ON "Transaction"(public_spending);
CREATE INDEX idx_acreage ON "Transaction"(Acreage);
CREATE INDEX idx_date ON "Transaction"("Date");

--STORED PROCEDURES
CREATE OR REPLACE FUNCTION ResearcherChangeFunction()
RETURNS TRIGGER LANGUAGE plpgsql
AS $trigfunc$
BEGIN
    INSERT INTO ResearcherChange(ResearcherChangeID, ct_id, Old_Researcher_first_name, New_Researcher_first_name, ChangeDate)
    SELECT nextval('researcher_change_seq'),
           alt.ct_id,
           OLD.Researcher_first_name,
           NEW.Researcher_first_name,
           current_date
    FROM "Alter" alt
    WHERE alt.ResearcherID = OLD.ResearcherID;

    RETURN NEW;
END;
$trigfunc$;

CREATE TRIGGER ResearcherChangeTrigger
BEFORE UPDATE OF Researcher_first_name ON Researcher
FOR EACH ROW
EXECUTE PROCEDURE ResearcherChangeFunction();


INSERT INTO Contact_Status (Contact_Status_ID, Contact_Status, Responded) 
VALUES (1, 1, FALSE),
	   (2, 2, FALSE),
	   (3, 3, FALSE),
	   (4, 4, FALSE),
	   (5, 5, FALSE),
	   (6, 6, TRUE),
	   (7, 7, TRUE),
	   (8, 8, TRUE),
	   (9, 9, TRUE),
	   (10, 10, TRUE),
	   (11, 11, TRUE);

CREATE OR REPLACE PROCEDURE AddCityData (Closest_City IN VARCHAR, City_Center_x IN DECIMAL, City_Center_y IN DECIMAL)
AS
$proc$
BEGIN
    INSERT INTO Cities (Cities_ID, Closest_City, City_Center_x, City_Center_y)
    VALUES (nextval('cities_seq'), Closest_City, City_Center_x, City_Center_y);
END;
$proc$ LANGUAGE plpgsql;

START TRANSACTION;
DO
$$ BEGIN
    CALL AddCityData ('Chicago', 41.8781, -87.6298);
    CALL AddCityData ('Charlotte', 35.2271, -80.8431);
    CALL AddCityData ('Baltimore', 39.2904, -76.6122);
    CALL AddCityData ('New York City', 40.7128, -74.0060);
    CALL AddCityData ('Louisville', 38.2527, -85.7585);
END $$;
COMMIT TRANSACTION;


CREATE OR REPLACE PROCEDURE AddOurData (ct_id IN DECIMAL, Acreage IN DECIMAL, Price_per_Acre IN DECIMAL, "Date" IN DATE, 
										Protection_Type IN VARCHAR, Public_Spending IN DECIMAL, Contact_Status IN DECIMAL,
										Center_of_Transaction_x IN DECIMAL, Center_of_Transaction_y IN DECIMAL,
										Distance_from_City IN DECIMAL, Closest_City IN VARCHAR, APN IN VARCHAR)
AS
$proc$
BEGIN
 INSERT INTO "Transaction" (ct_id, Acreage, Price_per_Acre, "Date", Protection_Type, Public_Spending, Contact_Status,
							Center_of_Transaction_x, Center_of_Transaction_y, Distance_from_City, Closest_City)
 VALUES(ct_id, Acreage, Price_per_Acre, "Date", Protection_Type, Public_Spending, Contact_Status,
							Center_of_Transaction_x, Center_of_Transaction_y, Distance_from_City, Closest_City);

 INSERT INTO APN(APN_id, ct_id, APN)
 VALUES(nextval('apn_seq'), ct_id, APN);
END;
$proc$ LANGUAGE plpgsql;

START TRANSACTION;
DO
 $$BEGIN
 	CALL AddOurData (10399622, 172.14, NULL, '2001-01-01', 'Easement', 374100, 11, 37.25043, -85.36798, NULL, 'Louisville', '37-005-01');
	CALL AddOurData (10405056, 165.74, NULL, '2002-10-17', 'Acquisition (fee simple)', 2899947, 11, 40.22852, -74.1326, NULL, 'New York City', '1352_907_17.02');
	CALL AddOurData (10438386, 318.5, NULL, '2001-06-06', 'Easement', 222479.71, 11, 38.91877, -75.64379, NULL, 'Baltimore', '6-00-17800-01-0500-00001');
	CALL AddOurData (10234143, 2463, NULL, '2003-11-18', 'Acquisition (fee simple)', 3928000, 11, 35.6627, -82.29769, NULL, 'Charlotte', '072100597300000');
	CALL AddOurData (10193035, 233, NULL, NULL, 'Acquisition (fee simple)', 232000.00, 10, 41.59914, -88.55907, NULL, 'Chicago', '04-09-100-008');
 END$$;
COMMIT TRANSACTION; 

INSERT INTO Researcher (ResearcherID, Researcher_first_name, Researcher_last_name, Researcher_Type)
VALUES (nextval('researcher_seq'),'Katherine','Rein','Undergraduate'),
	   (nextval('researcher_seq'),'Julianne', NULL, 'Undergraduate'),
	   (nextval('researcher_seq'),'Cece', NULL, 'Undergraduate'),
	   (nextval('researcher_seq'),'Ella', NULL, 'Undergraduate'),
	   (nextval('researcher_seq'),'Christoph','Nolte','PI');

CREATE OR REPLACE PROCEDURE AddResearcherToTransaction (Researcher_first_name IN VARCHAR, ct_id IN DECIMAL)
AS
$proc$
DECLARE
    v_ResearcherID DECIMAL;
BEGIN

	SELECT ResearcherID INTO v_ResearcherID
    FROM Researcher
    WHERE Researcher.Researcher_first_name = AddResearcherToTransaction.Researcher_first_name;
	
	INSERT INTO "Alter" (AlterID, ct_id, ResearcherID)
	VALUES(nextval('alter_seq'), ct_id, v_ResearcherID);
END;
$proc$ LANGUAGE plpgsql;

START TRANSACTION;
DO
 $$BEGIN
 	CALL AddResearcherToTransaction ('Christoph', 10399622);
 	CALL AddResearcherToTransaction ('Katherine', 10405056);
	CALL AddResearcherToTransaction ('Cece', 10438386);
	CALL AddResearcherToTransaction ('Katherine', 10234143);
	CALL AddResearcherToTransaction ('Katherine', 10193035);
 END$$;
COMMIT TRANSACTION;


CREATE OR REPLACE PROCEDURE AddValidationData (Researcher_first_name IN VARCHAR, ct_id IN DECIMAL,
											   Validate_Purchase_Price IN DECIMAL, Validate_Acreage IN DECIMAL,
											   Validate_Date IN DATE, Validate_Protection_Type IN VARCHAR,
											   Validate_Public_Spending IN DECIMAL)
AS
$proc$
DECLARE
    v_ResearcherID DECIMAL;
BEGIN

	SELECT ResearcherID INTO v_ResearcherID
    FROM Researcher
    WHERE Researcher.Researcher_first_name = AddValidationData.Researcher_first_name;
	
    INSERT INTO ValidationData (ValidationDataID, ResearcherID, ct_id, Validate_Purchase_Price,Validate_Acreage, 
								Validate_Date, Validate_Protection_Type,Validate_Public_Spending)
    VALUES (nextval('validation_data_seq'), v_ResearcherID, ct_id, Validate_Purchase_Price, Validate_Acreage,
			Validate_Date, Validate_Protection_Type, Validate_Public_Spending);
END;
$proc$ LANGUAGE plpgsql;

START TRANSACTION;
DO
 $$BEGIN
 	CALL AddValidationData ('Christoph', 10399622, 293031, 172.1, '2001-08-28', 'Easement', 293031);
 	CALL AddValidationData ('Katherine', 10405056, 2835000, 82.87, '2002-10-17', 'Acquisition (fee simple)', 2835000);
	CALL AddValidationData ('Cece', 10438386, 222479.71, 319.8, '2000-01-01', 'Easement', 222479.71);
	CALL AddValidationData ('Katherine', 10234143, 3928000, 2463, '2003-11-18', 'Easement', 3928000);
	CALL AddValidationData ('Katherine', 10193035, 20732000, 603, '2007-01-01', 'Acquisition (fee simple)', 20732000);
 END$$;
COMMIT TRANSACTION;

--INSERTS
INSERT INTO APN (APN_id, ct_id, APN) 
VALUES (nextval('apn_seq'), 10438386, '6-00-17800-01-0502-00001'),
	   (nextval('apn_seq'), 10438386, '6-00-17800-01-0503-00001'),
	   (nextval('apn_seq'), 10234143, '072035393000000'),
	   (nextval('apn_seq'), 10234143, '072008284700000'),
	   (nextval('apn_seq'), 10234143, '072029305400000'),
	   (nextval('apn_seq'), 10193035, '04-17-400-003');

--QUERIES
-- First Query 
SELECT Researcher.Researcher_first_name, 
       COUNT(DISTINCT "Transaction".ct_id) AS Number_of_ct_ids, 
       COUNT(DISTINCT APN.APN) AS Number_of_APNs
FROM Researcher
JOIN "Alter" ON "Alter".ResearcherID = Researcher.ResearcherID
JOIN "Transaction" ON "Transaction".ct_id = "Alter".ct_id
JOIN Contact_Status ON Contact_Status.Contact_Status = "Transaction".Contact_Status
JOIN APN ON APN.ct_id = "Transaction".ct_id
WHERE Contact_Status.Responded = TRUE
GROUP BY Researcher.Researcher_first_name;

-- Second Query
SELECT APN.ct_id, COUNT(DISTINCT APN.APN) AS Number_of_APNs
FROM APN
JOIN "Transaction" ON "Transaction".ct_id = APN.ct_id
GROUP BY APN.ct_id
HAVING COUNT(DISTINCT APN.APN) > 1;

-- Third Query
SELECT "Transaction".ct_id,
       "Transaction".public_spending,
	   Researcher.Researcher_first_name,
       "Transaction".Closest_City 
FROM Researcher
JOIN "Alter" ON "Alter".ResearcherID = Researcher.ResearcherID
JOIN "Transaction" ON "Transaction".ct_id = "Alter".ct_id
GROUP BY Researcher.Researcher_first_name,
         "Transaction".public_spending,
         "Transaction".ct_id,
         "Transaction".Closest_City
HAVING SUM("Transaction".public_spending) > 200000
ORDER BY "Transaction".public_spending ASC,
		 Researcher.Researcher_first_name ASC;

-- History Testing
UPDATE Researcher
SET Researcher_first_name = 'Ella'
FROM "Transaction"
WHERE Researcher.ResearcherID = 5
AND "Transaction".ct_id = 10399622;

SELECT * 
FROM ResearcherChange;

-- Data Visualizations
SELECT  Protection_Type, SUM(Public_Spending) AS Total_Public_Spending
FROM "Transaction"
GROUP BY Protection_Type
ORDER BY Total_Public_Spending DESC;

SELECT Acreage, Public_Spending
FROM "Transaction"
WHERE Public_Spending IS NOT NULL AND Acreage IS NOT NULL;



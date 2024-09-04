-- Step One
CREATE TABLE Phone(
	phone_id DECIMAL(12) NOT NULL PRIMARY KEY,
	phone_model VARCHAR(32) NOT NULL,
	phone_price DECIMAL(6,2) NOT NULL,
	release_date DATE NOT NULL);

CREATE TABLE Customer(
	customer_id DECIMAL(12) NOT NULL PRIMARY KEY,
	customer_email VARCHAR(64) NOT NULL,
	customer_name VARCHAR(64) NOT NULL,
	phone_id DECIMAL(12) NULL);

ALTER TABLE Customer
ADD CONSTRAINT customer_fk
FOREIGN KEY (phone_id)
REFERENCES Phone(phone_id);

-- Step Two
INSERT INTO Phone(phone_id, phone_model, phone_price, release_date)
VALUES 
	(1, 'Apple iPhone X', 379.00, '2017-11-03'),
	(2, 'Galaxy S21+', 799.00, '2021-01-29'),
	(3, 'Xenos 360', 1024.00, '2021-03-22'),
	(4, 'Meridian Duplex', 462.00, '2021-05-15');

INSERT INTO Customer(customer_id, customer_email, customer_name, phone_id)
VALUES 
	(1, 'katherine@gmail.com', 'Katherine', NULL),
	(2, 'maddie@gmail.com', 'Maddie', 2),
	(3, 'laura@gmail.com', 'Laura', 3),
	(4, 'collin@gmail.com', 'Collin', 2),
	(5, 'josie@gmail.com', 'Josie', 4);

SELECT * 
FROM Phone;

SELECT * 
FROM Customer;

-- Step 3
INSERT INTO Customer(customer_id, customer_email, customer_name, phone_id)
VALUES (6, 'amy@gmail.com', 'Amy', 5);

-- Step 4
SELECT phone_model
FROM Phone
JOIN Customer ON Phone.phone_id = Customer.phone_id;

SELECT customer_name
FROM Customer
JOIN Phone ON Customer.phone_id = Phone.phone_id;

-- Step 5
SELECT phone_model, release_date
FROM Phone;

SELECT customer_name
FROM Customer
JOIN Phone ON Customer.phone_id = Phone.phone_id
ORDER BY release_date ASC;

SELECT customer_name, release_date
FROM Customer
INNER JOIN Phone ON Customer.phone_id = Phone.phone_id
ORDER BY release_date ASC;

-- Step 6
SELECT customer_name, customer_email
FROM Customer;

SELECT customer_name, customer_email, phone_model
FROM Phone
JOIN Customer ON Phone.phone_id = Customer.phone_id
ORDER BY customer_email DESC;

SELECT customer_name, customer_email, phone_model
FROM Phone
INNER JOIN Customer ON Phone.phone_id = Customer.phone_id
ORDER BY customer_email DESC;

-- Step 7
SELECT *
FROM Phone
JOIN Customer ON Phone.phone_id = Customer.phone_id
ORDER BY phone_model, customer_name;

-- Step 8
SELECT phone_model, to_char(phone_price,'$9999.00')
FROM Phone;

-- Step 9
SELECT phone_model, to_char(phone_price - 50,'$9999.00')
FROM Phone;

-- Step 10
SELECT customer_name || ' (' || phone_model || ' - ' || to_char(phone_price,'$9999.00') || ')'
FROM Phone
JOIN Customer ON Phone.phone_id = Customer.phone_id;

-- Step 12
SELECT phone_model, phone_price
FROM Phone
WHERE phone_model != 'Apple iPhone X' AND release_date >= '2020-05-01' AND phone_price >= 900.00;

INSERT INTO Phone(phone_id, phone_model, phone_price, release_date)
VALUES (5, 'Apple iPhone 13', 1200.00, '2021-11-03');

SELECT phone_model, phone_price
FROM Phone
WHERE phone_model != 'Xenos 360' AND release_date > '2021-03-05' AND phone_price > 1000.00;

-- Step 13
ALTER TABLE Phone
ADD COLUMN reduced_price DECIMAL(6,2) GENERATED ALWAYS AS (phone_price * 0.75) STORED;

SELECT phone_model, phone_price, reduced_price
FROM Phone;

ALTER TABLE Phone
ADD COLUMN is_high_end BOOLEAN GENERATED ALWAYS AS (phone_price > 700) STORED;

SELECT phone_model, phone_price, reduced_price
FROM Phone
WHERE is_high_end = TRUE;
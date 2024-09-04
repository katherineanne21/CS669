-- Step 1

-- Create the tables
CREATE TABLE Person(
person_id DECIMAL(12) NOT NULL,
first_name VARCHAR(32) NOT NULL,
last_name VARCHAR(32) NOT NULL,
username VARCHAR(20) NOT NULL,
PRIMARY KEY (person_id));

CREATE TABLE Post(
post_id DECIMAL(12) NOT NULL,
person_id DECIMAL(12) NOT NULL,
content VARCHAR(255) NOT NULL,
created_on DATE NOT NULL,
summary VARCHAR(13) NOT NULL,
PRIMARY KEY (post_id),
FOREIGN KEY (person_id) REFERENCES Person);

CREATE TABLE Likes(
likes_id DECIMAL(12) NOT NULL,
post_id DECIMAL(12) NOT NULL,
person_id DECIMAL(12) NOT NULL,
liked_on DATE NOT NULL,
PRIMARY KEY (likes_id),
FOREIGN KEY (person_id) REFERENCES Person,
FOREIGN KEY (post_id) REFERENCES Post);

-- Create the sequences
CREATE SEQUENCE person_seq START WITH 1;
CREATE SEQUENCE post_seq START WITH 1;
CREATE SEQUENCE likes_seq START WITH 1;

-- Step 2

-- Inserts
INSERT INTO Person VALUES(nextval('person_seq'),'Katherine','Rein','khaki');
INSERT INTO Post VALUES(nextval('post_seq'), currval('person_seq'), 'First Day of School Post!', CAST('15-DEC-2022' AS DATE), 'First Day ...');
INSERT INTO Likes VALUES(nextval('likes_seq'), currval('post_seq'), currval('person_seq'), CAST('18-MAR-2023' AS DATE));

INSERT INTO Post VALUES(nextval('post_seq'), currval('person_seq'), 'Field Trip Time', CAST('03-DEC-2021' AS DATE), 'Field Trip...');
INSERT INTO Likes VALUES(nextval('likes_seq'), currval('post_seq'), currval('person_seq'), CAST('23-JUN-2021' AS DATE));

INSERT INTO Post VALUES(nextval('post_seq'), currval('person_seq'), 'Finally done with this', CAST('12-NOV-2023' AS DATE), 'Finally do...');

INSERT INTO Person VALUES(nextval('person_seq'),'Collin','Brooks','coco');
INSERT INTO Post VALUES(nextval('post_seq'), currval('person_seq'), 'out at sea for now', CAST('12-DEC-2023' AS DATE), 'out at sea...');
INSERT INTO Likes VALUES(nextval('likes_seq'), currval('post_seq'), currval('person_seq'), CAST('02-FEB-2024' AS DATE));

INSERT INTO Person VALUES(nextval('person_seq'),'Maddie','Keefer','madds');
INSERT INTO Post VALUES(nextval('post_seq'), currval('person_seq'), 'dancing in spain', CAST('13-MAY-2022' AS DATE), 'dancing in...');

INSERT INTO Person VALUES(nextval('person_seq'),'Josie','Foust','jo.mama');
INSERT INTO Post VALUES(nextval('post_seq'), currval('person_seq'), 'pretend this says something in german', CAST('12-DEC-2023' AS DATE), 'pretend th...');
INSERT INTO Likes VALUES(nextval('likes_seq'), currval('post_seq'), currval('person_seq'), CAST('02-MAY-2024' AS DATE));

INSERT INTO Post VALUES(nextval('post_seq'), currval('person_seq'), 'songs and cats I love', CAST('12-SEP-2023' AS DATE), 'songs and ...');

INSERT INTO Person VALUES(nextval('person_seq'),'Amy','Rein','amy.tamy');
INSERT INTO Post VALUES(nextval('post_seq'), currval('person_seq'), 'little runner girl', CAST('30-MAY-2024' AS DATE), 'little run...');

INSERT INTO Post VALUES(nextval('post_seq'), currval('person_seq'), 'artsy fartsy work', CAST('12-MAR-2021' AS DATE), 'artsy fart...');

-- View data
SELECT first_name, last_name, username, content, created_on, summary, liked_on
FROM Person
JOIN Post ON Post.person_id = Person.person_id
LEFT JOIN Likes ON Likes.post_id = Post.post_id
ORDER BY last_name, first_name, created_on;

-- Step 3
CREATE OR REPLACE PROCEDURE add_michelle_stella ()
AS
$proc$
 BEGIN
 INSERT INTO Person (person_id, first_name, last_name, username)
 VALUES (nextval('person_seq'), 'Michelle', 'Stella', 'michelle.stella');
 END;
$proc$ LANGUAGE plpgsql; 

CALL add_michelle_stella ();

SELECT first_name, last_name, username, content, created_on, summary, liked_on
FROM Person
LEFT JOIN Post ON Post.person_id = Person.person_id
LEFT JOIN Likes ON Likes.post_id = Post.post_id
ORDER BY last_name, first_name, created_on;

-- Step 4
CREATE OR REPLACE PROCEDURE add_person(
first_name_arg IN VARCHAR, 
last_name_arg IN VARCHAR,
username_arg IN VARCHAR)
LANGUAGE plpgsql
AS 
$resuableproc$
BEGIN
 INSERT INTO Person (person_id, first_name, last_name, username)
 VALUES (nextval('person_seq'),first_name_arg, last_name_arg, username_arg);
END;
$resuableproc$;

CALL add_person('Kaitlyn', 'Desio', 'kaitlyn.desio');

SELECT first_name, last_name, username, content, created_on, summary, liked_on
FROM Person
LEFT JOIN Post ON Post.person_id = Person.person_id
LEFT JOIN Likes ON Likes.post_id = Post.post_id
ORDER BY last_name, first_name, created_on;

-- Step 5
CREATE OR REPLACE PROCEDURE add_post(
p_person_id IN DECIMAL,
p_content IN VARCHAR, 
p_created_on IN DATE) 
LANGUAGE plpgsql
AS
$$
DECLARE
temp_summary VARCHAR(13);
BEGIN
 temp_summary := SUBSTRING(p_content FROM 1 FOR 10) || '...';
 
 INSERT INTO Post (post_id, person_id, content, created_on, summary)
 VALUES(nextval('post_seq'), p_person_id, p_content, p_created_on, temp_summary);
END;
$$;

CALL add_post(4, 'I just had the best time ever in Rome.', CAST('13-MAY-2022' AS DATE));

SELECT first_name, last_name, username, content, created_on, summary, liked_on
FROM Person
LEFT JOIN Post ON Post.person_id = Person.person_id
LEFT JOIN Likes ON Likes.post_id = Post.post_id
ORDER BY last_name, first_name, created_on;

-- Step 6
CREATE OR REPLACE PROCEDURE add_like(
p_post_id IN DECIMAL,
p_username IN VARCHAR, 
p_liked_on IN DATE) 
LANGUAGE plpgsql
AS $$
DECLARE
v_person_id DECIMAL(12); 
BEGIN
 SELECT person_id
 INTO v_person_id
 FROM Person
 WHERE username = p_username;

 INSERT INTO Likes (likes_id, post_id, person_id, liked_on)
 VALUES(nextval('likes_seq'), p_post_id, v_person_id, p_liked_on);
END;
$$;

CALL add_like(9,'coco',CAST('15-SEP-2020' AS DATE));

SELECT *
FROM Likes;

-- Step 7
CREATE OR REPLACE FUNCTION ten_char_sum_func()
 RETURNS TRIGGER LANGUAGE plpgsql
 AS $trigfunc$
 BEGIN
 RAISE EXCEPTION USING MESSAGE = 'Summary is not 10 characters followed by ...',
 ERRCODE = 22000;
 END;
 $trigfunc$;
CREATE TRIGGER ten_char_sum_trg
BEFORE UPDATE OR INSERT ON Post
FOR EACH ROW WHEN(NEW.summary != substring(NEW.content FROM 1 FOR 10) || '...')
EXECUTE PROCEDURE ten_char_sum_func();

INSERT INTO Post VALUES(nextval('post_seq'), 6, 'having a blast this summer', CAST('12-JUN-2021' AS DATE), 'having a b...');
INSERT INTO Post VALUES(nextval('post_seq'), 7, 'this is the best time', CAST('12-JUN-2021' AS DATE), 'tkis is th...');

SELECT *
FROM Post;

-- Step 8
CREATE OR REPLACE FUNCTION like_check_func()
RETURNS TRIGGER LANGUAGE plpgsql
AS $$
DECLARE
 v_correct_line_price DECIMAL(12,2);
BEGIN
 IF NEW.liked_on < (SELECT created_on FROM Post WHERE post_id = NEW.post_id) THEN
 RAISE EXCEPTION USING MESSAGE = 'A post cannot be liked before it is created.',
 ERRCODE = 22000;
 END IF;
 RETURN NEW;
END;
$$;
CREATE TRIGGER like_check_trg
BEFORE UPDATE OR INSERT ON Likes
FOR EACH ROW
EXECUTE PROCEDURE like_check_func(); 

INSERT INTO Likes VALUES(nextval('likes_seq'), 10, 3, CAST('18-DEC-2023' AS DATE));
INSERT INTO Likes VALUES(nextval('likes_seq'), 10, 5, CAST('04-JUN-2003' AS DATE));

SELECT *
FROM Likes;

-- Step 9
CREATE TABLE post_content_history (
post_id DECIMAL(12) NOT NULL,
old_content VARCHAR(255) NOT NULL,
new_content VARCHAR(255) NOT NULL,
change_date DATE NOT NULL,
FOREIGN KEY (post_id) REFERENCES Post(post_id));

CREATE OR REPLACE FUNCTION post_history_func()
RETURNS TRIGGER LANGUAGE plpgsql
AS $$
BEGIN
 IF OLD.content <> NEW.content THEN
 INSERT INTO post_content_history(post_id, old_content, new_content, change_date)
 VALUES(NEW.post_id, OLD.content, NEW.content, CURRENT_DATE);
 END IF;
 RETURN NEW;
END;
$$;
CREATE TRIGGER post_history_trg
BEFORE UPDATE ON Post
FOR EACH ROW
EXECUTE PROCEDURE post_history_func(); 

UPDATE Post
SET content = 'these are some songs and cats I love',
    summary = substring('these are some songs and cats I love' from 1 for 10) || '...'
WHERE post_id = 7;

SELECT *
FROM post_content_history;

-- Step 10



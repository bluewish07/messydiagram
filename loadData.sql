CREATE TABLE USER_SCHEMA AS (SELECT * FROM daneliza.public_user_information);

create table friends_schema as (select * from daneliza.public_are_friends);

create table photo_schema as (select * from daneliza.public_photo_information);

create table tag_schema as (select * from daneliza.public_tag_information);

create table event_schema as (select * from daneliza.public_event_information);

--LOCATION TRIGGER
CREATE SEQUENCE loc_sequence
START WITH 1 
INCREMENT BY 1; 
CREATE or replace TRIGGER loc_trigger 
BEFORE INSERT ON LOCATION 
FOR EACH ROW 
BEGIN 
SELECT loc_sequence.nextval into :new.LOC_ID from dual; 
END;
/

--COPY TO LOCATION TABLE
INSERT INTO LOCATION (CITY, STATE, COUNTRY) 
SELECT DISTINCT HOMETOWN_CITY, HOMETOWN_STATE, HOMETOWN_COUNTRY FROM 
USER_SCHEMA
UNION 
SELECT DISTINCT CURRENT_CITY, CURRENT_STATE, CURRENT_COUNTRY FROM 
USER_SCHEMA
UNION 
SELECT DISTINCT EVENT_CITY, EVENT_STATE, EVENT_COUNTRY FROM 
EVENT_SCHEMA; 


--INSERT TO USER TABLE
INSERT INTO FB_USER(USER_ID, FIRST_NAME, LAST_NAME,YEAR_OF_BIRTH, MONTH_OF_BIRTH,DAY_OF_BIRTH, GENDER,HOMETOWN,CURRENT_LOCATION) 
SELECT DISTINCT FB.USER_ID, FB.FIRST_NAME, FB.LAST_NAME, FB.YEAR_OF_BIRTH, FB.MONTH_OF_BIRTH, FB.DAY_OF_BIRTH, FB.GENDER, HM.LOC_ID, CUR.LOC_ID
FROM USER_SCHEMA FB, LOCATION HM, LOCATION CUR
WHERE FB.HOMETOWN_CITY = HM.CITY AND
      FB.HOMETOWN_STATE = HM.STATE AND
      FB.HOMETOWN_COUNTRY = HM.COUNTRY AND
      FB.CURRENT_CITY = CUR.CITY AND
      FB.CURRENT_STATE = CUR.STATE AND
      FB.CURRENT_COUNTRY = CUR.COUNTRY;

--EDUCATION TRIGGER
CREATE SEQUENCE edu_sequence 
START WITH 1 
INCREMENT BY 1;  
CREATE or replace TRIGGER edu_trigger 
BEFORE INSERT ON EDU_PROGRAM
FOR EACH ROW 
BEGIN 
SELECT edu_sequence.nextval into :new.PROGRAM_ID from dual; 
END;
/

--COPY TO EDUCATION_PROGRAM TABLE
INSERT INTO EDU_PROGRAM (INSTITUTION_NAME, PROGRAM_YEAR, PROGRAM_CONCENTRATION, PROGRAM_DEGREE) 
SELECT DISTINCT INSTITUTION_NAME, PROGRAM_YEAR, PROGRAM_CONCENTRATION, PROGRAM_DEGREE 
FROM user_schema;

--INSERT TO EDUCATION TABLE
INSERT INTO USER_EDUCATION (USER_ID, PROGRAM_ID)
SELECT use.USER_ID, edu.PROGRAM_ID
FROM user_schema use, EDU_PROGRAM edu
WHERE use.INSTITUTION_NAME = edu.INSTITUTION_NAME
    AND use.PROGRAM_YEAR = edu.PROGRAM_YEAR
    AND use.PROGRAM_CONCENTRATION = edu.PROGRAM_CONCENTRATION
    AND use.PROGRAM_DEGREE = edu.PROGRAM_DEGREE;


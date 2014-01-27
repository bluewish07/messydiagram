
create table user_schema as (select * from daneliza.public_user_information)

create table friends_schema as (select * from daneliza.public_are_friends)

create table photo_schema as (select * from daneliza.public_photo_information)

create table tag_schema as (select * from daneliza.public_tag_information)

create table event_schema as (select * from daneliza.public_event_information)

INSERT INTO EDU_PROGRAM (INSTITUTION_NAME, PROGRAM_YEAR, ROGRAM_CONCENTRATION, PROGRAM_DEGREE) 
SELECT DISTINCT INSTITUTION_NAME, PROGRAM_YEAR, ROGRAM_CONCENTRATION, PROGRAM_DEGREE 
FROM user_schema;

CREATE SEQUENCE edu_sequence 
START WITH 1 
INCREMENT BY 1;  
CREATE TRIGGER edu_trigger 
BEFORE INSERT ON LOCATION 
FOR EACH ROW 
BEGIN 
SELECT edu_sequence.nextval into :new.PROGRAM_ID from dual; 
END;

INSERT INTO USER_EDUCATION (USER_ID, PROGRAM_ID)
SELECT user_schema.USER_ID, EDU_PROGRAM.PROGRAM_ID
FROM
(SELECT user_schema.USER_ID, user_schema.INSTITUTION_NAME, user_schema.PROGRAM_YEAR, user_schema.PROGRAM_CONCENTRATION, user_schema.PROGRAM_DEGREE,
	EDU_PROGRAM.*
FROM user_schema, EDU_PROGRAM
WHERE user_schema.INSTITUTION_NAME = EDU_PROGRAM.INSTITUTION_NAME
AND user_schema.PROGRAM_YEAR = EDU_PROGRAM.PROGRAM_YEAR
AND user_schema.PROGRAM_CONCENTRATION = EDU_PROGRAM.PROGRAM_CONCENTRATION
AND user_schema.PROGRAM_DEGREE = EDU_PROGRAM.PROGRAM_DEGREE);
CREATE TABLE LOCATION (
LOC_ID INTEGER,
CITY VARCHAR2(100),
STATE VARCHAR2(100),
COUNTRY VARCHAR2(100),
PRIMARY KEY (LOC_ID),
UNIQUE (CITY, STATE, COUNTRY)
);


CREATE TABLE FB_USER (
USER_ID VARCHAR2(100),
FIRST_NAME VARCHAR2(100) NOT NULL,
LAST_NAME VARCHAR(100) NOT NULL,
YEAR_OF_BIRTH INTEGER,
MONTH_OF_BIRTH INTEGER,
DAY_OF_BIRTH INTEGER,
GENDER CHAR(6),
HOMETOWN INTEGER,
CURRENT_LOCATION INTEGER,
PRIMARY KEY (USER_ID),
FOREIGN KEY (HOMETOWN) REFERENCES LOCATION,
FOREIGN KEY (CURRENT_LOCATION) REFERENCES LOCATION
);


CREATE TABLE EDU_PROGRAM (
PROGRAM_ID INTEGER,
INSTITUTION_NAME VARCHAR2(100),
PROGRAM_YEAR INTEGER,
PROGRAM_CONCENTRATION CHAR(100),
PROGRAM_DEGREE VARCHAR2(100),
PRIMARY KEY (PROGRAM_ID),
UNIQUE (INSTITUTION_NAME, PROGRAM_YEAR, PROGRAM_CONCENTRATION, PROGRAM_DEGREE)
);

CREATE TABLE USER_EDUCATION (
USER_ID VARCHAR2(100) NOT NULL,
PROGRAM_ID INTEGER NOT NULL,
FOREIGN KEY (USER_ID) REFERENCES FB_USER ON DELETE CASCADE,
FOREIGN KEY (PROGRAM_ID) REFERENCES EDU_PROGRAM
);

CREATE TABLE FRIENDSHIP (
USER1_ID VARCHAR2(100) NOT NULL,
USER2_ID VARCHAR2(100) NOT NULL,
FOREIGN KEY (USER1_ID) REFERENCES FB_USER ON DELETE CASCADE,
FOREIGN KEY (USER2_ID) REFERENCES FB_USER ON DELETE CASCADE,
UNIQUE (USER1_ID, USER2_ID)
);

CREATE TABLE PHOTO (
PHOTO_ID VARCHAR2(100),
PHOTO_CAPTION VARCHAR2(2000),
PHOTO_CREATED_TIME TIMESTAMP NOT NULL,
PHOTO_MODIFIED_TIME TIMESTAMP,
PHOTO_LINK VARCHAR2(2000) NOT NULL,
PRIMARY KEY (PHOTO_ID),
UNIQUE (PHOTO_LINK)
);

CREATE TABLE ALBUM (
ALBUM_ID VARCHAR2(100),
OWNER_ID VARCHAR2(100) NOT NULL,
COVER_PHOTO_ID VARCHAR2(100) NOT NULL,
ALBUM_NAME VARCHAR2(100),
ALBUM_CREATED_TIME TIMESTAMP NOT NULL,
ALBUM_MODIFIED_TIME TIMESTAMP,
ALBUM_LINK VARCHAR2(2000) NOT NULL,
ALBUM_VISIBILITY VARCHAR2(100) NOT NULL,
PRIMARY KEY (ALBUM_ID),
FOREIGN KEY (OWNER_ID) REFERENCES FB_USER,
FOREIGN KEY (COVER_PHOTO_ID) REFERENCES PHOTO,
UNIQUE (ALBUM_LINK)
);

CREATE TABLE ALBUM_PHOTOS (
ALBUM_ID VARCHAR2(100) NOT NULL,
PHOTO_ID VARCHAR2(100) NOT NULL,
FOREIGN KEY (ALBUM_ID) REFERENCES ALBUM ON DELETE CASCADE,
FOREIGN KEY (PHOTO_ID) REFERENCES PHOTO ON DELETE CASCADE,
UNIQUE (ALBUM_ID, PHOTO_ID)
);

CREATE TABLE TAG (
PHOTO_ID VARCHAR2(100) NOT NULL,
TAG_SUBJECT_ID VARCHAR2(100) NOT NULL,
TAG_CREATED_TIME TIMESTAMP NOT NULL,
TAG_X_COORDINATE REAL NOT NULL,
TAG_Y_COORDINATE REAL NOT NULL,
FOREIGN KEY (PHOTO_ID) REFERENCES PHOTO ON DELETE CASCADE,
FOREIGN KEY (TAG_SUBJECT_ID) REFERENCES FB_USER,
UNIQUE (PHOTO_ID, TAG_SUBJECT_ID)
);

CREATE TABLE PHOTO_COMMENT (
PHOTO_ID VARCHAR2(100) NOT NULL,
USER_ID VARCHAR2(100) NOT NULL,
CONTENT VARCHAR2(1000) NOT NULL,
TIME TIMESTAMP NOT NULL,
FOREIGN KEY (PHOTO_ID) REFERENCES PHOTO ON DELETE CASCADE,
FOREIGN KEY (USER_ID) REFERENCES FB_USER,
UNIQUE (PHOTO_ID, USER_ID, TIME)
);

CREATE TABLE EVENT (
EVENT_ID VARCHAR2(100),
EVENT_CREATOR_ID VARCHAR2(100) NOT NULL,
EVENT_NAME VARCHAR2(100),
EVENT_TAGLINE VARCHAR2(1000),
EVENT_DESCRIPTION VARCHAR2(4000),
EVENT_HOST VARCHAR2(100),
EVENT_TYPE VARCHAR2(100),
EVENT_SUBTYPE VARCHAR2(100),
EVENT_LOCATION VARCHAR2(200),
LOC_ID INTEGER,
EVENT_START_TIME TIMESTAMP,
EVENT_END_TIME TIMESTAMP,
PRIMARY KEY (EVENT_ID),
FOREIGN KEY (EVENT_CREATOR_ID) REFERENCES FB_USER,
FOREIGN KEY (LOC_ID) REFERENCES LOCATION
);
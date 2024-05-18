---------- EXECUTE AS DEVELOPER ----------


---------- USERS DATA ----------

---------- ROLES TABLE ----------
CREATE TABLE ROLES (
    ROLE_ID     INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY(START WITH 1 INCREMENT BY 1),
    ROLE_NAME   NVARCHAR2(255) NOT NULL,
    
    CONSTRAINT RLS_PK PRIMARY KEY (ROLE_ID)
)
TABLESPACE TS_USER
;

---------- USERS TABLE ----------
CREATE TABLE USERS (
    USER_ID         INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY(START WITH 1 INCREMENT BY 1),
    USER_NAME       NVARCHAR2(255) NOT NULL,
    USER_EMAIL      NVARCHAR2(255) NOT NULL UNIQUE,
    USER_PASSWORD   NVARCHAR2(255) NOT NULL,
    USER_AVATAR     BLOB,
    USER_ROLE_ID    INTEGER NOT NULL,
    
    CONSTRAINT USRS_PK PRIMARY KEY (USER_ID),
    CONSTRAINT USRS_USER_ROLE_ID_FK FOREIGN KEY (USER_ROLE_ID) REFERENCES ROLES(ROLE_ID)
) 
TABLESPACE TS_USER
;


---------- GAMES DATA ----------

---------- GENRES TABLE ----------
CREATE TABLE GENRES (
    GENRE_ID    INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY(START WITH 1 INCREMENT BY 1),
    GENRE_NAME  NVARCHAR2(255) NOT NULL,
    
    CONSTRAINT GNRS_PK PRIMARY KEY (GENRE_ID)
)
TABLESPACE TS_GAME
;

---------- DEVELOPERS TABLE ----------
CREATE TABLE DEVELOPERS (
    DEVELOPER_ID    INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY(START WITH 1 INCREMENT BY 1),
    DEVELOPER_NAME  NVARCHAR2(255) NOT NULL,
    
    CONSTRAINT DVLS_PK PRIMARY KEY (DEVELOPER_ID)
)
TABLESPACE TS_GAME
;

---------- PUBLISHERS TABLE ----------
CREATE TABLE PUBLISHERS (
    PUBLISHER_ID    INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY(START WITH 1 INCREMENT BY 1),
    PUBLISHER_NAME  NVARCHAR2(255) NOT NULL,
    
    CONSTRAINT PBLS_PK PRIMARY KEY (PUBLISHER_ID)
)
TABLESPACE TS_GAME
;

---------- GAMES TABLE ----------
CREATE TABLE GAMES (
    GAME_ID             INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY(START WITH 1 INCREMENT BY 1),
    GAME_TITLE          NVARCHAR2(255) NOT NULL,
    GAME_PRICE          NUMBER(15, 2) NOT NULL,
    GAME_SCORE          NUMBER(3, 0) NOT NULL,
    GAME_AGE_LIMIT      NUMBER(2, 0) NOT NULL,
    GAME_RELEASE_DATE   DATE NOT NULL,
    GAME_DESCRIPTION    NVARCHAR2(2000) NOT NULL,
    GAME_POSTER         BLOB,
    GAME_COVER          BLOB,
    
    CONSTRAINT GMS_PK PRIMARY KEY (GAME_ID)
)
TABLESPACE TS_GAME
;

---------- SCREENSHOTS TABLE ----------
CREATE TABLE SCREENSHOTS (
    ID          INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY(START WITH 1 INCREMENT BY 1),
    GAME_ID     INTEGER NOT NULL,
    SCREENSHOT  BLOB NOT NULL,
    
    CONSTRAINT SNSH_PK PRIMARY KEY(ID),
    CONSTRAINT SNSH_GAME_ID_FK FOREIGN KEY (GAME_ID) REFERENCES GAMES(GAME_ID)
)
TABLESPACE TS_GAME
;

---------- GMS_GNRS TABLE ----------
CREATE TABLE GMS_GNRS (
    GAME_ID     INTEGER NOT NULL,
    GENRE_ID    INTEGER NOT NULL,
    
    CONSTRAINT GMS_GNRS_PK PRIMARY KEY (GAME_ID, GENRE_ID),
    CONSTRAINT GMS_GNRS_GAME_ID_FK FOREIGN KEY (GAME_ID) REFERENCES GAMES(GAME_ID),
    CONSTRAINT GMS_GNRS_GENRE_ID_FK FOREIGN KEY (GENRE_ID) REFERENCES GENRES(GENRE_ID)
)
TABLESPACE TS_GAME
;

---------- GMS_DVLS TABLE ----------
CREATE TABLE GMS_DVLS (
    GAME_ID         INTEGER NOT NULL,
    DEVELOPER_ID    INTEGER NOT NULL,
    
    CONSTRAINT GMS_DVLS_PK PRIMARY KEY (GAME_ID, DEVELOPER_ID),
    CONSTRAINT GMS_DVLS_GAME_ID_FK FOREIGN KEY (GAME_ID) REFERENCES GAMES(GAME_ID),
    CONSTRAINT GMS_DVLS_DEVELOPER_ID_FK FOREIGN KEY (DEVELOPER_ID) REFERENCES DEVELOPERS(DEVELOPER_ID)
)
TABLESPACE TS_GAME
;

---------- GMS_PBLS TABLE ----------
CREATE TABLE GMS_PBLS (
    GAME_ID         INTEGER NOT NULL,
    PUBLISHER_ID    INTEGER NOT NULL,
    
    CONSTRAINT GMS_PBLS_PK PRIMARY KEY (GAME_ID, PUBLISHER_ID),
    CONSTRAINT GMS_PBLS_GAME_ID_FK FOREIGN KEY (GAME_ID) REFERENCES GAMES(GAME_ID),
    CONSTRAINT GMS_PBLS_PUBLISHER_ID_FK FOREIGN KEY (PUBLISHER_ID) REFERENCES PUBLISHERS(PUBLISHER_ID)
)
TABLESPACE TS_GAME
;


---------- LISTS DATA ----------

---------- WISHLISTS TABLE ----------
CREATE TABLE WISHLISTS (
    USER_ID     INTEGER NOT NULL,
    GAME_ID     INTEGER NOT NULL,
    
    CONSTRAINT WLST_PK PRIMARY KEY(USER_ID, GAME_ID),
    CONSTRAINT WLST_USER_ID_FK FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    CONSTRAINT WLST_GAME_ID_FK FOREIGN KEY (GAME_ID) REFERENCES GAMES(GAME_ID)
)
TABLESPACE TS_LIST
;

---------- CARTS TABLE ----------
CREATE TABLE CARTS (
    USER_ID     INTEGER NOT NULL,
    GAME_ID     INTEGER NOT NULL,
    
    CONSTRAINT CRTS_PK PRIMARY KEY(USER_ID, GAME_ID),
    CONSTRAINT CRTS_USER_ID_FK FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    CONSTRAINT CRTS_GAME_ID_FK FOREIGN KEY (GAME_ID) REFERENCES GAMES(GAME_ID)
)
TABLESPACE TS_LIST
;

---------- LIBRARIES TABLE ----------
CREATE TABLE LIBRARIES (
    USER_ID     INTEGER NOT NULL,
    GAME_ID     INTEGER NOT NULL,
    FAVORITE    CHAR(1) NOT NULL,
    
    CONSTRAINT LBRS_PK PRIMARY KEY(USER_ID, GAME_ID),
    CONSTRAINT LBRS_USER_ID_FK FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    CONSTRAINT LBRS_GAME_ID_FK FOREIGN KEY (GAME_ID) REFERENCES GAMES(GAME_ID)
)
TABLESPACE TS_LIST
;

---------- RATINGS TABLE ----------
CREATE TABLE RATINGS (
    USER_ID     INTEGER NOT NULL,
    GAME_ID     INTEGER NOT NULL,
    RATING      NUMBER(2, 0) NOT NULL,
    
    CONSTRAINT RTGS_PK PRIMARY KEY(USER_ID, GAME_ID),
    CONSTRAINT RTGS_USER_ID_FK FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    CONSTRAINT RTGS_GAME_ID_FK FOREIGN KEY (GAME_ID) REFERENCES GAMES(GAME_ID)
)
TABLESPACE TS_LIST
;

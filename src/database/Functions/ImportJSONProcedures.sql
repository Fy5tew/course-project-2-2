---------- EXECUTE AS DEVELOPER ----------


---------- IMPORT ROLES FROM JSON PROCEDURE ----------
CREATE OR REPLACE PROCEDURE IMPORT_ROLES_FROM_JSON
IS
    JSON_FILE UTL_FILE.FILE_TYPE;
    JSON_DATA NVARCHAR2(32000);
    JSON_OBJS JSON_ARRAY_T;
    JSON_OBJ NVARCHAR2(32000);
BEGIN
    JSON_FILE := UTL_FILE.FOPEN('JSON_EXPORT_DIR', 'ROLES.JSON', 'R');
    UTL_FILE.GET_LINE(JSON_FILE, JSON_DATA);
    JSON_OBJS := JSON_ARRAY_T(JSON_DATA);
    
    FOR i IN 0..JSON_OBJS.GET_SIZE-1 LOOP
        JSON_OBJ := JSON_OBJS.GET(i).TO_STRING();
        MERGE INTO ROLES r
        USING (
            SELECT
                JSON_VALUE(JSON_OBJ, '$.ID') AS ROLE_ID,
                JSON_VALUE(JSON_OBJ, '$.NAME') AS ROLE_NAME
            FROM DUAL
        ) parsed
        ON (r.ROLE_ID = parsed.ROLE_ID)
        WHEN NOT MATCHED THEN
            INSERT (ROLE_ID, ROLE_NAME)
            VALUES (parsed.ROLE_ID, parsed.ROLE_NAME)
        ;
    END LOOP;
    
    UTL_FILE.FCLOSE(JSON_FILE);
EXCEPTION
    WHEN OTHERS THEN BEGIN
        UTL_FILE.FCLOSE(JSON_FILE);
        RAISE;
    END;
END IMPORT_ROLES_FROM_JSON;
/


---------- IMPORT USERS FROM JSON PROCEDURE ----------
CREATE OR REPLACE PROCEDURE IMPORT_USERS_FROM_JSON
IS
    JSON_FILE UTL_FILE.FILE_TYPE;
    JSON_DATA NVARCHAR2(32000);
    JSON_OBJS JSON_ARRAY_T;
    JSON_OBJ NVARCHAR2(32000);
BEGIN
    JSON_FILE := UTL_FILE.FOPEN('JSON_EXPORT_DIR', 'USERS.JSON', 'R');
    UTL_FILE.GET_LINE(JSON_FILE, JSON_DATA);
    JSON_OBJS := JSON_ARRAY_T(JSON_DATA);
    
    FOR i IN 0..JSON_OBJS.GET_SIZE-1 LOOP
        JSON_OBJ := JSON_OBJS.GET(i).TO_STRING();
        MERGE INTO USERS u
        USING (
            SELECT
                JSON_VALUE(JSON_OBJ, '$.ID') AS USER_ID,
                JSON_VALUE(JSON_OBJ, '$.NAME') AS USER_NAME,
                JSON_VALUE(JSON_OBJ, '$.EMAIL') AS USER_EMAIL,
                JSON_VALUE(JSON_OBJ, '$.PASSWORD') AS USER_PASSWORD,
                JSON_VALUE(JSON_OBJ, '$.AVATAR') AS USER_AVATAR,
                JSON_VALUE(JSON_OBJ, '$.ROLE_ID') AS USER_ROLE_ID
            FROM DUAL
        ) parsed
        ON (u.USER_ID = parsed.USER_ID)
        WHEN NOT MATCHED THEN
            INSERT (USER_ID, USER_NAME, USER_EMAIL, USER_PASSWORD, USER_AVATAR, USER_ROLE_ID)
            VALUES (
                parsed.USER_ID, 
                parsed.USER_NAME, 
                parsed.USER_EMAIL, 
                parsed.USER_PASSWORD, 
                parsed.USER_AVATAR, 
                parsed.USER_ROLE_ID
            )
        ;
    END LOOP;
    
    UTL_FILE.FCLOSE(JSON_FILE);
EXCEPTION
    WHEN OTHERS THEN BEGIN
        UTL_FILE.FCLOSE(JSON_FILE);
        RAISE;
    END;
END IMPORT_USERS_FROM_JSON;
/


---------- IMPORT GENRES FROM JSON PROCEDURE ----------
CREATE OR REPLACE PROCEDURE IMPORT_GENRES_FROM_JSON
IS
    JSON_FILE UTL_FILE.FILE_TYPE;
    JSON_DATA NVARCHAR2(32000);
    JSON_OBJS JSON_ARRAY_T;
    JSON_OBJ NVARCHAR2(32000);
BEGIN
    JSON_FILE := UTL_FILE.FOPEN('JSON_EXPORT_DIR', 'GENRES.JSON', 'R');
    UTL_FILE.GET_LINE(JSON_FILE, JSON_DATA);
    JSON_OBJS := JSON_ARRAY_T(JSON_DATA);
    
    FOR i IN 0..JSON_OBJS.GET_SIZE-1 LOOP
        JSON_OBJ := JSON_OBJS.GET(i).TO_STRING();
        MERGE INTO GENRES g
        USING (
            SELECT
                JSON_VALUE(JSON_OBJ, '$.ID') AS GENRE_ID,
                JSON_VALUE(JSON_OBJ, '$.NAME') AS GENRE_NAME
            FROM DUAL
        ) parsed
        ON (g.GENRE_ID = parsed.GENRE_ID)
        WHEN NOT MATCHED THEN
            INSERT (GENRE_ID, GENRE_NAME)
            VALUES (parsed.GENRE_ID, parsed.GENRE_NAME)
        ;
    END LOOP;
    
    UTL_FILE.FCLOSE(JSON_FILE);
EXCEPTION
    WHEN OTHERS THEN BEGIN
        UTL_FILE.FCLOSE(JSON_FILE);
        RAISE;
    END;
END IMPORT_GENRES_FROM_JSON;
/


---------- IMPORT DEVELOPERS FROM JSON PROCEDURE ----------
CREATE OR REPLACE PROCEDURE IMPORT_DEVELOPERS_FROM_JSON
IS
    JSON_FILE UTL_FILE.FILE_TYPE;
    JSON_DATA NVARCHAR2(32000);
    JSON_OBJS JSON_ARRAY_T;
    JSON_OBJ NVARCHAR2(32000);
BEGIN
    JSON_FILE := UTL_FILE.FOPEN('JSON_EXPORT_DIR', 'DEVELOPERS.JSON', 'R');
    UTL_FILE.GET_LINE(JSON_FILE, JSON_DATA);
    JSON_OBJS := JSON_ARRAY_T(JSON_DATA);
    
    FOR i IN 0..JSON_OBJS.GET_SIZE-1 LOOP
        JSON_OBJ := JSON_OBJS.GET(i).TO_STRING();
        MERGE INTO DEVELOPERS d
        USING (
            SELECT
                JSON_VALUE(JSON_OBJ, '$.ID') AS DEVELOPER_ID,
                JSON_VALUE(JSON_OBJ, '$.NAME') AS DEVELOPER_NAME
            FROM DUAL
        ) parsed
        ON (d.DEVELOPER_ID = parsed.DEVELOPER_ID)
        WHEN NOT MATCHED THEN
            INSERT (DEVELOPER_ID, DEVELOPER_NAME)
            VALUES (parsed.DEVELOPER_ID, parsed.DEVELOPER_NAME)
        ;
    END LOOP;
    
    UTL_FILE.FCLOSE(JSON_FILE);
EXCEPTION
    WHEN OTHERS THEN BEGIN
        UTL_FILE.FCLOSE(JSON_FILE);
        RAISE;
    END;
END IMPORT_DEVELOPERS_FROM_JSON;
/


---------- IMPORT PUBLISHERS FROM JSON PROCEDURE ----------
CREATE OR REPLACE PROCEDURE IMPORT_PUBLISHERS_FROM_JSON
IS
    JSON_FILE UTL_FILE.FILE_TYPE;
    JSON_DATA NVARCHAR2(32000);
    JSON_OBJS JSON_ARRAY_T;
    JSON_OBJ NVARCHAR2(32000);
BEGIN
    JSON_FILE := UTL_FILE.FOPEN('JSON_EXPORT_DIR', 'PUBLISHERS.JSON', 'R');
    UTL_FILE.GET_LINE(JSON_FILE, JSON_DATA);
    JSON_OBJS := JSON_ARRAY_T(JSON_DATA);
    
    FOR i IN 0..JSON_OBJS.GET_SIZE-1 LOOP
        JSON_OBJ := JSON_OBJS.GET(i).TO_STRING();
        MERGE INTO PUBLISHERS p
        USING (
            SELECT
                JSON_VALUE(JSON_OBJ, '$.ID') AS PUBLISHER_ID,
                JSON_VALUE(JSON_OBJ, '$.NAME') AS PUBLISHER_NAME
            FROM DUAL
        ) parsed
        ON (p.PUBLISHER_ID = parsed.PUBLISHER_ID)
        WHEN NOT MATCHED THEN
            INSERT (PUBLISHER_ID, PUBLISHER_NAME)
            VALUES (parsed.PUBLISHER_ID, parsed.PUBLISHER_NAME)
        ;
    END LOOP;
    
    UTL_FILE.FCLOSE(JSON_FILE);
EXCEPTION
    WHEN OTHERS THEN BEGIN
        UTL_FILE.FCLOSE(JSON_FILE);
        RAISE;
    END;
END IMPORT_PUBLISHERS_FROM_JSON;
/


---------- IMPORT GAMES FROM JSON PROCEDURE ----------
CREATE OR REPLACE PROCEDURE IMPORT_GAMES_FROM_JSON
IS
    JSON_FILE UTL_FILE.FILE_TYPE;
    JSON_DATA NVARCHAR2(32000);
    JSON_OBJS JSON_ARRAY_T;
    JSON_OBJ NVARCHAR2(32000);
BEGIN
    JSON_FILE := UTL_FILE.FOPEN('JSON_EXPORT_DIR', 'GAMES.JSON', 'R');
    UTL_FILE.GET_LINE(JSON_FILE, JSON_DATA);
    JSON_OBJS := JSON_ARRAY_T(JSON_DATA);
    
    FOR i IN 0..JSON_OBJS.GET_SIZE-1 LOOP
        JSON_OBJ := JSON_OBJS.GET(i).TO_STRING();
        MERGE INTO GAMES g
        USING (
            SELECT
                JSON_VALUE(JSON_OBJ, '$.ID') AS GAME_ID,
                JSON_VALUE(JSON_OBJ, '$.TITLE') AS GAME_TITLE,
                JSON_VALUE(JSON_OBJ, '$.PRICE') AS GAME_PRICE,
                JSON_VALUE(JSON_OBJ, '$.SCORE') AS GAME_SCORE,
                JSON_VALUE(JSON_OBJ, '$.AGE_LIMIT') AS GAME_AGE_LIMIT,
                JSON_VALUE(JSON_OBJ, '$.RELEASE_DATE') AS GAME_RELEASE_DATE,
                JSON_VALUE(JSON_OBJ, '$.DESCRIPTION') AS GAME_DESCRIPTION,
                JSON_VALUE(JSON_OBJ, '$.POSTER') AS GAME_POSTER,
                JSON_VALUE(JSON_OBJ, '$.COVER') AS GAME_COVER
            FROM DUAL
        ) parsed
        ON (g.GAME_ID = parsed.GAME_ID)
        WHEN NOT MATCHED THEN
            INSERT (GAME_ID, GAME_TITLE, GAME_PRICE, GAME_SCORE, GAME_AGE_LIMIT, GAME_RELEASE_DATE, GAME_DESCRIPTION, GAME_POSTER, GAME_COVER)
            VALUES (
                parsed.GAME_ID,
                parsed.GAME_TITLE,
                parsed.GAME_PRICE,
                parsed.GAME_SCORE,
                parsed.GAME_AGE_LIMIT,
                TO_DATE(parsed.GAME_RELEASE_DATE, 'YYYY-MM-DD"T"HH24:MI:SS'),
                parsed.GAME_DESCRIPTION,
                parsed.GAME_POSTER,
                parsed.GAME_COVER
            )
        ;
    END LOOP;
    
    UTL_FILE.FCLOSE(JSON_FILE);
EXCEPTION
    WHEN OTHERS THEN BEGIN
        UTL_FILE.FCLOSE(JSON_FILE);
        RAISE;
    END;
END IMPORT_GAMES_FROM_JSON;
/


---------- IMPORT SCREENSHOTS FROM JSON PROCEDURE ----------
CREATE OR REPLACE PROCEDURE IMPORT_SCREENSHOTS_FROM_JSON
IS
    JSON_FILE UTL_FILE.FILE_TYPE;
    JSON_DATA NVARCHAR2(32000);
    JSON_OBJS JSON_ARRAY_T;
    JSON_OBJ NVARCHAR2(32000);
BEGIN
    JSON_FILE := UTL_FILE.FOPEN('JSON_EXPORT_DIR', 'SCREENSHOTS.JSON', 'R');
    UTL_FILE.GET_LINE(JSON_FILE, JSON_DATA);
    JSON_OBJS := JSON_ARRAY_T(JSON_DATA);
    
    FOR i IN 0..JSON_OBJS.GET_SIZE-1 LOOP
        JSON_OBJ := JSON_OBJS.GET(i).TO_STRING();
        MERGE INTO SCREENSHOTS s
        USING (
            SELECT
                JSON_VALUE(JSON_OBJ, '$.ID') AS ID,
                JSON_VALUE(JSON_OBJ, '$.GAME_ID') AS GAME_ID,
                JSON_VALUE(JSON_OBJ, '$.SCREENSHOT') AS SCREENSHOT
            FROM DUAL
        ) parsed
        ON (s.ID = parsed.ID)
        WHEN NOT MATCHED THEN
            INSERT (ID, GAME_ID, SCREENSHOT)
            VALUES (
                parsed.ID,
                parsed.GAME_ID,
                parsed.SCREENSHOT
            )
        ;
    END LOOP;
    
    UTL_FILE.FCLOSE(JSON_FILE);
EXCEPTION
    WHEN OTHERS THEN BEGIN
        UTL_FILE.FCLOSE(JSON_FILE);
        RAISE;
    END;
END IMPORT_SCREENSHOTS_FROM_JSON;
/


---------- IMPORT GMS_GNRS FROM JSON PROCEDURE ----------
CREATE OR REPLACE PROCEDURE IMPORT_GMS_GNRS_FROM_JSON
IS
    JSON_FILE UTL_FILE.FILE_TYPE;
    JSON_DATA NVARCHAR2(32000);
    JSON_OBJS JSON_ARRAY_T;
    JSON_OBJ NVARCHAR2(32000);
BEGIN
    JSON_FILE := UTL_FILE.FOPEN('JSON_EXPORT_DIR', 'GMS_GNRS.JSON', 'R');
    UTL_FILE.GET_LINE(JSON_FILE, JSON_DATA);
    JSON_OBJS := JSON_ARRAY_T(JSON_DATA);
    
    FOR i IN 0..JSON_OBJS.GET_SIZE-1 LOOP
        JSON_OBJ := JSON_OBJS.GET(i).TO_STRING();
        MERGE INTO GMS_GNRS gg
        USING (
            SELECT
                JSON_VALUE(JSON_OBJ, '$.GAME_ID') AS GAME_ID,
                JSON_VALUE(JSON_OBJ, '$.GENRE_ID') AS GENRE_ID
            FROM DUAL
        ) parsed
        ON (gg.GAME_ID = parsed.GAME_ID AND gg.GENRE_ID = parsed.GENRE_ID)
        WHEN NOT MATCHED THEN
            INSERT (GAME_ID, GENRE_ID)
            VALUES (parsed.GAME_ID, parsed.GENRE_ID)
        ;
    END LOOP;
    
    UTL_FILE.FCLOSE(JSON_FILE);
EXCEPTION
    WHEN OTHERS THEN BEGIN
        UTL_FILE.FCLOSE(JSON_FILE);
        RAISE;
    END;
END IMPORT_GMS_GNRS_FROM_JSON;
/


---------- IMPORT GMS_DVLS FROM JSON PROCEDURE ----------
CREATE OR REPLACE PROCEDURE IMPORT_GMS_DVLS_FROM_JSON
IS
    JSON_FILE UTL_FILE.FILE_TYPE;
    JSON_DATA NVARCHAR2(32000);
    JSON_OBJS JSON_ARRAY_T;
    JSON_OBJ NVARCHAR2(32000);
BEGIN
    JSON_FILE := UTL_FILE.FOPEN('JSON_EXPORT_DIR', 'GMS_DVLS.JSON', 'R');
    UTL_FILE.GET_LINE(JSON_FILE, JSON_DATA);
    JSON_OBJS := JSON_ARRAY_T(JSON_DATA);
    
    FOR i IN 0..JSON_OBJS.GET_SIZE-1 LOOP
        JSON_OBJ := JSON_OBJS.GET(i).TO_STRING();
        MERGE INTO GMS_DVLS gd
        USING (
            SELECT
                JSON_VALUE(JSON_OBJ, '$.GAME_ID') AS GAME_ID,
                JSON_VALUE(JSON_OBJ, '$.DEVELOPER_ID') AS DEVELOPER_ID
            FROM DUAL
        ) parsed
        ON (gd.GAME_ID = parsed.GAME_ID AND gd.DEVELOPER_ID = parsed.DEVELOPER_ID)
        WHEN NOT MATCHED THEN
            INSERT (GAME_ID, DEVELOPER_ID)
            VALUES (parsed.GAME_ID, parsed.DEVELOPER_ID)
        ;
    END LOOP;
    
    UTL_FILE.FCLOSE(JSON_FILE);
EXCEPTION
    WHEN OTHERS THEN BEGIN
        UTL_FILE.FCLOSE(JSON_FILE);
        RAISE;
    END;
END IMPORT_GMS_DVLS_FROM_JSON;
/


---------- IMPORT GMS_PBLS FROM JSON PROCEDURE ----------
CREATE OR REPLACE PROCEDURE IMPORT_GMS_PBLS_FROM_JSON
IS
    JSON_FILE UTL_FILE.FILE_TYPE;
    JSON_DATA NVARCHAR2(32000);
    JSON_OBJS JSON_ARRAY_T;
    JSON_OBJ NVARCHAR2(32000);
BEGIN
    JSON_FILE := UTL_FILE.FOPEN('JSON_EXPORT_DIR', 'GMS_PBLS.JSON', 'R');
    UTL_FILE.GET_LINE(JSON_FILE, JSON_DATA);
    JSON_OBJS := JSON_ARRAY_T(JSON_DATA);
    
    FOR i IN 0..JSON_OBJS.GET_SIZE-1 LOOP
        JSON_OBJ := JSON_OBJS.GET(i).TO_STRING();
        MERGE INTO GMS_PBLS gp
        USING (
            SELECT
                JSON_VALUE(JSON_OBJ, '$.GAME_ID') AS GAME_ID,
                JSON_VALUE(JSON_OBJ, '$.PUBLISHER_ID') AS PUBLISHER_ID
            FROM DUAL
        ) parsed
        ON (gp.GAME_ID = parsed.GAME_ID AND gp.PUBLISHER_ID = parsed.PUBLISHER_ID)
        WHEN NOT MATCHED THEN
            INSERT (GAME_ID, PUBLISHER_ID)
            VALUES (parsed.GAME_ID, parsed.PUBLISHER_ID)
        ;
    END LOOP;
    
    UTL_FILE.FCLOSE(JSON_FILE);
EXCEPTION
    WHEN OTHERS THEN BEGIN
        UTL_FILE.FCLOSE(JSON_FILE);
        RAISE;
    END;
END IMPORT_GMS_PBLS_FROM_JSON;
/


---------- IMPORT WISHLISTS FROM JSON PROCEDURE ----------
CREATE OR REPLACE PROCEDURE IMPORT_WISHLISTS_FROM_JSON
IS
    JSON_FILE UTL_FILE.FILE_TYPE;
    JSON_DATA NVARCHAR2(32000);
    JSON_OBJS JSON_ARRAY_T;
    JSON_OBJ NVARCHAR2(32000);
BEGIN
    JSON_FILE := UTL_FILE.FOPEN('JSON_EXPORT_DIR', 'WISHLISTS.JSON', 'R');
    UTL_FILE.GET_LINE(JSON_FILE, JSON_DATA);
    JSON_OBJS := JSON_ARRAY_T(JSON_DATA);
    
    FOR i IN 0..JSON_OBJS.GET_SIZE-1 LOOP
        JSON_OBJ := JSON_OBJS.GET(i).TO_STRING();
        MERGE INTO WISHLISTS w
        USING (
            SELECT
                JSON_VALUE(JSON_OBJ, '$.USER_ID') AS USER_ID,
                JSON_VALUE(JSON_OBJ, '$.GAME_ID') AS GAME_ID
            FROM DUAL
        ) parsed
        ON (w.USER_ID = parsed.USER_ID AND w.GAME_ID = parsed.GAME_ID)
        WHEN NOT MATCHED THEN
            INSERT (USER_ID, GAME_ID)
            VALUES (parsed.USER_ID, parsed.GAME_ID)
        ;
    END LOOP;
    
    UTL_FILE.FCLOSE(JSON_FILE);
EXCEPTION
    WHEN OTHERS THEN BEGIN
        UTL_FILE.FCLOSE(JSON_FILE);
        RAISE;
    END;
END IMPORT_WISHLISTS_FROM_JSON;
/


---------- IMPORT CARTS FROM JSON PROCEDURE ----------
CREATE OR REPLACE PROCEDURE IMPORT_CARTS_FROM_JSON
IS
    JSON_FILE UTL_FILE.FILE_TYPE;
    JSON_DATA NVARCHAR2(32000);
    JSON_OBJS JSON_ARRAY_T;
    JSON_OBJ NVARCHAR2(32000);
BEGIN
    JSON_FILE := UTL_FILE.FOPEN('JSON_EXPORT_DIR', 'CARTS.JSON', 'R');
    UTL_FILE.GET_LINE(JSON_FILE, JSON_DATA);
    JSON_OBJS := JSON_ARRAY_T(JSON_DATA);
    
    FOR i IN 0..JSON_OBJS.GET_SIZE-1 LOOP
        JSON_OBJ := JSON_OBJS.GET(i).TO_STRING();
        MERGE INTO CARTS c
        USING (
            SELECT
                JSON_VALUE(JSON_OBJ, '$.USER_ID') AS USER_ID,
                JSON_VALUE(JSON_OBJ, '$.GAME_ID') AS GAME_ID
            FROM DUAL
        ) parsed
        ON (c.USER_ID = parsed.USER_ID AND c.GAME_ID = parsed.GAME_ID)
        WHEN NOT MATCHED THEN
            INSERT (USER_ID, GAME_ID)
            VALUES (parsed.USER_ID, parsed.GAME_ID)
        ;
    END LOOP;
    
    UTL_FILE.FCLOSE(JSON_FILE);
EXCEPTION
    WHEN OTHERS THEN BEGIN
        UTL_FILE.FCLOSE(JSON_FILE);
        RAISE;
    END;
END IMPORT_CARTS_FROM_JSON;
/


---------- IMPORT LIBRARIES FROM JSON PROCEDURE ----------
CREATE OR REPLACE PROCEDURE IMPORT_LIBRARIES_FROM_JSON
IS
    JSON_FILE UTL_FILE.FILE_TYPE;
    JSON_DATA NVARCHAR2(32000);
    JSON_OBJS JSON_ARRAY_T;
    JSON_OBJ NVARCHAR2(32000);
BEGIN
    JSON_FILE := UTL_FILE.FOPEN('JSON_EXPORT_DIR', 'LIBRARIES.JSON', 'R');
    UTL_FILE.GET_LINE(JSON_FILE, JSON_DATA);
    JSON_OBJS := JSON_ARRAY_T(JSON_DATA);
    
    FOR i IN 0..JSON_OBJS.GET_SIZE-1 LOOP
        JSON_OBJ := JSON_OBJS.GET(i).TO_STRING();
        MERGE INTO LIBRARIES l
        USING (
            SELECT
                JSON_VALUE(JSON_OBJ, '$.USER_ID') AS USER_ID,
                JSON_VALUE(JSON_OBJ, '$.GAME_ID') AS GAME_ID,
                JSON_VALUE(JSON_OBJ, '$.FAVORITE') AS FAVORITE
            FROM DUAL
        ) parsed
        ON (l.USER_ID = parsed.USER_ID AND l.GAME_ID = parsed.GAME_ID)
        WHEN NOT MATCHED THEN
            INSERT (USER_ID, GAME_ID, FAVORITE)
            VALUES (parsed.USER_ID, parsed.GAME_ID, parsed.FAVORITE)
        ;
    END LOOP;
    
    UTL_FILE.FCLOSE(JSON_FILE);
EXCEPTION
    WHEN OTHERS THEN BEGIN
        UTL_FILE.FCLOSE(JSON_FILE);
        RAISE;
    END;
END IMPORT_LIBRARIES_FROM_JSON;
/


---------- IMPORT RATINGS FROM JSON PROCEDURE ----------
CREATE OR REPLACE PROCEDURE IMPORT_RATINGS_FROM_JSON
IS
    JSON_FILE UTL_FILE.FILE_TYPE;
    JSON_DATA NVARCHAR2(32000);
    JSON_OBJS JSON_ARRAY_T;
    JSON_OBJ NVARCHAR2(32000);
BEGIN
    JSON_FILE := UTL_FILE.FOPEN('JSON_EXPORT_DIR', 'RATINGS.JSON', 'R');
    UTL_FILE.GET_LINE(JSON_FILE, JSON_DATA);
    JSON_OBJS := JSON_ARRAY_T(JSON_DATA);
    
    FOR i IN 0..JSON_OBJS.GET_SIZE-1 LOOP
        JSON_OBJ := JSON_OBJS.GET(i).TO_STRING();
        MERGE INTO RATINGS r
        USING (
            SELECT
                JSON_VALUE(JSON_OBJ, '$.USER_ID') AS USER_ID,
                JSON_VALUE(JSON_OBJ, '$.GAME_ID') AS GAME_ID,
                JSON_VALUE(JSON_OBJ, '$.RATING') AS RATING
            FROM DUAL
        ) parsed
        ON (r.USER_ID = parsed.USER_ID AND r.GAME_ID = parsed.GAME_ID)
        WHEN NOT MATCHED THEN
            INSERT (USER_ID, GAME_ID, RATING)
            VALUES (parsed.USER_ID, parsed.GAME_ID, parsed.RATING)
        ;
    END LOOP;
    
    UTL_FILE.FCLOSE(JSON_FILE);
EXCEPTION
    WHEN OTHERS THEN BEGIN
        UTL_FILE.FCLOSE(JSON_FILE);
        RAISE;
    END;
END IMPORT_RATINGS_FROM_JSON;
/

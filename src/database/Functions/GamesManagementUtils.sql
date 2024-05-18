---------- EXECUTE AS DEVELOPER ----------


---------- GAMES MANAGEMENT UTILS PACKAGE SPECIFICATION ----------
CREATE OR REPLACE PACKAGE GAMES_MANAGEMENT_UTILS IS
    PROCEDURE CREATE_GENRE(
        in_genre_name GENRES.GENRE_NAME%TYPE
    );
    
    PROCEDURE UPDATE_GENRE(
        in_genre_id GENRES.GENRE_ID%TYPE,
        in_new_genre_name GENRES.GENRE_NAME%TYPE
    );
    
    PROCEDURE DELETE_GENRE(
        in_genre_id GENRES.GENRE_ID%TYPE
    );
    
    PROCEDURE CREATE_DEVELOPER(
        in_developer_name DEVELOPERS.DEVELOPER_NAME%TYPE
    );
    
    PROCEDURE UPDATE_DEVELOPER(
        in_developer_id DEVELOPERS.DEVELOPER_ID%TYPE,
        in_new_developer_name DEVELOPERS.DEVELOPER_NAME%TYPE
    );    
    
    PROCEDURE DELETE_DEVELOPER(
        in_developer_id DEVELOPERS.DEVELOPER_ID%TYPE
    );
    
    PROCEDURE CREATE_PUBLISHER(
        in_publisher_name PUBLISHERS.PUBLISHER_NAME%TYPE
    );
    
    PROCEDURE UPDATE_PUBLISHER(
        in_publisher_id PUBLISHERS.PUBLISHER_ID%TYPE,
        in_new_publisher_name PUBLISHERS.PUBLISHER_NAME%TYPE
    );
    
    PROCEDURE DELETE_PUBLISHER(
        in_publisher_id PUBLISHERS.PUBLISHER_ID%TYPE
    );
    
    PROCEDURE CREATE_GAME(
        in_title GAMES.GAME_TITLE%TYPE,
        in_price GAMES.GAME_PRICE%TYPE,
        in_score GAMES.GAME_SCORE%TYPE,
        in_age_limit GAMES.GAME_AGE_LIMIT%TYPE,
        in_release_date GAMES.GAME_RELEASE_DATE%TYPE,
        in_description GAMES.GAME_DESCRIPTION%TYPE
    );
    
    PROCEDURE UPDATE_GAME(
        in_game_id GAMES.GAME_ID%TYPE,
        in_new_title GAMES.GAME_TITLE%TYPE,
        in_new_price GAMES.GAME_PRICE%TYPE,
        in_new_score GAMES.GAME_SCORE%TYPE,
        in_new_age_limit GAMES.GAME_AGE_LIMIT%TYPE,
        in_new_release_date GAMES.GAME_RELEASE_DATE%TYPE,
        in_new_description GAMES.GAME_DESCRIPTION%TYPE
    );
    
    PROCEDURE DELETE_GAME(
        in_game_id GAMES.GAME_ID%TYPE
    );
    
    PROCEDURE ADD_GENRE(
        in_game_id GAMES.GAME_ID%TYPE,
        in_genre_id GENRES.GENRE_ID%TYPE
    );
    
    PROCEDURE REMOVE_GENRE(
        in_game_id GAMES.GAME_ID%TYPE,
        in_genre_id GENRES.GENRE_ID%TYPE
    );
    
    PROCEDURE ADD_DEVELOPER(
        in_game_id GAMES.GAME_ID%TYPE,
        in_developer_id DEVELOPERS.DEVELOPER_ID%TYPE
    );
    
    PROCEDURE REMOVE_DEVELOPER(
        in_game_id GAMES.GAME_ID%TYPE,
        in_developer_id DEVELOPERS.DEVELOPER_ID%TYPE
    );
    
    PROCEDURE ADD_PUBLISHER(
        in_game_id GAMES.GAME_ID%TYPE,
        in_publisher_id PUBLISHERS.PUBLISHER_ID%TYPE
    );
    
    PROCEDURE REMOVE_PUBLISHER(
        in_game_id GAMES.GAME_ID%TYPE,
        in_publisher_id PUBLISHERS.PUBLISHER_ID%TYPE
    );
END GAMES_MANAGEMENT_UTILS;
/


---------- GAMES MANAGEMENT UTILS PACKAGE BODY ----------
CREATE OR REPLACE PACKAGE BODY GAMES_MANAGEMENT_UTILS IS
---------- CREATE GENRE PROCEDURE ----------
    PROCEDURE CREATE_GENRE(
        in_genre_name GENRES.GENRE_NAME%TYPE
    )
    IS
    BEGIN
        INSERT INTO GENRES(GENRE_NAME)
        VALUES (in_genre_name)
        ;
    END CREATE_GENRE;

---------- UPDATE GENRE PROCEDURE ----------
    PROCEDURE UPDATE_GENRE(
        in_genre_id GENRES.GENRE_ID%TYPE,
        in_new_genre_name GENRES.GENRE_NAME%TYPE
    )
    IS
    BEGIN
        UPDATE GENRES
        SET GENRE_NAME = in_new_genre_name
        WHERE GENRE_ID = in_genre_id
        ;
    END UPDATE_GENRE;

---------- DELETE GENRE PROCEDURE ----------
    PROCEDURE DELETE_GENRE(
        in_genre_id GENRES.GENRE_ID%TYPE
    )
    IS
    BEGIN
        DELETE FROM GENRES
        WHERE GENRE_ID = in_genre_id
        ;
    END DELETE_GENRE;

---------- CREATE DEVELOPER PROCEDURE ----------
    PROCEDURE CREATE_DEVELOPER(
        in_developer_name DEVELOPERS.DEVELOPER_NAME%TYPE
    )
    IS
    BEGIN
        INSERT INTO DEVELOPERS(DEVELOPER_NAME)
        VALUES (in_developer_name)
        ;
    END CREATE_DEVELOPER;

---------- UPDATE DEVELOPER PROCEDURE ----------    
    PROCEDURE UPDATE_DEVELOPER(
        in_developer_id DEVELOPERS.DEVELOPER_ID%TYPE,
        in_new_developer_name DEVELOPERS.DEVELOPER_NAME%TYPE
    )
    IS
    BEGIN
        UPDATE DEVELOPERS
        SET DEVELOPER_NAME = in_new_developer_name
        WHERE DEVELOPER_ID = in_developer_id
        ;
    END UPDATE_DEVELOPER;

---------- DELETE DEVELOPER PROCEDURE ----------
    PROCEDURE DELETE_DEVELOPER(
        in_developer_id DEVELOPERS.DEVELOPER_ID%TYPE
    )
    IS
    BEGIN
        DELETE FROM DEVELOPERS
        WHERE DEVELOPER_ID = in_developer_id
        ;
    END DELETE_DEVELOPER;

---------- CREATE PUBLUSHER PROCEDURE ----------
    PROCEDURE CREATE_PUBLISHER(
        in_publisher_name PUBLISHERS.PUBLISHER_NAME%TYPE
    )
    IS
    BEGIN
        INSERT INTO PUBLISHERS(PUBLISHER_NAME)
        VALUES (in_publisher_name)
        ;
    END CREATE_PUBLISHER;
    
---------- UPDATE PUBLUSHER PROCEDURE ----------
    PROCEDURE UPDATE_PUBLISHER(
        in_publisher_id PUBLISHERS.PUBLISHER_ID%TYPE,
        in_new_publisher_name PUBLISHERS.PUBLISHER_NAME%TYPE
    )
    IS
    BEGIN
        UPDATE PUBLISHERS
        SET PUBLISHER_NAME = in_new_publisher_name
        WHERE PUBLISHER_ID = in_publisher_id
        ;
    END UPDATE_PUBLISHER;

---------- DELETE PUBLUSHER PROCEDURE ----------
    PROCEDURE DELETE_PUBLISHER(
        in_publisher_id PUBLISHERS.PUBLISHER_ID%TYPE
    )
    IS
    BEGIN
        DELETE FROM PUBLISHERS
        WHERE PUBLISHER_ID = in_publisher_id
        ;
    END DELETE_PUBLISHER;

---------- CREATE GAME PROCEDURE ----------
    PROCEDURE CREATE_GAME(
        in_title GAMES.GAME_TITLE%TYPE,
        in_price GAMES.GAME_PRICE%TYPE,
        in_score GAMES.GAME_SCORE%TYPE,
        in_age_limit GAMES.GAME_AGE_LIMIT%TYPE,
        in_release_date GAMES.GAME_RELEASE_DATE%TYPE,
        in_description GAMES.GAME_DESCRIPTION%TYPE
    )
    IS
    BEGIN
        INSERT INTO GAMES(GAME_TITLE, GAME_PRICE, GAME_SCORE, GAME_AGE_LIMIT, GAME_RELEASE_DATE, GAME_DESCRIPTION)
        VALUES (in_title, in_price, in_score, in_age_limit, in_release_date, in_description)
        ;
    END CREATE_GAME;
    
---------- UPDATE GAME PROCEDURE ----------
    PROCEDURE UPDATE_GAME(
        in_game_id GAMES.GAME_ID%TYPE,
        in_new_title GAMES.GAME_TITLE%TYPE,
        in_new_price GAMES.GAME_PRICE%TYPE,
        in_new_score GAMES.GAME_SCORE%TYPE,
        in_new_age_limit GAMES.GAME_AGE_LIMIT%TYPE,
        in_new_release_date GAMES.GAME_RELEASE_DATE%TYPE,
        in_new_description GAMES.GAME_DESCRIPTION%TYPE
    )
    IS
    BEGIN
        UPDATE GAMES
        SET
            GAME_TITLE = in_new_title,
            GAME_PRICE = in_new_price,
            GAME_SCORE = in_new_score,
            GAME_AGE_LIMIT = in_new_age_limit,
            GAME_RELEASE_DATE = in_new_release_date,
            GAME_DESCRIPTION = in_new_description
        WHERE GAME_ID = in_game_id
        ;
    END UPDATE_GAME;

---------- DELETE GAME PROCEDURE ----------
    PROCEDURE DELETE_GAME(
        in_game_id GAMES.GAME_ID%TYPE
    )
    IS
    BEGIN
        DELETE FROM GAMES
        WHERE GAME_ID = in_game_id
        ;
    END DELETE_GAME;

---------- ADD GENRE PROCEDURE ----------
    PROCEDURE ADD_GENRE(
        in_game_id GAMES.GAME_ID%TYPE,
        in_genre_id GENRES.GENRE_ID%TYPE
    )
    IS
    BEGIN
        INSERT INTO GMS_GNRS(GAME_ID, GENRE_ID)
        VALUES (in_game_id, in_genre_id)
        ;
    END ADD_GENRE;

---------- REMOVE GENRE PROCEDURE ----------
    PROCEDURE REMOVE_GENRE(
        in_game_id GAMES.GAME_ID%TYPE,
        in_genre_id GENRES.GENRE_ID%TYPE
    )
    IS
    BEGIN
        DELETE FROM GMS_GNRS
        WHERE
            GAME_ID = in_game_id
            AND GENRE_ID = in_genre_id
        ;
    END REMOVE_GENRE;

---------- ADD DEVELOPER PROCEDURE ----------
    PROCEDURE ADD_DEVELOPER(
        in_game_id GAMES.GAME_ID%TYPE,
        in_developer_id DEVELOPERS.DEVELOPER_ID%TYPE
    )
    IS
    BEGIN
        INSERT INTO GMS_DVLS(GAME_ID, DEVELOPER_ID)
        VALUES (in_game_id, in_developer_id)
        ;
    END ADD_DEVELOPER;

---------- REMOVE DEVELOPER PROCEDURE ----------
    PROCEDURE REMOVE_DEVELOPER(
        in_game_id GAMES.GAME_ID%TYPE,
        in_developer_id DEVELOPERS.DEVELOPER_ID%TYPE
    )
    IS
    BEGIN
        DELETE FROM GMS_DVLS
        WHERE
            GAME_ID = in_game_id
            AND DEVELOPER_ID = in_developer_id
        ;
    END REMOVE_DEVELOPER;

---------- ADD PUBLISHER PROCEDURE ----------
    PROCEDURE ADD_PUBLISHER(
        in_game_id GAMES.GAME_ID%TYPE,
        in_publisher_id PUBLISHERS.PUBLISHER_ID%TYPE
    )
    IS
    BEGIN
        INSERT INTO GMS_PBLS(GAME_ID, PUBLISHER_ID)
        VALUES (in_game_id, in_publisher_id)
        ;
    END ADD_PUBLISHER;

---------- REMOVE PUBLISHER PROCEDURE ----------
    PROCEDURE REMOVE_PUBLISHER(
        in_game_id GAMES.GAME_ID%TYPE,
        in_publisher_id PUBLISHERS.PUBLISHER_ID%TYPE
    )
    IS
    BEGIN
        DELETE FROM GMS_PBLS
        WHERE
            GAME_ID = in_game_id
            AND PUBLISHER_ID = in_publisher_id
        ;
    END REMOVE_PUBLISHER;
END GAMES_MANAGEMENT_UTILS;
/

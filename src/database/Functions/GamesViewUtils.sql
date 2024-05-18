---------- EXECUTE AS DEVELOPER ----------


---------- GAMES VIEW UTILS PACKAGE SPECIFICATION ----------
CREATE OR REPLACE PACKAGE GAMES_VIEW_UTILS IS
    FUNCTION GET_GENRE_BY_ID(
        in_genre_id GENRES.GENRE_ID%TYPE
    )
    RETURN GENRE_RECORD;
    
    FUNCTION GET_GENRES_BY_NAME(
        in_genre_name GENRES.GENRE_NAME%TYPE
    )
    RETURN GENRE_RECORD_TABLE;
    
    FUNCTION GET_DEVELOPER_BY_ID(
        in_developer_id DEVELOPERS.DEVELOPER_ID%TYPE
    )
    RETURN DEVELOPER_RECORD;
    
    FUNCTION GET_DEVELOPERS_BY_NAME(
        in_developer_name DEVELOPERS.DEVELOPER_NAME%TYPE
    )
    RETURN DEVELOPER_RECORD_TABLE;
    
    FUNCTION GET_PUBLISHER_BY_ID(
        in_publisher_id PUBLISHERS.PUBLISHER_ID%TYPE
    )
    RETURN PUBLISHER_RECORD;
    
    FUNCTION GET_PUBLISHERS_BY_NAME(
        in_publisher_name PUBLISHERS.PUBLISHER_NAME%TYPE
    )
    RETURN PUBLISHER_RECORD_TABLE;
    
    FUNCTION GET_GAME_BY_ID(
        in_game_id GAMES.GAME_ID%TYPE
    )
    RETURN GAME_RECORD;
    
    FUNCTION GET_GAME_GENRES_BY_ID(
        in_game_id GAMES.GAME_ID%TYPE
    )
    RETURN GENRE_RECORD_TABLE;
    
    FUNCTION GET_GAME_DEVELOPERS_BY_ID(
        in_game_id GAMES.GAME_ID%TYPE
    )
    RETURN DEVELOPER_RECORD_TABLE;
    
    FUNCTION GET_GAME_PUBLISHERS_BY_ID(
        in_game_id GAMES.GAME_ID%TYPE
    )
    RETURN PUBLISHER_RECORD_TABLE;
    
    FUNCTION GET_GAMES_BY_TITLE(
        in_game_title GAMES.GAME_TITLE%TYPE
    )
    RETURN GAME_RECORD_TABLE;

    FUNCTION GET_GAMES_BY_GENRE_ID(
        in_genre_id GENRES.GENRE_ID%TYPE
    )
    RETURN GAME_RECORD_TABLE;
    
    FUNCTION GET_GAMES_BY_DEVELOPER_ID(
        in_developer_id DEVELOPERS.DEVELOPER_ID%TYPE
    )
    RETURN GAME_RECORD_TABLE;
    
    FUNCTION GET_GAMES_BY_PUBLISHER_ID(
        in_publisher_id PUBLISHERS.PUBLISHER_ID%TYPE
    )
    RETURN GAME_RECORD_TABLE;
    
    FUNCTION GET_GAME_AVERANGE_USER_RATING(
        in_game_id GAMES.GAME_ID%TYPE
    )
    RETURN NUMBER;
END GAMES_VIEW_UTILS;
/


---------- GAMES VIEW UTILS PACKAGE BODY ----------
CREATE OR REPLACE PACKAGE BODY GAMES_VIEW_UTILS IS
---------- GET GENRE BY ID FUNCTION ----------
    FUNCTION GET_GENRE_BY_ID(
        in_genre_id GENRES.GENRE_ID%TYPE
    )
    RETURN GENRE_RECORD
    IS
        genre_rec GENRE_RECORD;
    BEGIN
        SELECT GENRE_RECORD(
            GENRE_ID,
            GENRE_NAME
        )
        INTO genre_rec
        FROM GENRES
        WHERE GENRE_ID = in_genre_id
        ;
        RETURN genre_rec;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN BEGIN
            RAISE_APPLICATION_ERROR(-20000, 'Invalid genre id');
        END;
    END GET_GENRE_BY_ID;
    
---------- GET GENRES BY NAME FUNCTION ----------    
    FUNCTION GET_GENRES_BY_NAME(
        in_genre_name GENRES.GENRE_NAME%TYPE
    )
    RETURN GENRE_RECORD_TABLE
    IS
        founded_genres GENRE_RECORD_TABLE;
    BEGIN
        SELECT GET_GENRE_BY_ID(GENRE_ID)
        BULK COLLECT INTO founded_genres
        FROM GENRES
        WHERE LOWER(GENRE_NAME) LIKE '%' || LOWER(in_genre_name) || '%'
        ;
        RETURN founded_genres;
    END GET_GENRES_BY_NAME;

---------- GET DEVELOPER BY ID FUNCTION ----------
    FUNCTION GET_DEVELOPER_BY_ID(
        in_developer_id DEVELOPERS.DEVELOPER_ID%TYPE
    )
    RETURN DEVELOPER_RECORD
    IS
        developer_rec DEVELOPER_RECORD;
    BEGIN
        SELECT DEVELOPER_RECORD(
            DEVELOPER_ID,
            DEVELOPER_NAME
        )
        INTO developer_rec
        FROM DEVELOPERS
        WHERE DEVELOPER_ID = in_developer_id
        ;
        RETURN developer_rec;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN BEGIN
            RAISE_APPLICATION_ERROR(-20000, 'Invalid developer id');
        END;
    END GET_DEVELOPER_BY_ID;

---------- GET DEVELOPERS BY NAME FUNCTION ----------
    FUNCTION GET_DEVELOPERS_BY_NAME(
        in_developer_name DEVELOPERS.DEVELOPER_NAME%TYPE
    )
    RETURN DEVELOPER_RECORD_TABLE
    IS
        founded_developers DEVELOPER_RECORD_TABLE;
    BEGIN
        SELECT GET_DEVELOPER_BY_ID(DEVELOPER_ID)
        BULK COLLECT INTO founded_developers
        FROM DEVELOPERS
        WHERE LOWER(DEVELOPER_NAME) LIKE '%' || LOWER(in_developer_name) || '%'
        ;
        RETURN founded_developers;
    END GET_DEVELOPERS_BY_NAME;

---------- GET PUBLISHER BY ID FUNCTION ----------
    FUNCTION GET_PUBLISHER_BY_ID(
        in_publisher_id PUBLISHERS.PUBLISHER_ID%TYPE
    )
    RETURN PUBLISHER_RECORD
    IS
        publisher_rec PUBLISHER_RECORD;
    BEGIN
        SELECT PUBLISHER_RECORD(
            PUBLISHER_ID,
            PUBLISHER_NAME
        )
        INTO publisher_rec
        FROM PUBLISHERS
        WHERE PUBLISHER_ID = in_publisher_id
        ;
        RETURN publisher_rec;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN BEGIN
            RAISE_APPLICATION_ERROR(-20000, 'Invalid publisher id');
        END;
    END GET_PUBLISHER_BY_ID;
    
---------- GET PUBLISHERS BY NAME FUNCTION ----------
    FUNCTION GET_PUBLISHERS_BY_NAME(
        in_publisher_name PUBLISHERS.PUBLISHER_NAME%TYPE
    )
    RETURN PUBLISHER_RECORD_TABLE
    IS
        founded_publishers PUBLISHER_RECORD_TABLE;
    BEGIN
        SELECT GET_PUBLISHER_BY_ID(PUBLISHER_ID)
        BULK COLLECT INTO founded_publishers
        FROM PUBLISHERS
        WHERE LOWER(PUBLISHER_NAME) LIKE '%' || LOWER(in_publisher_name) || '%'
        ;
        RETURN founded_publishers;
    END GET_PUBLISHERS_BY_NAME;

---------- GET GAME BY ID FUNCTION ----------
    FUNCTION GET_GAME_BY_ID(
        in_game_id GAMES.GAME_ID%TYPE
    )
    RETURN GAME_RECORD
    IS
        game_rec GAME_RECORD;
    BEGIN
        SELECT GAME_RECORD(
            GAME_ID,
            GAME_TITLE,
            GAME_PRICE,
            GAME_SCORE,
            GAME_AGE_LIMIT,
            GAME_RELEASE_DATE,
            GAME_DESCRIPTION,
            GAME_POSTER,
            GAME_COVER
        )
        INTO game_rec
        FROM GAMES
        WHERE GAME_ID = in_game_id
        ;
        RETURN game_rec;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN BEGIN
            RAISE_APPLICATION_ERROR(-20000, 'Invalid game id');
        END;
    END GET_GAME_BY_ID;

---------- GET GAME GENRES BY ID FUNCTION ----------    
    FUNCTION GET_GAME_GENRES_BY_ID(
        in_game_id GAMES.GAME_ID%TYPE
    )
    RETURN GENRE_RECORD_TABLE
    IS
        game_genres GENRE_RECORD_TABLE;
    BEGIN
        SELECT GET_GENRE_BY_ID(GENRE_ID)
        BULK COLLECT INTO game_genres
        FROM GMS_GNRS
        WHERE GAME_ID = in_game_id
        ;
        RETURN game_genres;
    END GET_GAME_GENRES_BY_ID;

---------- GET GAME DEVELOPERS BY ID FUNCTION ----------
    FUNCTION GET_GAME_DEVELOPERS_BY_ID(
        in_game_id GAMES.GAME_ID%TYPE
    )
    RETURN DEVELOPER_RECORD_TABLE
    IS
        game_developers DEVELOPER_RECORD_TABLE;
    BEGIN
        SELECT GET_DEVELOPER_BY_ID(DEVELOPER_ID)
        BULK COLLECT INTO game_developers
        FROM GMS_DVLS
        WHERE GAME_ID = in_game_id
        ;
        RETURN game_developers;
    END GET_GAME_DEVELOPERS_BY_ID;

---------- GET GAME PUBLISHERS BY ID FUNCTION ----------
    FUNCTION GET_GAME_PUBLISHERS_BY_ID(
        in_game_id GAMES.GAME_ID%TYPE
    )
    RETURN PUBLISHER_RECORD_TABLE
    IS
        game_publishers PUBLISHER_RECORD_TABLE;
    BEGIN
        SELECT GET_PUBLISHER_BY_ID(PUBLISHER_ID)
        BULK COLLECT INTO game_publishers
        FROM GMS_PBLS
        WHERE GAME_ID = in_game_id
        ;
        RETURN game_publishers;
    END GET_GAME_PUBLISHERS_BY_ID;

---------- GET GAMES BY TITLE FUNCTION ----------
    FUNCTION GET_GAMES_BY_TITLE(
        in_game_title GAMES.GAME_TITLE%TYPE
    )
    RETURN GAME_RECORD_TABLE
    IS
        founded_games GAME_RECORD_TABLE;
    BEGIN
        SELECT GET_GAME_BY_ID(GAME_ID)
        BULK COLLECT INTO founded_games
        FROM GAMES
        WHERE LOWER(GAME_TITLE) LIKE '%' || LOWER(in_game_title) || '%'
        ;
        RETURN founded_games;
    END GET_GAMES_BY_TITLE;

---------- GET GAMES BY GENRE ID FUNCTION ----------
    FUNCTION GET_GAMES_BY_GENRE_ID(
        in_genre_id GENRES.GENRE_ID%TYPE
    )
    RETURN GAME_RECORD_TABLE
    IS
        founded_games GAME_RECORD_TABLE;
    BEGIN
        SELECT GET_GAME_BY_ID(GAME_ID)
        BULK COLLECT INTO founded_games
        FROM GMS_GNRS
        WHERE GENRE_ID = in_genre_id
        ;
        RETURN founded_games;
    END GET_GAMES_BY_GENRE_ID;
    
---------- GET GAMES BY DEVELOPER ID FUNCTION ----------
    FUNCTION GET_GAMES_BY_DEVELOPER_ID(
        in_developer_id DEVELOPERS.DEVELOPER_ID%TYPE
    )
    RETURN GAME_RECORD_TABLE
    IS
        founded_games GAME_RECORD_TABLE;
    BEGIN
        SELECT GET_GAME_BY_ID(GAME_ID)
        BULK COLLECT INTO founded_games
        FROM GMS_DVLS
        WHERE DEVELOPER_ID = in_developer_id
        ;
        RETURN founded_games;
    END GET_GAMES_BY_DEVELOPER_ID;

---------- GET GAMES BY DEVELOPER ID FUNCTION ----------
    FUNCTION GET_GAMES_BY_PUBLISHER_ID(
        in_publisher_id PUBLISHERS.PUBLISHER_ID%TYPE
    )
    RETURN GAME_RECORD_TABLE
    IS
        founded_games GAME_RECORD_TABLE;
    BEGIN
        SELECT GET_GAME_BY_ID(GAME_ID)
        BULK COLLECT INTO founded_games
        FROM GMS_PBLS
        WHERE PUBLISHER_ID = in_publisher_id
        ;
        RETURN founded_games;
    END GET_GAMES_BY_PUBLISHER_ID;
    
---------- GET GAME AVERANGE USER RATING FUNCTION ----------    
    FUNCTION GET_GAME_AVERANGE_USER_RATING(
        in_game_id GAMES.GAME_ID%TYPE
    )
    RETURN NUMBER
    IS
        out_game_averange_user_rating NUMBER;
    BEGIN
        SELECT AVG(RATING)
        INTO out_game_averange_user_rating
        FROM RATINGS
        WHERE GAME_ID = in_game_id
        ;
        RETURN out_game_averange_user_rating;
    END GET_GAME_AVERANGE_USER_RATING;
END GAMES_VIEW_UTILS;
/

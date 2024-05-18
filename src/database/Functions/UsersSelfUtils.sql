---------- EXECUTE AS DEVELOPER ----------


---------- USERS SELF UTILS PACKAGE SPECIFICATION ----------
CREATE OR REPLACE PACKAGE USERS_SELF_UTILS IS
    PROCEDURE REGISTER(
        in_name USERS.USER_NAME%TYPE,
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    );
    
    PROCEDURE LOGIN(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    );
    
    PROCEDURE DELETE_ACCOUNT(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    );
    
    PROCEDURE UPDATE_NAME(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_new_name NVARCHAR2
    );
    
    PROCEDURE UPDATE_PASSWORD(
        in_email USERS.USER_EMAIL%TYPE,
        in_old_password NVARCHAR2,
        in_new_password NVARCHAR2
    );
    
    PROCEDURE ADD_TO_WISHLIST(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    );
    
    PROCEDURE REMOVE_FROM_WISHLIST(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    );
    
    PROCEDURE ADD_TO_CART(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    );
    
    PROCEDURE REMOVE_FROM_CART(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    );
    
    PROCEDURE CLEAR_CART(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    );
    
    PROCEDURE BUY_GAME(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    );
    
    PROCEDURE ADD_TO_FAVORITE(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    );

    PROCEDURE REMOVE_FROM_FAVORITE(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    );
    
    PROCEDURE RATE_GAME(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE,
        in_rating RATINGS.RATING%TYPE
    );

    PROCEDURE UPDATE_GAME_RATING(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE,
        in_new_rating RATINGS.RATING%TYPE
    );

    PROCEDURE DELETE_GAME_RATING(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    );

    FUNCTION GET_USER_INFO(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    )
    RETURN USER_RECORD;
    
    FUNCTION GET_WISHLIST(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    )
    RETURN GAME_RECORD_TABLE;
    
    FUNCTION GET_CART(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    )
    RETURN GAME_RECORD_TABLE;
    
    FUNCTION GET_LIBRARY(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    )
    RETURN GAME_RECORD_TABLE;
    
    FUNCTION GET_FAVORITE(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    )
    RETURN GAME_RECORD_TABLE;

    FUNCTION GET_GAME_RATING(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    )
    RETURN RATINGS.RATING%TYPE;
END USERS_SELF_UTILS;
/


---------- USERS SELF UTILS PACKAGE BODY ----------
CREATE OR REPLACE PACKAGE BODY USERS_SELF_UTILS IS
---------- REGISTER PROCEDURE ----------
    PROCEDURE REGISTER(
        in_name USERS.USER_NAME%TYPE,
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    )
    IS
    BEGIN
        INSERT INTO USERS(USER_NAME, USER_EMAIL, USER_PASSWORD, USER_ROLE_ID)
        VALUES (in_name, in_email, GET_HASH(in_password), 1)
        ;
    END REGISTER;

---------- LOGIN PROCEDURE ----------
    PROCEDURE LOGIN(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    )
    IS
        user_id USERS.USER_ID%TYPE;
    BEGIN
        SELECT USER_ID
        INTO user_id
        FROM USERS
        WHERE
            USER_EMAIL = in_email
            AND USER_PASSWORD = GET_HASH(in_password)
        ;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN BEGIN
            RAISE_APPLICATION_ERROR(-20000, 'Invalid email or password');
        END;
    END LOGIN;

---------- DELETE ACCOUNT PROCEDURE ----------
    PROCEDURE DELETE_ACCOUNT(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    )
    IS
        delete_user USER_RECORD;
    BEGIN
        delete_user := GET_USER_INFO(in_email, in_password);
        DELETE FROM USERS
        WHERE USER_ID = delete_user.ID
        ;
    END DELETE_ACCOUNT;

---------- UPDATE NAME PROCEDURE ----------
    PROCEDURE UPDATE_NAME(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_new_name NVARCHAR2
    )
    IS
        update_user USER_RECORD;
    BEGIN
        update_user := GET_USER_INFO(in_email, in_password);
        UPDATE USERS
        SET USER_NAME = in_new_name
        WHERE USER_ID = update_user.ID
        ;
    END UPDATE_NAME;

---------- UPDATE PASSWORD PROCEDURE ----------
    PROCEDURE UPDATE_PASSWORD(
        in_email USERS.USER_EMAIL%TYPE,
        in_old_password NVARCHAR2,
        in_new_password NVARCHAR2
    )
    IS
        update_user USER_RECORD;
    BEGIN
        update_user := GET_USER_INFO(in_email, in_old_password);
        UPDATE USERS
        SET USER_PASSWORD = GET_HASH(in_new_password)
        WHERE USER_ID = update_user.ID
        ;
    END UPDATE_PASSWORD;

---------- ADD TO WISHLIST PROCEDURE ---------- 
    PROCEDURE ADD_TO_WISHLIST(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    )
    IS
        update_user USER_RECORD;
    BEGIN
        update_user := GET_USER_INFO(in_email, in_password);
        INSERT INTO WISHLISTS(USER_ID, GAME_ID)
        VALUES (update_user.ID, in_game_id)
        ;
    END ADD_TO_WISHLIST;

---------- REMOVE FROM WISHLIST PROCEDURE ---------- 
    PROCEDURE REMOVE_FROM_WISHLIST(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    )
    IS
        update_user USER_RECORD;
    BEGIN
        update_user := GET_USER_INFO(in_email, in_password);
        DELETE FROM WISHLISTS
        WHERE
            USER_ID = update_user.ID
            AND GAME_ID = in_game_id
        ;
    END REMOVE_FROM_WISHLIST;

---------- ADD TO CART PROCEDURE ---------- 
    PROCEDURE ADD_TO_CART(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    )
    IS
        update_user USER_RECORD;
    BEGIN
        update_user := GET_USER_INFO(in_email, in_password);
        INSERT INTO CARTS(USER_ID, GAME_ID)
        VALUES (update_user.ID, in_game_id)
        ;
    END ADD_TO_CART;

---------- REMOVE FROM CART PROCEDURE ---------- 
    PROCEDURE REMOVE_FROM_CART(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    )
    IS
        update_user USER_RECORD;
    BEGIN
        update_user := GET_USER_INFO(in_email, in_password);
        DELETE FROM CARTS
        WHERE
            USER_ID = update_user.ID
            AND GAME_ID = in_game_id
        ;
    END REMOVE_FROM_CART;

---------- CLEAR CART PROCEDURE ----------     
    PROCEDURE CLEAR_CART(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    )
    IS
        update_user USER_RECORD;
    BEGIN
        update_user := GET_USER_INFO(in_email, in_password);
        DELETE FROM CARTS
        WHERE USER_ID = update_user.ID
        ;
    END CLEAR_CART;

---------- BUY GAME PROCEDURE ----------  
    PROCEDURE BUY_GAME(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    )
    IS
        update_user USER_RECORD;
    BEGIN
        update_user := GET_USER_INFO(in_email, in_password);
        INSERT INTO LIBRARIES(USER_ID, GAME_ID, FAVORITE)
        VALUES (update_user.ID, in_game_id, 'N')
        ;
        REMOVE_FROM_WISHLIST(in_email, in_password, in_game_id);
        REMOVE_FROM_CART(in_email, in_password, in_game_id);
    END BUY_GAME;
    
---------- ADD TO FAVORITE PROCEDURE ----------      
    PROCEDURE ADD_TO_FAVORITE(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    )
    IS
        update_user USER_RECORD;
    BEGIN
        update_user := GET_USER_INFO(in_email, in_password);
        UPDATE LIBRARIES
        SET FAVORITE = 'Y'
        WHERE
            USER_ID = update_user.ID
            AND GAME_ID = in_game_id
        ;
    END ADD_TO_FAVORITE;

---------- REMOVE FROM FAVORITE PROCEDURE ----------      
    PROCEDURE REMOVE_FROM_FAVORITE(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    )
    IS
        update_user USER_RECORD;
    BEGIN
        update_user := GET_USER_INFO(in_email, in_password);
        UPDATE LIBRARIES
        SET FAVORITE = 'N'
        WHERE
            USER_ID = update_user.ID
            AND GAME_ID = in_game_id
        ;
    END REMOVE_FROM_FAVORITE;
    
---------- RATE GAME PROCEDURE ----------  
    PROCEDURE RATE_GAME(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE,
        in_rating RATINGS.RATING%TYPE
    )
    IS
        update_user USER_RECORD;
    BEGIN
        update_user := GET_USER_INFO(in_email, in_password);
        INSERT INTO RATINGS(USER_ID, GAME_ID, RATING)
        VALUES (update_user.ID, in_game_id, in_rating)
        ;
    END RATE_GAME;

---------- UPDATE GAME RATING PROCEDURE ----------
    PROCEDURE UPDATE_GAME_RATING(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE,
        in_new_rating RATINGS.RATING%TYPE
    )
    IS
        update_user USER_RECORD;
    BEGIN
        update_user := GET_USER_INFO(in_email, in_password);
        UPDATE RATINGS
        SET RATING = in_new_rating
        WHERE
            USER_ID = update_user.ID
            AND GAME_ID = in_game_id
        ;
    END UPDATE_GAME_RATING;

---------- DELETE GAME RATING PROCEDURE ----------
    PROCEDURE DELETE_GAME_RATING(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    )
    IS
        update_user USER_RECORD;
    BEGIN
        update_user := GET_USER_INFO(in_email, in_password);
        DELETE FROM RATINGS
        WHERE
            USER_ID = update_user.ID
            AND GAME_ID = in_game_id
        ;
    END DELETE_GAME_RATING;
    
---------- GET USER INFO FUNCTION ----------
    FUNCTION GET_USER_INFO(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    )
    RETURN USER_RECORD
    IS
        out_user_record USER_RECORD;
    BEGIN
        LOGIN(in_email, in_password);
        SELECT USER_RECORD(
            USER_ID,
            USER_NAME,
            USER_EMAIL,
            USER_ROLE_ID,
            USER_AVATAR
        )
        INTO out_user_record
        FROM USERS
        WHERE
            USER_EMAIL = in_email
            AND USER_PASSWORD = GET_HASH(in_password)
        ;
        RETURN out_user_record;
    END GET_USER_INFO;

---------- GET WISHLIST FUNCTION ----------
    FUNCTION GET_WISHLIST(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    )
    RETURN GAME_RECORD_TABLE
    IS
        cur_user USER_RECORD;
        wishlist_games GAME_RECORD_TABLE;
    BEGIN
        cur_user := GET_USER_INFO(in_email, in_password);
        SELECT GAMES_VIEW_UTILS.GET_GAME_BY_ID(GAME_ID)
        BULK COLLECT INTO wishlist_games
        FROM WISHLISTS
        WHERE USER_ID = cur_user.ID
        ;
        RETURN wishlist_games;
    END GET_WISHLIST;

---------- GET CART FUNCTION ----------    
    FUNCTION GET_CART(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    )
    RETURN GAME_RECORD_TABLE
    IS
        cur_user USER_RECORD;
        cart_games GAME_RECORD_TABLE;
    BEGIN
        cur_user := GET_USER_INFO(in_email, in_password);
        SELECT GAMES_VIEW_UTILS.GET_GAME_BY_ID(GAME_ID)
        BULK COLLECT INTO cart_games
        FROM CARTS
        WHERE USER_ID = cur_user.ID
        ;
        RETURN cart_games;
    END GET_CART;
    
---------- GET LIBRARY FUNCTION ----------    
    FUNCTION GET_LIBRARY(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    )
    RETURN GAME_RECORD_TABLE
    IS
        cur_user USER_RECORD;
        library_games GAME_RECORD_TABLE;
    BEGIN
        cur_user := GET_USER_INFO(in_email, in_password);
        SELECT GAMES_VIEW_UTILS.GET_GAME_BY_ID(GAME_ID)
        BULK COLLECT INTO library_games
        FROM LIBRARIES
        WHERE USER_ID = cur_user.ID
        ;
        RETURN library_games;
    END GET_LIBRARY;
    
---------- GET FAVORITE FUNCTION ----------      
    FUNCTION GET_FAVORITE(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2
    )
    RETURN GAME_RECORD_TABLE
    IS
        cur_user USER_RECORD;
        library_games GAME_RECORD_TABLE;
    BEGIN
        cur_user := GET_USER_INFO(in_email, in_password);
        SELECT GAMES_VIEW_UTILS.GET_GAME_BY_ID(GAME_ID)
        BULK COLLECT INTO library_games
        FROM LIBRARIES
        WHERE
            USER_ID = cur_user.ID
            AND FAVORITE = 'Y'
        ;
        RETURN library_games;
    END GET_FAVORITE;

---------- GET GAME RATING FUNCTION ----------
    FUNCTION GET_GAME_RATING(
        in_email USERS.USER_EMAIL%TYPE,
        in_password NVARCHAR2,
        in_game_id GAMES.GAME_ID%TYPE
    )
    RETURN RATINGS.RATING%TYPE
    IS
        cur_user USER_RECORD;
        out_game_rating RATINGS.RATING%TYPE;
    BEGIN
        cur_user := GET_USER_INFO(in_email, in_password);
        SELECT RATING
        INTO out_game_rating
        FROM RATINGS
        WHERE
            USER_ID = cur_user.ID
            AND GAME_ID = in_game_id
        ;
        RETURN out_game_rating;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN BEGIN
            RAISE_APPLICATION_ERROR(-20000, 'No rating for this game');
        END;
    END GET_GAME_RATING;
END USERS_SELF_UTILS;
/

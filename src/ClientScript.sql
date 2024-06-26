---------- EXECUTE AS CLIENT ----------


EXECUTE USERS_SELF_UTILS.REGISTER('Nikita', 'nik@email.ru', 'pwd');

EXECUTE USERS_SELF_UTILS.LOGIN('nik@email.ru', 'pwd');

SELECT * FROM TABLE(GAMES_VIEW_UTILS.GET_GAMES_BY_TITLE('game'));

SELECT * FROM TABLE(GAMES_VIEW_UTILS.GET_GENRES_BY_NAME('Act'));

SELECT * FROM TABLE(GAMES_VIEW_UTILS.GET_GAMES_BY_GENRE_ID(1));

SELECT * FROM TABLE(GAMES_VIEW_UTILS.GET_GAME_GENRES_BY_ID(1));

EXECUTE USERS_SELF_UTILS.ADD_TO_CART('nik@email.ru', 'pwd', 3);

EXECUTE USERS_SELF_UTILS.ADD_TO_WISHLIST('nik@email.ru', 'pwd', 2);

EXECUTE USERS_SELF_UTILS.BUY_GAME('nik@email.ru', 'pwd', 1);

EXECUTE USERS_SELF_UTILS.ADD_TO_FAVORITE('nik@email.ru', 'pwd', 1);

EXECUTE USERS_SELF_UTILS.RATE_GAME('nik@email.ru', 'pwd', 1, 10);

SELECT * FROM TABLE(USERS_SELF_UTILS.GET_WISHLIST('nik@email.ru', 'pwd'));

SELECT * FROM TABLE(USERS_SELF_UTILS.GET_CART('nik@email.ru', 'pwd'));

SELECT * FROM TABLE(USERS_SELF_UTILS.GET_LIBRARY('nik@email.ru', 'pwd'));

SELECT * FROM TABLE(USERS_SELF_UTILS.GET_FAVORITE('nik@email.ru', 'pwd'));

SELECT USERS_SELF_UTILS.GET_GAME_RATING('nik@email.ru', 'pwd', 1) FROM DUAL;

SELECT GAMES_VIEW_UTILS.GET_GAME_AVERANGE_USER_RATING(1) FROM DUAL;

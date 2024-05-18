---------- EXECUTE AS DEVELOPER ----------


---------- INSERT 100K GAMES PROCEDURE ----------
CREATE OR REPLACE PROCEDURE INSERT_100K_GAMES
IS
BEGIN
    FOR i IN 0..100000 LOOP
        GAMES_MANAGEMENT_UTILS.CREATE_GAME(
            '100K Test Game #' || i,
            (1.67 * i + 1.9),
            MOD(10 * i + i, 100),
            21,
            TO_DATE('01.01.1978', 'DD.MM.YYYY') + numtodsinterval(i*4, 'hour'),
            '100K Test Game #' || i || ' Full Long Description'
        );
    END LOOP;
END INSERT_100K_GAMES;

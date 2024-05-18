---------- EXECUTE AS DEVELOPER ----------


---------- ROLES MANAGEMENT UTILS PACKAGE SPECIFICATION ----------
CREATE OR REPLACE PACKAGE ROLES_MANAGEMENT_UTILS IS
    PROCEDURE CREATE_ROLE(
        in_name ROLES.ROLE_NAME%TYPE
    );
    
    PROCEDURE UPDATE_ROLE(
        in_role_id ROLES.ROLE_ID%TYPE,
        in_new_name ROLES.ROLE_NAME%TYPE
    );
    
    PROCEDURE DELETE_ROLE(
        in_role_id ROLES.ROLE_ID%TYPE
    );
END ROLES_MANAGEMENT_UTILS;
/


---------- ROLES MANAGEMENT UTILS PACKAGE BODY ----------
CREATE OR REPLACE PACKAGE BODY ROLES_MANAGEMENT_UTILS IS
---------- CREATE ROLE PROCEDURE ----------
    PROCEDURE CREATE_ROLE(
        in_name ROLES.ROLE_NAME%TYPE
    )
    IS
    BEGIN
        INSERT INTO ROLES(ROLE_NAME)
        VALUES (in_name)
        ;
    END CREATE_ROLE;

---------- UPDATE ROLE PROCEDURE ----------
    PROCEDURE UPDATE_ROLE(
        in_role_id ROLES.ROLE_ID%TYPE,
        in_new_name ROLES.ROLE_NAME%TYPE
    )
    IS
    BEGIN
        UPDATE ROLES
        SET ROLE_NAME = in_new_name
        WHERE ROLE_ID = in_role_id
        ;
    END UPDATE_ROLE;

---------- DELETE ROLE PROCEDURE ----------
    PROCEDURE DELETE_ROLE(
        in_role_id ROLES.ROLE_ID%TYPE
    )
    IS
    BEGIN
        DELETE FROM ROLES
        WHERE ROLE_ID = in_role_id
        ;
    END;
END ROLES_MANAGEMENT_UTILS;
/

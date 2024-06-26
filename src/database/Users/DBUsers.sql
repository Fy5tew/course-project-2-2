---------- EXECUTE AS DEVELOPER ----------


---------- ROLES ----------

---------- VIEW ACCESS ROLE ----------
CREATE ROLE VIEW_ACCESS_ROLE;
GRANT SELECT ON V_ROLES TO VIEW_ACCESS_ROLE;
GRANT SELECT ON V_USERS TO VIEW_ACCESS_ROLE;
GRANT SELECT ON V_GENRES TO VIEW_ACCESS_ROLE;
GRANT SELECT ON V_DEVELOPERS TO VIEW_ACCESS_ROLE;
GRANT SELECT ON V_PUBLISHERS TO VIEW_ACCESS_ROLE;
GRANT SELECT ON V_GAMES TO VIEW_ACCESS_ROLE;
GRANT SELECT ON V_SCREENSHOTS TO VIEW_ACCESS_ROLE;
GRANT SELECT ON V_GMS_GNRS TO VIEW_ACCESS_ROLE;
GRANT SELECT ON V_GMS_DVLS TO VIEW_ACCESS_ROLE;
GRANT SELECT ON V_GMS_PBLS TO VIEW_ACCESS_ROLE;
GRANT SELECT ON V_WISHLISTS TO VIEW_ACCESS_ROLE;
GRANT SELECT ON V_CARTS TO VIEW_ACCESS_ROLE;
GRANT SELECT ON V_LIBRARIES TO VIEW_ACCESS_ROLE;
GRANT SELECT ON V_RATINGS TO VIEW_ACCESS_ROLE;

---------- PUBLISHER ROLE ----------
CREATE ROLE PUBLISHER_ROLE;
GRANT
    CONNECT
TO PUBLISHER_ROLE;
GRANT EXECUTE ON USERS_SELF_UTILS TO PUBLISHER_ROLE;
GRANT EXECUTE ON GAMES_VIEW_UTILS TO PUBLISHER_ROLE;
GRANT EXECUTE ON GAMES_MANAGEMENT_UTILS TO PUBLISHER_ROLE;

---------- CLIENT ROLE ----------
CREATE ROLE CLIENT_ROLE;
GRANT
    CONNECT
TO CLIENT_ROLE;
GRANT EXECUTE ON USERS_SELF_UTILS TO CLIENT_ROLE;
GRANT EXECUTE ON GAMES_VIEW_UTILS TO CLIENT_ROLE;


---------- USERS ----------

---------- PUBLISHER USER ----------
CREATE USER PUBLISHER
IDENTIFIED BY F5STOREDBPublisher
;
GRANT VIEW_ACCESS_ROLE TO PUBLISHER;
GRANT PUBLISHER_ROLE TO PUBLISHER;

---------- CLIENT USER ----------
CREATE USER CLIENT
IDENTIFIED BY F5STOREDBClient
;
GRANT CLIENT_ROLE TO CLIENT;
GRANT VIEW_ACCESS_ROLE TO CLIENT;

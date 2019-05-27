/********************************************************
  CREATE NEW USER
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_create_user (
  IN _en_name                 VARCHAR(100),
  IN _duty                    VARCHAR(255),
  IN _position_uuid           VARCHAR(50),
  IN _employment_status_uuid  VARCHAR(50),
  IN _team_uuid               VARCHAR(50),
  IN _first_manager_uuid      VARCHAR(50),
  IN _second_manager_uuid     VARCHAR(50),
  OUT action_code             VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  positionId          INTEGER;
  employmentStatusId  INTEGER;
  teamId              INTEGER;
  firstManagerId      INTEGER;
  secondManagerId     INTEGER;
  rowCount            INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _en_name = '' OR _en_name IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Name is empty.';
    END IF;

    IF _position_uuid = '' OR _position_uuid IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'Position UUID is empty.';

    ELSE
      SELECT id INTO positionId
      FROM "user".position
      WHERE uuid = _position_uuid;

    END IF;

    IF _employment_status_uuid = '' OR _employment_status_uuid IS NULL THEN
      action_code := '00103';
      RAISE EXCEPTION 'Employment Status UUID is empty.';

    ELSE
      SELECT id INTO employmentStatusId
      FROM "user".employment_status
      WHERE uuid = _employment_status_uuid;

    END IF;

    IF _team_uuid = '' OR _team_uuid IS NULL THEN
      action_code := '00104';
      RAISE EXCEPTION 'Team UUID is empty.';

    ELSE
      SELECT id INTO teamId
      FROM "user".team
      WHERE uuid = _team_uuid;

    END IF;

    IF _first_manager_uuid = '' OR _first_manager_uuid IS NULL THEN
      action_code := '00105';
      RAISE EXCEPTION 'First Manager UUID is empty.';

    ELSE
      SELECT id INTO firstManagerId
      FROM "user".user
      WHERE uuid = _first_manager_uuid;

    END IF;

    IF _second_manager_uuid = '' OR _second_manager_uuid IS NULL THEN
      action_code := '00106';
      RAISE EXCEPTION 'Second Manager UUID is empty.';

    ELSE
      SELECT id INTO secondManagerId
      FROM "user".user
      WHERE uuid = _second_manager_uuid;

    END IF;

    IF positionId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Position UUID is invalid.';
    END IF;

    IF employmentStatusId IS NULL THEN
      action_code := '00202';
      RAISE EXCEPTION 'Employment Status UUID is invalid.';
    END IF;

    IF teamId IS NULL THEN
      action_code := '00203';
      RAISE EXCEPTION 'Team UUID is invalid.';
    END IF;

    IF firstManagerId IS NULL THEN
      action_code := '00204';
      RAISE EXCEPTION 'First Manager UUID is invalid.';
    END IF;

    IF secondManagerId IS NULL THEN
      action_code := '00205';
      RAISE EXCEPTION 'Second Manager UUID is invalid.';
    END IF;


    WITH inserted AS (
      INSERT INTO "user".user(en_name, duty, position, employment_status, first_manager, second_manager, team_id, role)
      VALUES(_en_name, _duty, positionId, employmentStatusId, firstManagerId, secondManagerId, teamId, 'USER')
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM inserted;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'User has been created successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'User has been created unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  FIND INACTIVE USER
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_find_inactive_user (
  IN _en_name                 VARCHAR(100),
  OUT action_code             VARCHAR(10),
  OUT user_uuid               VARCHAR(50)
)
RETURNS RECORD
AS $$
DECLARE
  userStatus                  INTEGER;
BEGIN
  BEGIN
    action_code := '00001';

    IF _en_name = '' OR _en_name IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Name is empty.';

    ELSE
      SELECT status, uuid INTO userStatus, user_uuid
      FROM "user".user
      WHERE en_name = _en_name;

    END IF;

    IF userStatus IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Name is invalid.';
    END IF;

    IF userStatus = '1' THEN
      action_code := '00202';
      RAISE EXCEPTION 'User is already activated.';

    ELSE
      action_code := '00000';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  ACTIVATE NEW USER
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_activate_user (
  IN _username                VARCHAR(50),
  IN _password                VARCHAR(255),
  IN _uuid                    VARCHAR(50),
  OUT action_code             VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  userId                      INTEGER;
  userUsername                VARCHAR(50);
  userStatus                  INTEGER;
  rowCount                    INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _username = '' OR _username IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Username is empty.';

    ELSE
      SELECT username INTO userUsername
      FROM "user".user
      WHERE username = _username;

    END IF;

    IF _password = '' OR _password IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'Password is empty.';
    END IF;

    IF _uuid = '' OR _uuid IS NULL THEN
      action_code := '00103';
      RAISE EXCEPTION 'User UUID is empty.';

    ELSE
      SELECT id, status INTO userId, userStatus
      FROM "user".user
      WHERE uuid = _uuid;

    END IF;

    IF userId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'User UUID is invalid.';
    END IF;

    IF userStatus = '1' THEN
      action_code := '00202';
      RAISE EXCEPTION 'User is already activated.';
    END IF;

    IF userUsername IS NOT NULL THEN
      action_code := '00203';
      RAISE EXCEPTION 'Username is already exist.';
    END IF;

    WITH updated AS (
      UPDATE "user".user SET
        username = _username,
        password = _password,
        status = '1'
      WHERE id = userId
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM updated;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'User has been activated successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'User has been activated unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  FORGET PASSWORD
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_forget_password (
  IN _username                VARCHAR(50),
  OUT action_code             VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  userId                      INTEGER;
  rowCount                    INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _username = '' OR _username IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Username is empty.';

    ELSE
      SELECT id INTO userId
      FROM "user".user
      WHERE username = _username;

    END IF;

    IF userId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Username does not exist.';
    END IF;

    WITH updated AS (
      UPDATE "user".user SET
        password = 'WE_GARDEN_TEMP_PWD'
      WHERE id = userId
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM updated;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'User Password has been reset successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'User Password has been reset unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  CHANGE PASSWORD
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_change_password (
  IN _username                VARCHAR(50),
  IN _old_password            VARCHAR(255),
  IN _new_password            VARCHAR(255),
  OUT action_code             VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  userId                      INTEGER;
  oldPassword                 VARCHAR(255);
  rowCount                    INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _username = '' OR _username IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Username is empty.';

    ELSE
      SELECT id, password INTO userId, oldPassword
      FROM "user".user
      WHERE username = _username;

    END IF;

    IF _old_password = '' OR _old_password IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'Old Password is empty.';
    END IF;

    IF _new_password = '' OR _new_password IS NULL THEN
      action_code := '00103';
      RAISE EXCEPTION 'New Password is empty.';
    END IF;

    IF userId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Username does not exist.';
    END IF;

    IF oldPassword != _old_password THEN
      action_code := '00202';
      RAISE EXCEPTION 'Old Passwords do not match with each other.';
    END IF;

    IF _new_password = _old_password THEN
      action_code := '00203';
      RAISE EXCEPTION 'Old & New Passwords cannot be the same.';
    END IF;


    WITH updated AS (
      UPDATE "user".user SET
        password = _new_password
      WHERE id = userId
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM updated;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'User Password has been changed successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'User Password has been changed unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  LOGIN
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_login (
  IN _username                VARCHAR(50),
  IN _password                VARCHAR(255),
  IN _device_token            VARCHAR(255)
)
RETURNS TABLE(
  "user_uuid"           VARCHAR(50),
  "user_en_name"        VARCHAR(100),
  "user_kh_name"        VARCHAR(100),
  "user_kr_name"        VARCHAR(100),
  "user_duty"           VARCHAR(255),
  "user_gender"         VARCHAR(1),
  "user_dob"            DATE,
  "user_phone_number"   VARCHAR(50),
  "user_image"          VARCHAR(110),
  "user_username"       VARCHAR(50),
  "user_email"          VARCHAR(255),
  "user_role"           VARCHAR(255),
  "user_token"          VARCHAR(255),
  "user_created_date"   TIMESTAMP,
  "user_emplyment_status"         VARCHAR(50),
  "user_status"         VARCHAR(1),
  "position"            VARCHAR(100),
  "position_type"       VARCHAR(100),
  "position_uuid"       VARCHAR(50),
  "team_uuid"           VARCHAR(50),
  "team_name"           VARCHAR(100),
  "team_remark"         VARCHAR(100),
  "team_status"         VARCHAR(100),
  "department_uuid"     VARCHAR(50),
  "department_name"     VARCHAR(100),
  "department_remark"   VARCHAR(100),
  "department_status"   VARCHAR(100)
)
AS $$
BEGIN
  UPDATE "user".user u SET
    token = _device_token
  WHERE u.username = _username AND u.password = _password;

  RETURN QUERY
  SELECT
    COALESCE(u.uuid, ''),
    COALESCE(u.en_name, ''),
    COALESCE(u.kh_name, ''),
    COALESCE(u.kr_name, ''),
    COALESCE(u.duty, ''),
    COALESCE(u.gender, ''),
    u.dob,
    COALESCE(u.phone_number, ''),
    COALESCE((
      SELECT CONCAT(image.name, image.type)
      FROM "user".image
      WHERE image.id = u.image_id
    ) :: VARCHAR(110), ''),
    COALESCE(u.username, ''),
    COALESCE(u.email, ''),
    COALESCE(u.role, ''),
    COALESCE(u.token, ''),
    u.created_date,
    COALESCE("employment_status".status, ''),
    COALESCE(u.status, ''),
    COALESCE(p.position, ''),
    COALESCE(p.type, ''),
    COALESCE(p.uuid, ''),
    COALESCE(team.uuid, ''),
    COALESCE(team.name, ''),
    COALESCE(team.remark, ''),
    COALESCE(team.status, ''),
    COALESCE(department.uuid, ''),
    COALESCE(department.name, ''),
    COALESCE(department.remark, ''),
    COALESCE(department.status, '')

  FROM "user".user u
  LEFT JOIN "user".team
    ON u.team_id = team.id
  LEFT JOIN "user".department
    ON "team".department_id = department.id
  INNER JOIN "user".employment_status
    ON u.employment_status = employment_status.id
  INNER JOIN "user".position p
    ON u.position = p.id
  WHERE u.username = _username AND u.password = _password;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  GET ALL USERS
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_read_users (
  _en_name  VARCHAR(100),
  _status   VARCHAR(1),
  _page     INTEGER,
  _limit    INTEGER
)
  RETURNS TABLE(
    "user_uuid"           VARCHAR(50),
    "user_en_name"        VARCHAR(100),
    "user_kh_name"        VARCHAR(100),
    "user_kr_name"        VARCHAR(100),
    "user_duty"           VARCHAR(255),
    "user_gender"         VARCHAR(1),
    "user_dob"            DATE,
    "user_phone_number"   VARCHAR(50),
    "user_image"          VARCHAR(110),
    "user_credit_balance" DOUBLE PRECISION,
    "user_username"       VARCHAR(50),
    "user_email"          VARCHAR(255),
    "user_role"           VARCHAR(255),
    "user_token"          VARCHAR(255),
    "user_created_date"   TIMESTAMP,
    "user_emplyment_status"         VARCHAR(50),
    "user_status"         VARCHAR(1),
    "position"            VARCHAR(100),
    "position_type"       VARCHAR(100),
    "position_uuid"       VARCHAR(50),
    "team_uuid"           VARCHAR(100),
    "team_name"           VARCHAR(100),
    "team_remark"         VARCHAR(100),
    "team_status"         VARCHAR(100),
    "department_uuid"     VARCHAR(100),
    "department_name"     VARCHAR(100),
    "department_remark"   VARCHAR(100),
    "department_status"   VARCHAR(100)
  )
AS $$
BEGIN
  RETURN QUERY
  SELECT
    COALESCE(u.uuid, ''),
    COALESCE(u.en_name, ''),
    COALESCE(u.kh_name, ''),
    COALESCE(u.kr_name, ''),
    COALESCE(u.duty, ''),
    COALESCE(u.gender, ''),
    u.dob,
    COALESCE(u.phone_number, ''),
    COALESCE((
      SELECT CONCAT(image.name, image.type)
      FROM "user".image
      WHERE image.id = u.image_id
    ) :: VARCHAR(110), ''),
    COALESCE(u.credit_balance, 0),
    COALESCE(u.username, ''),
    COALESCE(u.email, ''),
    COALESCE(u.role, ''),
    COALESCE(u.token, ''),
    u.created_date,
    COALESCE("employment_status".status, ''),
    COALESCE(u.status, ''),
    COALESCE(p.position, ''),
    COALESCE(p.type, ''),
    COALESCE(p.uuid, ''),
    COALESCE(team.uuid, ''),
    COALESCE(team.name, ''),
    COALESCE(team.remark, ''),
    COALESCE(team.status, ''),
    COALESCE(department.uuid, ''),
    COALESCE(department.name, ''),
    COALESCE(department.remark, ''),
    COALESCE(department.status, '')

  FROM "user".user u
  LEFT JOIN "user".team
    ON u.team_id = team.id
  LEFT JOIN "user".department
    ON team.department_id = department.id
  INNER JOIN "user".employment_status
    ON u.employment_status = employment_status.id
  INNER JOIN "user".position p
    ON u.position = p.id
  WHERE u.status != (
    SELECT CASE
      WHEN _status = '0' THEN '1'
      WHEN _status = '1' THEN '0'
      ELSE ''
    END
  )
  AND LOWER(u.en_name) LIKE '%' || LOWER(_en_name) || '%'
  ORDER BY department.name, team.name, p.id ASC
  LIMIT _limit
  OFFSET (_page - 1) * _limit;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  GET USERS IN A DEPARTMENT
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_read_users_by_department (
  _en_name          VARCHAR(100),
  _department_uuid  VARCHAR(50),
  _status           VARCHAR(1),
  _page             INTEGER,
  _limit            INTEGER
)
RETURNS TABLE (
  "user_uuid"           VARCHAR(50),
  "user_en_name"        VARCHAR(100),
  "user_kh_name"        VARCHAR(100),
  "user_kr_name"        VARCHAR(100),
  "user_duty"           VARCHAR(255),
  "user_gender"         VARCHAR(1),
  "user_dob"            DATE,
  "user_phone_number"   VARCHAR(50),
  "user_image"          VARCHAR(110),
  "user_credit_balance" DOUBLE PRECISION,
  "user_username"       VARCHAR(50),
  "user_email"          VARCHAR(255),
  "user_role"           VARCHAR(255),
  "user_token"          VARCHAR(255),
  "user_created_date"   TIMESTAMP,
  "user_emplyment_status"         VARCHAR(50),
  "user_status"         VARCHAR(1),
  "position"            VARCHAR(100),
  "position_type"       VARCHAR(100),
  "position_uuid"       VARCHAR(50),
  "team_uuid"           VARCHAR(50),
  "team_name"           VARCHAR(100),
  "team_remark"         VARCHAR(100),
  "team_status"         VARCHAR(100),
  "department_uuid"     VARCHAR(50),
  "department_name"     VARCHAR(100),
  "department_remark"   VARCHAR(100),
  "department_status"   VARCHAR(100)
)
AS $$
DECLARE
  departmentId INTEGER;
BEGIN
  SELECT id INTO departmentId
  FROM "user".department
  WHERE uuid = _department_uuid;

  IF departmentId IS NULL THEN
    RETURN;
  END IF;

  RETURN QUERY
    WITH temp_department AS (
      SELECT id, name, remark, status, uuid
      FROM "user".department
      WHERE department.id = departmentId
    )
    SELECT
      COALESCE(u.uuid, ''),
      COALESCE(u.en_name, ''),
      COALESCE(u.kh_name, ''),
      COALESCE(u.kr_name, ''),
      COALESCE(u.duty, ''),
      COALESCE(u.gender, ''),
      u.dob,
      COALESCE(u.phone_number, ''),
      COALESCE((
        SELECT CONCAT(image.name, image.type)
        FROM "user".image
        WHERE image.id = u.image_id
      ) :: VARCHAR(110), ''),
      COALESCE(u.credit_balance, 0),
      COALESCE(u.username, ''),
      COALESCE(u.email, ''),
      COALESCE(u.role, ''),
      COALESCE(u.token, ''),
      u.created_date,
      COALESCE(employment_status.status, ''),
      COALESCE(u.status, ''),
      COALESCE(p.position, ''),
      COALESCE(p.type, ''),
      COALESCE(p.uuid, ''),
      COALESCE(team.uuid, ''),
      COALESCE(team.name, ''),
      COALESCE(team.remark, ''),
      COALESCE(team.status, ''),
      COALESCE(temp_department.uuid, ''),
      COALESCE(temp_department.name, ''),
      COALESCE(temp_department.remark, ''),
      COALESCE(temp_department.status, '')

    FROM "user".user u
    INNER JOIN "user".team
      ON u.team_id = team.id
    INNER JOIN temp_department
      ON "team".department_id = temp_department.id
    INNER JOIN "user".employment_status
      ON u.employment_status = employment_status.id
    INNER JOIN "user".position p
      ON u.position = p.id
    WHERE u.status != (
      SELECT CASE
        WHEN _status = '0' THEN '1'
        WHEN _status = '1' THEN '0'
        ELSE ''
      END
    )
    AND LOWER(u.en_name) LIKE '%' || LOWER(_en_name) || '%'
    ORDER BY team.name, p.id ASC
    LIMIT _limit
    OFFSET (_page - 1) * _limit;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  GET USERS IN A TEAM
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_read_users_by_team (
  _en_name          VARCHAR(100),
  _team_uuid        VARCHAR(50),
  _status           VARCHAR(1),
  _page             INTEGER,
  _limit            INTEGER
)
RETURNS TABLE (
  "user_uuid"           VARCHAR(50),
  "user_en_name"        VARCHAR(100),
  "user_kh_name"        VARCHAR(100),
  "user_kr_name"        VARCHAR(100),
  "user_duty"           VARCHAR(255),
  "user_gender"         VARCHAR(1),
  "user_dob"            DATE,
  "user_phone_number"   VARCHAR(50),
  "user_image"          VARCHAR(110),
  "user_credit_balance" DOUBLE PRECISION,
  "user_username"       VARCHAR(50),
  "user_email"          VARCHAR(255),
  "user_role"           VARCHAR(255),
  "user_token"          VARCHAR(255),
  "user_created_date"   TIMESTAMP,
  "user_emplyment_status"         VARCHAR(50),
  "user_status"         VARCHAR(1),
  "position"            VARCHAR(100),
  "position_type"       VARCHAR(100),
  "position_uuid"       VARCHAR(50),
  "team_uuid"           VARCHAR(50),
  "team_name"           VARCHAR(100),
  "team_remark"         VARCHAR(100),
  "team_status"         VARCHAR(100),
  "department_uuid"     VARCHAR(50),
  "department_name"     VARCHAR(100),
  "department_remark"   VARCHAR(100),
  "department_status"   VARCHAR(100)
)
AS $$
DECLARE
  teamId INTEGER;
BEGIN
  SELECT id INTO teamId
  FROM "user".team
  WHERE uuid = _team_uuid;

  IF teamId IS NULL THEN
    RETURN;
  END IF;

  RETURN QUERY
    WITH temp_team AS (
      SELECT id, name, remark, status, uuid, department_id
      FROM "user".team
      WHERE team.id = teamId
    )
    SELECT
      COALESCE(u.uuid, ''),
      COALESCE(u.en_name, ''),
      COALESCE(u.kh_name, ''),
      COALESCE(u.kr_name, ''),
      COALESCE(u.duty, ''),
      COALESCE(u.gender, ''),
      u.dob,
      COALESCE(u.phone_number, ''),
      COALESCE((
        SELECT CONCAT(image.name, image.type)
        FROM "user".image
        WHERE image.id = u.image_id
      ) :: VARCHAR(110), ''),
      COALESCE(u.credit_balance, 0),
      COALESCE(u.username, ''),
      COALESCE(u.email, ''),
      COALESCE(u.role, ''),
      COALESCE(u.token, ''),
      u.created_date,
      COALESCE(employment_status.status, ''),
      COALESCE(u.status, ''),
      COALESCE(p.position, ''),
      COALESCE(p.type, ''),
      COALESCE(p.uuid, ''),
      COALESCE(temp_team.uuid, ''),
      COALESCE(temp_team.name, ''),
      COALESCE(temp_team.remark, ''),
      COALESCE(temp_team.status, ''),
      COALESCE(department.uuid, ''),
      COALESCE(department.name, ''),
      COALESCE(department.remark, ''),
      COALESCE(department.status, '')

    FROM "user".user u
    INNER JOIN temp_team
      ON u.team_id = temp_team.id
    INNER JOIN "user".department
      ON temp_team.department_id = department.id
    INNER JOIN "user".employment_status
      ON u.employment_status = employment_status.id
    INNER JOIN "user".position p
      ON u.position = p.id
    WHERE u.status != (
      SELECT CASE
        WHEN _status = '0' THEN '1'
        WHEN _status = '1' THEN '0'
        ELSE ''
      END
    )
    AND LOWER(u.en_name) LIKE '%' || LOWER(_en_name) || '%'
    ORDER BY p.id, u.id ASC
    LIMIT _limit
    OFFSET (_page - 1) * _limit;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  GET USERS BY ROLE(TEAM LEADER, BRONZE MASTER, ADMIN, USER)
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_read_users_by_role (
  _role                 VARCHAR(2),
  _page                 INTEGER,
  _limit                INTEGER
)
RETURNS TABLE (
  "user_uuid"           VARCHAR(50),
  "user_en_name"        VARCHAR(100),
  "user_kh_name"        VARCHAR(100),
  "user_kr_name"        VARCHAR(100),
  "user_duty"           VARCHAR(255),
  "user_gender"         VARCHAR(1),
  "user_dob"            DATE,
  "user_phone_number"   VARCHAR(50),
  "user_image"          VARCHAR(110),
  "user_credit_balance" DOUBLE PRECISION,
  "user_username"       VARCHAR(50),
  "user_email"          VARCHAR(255),
  "user_role"           VARCHAR(255),
  "user_token"          VARCHAR(255),
  "user_created_date"   TIMESTAMP,
  "user_emplyment_status"         VARCHAR(50),
  "user_status"         VARCHAR(1),
  "position"            VARCHAR(100),
  "position_type"       VARCHAR(100),
  "position_uuid"       VARCHAR(50),
  "team_uuid"           VARCHAR(50),
  "team_name"           VARCHAR(100),
  "team_remark"         VARCHAR(100),
  "team_status"         VARCHAR(100),
  "department_uuid"     VARCHAR(50),
  "department_name"     VARCHAR(100),
  "department_remark"   VARCHAR(100),
  "department_status"   VARCHAR(100)
)
AS $$
DECLARE
  roleType VARCHAR(50);
BEGIN
  SELECT role_type INTO roleType
  FROM "user".role_type
  WHERE id::VARCHAR(2) = _role;

  IF roleType IS NULL THEN
    RETURN;
  END IF;

  RETURN QUERY
  SELECT
    COALESCE(u.uuid, ''),
    COALESCE(u.en_name, ''),
    COALESCE(u.kh_name, ''),
    COALESCE(u.kr_name, ''),
    COALESCE(u.duty, ''),
    COALESCE(u.gender, ''),
    u.dob,
    COALESCE(u.phone_number, ''),
    COALESCE((
      SELECT CONCAT(image.name, image.type)
      FROM "user".image
      WHERE image.id = u.image_id
    ) :: VARCHAR(110), ''),
    COALESCE(u.credit_balance, 0),
    COALESCE(u.username, ''),
    COALESCE(u.email, ''),
    COALESCE(u.role, ''),
    COALESCE(u.token, ''),
    u.created_date,
    COALESCE(employment_status.status, ''),
    COALESCE(u.status, ''),
    COALESCE(p.position, ''),
    COALESCE(p.type, ''),
    COALESCE(p.uuid, ''),
    COALESCE(team.uuid, ''),
    COALESCE(team.name, ''),
    COALESCE(team.remark, ''),
    COALESCE(team.status, ''),
    COALESCE(department.uuid, ''),
    COALESCE(department.name, ''),
    COALESCE(department.remark, ''),
    COALESCE(department.status, '')

  FROM "user".user u
  LEFT JOIN "user".team
    ON u.team_id = team.id
  LEFT JOIN "user".department
    ON team.department_id = department.id
  INNER JOIN "user".employment_status
    ON u.employment_status = employment_status.id
  INNER JOIN "user".position p
    ON u.position = p.id
  WHERE u.role LIKE '%' || roleType || '%'
  ORDER BY department.name, team.name, p.id ASC
  LIMIT _limit
  OFFSET (_page - 1) * _limit;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  UPDATE USER BALANCE
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_update_balance (
  IN _user_uuid               VARCHAR(50),
  IN _transaction_type        VARCHAR(1),
  IN _transaction_amount      DOUBLE PRECISION,
  OUT action_code             VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  userId                      INTEGER;
  userBalance                 DOUBLE PRECISION := 0;
  rowCount                    INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _user_uuid = '' OR _user_uuid IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'User UUID is empty.';

    ELSE
      SELECT id, credit_balance INTO userId, userBalance
      FROM "user".user
      WHERE uuid = _user_uuid;

    END IF;

    IF _transaction_type = '' OR _transaction_type IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'Transaction Type is empty.';
    END IF;

    IF _transaction_amount <= 0 OR _transaction_amount IS NULL THEN
      action_code := '00103';
      RAISE EXCEPTION 'Transaction Amount is less than zero.';
    END IF;

    IF userId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'User UUID is invalid.';
    END IF;

    IF _transaction_type != '+' AND _transaction_type != '-' THEN
      action_code := '00202';
      RAISE EXCEPTION 'Transaction Type is invalid.';
    END IF;

    IF _transaction_type = '-' AND _transaction_amount > userBalance THEN
      action_code := '00301';
      RAISE EXCEPTION 'User does not have enough balance.';
    END IF;

    IF _transaction_type = '+' THEN
      userBalance := userBalance + _transaction_amount;

    ELSEIF _transaction_type = '-' THEN
      userBalance := userBalance - _transaction_amount;

    END IF;


    WITH updated AS (
      UPDATE "user".user SET
        credit_balance = userBalance
      WHERE id = userId
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM updated;

    IF rowCount = 1 THEN
      IF _transaction_type = '+' THEN
        WITH inserted AS (
          INSERT INTO "user".top_up(amount, user_id)
          VALUES (_transaction_amount, userId)
          RETURNING 1 AS result
        )
        SELECT result INTO rowCount
        FROM inserted;

        IF rowCount = 1 THEN
          action_code := '00000';
          RAISE NOTICE 'User Balance has been updated successfully.';
        END IF;

      ELSE
        action_code := '00000';
        RAISE NOTICE 'User Balance has been updated successfully.';
      END IF;
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'User Balance has been updated unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  UPDATE USER INFO (USER)
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_update_user_info (
  IN _en_name           VARCHAR(100),
  IN _kh_name           VARCHAR(100),
  IN _kr_name           VARCHAR(100),
  IN _gender            VARCHAR(1),
  IN _dob               VARCHAR(10),
  IN _phone_number      VARCHAR(50),
  IN _email             VARCHAR(255),
  IN _uuid              VARCHAR(50),
  OUT action_code       VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  userId      INTEGER;
  userDOB     DATE;
  rowCount    INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _en_name = '' OR _en_name IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'User English name is empty.';
    END IF;

    IF _kh_name IS NOT NULL AND _kh_name = '' THEN
      action_code := '00102';
      RAISE EXCEPTION 'User Khmer name is empty.';
    END IF;

    IF _kr_name IS NOT NULL AND _kr_name = '' THEN
      action_code := '00103';
      RAISE EXCEPTION 'User Korean name is empty.';
    END IF;

    IF _gender IS NOT NULL AND _gender = '' THEN
      action_code := '00104';
      RAISE EXCEPTION 'User Gender is empty.';

    ELSE
      IF _gender != 'M' AND _gender != 'F' THEN
        action_code := '00201';
        RAISE EXCEPTION 'User Gender is invalid.';
      END IF;
    END IF;

    IF _dob IS NOT NULL AND _dob = '' THEN
      action_code := '00105';
      RAISE EXCEPTION 'User Date of Birth is empty.';

    ELSE
      SELECT _dob::DATE INTO userDOB;

      IF userDOB IS NULL THEN
        action_code := '00202';
        RAISE EXCEPTION 'User Date of Birth is invalid.';
      END IF;
    END IF;

    IF _phone_number IS NOT NULL AND _phone_number = '' THEN
      action_code := '00106';
      RAISE EXCEPTION 'User Phone Number is empty.';

    ELSE
      IF _phone_number !~ '^ *(\d *){9,}$' THEN
        action_code := '00203';
        RAISE EXCEPTION 'User Phone Number is invalid.';
      END IF;
    END IF;

    IF _email IS NOT NULL AND _email = '' THEN
      action_code := '00107';
      RAISE EXCEPTION 'User Email is empty.';

    ELSE
      IF _email !~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$' THEN
        action_code := '00204';
        RAISE EXCEPTION 'User Email is invalid.';
      END IF;
    END IF;

    IF _uuid = '' OR _uuid IS NULL THEN
      action_code := '00108';
      RAISE EXCEPTION 'User UUID is empty.';

    ELSE
      SELECT id INTO userId
      FROM "user".user
      WHERE uuid = _uuid;

      IF userId IS NULL THEN
        action_code := '00205';
        RAISE EXCEPTION 'User UUID is invalid.';
      END IF;
    END IF;

    WITH updated AS (
      UPDATE "user".user SET
        en_name = _en_name,
        kh_name = _kh_name,
        kr_name = _kr_name,
        gender = _gender,
        dob = userDOB,
        phone_number = _phone_number,
        email = _email
      WHERE id = userId
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM updated;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'User Info has been updated successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'User Info has been updated unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  UPDATE USER PROFILE PICTURE
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_update_user_image (
  IN _image_uuid     VARCHAR(50),
  IN _user_uuid      VARCHAR(50),
  OUT action_code    VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  oldImageId      INTEGER;
  newImageId      INTEGER;
  userId          INTEGER;
  rowCount        INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _image_uuid = '' OR _image_uuid IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Image UUID is empty.';

    ELSE
      SELECT id INTO newImageId
      FROM "user".image
      WHERE uuid = _image_uuid;

    END IF;

    IF _user_uuid = '' OR _user_uuid IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'User UUID is empty.';

    ELSE
      SELECT id INTO userId
      FROM "user".user
      WHERE uuid = _user_uuid;

    END IF;

    IF newImageId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Image UUID is invalid.';
    END IF;

    IF userId IS NULL THEN
      action_code := '00202';
      RAISE EXCEPTION 'User UUID is invalid.';
    END IF;

    SELECT image_id INTO oldImageId
    FROM "user".user
    WHERE id = userId;

    WITH updated AS (
      UPDATE "user".user SET
      image_id = newImageId
      WHERE id = userId
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM updated;

    IF rowCount = 1 THEN
      UPDATE "user".image SET status = '0'
      WHERE id = oldImageId;

      action_code := '00000';
      RAISE NOTICE 'User image has been updated successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'User image has been updated unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  CHANGE USER TEAM
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_update_user_team (
  IN _team_uuid      VARCHAR(50),
  IN _user_uuid      VARCHAR(50),
  OUT action_code    VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  teamId          INTEGER;
  userId          INTEGER;
  rowCount        INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _team_uuid = '' OR _team_uuid IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Team UUID is empty.';

    ELSE
      SELECT id INTO teamId
      FROM "user".team
      WHERE uuid = _team_uuid;
    END IF;

    IF _user_uuid = '' OR _user_uuid IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'User UUID is empty.';

    ELSE
      SELECT id INTO userId
      FROM "user".user
      WHERE uuid = _user_uuid;
    END IF;

    IF teamId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Team UUID is invalid.';
    END IF;

    IF userId IS NULL THEN
      action_code := '00202';
      RAISE EXCEPTION 'User UUID is invalid.';
    END IF;

    WITH updated AS (
      UPDATE "user".user SET
      team_id = teamId
      WHERE id = userId
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM updated;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'User Team has been updated successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'User Team has been updated unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  CHANGE USER ROLE
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_update_user_role (
  IN _roles_id       VARCHAR(50),
  IN _user_uuid      VARCHAR(50),
  OUT action_code    VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  roleId        INTEGER;
  roleIds       INTEGER[] DEFAULT '{}';
  roleType      VARCHAR(50);
  roleTypes     VARCHAR(50)[] DEFAULT '{}';
  userId        INTEGER;
  rowCount      INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _roles_id = '' OR _roles_id IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Role IDs is empty.';

    ELSE
      SELECT STRING_TO_ARRAY(_roles_id, ',') INTO roleIds;

      IF cardinality(roleIds) = 0 THEN
        action_code := '00201';
        RAISE EXCEPTION 'Role IDs is invalid.';

      ELSE
        FOREACH roleId IN ARRAY roleIds LOOP
          roleType := NULL;

          SELECT role_type.role_type INTO roleType
          FROM "user".role_type
          WHERE id = roleId;

          IF roleType IS NULL THEN
            action_code := '00201';
            RAISE EXCEPTION 'Role Id is invalid.';
          END IF;

          SELECT ARRAY_APPEND(roleTypes, roleType) INTO roleTypes;
        END LOOP;
      END IF;
    END IF;

    IF _user_uuid = '' OR _user_uuid IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'User UUID is empty.';

    ELSE
      SELECT id INTO userId
      FROM "user".user
      WHERE uuid = _user_uuid;
    END IF;

    IF userId IS NULL THEN
      action_code := '00202';
      RAISE EXCEPTION 'User UUID is invalid.';
    END IF;

    WITH updated AS (
      UPDATE "user".user SET
      role = ARRAY_TO_STRING(roleTypes, ',')
      WHERE id = userId
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM updated;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'User Role has been updated successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'User Role has been updated unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  ENABLE USER
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_enable_user (
  IN _user_uuid  VARCHAR(50),
  OUT action_code   VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  rowCount    INTEGER := 0;
  userId      INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _user_uuid = '' OR _user_uuid IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'User UUID is empty.';

    ELSE
      SELECT id INTO userId
      FROM "user".user
      WHERE uuid = _user_uuid;

    END IF;

    IF userId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'User UUID is invalid.';

    ELSE
      WITH updated AS (
        UPDATE "user".user SET
          status = '1'
        WHERE id = userId
        RETURNING 1 AS result
      )
      SELECT result INTO rowCount
      FROM updated;
    END IF;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'User has been enabled successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'User has been enabled unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  DISABLE USER
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_disable_user (
  IN _user_uuid  VARCHAR(50),
  OUT action_code   VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  rowCount    INTEGER := 0;
  userId      INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _user_uuid = '' OR _user_uuid IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'User UUID is empty.';

    ELSE
      SELECT id INTO userId
      FROM "user".user
      WHERE uuid = _user_uuid;

    END IF;

    IF userId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'User UUID is invalid.';

    ELSE
      WITH updated AS (
        UPDATE "user".user SET
          status = '0'
        WHERE id = userId
        RETURNING 1 AS result
      )
      SELECT result INTO rowCount
      FROM updated;
    END IF;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'User has been disabled successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'User has been disabled unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  USER ORDER HISTORY PAGINATION BY RECORDS
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_read_user_finance (
  IN _user_uuid             VARCHAR(50),
  OUT user_credit_balance   DOUBLE PRECISION,
  OUT number_of_order       INTEGER,
  OUT action_code           VARCHAR(10)
)
RETURNS RECORD
AS $$
BEGIN
  BEGIN
    user_credit_balance := 0;
    number_of_order := 0;
    action_code := '00001';

    IF _user_uuid = '' OR _user_uuid IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'User UUID is empty.';
    END IF;

    IF (SELECT COUNT(*) FROM "user".user WHERE uuid = _user_uuid) = 0 THEN
      action_code := '00201';
      RAISE EXCEPTION 'User UUID is invalid.';
    end if;


    SELECT COUNT(*) AS count INTO number_of_order
    FROM "order".order
    INNER JOIN "user".user
      ON "order".user_id = "user".id
    WHERE "user".uuid = _user_uuid;

    SELECT COALESCE("user".credit_balance, 0) INTO user_credit_balance
    FROM "user"."user"
    WHERE "user".uuid = _user_uuid;

    IF user_credit_balance IS NULL THEN
      user_credit_balance := 0;
    END IF;

    IF number_of_order IS NOT NULL AND user_credit_balance IS NOT NULL THEN
      action_code := '00000';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Cannot read user finance.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';
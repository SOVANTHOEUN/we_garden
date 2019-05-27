/********************************************************
  GET ALL TOP UP TRANSACTIONS
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_read_top_up_transactions(
  _page  INTEGER,
  _limit INTEGER
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
    "team_uuid"           VARCHAR(100),
    "team_name"           VARCHAR(100),
    "team_remark"         VARCHAR(100),
    "team_leader"         VARCHAR(100),
    "team_status"         VARCHAR(100),
    "department_uuid"     VARCHAR(100),
    "department_name"     VARCHAR(100),
    "department_remark"   VARCHAR(100),
    "department_first_manager"      VARCHAR(100),
    "department_second_manager"     VARCHAR(100),
    "department_status"   VARCHAR(100),
    "top_up_amount"       DOUBLE PRECISION,
    "top_up_date"         TIMESTAMP
  )
AS $$
BEGIN
  RETURN QUERY
  SELECT
    COALESCE("user".uuid, ''),
    COALESCE("user".en_name, ''),
    COALESCE("user".kh_name, ''),
    COALESCE("user".kr_name, ''),
    COALESCE("user".duty, ''),
    COALESCE("user".gender, ''),
    "user".dob,
    COALESCE("user".phone_number, ''),
    COALESCE((
      SELECT CONCAT(image.name, image.type)
      FROM "user".image
      WHERE image.id = "user".image_id
    ) :: VARCHAR(110), ''),
    COALESCE("user".credit_balance, 0),
    COALESCE("user".username, ''),
    COALESCE("user".email, ''),
    COALESCE("user".role, ''),
    COALESCE("user".token, ''),
    "user".created_date,
    COALESCE("employment_status".status, ''),
    COALESCE("user".status, ''),
    COALESCE("team".uuid, ''),
    COALESCE("team".name, ''),
    COALESCE("team".remark, ''),
    COALESCE("u1".en_name, ''),
    COALESCE("team".status, ''),
    COALESCE("department".uuid, ''),
    COALESCE("department".name, ''),
    COALESCE("department".remark, ''),
    COALESCE("u2".en_name, ''),
    COALESCE("u3".en_name, ''),
    COALESCE("department".status, ''),
    COALESCE("top_up".amount, 0),
    "top_up".date

  FROM "user"."user"
  INNER JOIN "user".team
    ON "user".team_id = team.id
  INNER JOIN "user".department
    ON "team".department_id = department.id
  INNER JOIN "user".employment_status
    ON "user".employment_status = employment_status.id
  INNER JOIN "user".user u1
    ON "team".leader = u1.id
  INNER JOIN "user".user u2
    ON "department".first_manager = u2.id
  INNER JOIN "user".user u3
    ON "department".second_manager = u3.id
  INNER JOIN "user"."top_up"
    ON "user".id = "top_up".user_id
  ORDER BY "top_up".date DESC
  LIMIT _limit
  OFFSET (_page - 1) * _limit;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  GET ALL TOP UP TRANSACTIONS BY DEPARTMENT
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_read_top_up_transactions_by_department (
  _department_uuid VARCHAR(50),
  _page INTEGER,
  _limit INTEGER
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
    "team_uuid"           VARCHAR(100),
    "team_name"           VARCHAR(100),
    "team_remark"         VARCHAR(100),
    "team_leader"         VARCHAR(100),
    "team_status"         VARCHAR(100),
    "department_uuid"     VARCHAR(100),
    "department_name"     VARCHAR(100),
    "department_remark"   VARCHAR(100),
    "department_first_manager"      VARCHAR(100),
    "department_second_manager"     VARCHAR(100),
    "department_status"   VARCHAR(100),
    "top_up_amount"       DOUBLE PRECISION,
    "top_up_date"         TIMESTAMP
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
      SELECT id, name, remark, status, uuid, first_manager, second_manager
      FROM "user".department
      WHERE department.id = departmentId
    )
    SELECT
      COALESCE("user".uuid, ''),
    COALESCE("user".en_name, ''),
    COALESCE("user".kh_name, ''),
    COALESCE("user".kr_name, ''),
    COALESCE("user".duty, ''),
    COALESCE("user".gender, ''),
    "user".dob,
    COALESCE("user".phone_number, ''),
    COALESCE((
      SELECT CONCAT(image.name, image.type)
      FROM "user".image
      WHERE image.id = "user".image_id
    ) :: VARCHAR(110), ''),
    COALESCE("user".credit_balance, 0),
    COALESCE("user".username, ''),
    COALESCE("user".email, ''),
    COALESCE("user".role, ''),
    COALESCE("user".token, ''),
    "user".created_date,
    COALESCE("employment_status".status, ''),
    COALESCE("user".status, ''),
    COALESCE("team".uuid, ''),
    COALESCE("team".name, ''),
    COALESCE("team".remark, ''),
    COALESCE("u1".en_name, ''),
    COALESCE("team".status, ''),
    COALESCE("temp_department".uuid, ''),
    COALESCE("temp_department".name, ''),
    COALESCE("temp_department".remark, ''),
    COALESCE("u2".en_name, ''),
    COALESCE("u3".en_name, ''),
    COALESCE("temp_department".status, ''),
    COALESCE("top_up".amount, 0),
    "top_up".date

    FROM "user"."user"
    INNER JOIN "user".team
      ON "user".team_id = team.id
    INNER JOIN temp_department
      ON "team".department_id = temp_department.id
    INNER JOIN "user".employment_status
      ON "user".employment_status = employment_status.id
    INNER JOIN "user".user u1
      ON "team".leader = u1.id
    INNER JOIN "user".user u2
      ON "temp_department".first_manager = u2.id
    INNER JOIN "user".user u3
      ON "temp_department".second_manager = u3.id
    INNER JOIN "user"."top_up"
      ON "user".id = "top_up".user_id
    ORDER BY "top_up".date DESC
    LIMIT _limit
    OFFSET (_page - 1) * _limit;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  GET ALL TOP UP TRANSACTIONS BY TEAM
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_read_top_up_transactions_by_team (
  _team_uuid VARCHAR(50),
  _page INTEGER,
  _limit INTEGER
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
    "team_uuid"           VARCHAR(100),
    "team_name"           VARCHAR(100),
    "team_remark"         VARCHAR(100),
    "team_leader"         VARCHAR(100),
    "team_status"         VARCHAR(100),
    "department_uuid"     VARCHAR(100),
    "department_name"     VARCHAR(100),
    "department_remark"   VARCHAR(100),
    "department_first_manager"      VARCHAR(100),
    "department_second_manager"     VARCHAR(100),
    "department_status"   VARCHAR(100),
    "top_up_amount"       DOUBLE PRECISION,
    "top_up_date"         TIMESTAMP
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
      SELECT id, name, remark, status, uuid, department_id, leader
      FROM "user".team
      WHERE team.id = teamId
    )
    SELECT
      COALESCE("user".uuid, ''),
    COALESCE("user".en_name, ''),
    COALESCE("user".kh_name, ''),
    COALESCE("user".kr_name, ''),
    COALESCE("user".duty, ''),
    COALESCE("user".gender, ''),
    "user".dob,
    COALESCE("user".phone_number, ''),
    COALESCE((
      SELECT CONCAT(image.name, image.type)
      FROM "user".image
      WHERE image.id = "user".image_id
    ) :: VARCHAR(110), ''),
    COALESCE("user".credit_balance, 0),
    COALESCE("user".username, ''),
    COALESCE("user".email, ''),
    COALESCE("user".role, ''),
    COALESCE("user".token, ''),
    "user".created_date,
    COALESCE("employment_status".status, ''),
    COALESCE("user".status, ''),
    COALESCE("temp_team".uuid, ''),
    COALESCE("temp_team".name, ''),
    COALESCE("temp_team".remark, ''),
    COALESCE("u1".en_name, ''),
    COALESCE("temp_team".status, ''),
    COALESCE("department".uuid, ''),
    COALESCE("department".name, ''),
    COALESCE("department".remark, ''),
    COALESCE("u2".en_name, ''),
    COALESCE("u3".en_name, ''),
    COALESCE("department".status, ''),
    COALESCE("top_up".amount, 0),
    "top_up".date

    FROM "user"."user"
    INNER JOIN temp_team
      ON "user".team_id = temp_team.id
    INNER JOIN "user".department
      ON temp_team.department_id = department.id
    INNER JOIN "user".employment_status
      ON "user".employment_status = employment_status.id
    INNER JOIN "user".user u1
      ON temp_team.leader = u1.id
    INNER JOIN "user".user u2
      ON "department".first_manager = u2.id
    INNER JOIN "user".user u3
      ON "department".second_manager = u3.id
    INNER JOIN "user"."top_up"
      ON "user".id = "top_up".user_id
    ORDER BY "top_up".date DESC
    LIMIT _limit
    OFFSET (_page - 1) * _limit;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  GET ALL TOP UP TRANSACTIONS BY USER
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_read_top_up_transactions_by_user (
  _user_uuid VARCHAR(50),
  _page INTEGER,
  _limit INTEGER
)
RETURNS TABLE (
    "top_up_amount"       DOUBLE PRECISION,
    "top_up_date"         TIMESTAMP
)
AS $$
DECLARE
  userId INTEGER;
BEGIN
  SELECT id INTO userId
  FROM "user".user
  WHERE uuid = _user_uuid;

  IF userId IS NULL THEN
    RETURN;
  END IF;

  RETURN QUERY
    SELECT
      "top_up".amount,
      "top_up".date

    FROM "user"."user"
    INNER JOIN "user"."top_up"
      ON "user".id = "top_up".user_id
    WHERE "user".id = userId
    ORDER BY "top_up".date DESC
    LIMIT _limit
    OFFSET (_page - 1) * _limit;
END;
$$
LANGUAGE 'plpgsql';
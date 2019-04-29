/********************************************************
  CREATE NEW TEAM
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_create_team (
  IN _name              VARCHAR(100),
  IN _remark            VARCHAR(255),
  IN _department_uuid   VARCHAR(50),
  IN _user_uuid         VARCHAR(50),
  OUT action_code       VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  departmentId INTEGER;
  userId INTEGER;
  rowCount  INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _name = '' OR _name IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Team name is empty.';
    END IF;

    IF _department_uuid = '' OR _department_uuid IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'Department UUID is empty.';

    ELSE
      SELECT id INTO departmentId
      FROM "user".department
      WHERE uuid = _department_uuid;

    END IF;

    IF _user_uuid = '' OR _user_uuid IS NULL THEN
      action_code := '00103';
      RAISE EXCEPTION 'User UUID is empty.';

    ELSE
      SELECT id INTO userId
      FROM "user".user
      WHERE uuid = _user_uuid;

    END IF;

    IF departmentId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Department UUID is invalid.';
    END IF;

    IF userId IS NULL THEN
      action_code := '00202';
      RAISE EXCEPTION 'User UUID is invalid.';
    END IF;

    WITH inserted AS (
      INSERT INTO "user".team(name, remark, department_id, leader)
      VALUES(_name, _remark, departmentId, userId)
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM inserted;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Team has been created successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Team has been created unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  UPDATE TEAM
 *******************************************************/
CREATE OR REPLACE FUNCTION "user".fn_update_team (
  IN _name              VARCHAR(100),
  IN _remark            VARCHAR(255),
  IN _department_uuid   VARCHAR(50),
  IN _user_uuid         VARCHAR(50),
  IN _uuid              VARCHAR(50),
  OUT action_code       VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  rowCount  INTEGER := 0;
  departmentId INTEGER;
  userId INTEGER;
  teamId  INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _name = '' OR _name IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Team name is empty.';
    END IF;

    IF _department_uuid = '' OR _department_uuid IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'Department UUID is empty.';

    ELSE
      SELECT id INTO departmentId
      FROM "user".department
      WHERE uuid = _department_uuid;

    END IF;

    IF _user_uuid = '' OR _user_uuid IS NULL THEN
      action_code := '00103';
      RAISE EXCEPTION 'User UUID is empty.';

    ELSE
      SELECT id INTO userId
      FROM "user".user
      WHERE uuid = _user_uuid;

    END IF;

    IF _uuid = '' OR _uuid IS NULL THEN
      action_code := '00104';
      RAISE EXCEPTION 'Team UUID is empty.';

    ELSE
      SELECT id INTO teamId
      FROM "user".team
      WHERE uuid = _uuid;

    END IF;

    IF departmentId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Department UUID is invalid.';
    END IF;

    IF userId IS NULL THEN
      action_code := '00202';
      RAISE EXCEPTION 'User UUID is invalid.';
    END IF;

    IF teamId IS NULL THEN
      action_code := '00203';
      RAISE EXCEPTION 'Team UUID is invalid.';

    END IF;

    WITH updated AS (
      UPDATE "user".team SET
        name = _name,
        remark = _remark,
        department_id = departmentId,
        leader = userId
      WHERE id = teamId
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM updated;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Team has been updated successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Team has been updated unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  ENABLE TEAM
 *******************************************************/
CREATE OR REPLACE FUNCTION "user".fn_enable_team (
  IN _team_uuid     VARCHAR(50),
  OUT action_code   VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  rowCount    INTEGER := 0;
  teamId  INTEGER := 0;
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

    IF teamId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Team UUID is invalid.';

    ELSE
      WITH updated AS (
        UPDATE "user".team SET
          status = '1'
        WHERE id = teamId
        RETURNING 1 AS result
      )
      SELECT result INTO rowCount
      FROM updated;
    END IF;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Team has been enabled successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Team has been enabled unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  DISABLE TEAM
 *******************************************************/
CREATE OR REPLACE FUNCTION "user".fn_disable_team (
  IN _team_uuid  VARCHAR(50),
  OUT action_code   VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  rowCount    INTEGER := 0;
  teamId  INTEGER := 0;
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

    IF teamId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Team UUID is invalid.';

    ELSE
      WITH updated AS (
        UPDATE "user".team SET
          status = '0'
        WHERE id = teamId
        RETURNING 1 AS result
      )
      SELECT result INTO rowCount
      FROM updated;
    END IF;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Team has been disabled successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Team has been disabled unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  GET ALL TEAMS
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_read_teams (
  _status    VARCHAR(1)
)
RETURNS TABLE (
  "team_uuid"           VARCHAR(50),
  "team_name"           VARCHAR(100),
  "team_remark"         VARCHAR(255),
  "team_leader"         VARCHAR(100),
  "team_status"         VARCHAR(1),
  "department_uuid"     VARCHAR(50),
  "department_name"     VARCHAR(100),
  "department_remark"   VARCHAR(255),
  "department_first_manager"  VARCHAR(100),
  "department_second_manager" VARCHAR(100),
  "department_status"   VARCHAR(1)
) AS $$
BEGIN
  RETURN QUERY
    SELECT
      COALESCE(team.uuid, ''),
      COALESCE(team.name, ''),
      COALESCE(team.remark, ''),
      COALESCE(u1.en_name, ''),
      COALESCE(team.status, ''),
      COALESCE(department.uuid, ''),
      COALESCE(department.name, ''),
      COALESCE(department.remark, ''),
      COALESCE(u2.en_name, ''),
      COALESCE(u3.en_name, ''),
      COALESCE(department.status, '')

    FROM "user".team
    INNER JOIN "user".department
      ON team.department_id = department.id
    LEFT JOIN "user".user u1
      ON team.leader = u1.id
    LEFT JOIN "user".user u2
      ON department.first_manager = u2.id
    LEFT JOIN "user".user u3
      ON department.second_manager = u3.id
    WHERE team.status != (
      SELECT CASE
        WHEN _status = '0' THEN '1'
        WHEN _status = '1' THEN '0'
        ELSE ''
      END
    )
    ORDER BY department.name, team.name ASC;
END;
$$
LANGUAGE 'plpgsql';
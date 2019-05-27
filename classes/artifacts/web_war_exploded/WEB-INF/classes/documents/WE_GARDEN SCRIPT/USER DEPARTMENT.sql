/********************************************************
  CREATE NEW DEPARTMENT
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_create_department (
  IN _name                  VARCHAR(100),
  IN _remark                VARCHAR(255),
  IN _first_manager_uuid    VARCHAR(50),
  IN _second_manager_uuid   VARCHAR(50),
  OUT action_code           VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  firstManagerId    INTEGER;
  secondManagerId   INTEGER;
  rowCount          INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _name = '' OR _name IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Department name is empty.';
    END IF;

    IF _first_manager_uuid = '' OR _first_manager_uuid IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'First Manager UUID is empty.';
    ELSE
      SELECT id INTO firstManagerId
      FROM "user".user
      WHERE uuid = _first_manager_uuid;
    END IF;

    IF _second_manager_uuid = '' OR _second_manager_uuid IS NULL THEN
      action_code := '00103';
      RAISE EXCEPTION 'Second Manager UUID is empty.';
    ELSE
      SELECT id INTO secondManagerId
      FROM "user".user
      WHERE uuid = _second_manager_uuid;
    END IF;

    IF firstManagerId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'First Manager UUID is invalid.';
    END IF;

    IF secondManagerId IS NULL THEN
      action_code := '00202';
      RAISE EXCEPTION 'Second Manager UUID is invalid.';
    END IF;


    WITH inserted AS (
      INSERT INTO "user".department(name, remark, first_manager, second_manager)
      VALUES(_name, _remark, firstManagerId, secondManagerId)
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM inserted;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Department has been created successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Department has been created unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  UPDATE DEPARTMENT
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_update_department (
  IN _name                  VARCHAR(100),
  IN _remark                VARCHAR(255),
  IN _first_manager_uuid    VARCHAR(50),
  IN _second_manager_uuid   VARCHAR(50),
  IN _uuid                  VARCHAR(50),
  OUT action_code           VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  firstManagerId    INTEGER;
  secondManagerId   INTEGER;
  departmentId      INTEGER := 0;
  rowCount          INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _name = '' OR _name IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Department name is empty.';
    END IF;

    IF _first_manager_uuid = '' OR _first_manager_uuid IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'First Manager UUID is empty.';
    ELSE
      SELECT id INTO firstManagerId
      FROM "user".user
      WHERE uuid = _first_manager_uuid;
    END IF;

    IF _second_manager_uuid = '' OR _second_manager_uuid IS NULL THEN
      action_code := '00103';
      RAISE EXCEPTION 'Second Manager UUID is empty.';
    ELSE
      SELECT id INTO secondManagerId
      FROM "user".user
      WHERE uuid = _second_manager_uuid;
    END IF;

    IF _uuid = '' OR _uuid IS NULL THEN
      action_code := '00104';
      RAISE EXCEPTION 'Department UUID is empty.';
    ELSE
      SELECT id INTO departmentId
      FROM "user".department
      WHERE uuid = _uuid;
    END IF;

    IF firstManagerId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'First Manager UUID is invalid.';
    END IF;

    IF secondManagerId IS NULL THEN
      action_code := '00202';
      RAISE EXCEPTION 'Second Manager UUID is invalid.';
    END IF;

    IF departmentId IS NULL THEN
      action_code := '00203';
      RAISE EXCEPTION 'Department UUID is invalid.';
    END IF;

    WITH updated AS (
      UPDATE "user".department SET
        name = _name,
        remark = _remark,
        first_manager = firstManagerId,
        second_manager = secondManagerId
        WHERE id = departmentId
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM updated;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Department has been updated successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Department has been updated unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  ENABLE DEPARTMENT
 *******************************************************/
CREATE OR REPLACE FUNCTION "user".fn_enable_department (
  IN _department_uuid  VARCHAR(50),
  OUT action_code   VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  rowCount    INTEGER := 0;
  departmentId  INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _department_uuid = '' OR _department_uuid IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Department UUID is empty.';

    ELSE
      SELECT id INTO departmentId
      FROM "user".department
      WHERE uuid = _department_uuid;

    END IF;

    IF departmentId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Department UUID is invalid.';

    ELSE
      WITH updated AS (
        UPDATE "user".department SET
          status = '1'
        WHERE id = departmentId
        RETURNING 1 AS result
      )
      SELECT result INTO rowCount
      FROM updated;
    END IF;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Department has been enabled successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Department has been enabled unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  DISABLE DEPARTMENT
 *******************************************************/
CREATE OR REPLACE FUNCTION "user".fn_disable_department (
  IN _department_uuid  VARCHAR(50),
  OUT action_code   VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  rowCount    INTEGER := 0;
  departmentId  INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _department_uuid = '' OR _department_uuid IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Department UUID is empty.';

    ELSE
      SELECT id INTO departmentId
      FROM "user".department
      WHERE uuid = _department_uuid;

    END IF;

    IF departmentId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Department UUID is invalid.';

    ELSE
      WITH updated AS (
        UPDATE "user".department SET
          status = '0'
        WHERE id = departmentId
        RETURNING 1 AS result
      )
      SELECT result INTO rowCount
      FROM updated;
    END IF;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Department has been enabled successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Department has been enabled unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  GET ALL DEPARTMENTS
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_read_departments (
  _status    VARCHAR(1)
)
RETURNS TABLE (
  "uuid"           VARCHAR(50),
  "name"           VARCHAR(100),
  "remark"         VARCHAR(255),
  "first_manager"  VARCHAR(100),
  "second_manager" VARCHAR(100),
  "status"         VARCHAR(1)
) AS $$
BEGIN
  RETURN QUERY
    SELECT
      COALESCE(department.uuid, ''),
      COALESCE(department.name, ''),
      COALESCE(department.remark, ''),
      COALESCE(u1.en_name, ''),
      COALESCE(u2.en_name, ''),
      COALESCE(department.status, '')

    FROM "user".department
    INNER JOIN "user".user u1
      ON department.first_manager = u1.id
    INNER JOIN "user".user u2
      ON department.second_manager = u2.id
    WHERE department.status != (
      SELECT CASE
        WHEN _status = '0' THEN '1'
        WHEN _status = '1' THEN '0'
        ELSE ''
      END
    )
    ORDER BY department.name ASC;
END;
$$
LANGUAGE 'plpgsql';
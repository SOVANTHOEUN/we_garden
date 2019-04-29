/********************************************************
  CREATE NEW CATEGORY
 *******************************************************/
SELECT * FROM "stock".fn_create_category('Coffee', NULL);

CREATE OR REPLACE FUNCTION "stock".fn_create_category (
  IN _name           VARCHAR(100),
  IN _remark         VARCHAR(255),
  OUT action_code    VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  rowCount  INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _name = '' OR _name IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Category name is empty.';

    ELSE
      WITH inserted AS (
        INSERT INTO "stock".category(name, remark)
        VALUES(_name, _remark)
        RETURNING 1 AS result
      )
      SELECT result INTO rowCount
      FROM inserted;

      IF rowCount = 1 THEN
        action_code := '00000';
        RAISE NOTICE 'Category has been created successfully.';
      END IF;
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Category has been created unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  UPDATE CATEGORY
 *******************************************************/
CREATE OR REPLACE FUNCTION "stock".fn_update_category (
  IN _name           VARCHAR(100),
  IN _remark         VARCHAR(255),
  IN _uuid           VARCHAR(50),
  OUT action_code       VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  rowCount  INTEGER := 0;
  categoryId  INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _name = '' OR _name IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Category name is empty.';
    END IF;

    IF _uuid = '' OR _uuid IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'Category UUID is empty.';

    ELSE
      SELECT id INTO categoryId
      FROM "stock".category
      WHERE uuid = _uuid;
    END IF;

    IF categoryId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Category UUID is invalid.';

    ELSE
      WITH updated AS (
        UPDATE "stock".category
          SET name = _name, remark = _remark
          WHERE id = categoryId
        RETURNING 1 AS result
      )
      SELECT result INTO rowCount
      FROM updated;

      IF rowCount = 1 THEN
        action_code := '00000';
        RAISE NOTICE 'Category has been updated successfully.';
      END IF;
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Category has been updated unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  ENABLE CATEGORY
 *******************************************************/
CREATE OR REPLACE FUNCTION "stock".fn_enable_category (
  IN _uuid  VARCHAR(50),
  OUT action_code   VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  rowCount    INTEGER := 0;
  categoryId  INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _uuid = '' OR _uuid IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Category UUID is empty.';

    ELSE
      SELECT id INTO categoryId
      FROM "stock".category
      WHERE uuid = _uuid;

    END IF;

    IF categoryId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Category UUID is invalid.';

    ELSE
      WITH updated AS (
        UPDATE "stock".category SET
          status = '1'
        WHERE id = categoryId
        RETURNING 1 AS result
      )
      SELECT result INTO rowCount
      FROM updated;
    END IF;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Category has been enabled successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Category has been enabled unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  DISABLE CATEGORY
 *******************************************************/
SELECT * FROM "stock".fn_disable_category('2509f97f-b314-446c-9042-c37dea58bf8e');

CREATE OR REPLACE FUNCTION "stock".fn_disable_category (
  IN _category_uuid  VARCHAR(50),
  OUT action_code   VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  rowCount    INTEGER := 0;
  categoryId  INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _category_uuid = '' OR _category_uuid IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Category UUID is empty.';

    ELSE
      SELECT id INTO categoryId
      FROM "stock".category
      WHERE uuid = _category_uuid;

    END IF;

    IF categoryId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Category UUID is invalid.';

    ELSE
      WITH updated AS (
        UPDATE "stock".category SET
          status = '0'
        WHERE id = categoryId
        RETURNING 1 AS result
      )
      SELECT result INTO rowCount
      FROM updated;
    END IF;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Category has been disabled successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Category has been disabled unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  GET ALL CATEGORIES
 *******************************************************/
SELECT * FROM "stock".fn_read_categories('');

CREATE OR REPLACE FUNCTION "stock".fn_read_categories (
  _status    VARCHAR(1)
)
RETURNS TABLE (
  "uuid"           VARCHAR(50),
  "name"           VARCHAR(100),
  "remark"         VARCHAR(255),
  "status"         VARCHAR(1)
) AS $$
BEGIN
  RETURN QUERY
    SELECT
      COALESCE(category.uuid, ''),
      COALESCE(category.name, ''),
      COALESCE(category.remark, ''),
      COALESCE(category.status, '')

    FROM "stock".category
    WHERE category.status != (
      SELECT CASE
        WHEN _status = '0' THEN '1'
        WHEN _status = '1' THEN '0'
        ELSE ''
      END
    )
    ORDER BY category.name ASC;
END;
$$
LANGUAGE 'plpgsql';
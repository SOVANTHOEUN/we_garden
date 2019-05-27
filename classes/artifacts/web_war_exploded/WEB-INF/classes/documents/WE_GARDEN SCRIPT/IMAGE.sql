/********************************************************
  STOCK IMAGE
 *******************************************************/

SELECT * FROM "stock".fn_create_image('image_name_test', '.jpg');

CREATE OR REPLACE FUNCTION "stock".fn_create_image (
  IN _name           VARCHAR(100),
  IN _type           VARCHAR(255),
  OUT action_code    VARCHAR(10),
  OUT image_uuid     VARCHAR(50)
)
RETURNS RECORD
AS $$
DECLARE
  rowCount  INTEGER := 0;
BEGIN
  BEGIN
    IF _name = '' OR _name IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Image name is empty.';

    END IF;

    IF _type = '' OR _type IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'Image type is empty.';

    END IF;

    WITH inserted AS (
      INSERT INTO "stock".image(name, type)
      VALUES(_name, _type)
      RETURNING 1 AS result, image.uuid AS imgUUID
    )
    SELECT inserted.result, inserted.imgUUID INTO rowCount, image_uuid
    FROM inserted;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Image has been created successfully.';

    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Image has been created unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';






/********************************************************
  USER IMAGE
 *******************************************************/
SELECT * FROM "user".fn_create_image('image name', '.img');

CREATE OR REPLACE FUNCTION "user".fn_create_image (
  IN _name           VARCHAR(100),
  IN _type           VARCHAR(255),
  OUT action_code    VARCHAR(10),
  OUT image_uuid     VARCHAR(50)
)
RETURNS RECORD
AS $$
DECLARE
  rowCount  INTEGER := 0;
BEGIN
  BEGIN
    IF _name = '' OR _name IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Image name is empty.';

    END IF;

    IF _type = '' OR _type IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'Image type is empty.';

    END IF;

    WITH inserted AS (
      INSERT INTO "user".image(name, type)
      VALUES(_name, _type)
      RETURNING 1 AS result, image.uuid AS imgUUID
    )
    SELECT inserted.result, inserted.imgUUID INTO rowCount, image_uuid
    FROM inserted;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Image has been created successfully.';

    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Image has been created unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';
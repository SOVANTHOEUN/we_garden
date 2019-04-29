/********************************************************
  CREATE NEW PRODUCT
 *******************************************************/
SELECT * FROM "stock".fn_create_product('Mama (Duck)', 0.50, '325def11-f79e-4657-b979-fa95a2c44055', '7796aaf5-df82-46b6-9319-b79d7b6084ff');

CREATE OR REPLACE FUNCTION "stock".fn_create_product (
  IN _name           VARCHAR(100),
  IN _price          DOUBLE PRECISION,
  IN _category_uuid  VARCHAR(50),
  IN _image_uuid     VARCHAR(50),
  OUT action_code    VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  categoryId  INTEGER;
  imageId     INTEGER;
  rowCount    INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _name = '' OR _name IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Product name is empty.';
    END IF;

    IF _price <= 0 OR _price IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'Product price is empty.';
    END IF;

    IF _category_uuid = '' OR _category_uuid IS NULL THEN
      action_code := '00103';
      RAISE EXCEPTION 'Category UUID is empty.';

    ELSE
      SELECT id INTO categoryId
      FROM "stock".category
      WHERE uuid = _category_uuid;

    END IF;

    IF _image_uuid = '' OR _image_uuid IS NULL THEN
      action_code := '00104';
      RAISE EXCEPTION 'Image UUID is empty.';

    ELSE
      SELECT id INTO imageId
      FROM "stock".image
      WHERE uuid = _image_uuid;

    END IF;

    IF categoryId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Category UUID is invalid.';
    END IF;

    IF imageId IS NULL THEN
      action_code := '00202';
      RAISE EXCEPTION 'Image UUID is invalid.';
    END IF;


    WITH inserted AS (
      INSERT INTO "stock".product(name, price, category_id, image_id)
      VALUES(_name, _price, categoryId, imageId)
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM inserted;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Product has been created successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Product has been created unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  UPDATE PRODUCT INFO
 *******************************************************/
CREATE OR REPLACE FUNCTION "stock".fn_update_product_info (
  IN _name           VARCHAR(100),
  IN _price          DOUBLE PRECISION,
  IN _product_uuid   VARCHAR(50),
  OUT action_code    VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  productId  INTEGER;
  rowCount    INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _name = '' OR _name IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Product name is empty.';
    END IF;

    IF _price IS NULL OR _price <= 0 THEN
      action_code := '00102';
      RAISE EXCEPTION 'Product price is empty.';
    END IF;

    IF _product_uuid = '' OR _product_uuid IS NULL THEN
      action_code := '00103';
      RAISE EXCEPTION 'Product UUID is empty.';

    ELSE
      SELECT id INTO productId
      FROM "stock".product
      WHERE uuid = _product_uuid;

    END IF;

    IF productId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Product UUID is invalid.';
    END IF;

    WITH updated AS (
      UPDATE "stock".product SET
      name = _name,
      price = _price
      WHERE id = productId
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM updated;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Product has been updated successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Product has been updated unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  UPDATE PRODUCT IMAGE
 *******************************************************/
CREATE OR REPLACE FUNCTION "stock".fn_update_product_image (
  IN _image_uuid     VARCHAR(50),
  IN _product_uuid   VARCHAR(50),
  OUT action_code    VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  oldImageId      INTEGER;
  newImageId      INTEGER;
  productId       INTEGER;
  rowCount        INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _image_uuid = '' OR _image_uuid IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Image UUID is empty.';

    ELSE
      SELECT id INTO newImageId
      FROM "stock".image
      WHERE uuid = _image_uuid;

    END IF;

    IF _product_uuid = '' OR _product_uuid IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'Product UUID is empty.';

    ELSE
      SELECT id INTO productId
      FROM "stock".product
      WHERE uuid = _product_uuid;

    END IF;

    IF newImageId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Image UUID is invalid.';
    END IF;

    IF productId IS NULL THEN
      action_code := '00202';
      RAISE EXCEPTION 'Product UUID is invalid.';
    END IF;

    SELECT image_id INTO oldImageId
    FROM "stock".product
    WHERE id = productId;

    WITH updated AS (
      UPDATE "stock".product SET
      image_id = newImageId
      WHERE id = productId
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM updated;

    IF rowCount = 1 THEN
      UPDATE "stock".image SET status = '0'
      WHERE id = oldImageId;

      action_code := '00000';
      RAISE NOTICE 'Product image has been updated successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Product image has been updated unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  CHANGE PRODUCT CATEGORY
 *******************************************************/
CREATE OR REPLACE FUNCTION "stock".fn_update_product_category (
  IN _category_uuid  VARCHAR(50),
  IN _product_uuid   VARCHAR(50),
  OUT action_code    VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  categoryId      INTEGER;
  productId       INTEGER;
  rowCount        INTEGER := 0;
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

    IF _product_uuid = '' OR _product_uuid IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'Product UUID is empty.';

    ELSE
      SELECT id INTO productId
      FROM "stock".product
      WHERE uuid = _product_uuid;

    END IF;

    IF categoryId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Category UUID is invalid.';
    END IF;

    IF productId IS NULL THEN
      action_code := '00202';
      RAISE EXCEPTION 'Product UUID is invalid.';
    END IF;

    WITH updated AS (
      UPDATE "stock".product SET
      category_id = categoryId
      WHERE id = productId
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM updated;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Product category has been updated successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Product category has been updated unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  ENABLE PRODUCT
 *******************************************************/
CREATE OR REPLACE FUNCTION "stock".fn_enable_product (
  IN _product_uuid  VARCHAR(50),
  OUT action_code   VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  rowCount    INTEGER := 0;
  productId   INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _product_uuid = '' OR _product_uuid IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Product UUID is empty.';

    ELSE
      SELECT id INTO productId
      FROM "stock".product
      WHERE uuid = _product_uuid;

    END IF;

    IF productId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Product UUID is invalid.';

    ELSE
      WITH updated AS (
        UPDATE "stock".product SET
          status = '1'
        WHERE id = productId
        RETURNING 1 AS result
      )
      SELECT result INTO rowCount
      FROM updated;
    END IF;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Product has been enabled successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Product has been enabled unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  DISABLE PRODUCT
 *******************************************************/
SELECT * FROM "stock".fn_disable_product('05a910f4-2069-4683-a8d0-ec56393d97c9');


CREATE OR REPLACE FUNCTION "stock".fn_disable_product (
  IN _product_uuid  VARCHAR(50),
  OUT action_code   VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  rowCount    INTEGER := 0;
  productId   INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _product_uuid = '' OR _product_uuid IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Product UUID is empty.';

    ELSE
      SELECT id INTO productId
      FROM "stock".product
      WHERE uuid = _product_uuid;

    END IF;

    IF productId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Product UUID is invalid.';

    ELSE
      WITH updated AS (
        UPDATE "stock".product SET
          status = '0'
        WHERE id = productId
        RETURNING 1 AS result
      )
      SELECT result INTO rowCount
      FROM updated;
    END IF;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Product has been disabled successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Product has been disabled unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  GET PRODUCTS
 *******************************************************/
SELECT * FROM "stock".fn_read_products('');

CREATE OR REPLACE FUNCTION "stock".fn_read_products (
  _status          VARCHAR(1)
)
RETURNS TABLE (
  "product_uuid"           VARCHAR(50),
  "product_name"           VARCHAR(100),
  "product_price"          DOUBLE PRECISION,
  "product_image_name"     VARCHAR(110),
  "product_status"         VARCHAR(1),
  "category_uuid"          VARCHAR(50),
  "category_name"          VARCHAR(100),
  "category_remark"        VARCHAR(255),
  "category_status"        VARCHAR(1)
) AS $$
BEGIN
  IF _status = '0' THEN
    RETURN QUERY
    SELECT
      COALESCE(product.uuid, ''),
      COALESCE(product.name, ''),
      COALESCE(product.price, 0),
      COALESCE(CONCAT(image.name, image.type) :: VARCHAR(110), ''),
      COALESCE(product.status, ''),
      COALESCE(category.uuid, '') AS category_uuid,
      COALESCE(category.name, '') AS category_name,
      COALESCE(category.remark, '') AS category_remark,
      COALESCE(category.status, '') AS category_status

    FROM "stock".product
    INNER JOIN "stock".image
      ON product.image_id = image.id
    INNER JOIN "stock".category
      ON product.category_id = category.id
    WHERE product.status = _status
      OR category.status = _status
    ORDER BY category.name, product.name ASC;

  ELSEIF _status = '1' THEN
    RETURN QUERY
    SELECT
      COALESCE(product.uuid, ''),
      COALESCE(product.name, ''),
      COALESCE(product.price, 0),
      COALESCE(CONCAT(image.name, image.type) :: VARCHAR(110), ''),
      COALESCE(product.status, ''),
      COALESCE(category.uuid, '') AS category_uuid,
      COALESCE(category.name, '') AS category_name,
      COALESCE(category.remark, '') AS category_remark,
      COALESCE(category.status, '') AS category_status

    FROM "stock".product
    INNER JOIN "stock".image
      ON product.image_id = image.id
    INNER JOIN "stock".category
      ON product.category_id = category.id
    WHERE product.status = _status
      AND category.status = _status
    ORDER BY category.name, product.name ASC;

  ELSE
    RETURN QUERY
    SELECT
      COALESCE(product.uuid, ''),
      COALESCE(product.name, ''),
      COALESCE(product.price, 0),
      COALESCE(CONCAT(image.name, image.type) :: VARCHAR(110), ''),
      COALESCE(product.status, ''),
      COALESCE(category.uuid, '') AS category_uuid,
      COALESCE(category.name, '') AS category_name,
      COALESCE(category.remark, '') AS category_remark,
      COALESCE(category.status, '') AS category_status

    FROM "stock".product
    INNER JOIN "stock".image
      ON product.image_id = image.id
    INNER JOIN "stock".category
      ON product.category_id = category.id
    ORDER BY category.name, product.name ASC;

  END IF;
END;
$$
LANGUAGE 'plpgsql';
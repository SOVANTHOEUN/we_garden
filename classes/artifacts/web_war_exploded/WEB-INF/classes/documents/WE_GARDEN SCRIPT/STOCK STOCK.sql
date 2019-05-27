/********************************************************
  STOCK IN
 *******************************************************/

CREATE OR REPLACE FUNCTION "stock".fn_add_to_stock (
  IN _product_uuid      VARCHAR(100),
  IN _stock_in_qty      INTEGER,
  OUT action_code       VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  productId INTEGER;
  currentQuantity INTEGER;
  rowCount  INTEGER := 0;
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

    IF _stock_in_qty <= 0 OR _stock_in_qty IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'Stock in quantity is less than one.';
    END IF;

    IF productId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Product UUID is invalid.';
    END IF;

    SELECT quantity INTO currentQuantity
    FROM "stock".stock
    WHERE product_id = productId
    ORDER BY updated_date DESC
    LIMIT 1;

    IF currentQuantity IS NULL THEN
      currentQuantity := 0;
    END IF;

    WITH inserted AS (
      INSERT INTO "stock".stock(stock_in, quantity, product_id)
      VALUES(
        _stock_in_qty,
        (currentQuantity + _stock_in_qty) :: INTEGER,
        productId
      )
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM inserted;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Stock has been added successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Stock has been added unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  STOCK OUT
 *******************************************************/

CREATE OR REPLACE FUNCTION "stock".fn_remove_from_stock (
  IN _product_uuid      VARCHAR(100),
  IN _stock_out_qty     INTEGER,
  OUT action_code       VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  productId INTEGER;
  currentQuantity INTEGER;
  rowCount  INTEGER := 0;
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

    IF _stock_out_qty <= 0 OR _stock_out_qty IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'Stock out quantity is less than one.';
    END IF;

    IF productId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Product UUID is invalid.';
    END IF;

    SELECT quantity INTO currentQuantity
    FROM "stock".stock
    WHERE product_id = productId
    ORDER BY updated_date DESC
    LIMIT 1;

    IF currentQuantity IS NULL OR currentQuantity = 0 THEN
      action_code := '00301';
      RAISE EXCEPTION 'No products in stock.';
    END IF;

    IF currentQuantity - _stock_out_qty < 0 THEN
      action_code := '00302';
      RAISE EXCEPTION 'Not enough products in stock.';
    END IF;

    WITH inserted AS (
      INSERT INTO "stock".stock(stock_out, quantity, product_id)
      VALUES(
        _stock_out_qty,
        (currentQuantity - _stock_out_qty) :: INTEGER,
        productId
      )
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM inserted;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Stock has been removed successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Stock has been removed unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';



/********************************************************
  GET PRODUCTS IN STOCK
 *******************************************************/

CREATE OR REPLACE FUNCTION "stock".fn_read_products_in_stock (
  _status          VARCHAR(1)
)
RETURNS TABLE (
  "product_uuid"           VARCHAR(50),
  "product_name"           VARCHAR(100),
  "product_price"          DOUBLE PRECISION,
  "product_quantity"       INTEGER,
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
      COALESCE(
      (
        SELECT stock.quantity
        FROM "stock".stock stock
        WHERE stock.product_id = product.id
        ORDER BY stock.updated_date DESC
        LIMIT 1
      ), 0) :: INTEGER AS quantity,
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
      COALESCE(
      (
        SELECT stock.quantity
        FROM "stock".stock stock
        WHERE stock.product_id = product.id
        ORDER BY stock.updated_date DESC
        LIMIT 1
      ), 0) :: INTEGER AS quantity,
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
      COALESCE(
      (
        SELECT stock.quantity
        FROM "stock".stock stock
        WHERE stock.product_id = product.id
        ORDER BY stock.updated_date DESC
        LIMIT 1
      ), 0) :: INTEGER AS quantity,
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


/********************************************************
  STOCK IN HISTORY
 *******************************************************/

CREATE OR REPLACE FUNCTION "stock".fn_read_stock_in_history (
--   IN _type          VARCHAR(1)
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
  "category_status"        VARCHAR(1),
  "stock_in_quantity"      INTEGER,
  "stock_in_date"          TIMESTAMP
)
AS $$
BEGIN
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
      COALESCE(category.status, '') AS category_status,
      "stock".stock_in,
      "stock".updated_date

    FROM "stock".product
    INNER JOIN "stock".image
      ON product.image_id = image.id
    INNER JOIN "stock".category
      ON product.category_id = category.id
    INNER JOIN "stock"."stock"
      ON product.id = "stock".product_id
    WHERE "stock".stock_in IS NOT NULL
    ORDER BY "stock".updated_date DESC;
END;
$$
LANGUAGE 'plpgsql';



/********************************************************
  GET PRODUCTS IN STOCK & REFRIGERATOR
 *******************************************************/

CREATE OR REPLACE FUNCTION "stock".fn_read_products_in_stock_and_refrigerator (
  _status          VARCHAR(1)
)
RETURNS TABLE (
  "product_uuid"           VARCHAR(50),
  "product_name"           VARCHAR(100),
  "product_price"          DOUBLE PRECISION,
  "stock_quantity"         INTEGER,
  "refrigerator_quantity"  INTEGER,
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
      COALESCE(
      (
        SELECT quantity
        FROM "stock".stock
        WHERE product_id = product.id
        ORDER BY updated_date DESC
        LIMIT 1
      ), 0) :: INTEGER AS stock_quantity,
      COALESCE(
      (
        SELECT quantity
        FROM "stock".refrigerator
        WHERE product_id = product.id
        ORDER BY updated_date DESC
        LIMIT 1
      ), 0) :: INTEGER AS refrigerator_quantity,
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
      COALESCE(
      (
        SELECT quantity
        FROM "stock".stock
        WHERE product_id = product.id
        ORDER BY updated_date DESC
        LIMIT 1
      ), 0) :: INTEGER AS stock_quantity,
      COALESCE(
      (
        SELECT quantity
        FROM "stock".refrigerator
        WHERE product_id = product.id
        ORDER BY updated_date DESC
        LIMIT 1
      ), 0) :: INTEGER AS refrigerator_quantity,
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
      COALESCE(
      (
        SELECT quantity
        FROM "stock".stock
        WHERE product_id = product.id
        ORDER BY updated_date DESC
        LIMIT 1
      ), 0) :: INTEGER AS stock_quantity,
      COALESCE(
      (
        SELECT quantity
        FROM "stock".refrigerator
        WHERE product_id = product.id
        ORDER BY updated_date DESC
        LIMIT 1
      ), 0) :: INTEGER AS refrigerator_quantity,
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
/********************************************************
  ADD TO REFRIGERATOR FROM STOCK
 *******************************************************/
SELECT * FROM "stock".fn_add_to_refrigerator('74f50a72-ca0b-4c11-b822-2a8c0c9440e8', 5);

CREATE OR REPLACE FUNCTION "stock".fn_add_to_refrigerator (
  IN _product_uuid      VARCHAR(100),
  IN _stock_in_qty      INTEGER,
  OUT action_code       VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  productId INTEGER;
  currentQuantity INTEGER;
  stockQuantity INTEGER;
  stockOutCode VARCHAR(10);
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

    SELECT quantity INTO stockQuantity
    FROM "stock".stock
    WHERE product_id = productId
    ORDER BY updated_date DESC
    LIMIT 1;

    SELECT quantity INTO currentQuantity
    FROM "stock".refrigerator
    WHERE product_id = productId
    ORDER BY updated_date DESC
    LIMIT 1;

    IF currentQuantity IS NULL THEN
      currentQuantity := 0;
    END IF;

    IF stockQuantity IS NULL OR stockQuantity = 0 THEN
      action_code := '00301';
      RAISE EXCEPTION 'No products in stock.';
    END IF;

    IF stockQuantity - _stock_in_qty < 0 THEN
      action_code := '00302';
      RAISE EXCEPTION 'Not enough products in stock.';
    END IF;

    SELECT * INTO stockOutCode
    FROM "stock".fn_remove_from_stock(_product_uuid, _stock_in_qty);

    IF stockOutCode != '00000' THEN
      action_code := '00303';
      RAISE EXCEPTION 'Failed to remove product from stock.';
    END IF;

    WITH inserted AS (
      INSERT INTO "stock".refrigerator(stock_in, quantity, product_id)
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
      RAISE NOTICE 'Stock has been added to refrigerator successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Stock has been added refrigerator unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';



/********************************************************
  ORDER OUT FROM REFRIGERATOR
 *******************************************************/
SELECT * FROM "stock".fn_order_from_refrigerator('05a910f4-2069-4683-a8d0-ec56393d97c9', 3);

CREATE OR REPLACE FUNCTION "stock".fn_order_from_refrigerator (
  IN _product_uuid      VARCHAR(50),
  IN _product_qty       INTEGER,
  IN _order_uuid        VARCHAR(50),
  OUT action_code       VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  productId INTEGER;
  orderId INTEGER;
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

    IF _product_qty <= 0 OR _product_qty IS NULL THEN
      action_code := '00102';
      RAISE EXCEPTION 'Order quantity is less than one.';
    END IF;

    IF _order_uuid = '' OR _order_uuid IS NULL THEN
      action_code := '00103';
      RAISE EXCEPTION 'Order UUID is empty.';

    ELSE
      SELECT id INTO orderId
      FROM "order"."order"
      WHERE uuid = _order_uuid;

    END IF;

    IF productId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Product UUID is invalid.';
    END IF;

    IF orderId IS NULL THEN
      action_code := '00202';
      RAISE EXCEPTION 'Order UUID is invalid.';
    END IF;

    SELECT quantity INTO currentQuantity
    FROM "stock".refrigerator
    WHERE product_id = productId
    ORDER BY updated_date DESC
    LIMIT 1;

    IF currentQuantity IS NULL OR currentQuantity = 0 THEN
      action_code := '00301';
      RAISE EXCEPTION 'No products in refrigerator.';
    END IF;

    IF currentQuantity - _product_qty < 0 THEN
      action_code := '00302';
      RAISE EXCEPTION 'Not enough products in refrigerator.';
    END IF;

    WITH inserted AS (
      INSERT INTO "stock".refrigerator(stock_out, quantity, product_id, order_id)
      VALUES(
        _product_qty,
        (currentQuantity - _product_qty) :: INTEGER,
        productId,
        orderId
      )
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM inserted;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Ordered product has been removed from refrigerator successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Ordered product has been removed from refrigerator unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  GET PRODUCTS IN REFRIGERATOR
 *******************************************************/
SELECT * FROM "stock".fn_read_products_in_refrigerator('');

CREATE OR REPLACE FUNCTION "stock".fn_read_products_in_refrigerator (
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
    WITH allProducts AS (
      SELECT
        COALESCE(product.uuid, ''),
        COALESCE(product.name, ''),
        COALESCE(product.price, 0),
        COALESCE(
        (
          SELECT quantity
          FROM "stock".refrigerator
          WHERE product_id = product.id
          ORDER BY updated_date DESC
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
      ORDER BY category.name, product.name ASC
    )
    SELECT * FROM allProducts WHERE quantity > 0;

  ELSEIF _status = '1' THEN
    RETURN QUERY
    WITH allProducts AS (
      SELECT
        COALESCE(product.uuid, ''),
        COALESCE(product.name, ''),
        COALESCE(product.price, 0),
        COALESCE(
        (
          SELECT quantity
          FROM "stock".refrigerator
          WHERE product_id = product.id
          ORDER BY updated_date DESC
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
      ORDER BY category.name, product.name ASC
    )
    SELECT * FROM allProducts WHERE quantity > 0;

  ELSE
    RETURN QUERY
    WITH allProducts AS (
      SELECT
        COALESCE(product.uuid, ''),
        COALESCE(product.name, ''),
        COALESCE(product.price, 0),
        COALESCE(
        (
          SELECT quantity
          FROM "stock".refrigerator
          WHERE product_id = product.id
          ORDER BY updated_date DESC
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
      ORDER BY category.name, product.name ASC
    )
    SELECT * FROM allProducts WHERE quantity > 0;

  END IF;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  REFRIGERATOR STOCK IN HISTORY
 *******************************************************/
SELECT * FROM "stock".fn_read_refrigerator_stock_in_history();

CREATE OR REPLACE FUNCTION "stock".fn_read_refrigerator_stock_in_history (
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
      refrigerator.stock_in,
      refrigerator.updated_date

    FROM "stock".product
    INNER JOIN "stock".image
      ON product.image_id = image.id
    INNER JOIN "stock".category
      ON product.category_id = category.id
    INNER JOIN "stock".refrigerator
      ON product.id = refrigerator.product_id
    WHERE refrigerator.stock_in IS NOT NULL
    ORDER BY refrigerator.updated_date DESC;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  REFRIGERATOR STOCK OUT HISTORY
 *******************************************************/
SELECT * FROM "stock".fn_read_refrigerator_stock_out_history();

CREATE OR REPLACE FUNCTION "stock".fn_read_refrigerator_stock_out_history (
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
  "stock_out_quantity"     INTEGER,
  "stock_out_date"         TIMESTAMP,
  "order_uuid"             VARCHAR(50)
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
      refrigerator.stock_out,
      refrigerator.updated_date,
      "order".uuid

    FROM "stock".product
    INNER JOIN "stock".image
      ON product.image_id = image.id
    INNER JOIN "stock".category
      ON product.category_id = category.id
    INNER JOIN "stock".refrigerator
      ON product.id = refrigerator.product_id
    INNER JOIN "order".order
      ON refrigerator.order_id = "order".id
    WHERE refrigerator.stock_out IS NOT NULL
    ORDER BY refrigerator.updated_date DESC;
END;
$$
LANGUAGE 'plpgsql';
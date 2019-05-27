/********************************************************
  CREATE NEW ORDER & ORDER DETAIL (THEN REFRIGERATOR.ORDER OUT)
  ~> MAYBE USER.UPDATE USER BALANCE
 *******************************************************/
SELECT * FROM "order".fn_order_products(
--     'a8a66193-5560-458f-9676-4bc0eb178c2d',
--     '74f50a72-ca0b-4c11-b822-2a8c0c9440e8',
--     '3f99bdae-06f8-481f-b538-a8bd3b531466',
--     '8003c077-6107-4d86-9883-7d4108c55f53',
--     'dcd2d1d7-c748-46f5-a24f-acf56460c0b1',
--     '719b7a36-9d35-4ca0-a029-a1edd6594263',
--     '47803051-32be-4299-9a80-fad0defb64b2',
--     '7c4eb02e-fa1a-4f44-aaf8-aeb558b0a850',
--     'c1af9831-6d79-4ef7-a0c1-e036a0ea5126',
--     '8da2b271-0812-4f9c-9834-66356599fc9a',
    'da98310b-0f45-46a4-8a49-d9aad21bde83',
--     'e4690edb-acf0-4013-b012-ec170ce7526c',
--     '2bcd8000-4f98-4ea5-bf54-f6765f81fe19',
--     '588384a0-47fb-424b-a973-d0f48db0ef2e',
    '1',
    '4',
    'Testing',
    '2688d7bf-8e7e-4217-a00f-a9d5edd5f134'
);

CREATE OR REPLACE FUNCTION "order".fn_order_products (
  IN _products_uuid     TEXT,
  IN _products_qty      TEXT,
  IN _order_type        VARCHAR(1),
  IN _remark            VARCHAR(255),
  IN _user_uuid         VARCHAR(50),
  OUT action_code       VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  productId       INTEGER;
  productUUID     VARCHAR(50);
  productPrice    DOUBLE PRECISION;

  productIds      INTEGER[] DEFAULT '{}';
  productQtys     INTEGER[] DEFAULT '{}';
  productUUIDs    VARCHAR(50)[] DEFAULT '{}';
  productPrices   DOUBLE PRECISION[] DEFAULT '{}';

  orderType       VARCHAR(50);
  userId          INTEGER;
  userRoles       VARCHAR(255);
  subtotalAmount  DOUBLE PRECISION := 0;
  totalAmount     DOUBLE PRECISION := 0;

  orderId         INTEGER;
  orderUUID       VARCHAR(50);

  currentQuantity INTEGER;
  iterator        INTEGER := 1;
  balanceCode     VARCHAR(10);
  stockOutCode    VARCHAR(10);
  rowCount        INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _products_qty = '' OR _products_qty IS NULL THEN
      -- EMPTY QUANTITY
      action_code := '00102';
      RAISE EXCEPTION 'Product quantity is empty.';

    ELSE
      -- CONVERT STRING TO ARRAY & SET INTO productQtys
      SELECT STRING_TO_ARRAY(_products_qty, ',') INTO productQtys;

      IF cardinality(productQtys) = 0 THEN
        -- ARRAY COUNT = 0
        action_code := '00202';
        RAISE EXCEPTION 'Product quantity is invalid.';
      END IF;
    END IF;

    IF _products_uuid = '' OR _products_uuid IS NULL THEN
      -- EMPTY UUID
      action_code := '00101';
      RAISE EXCEPTION 'Product UUID is empty.';

    ELSE
      -- CONVERT STRING TO ARRAY & SET INTO productUUIDs
      SELECT STRING_TO_ARRAY(_products_uuid, ',') INTO productUUIDs;

      IF cardinality(productUUIDs) = 0 THEN
        -- ARRAY COUNT = 0
        action_code := '00201';
        RAISE EXCEPTION 'Product UUID is invalid.';

      ELSE
        -- COUNT OF PRODUCT & QTY ARE NOT EQUAL TO EACH OTHER
        IF cardinality(productUUIDs) != cardinality(productQtys) THEN
          action_code := '00301';
          RAISE EXCEPTION 'Product UUID & Quantity are not match each other.';
        END IF;

        -- CHECK IF ORDERED QTY <= REFRIGERATOR QTY & GET ID, PRICE OF PRODUCTS
        FOREACH productUUID IN ARRAY productUUIDs LOOP
          SELECT product_quantity INTO currentQuantity
          FROM "stock".fn_read_products_in_refrigerator('1')
          WHERE product_uuid = productUUID;

          IF currentQuantity < productQtys[iterator] THEN
            action_code := '00302';
            RAISE EXCEPTION 'Not enough product quantity in refrigerator.';
            EXIT;
          END IF;

          SELECT id, price INTO productId, productPrice
          FROM "stock".product
          WHERE uuid = productUUID;

          IF productId IS NULL OR productPrice IS NULL THEN
            action_code := '00303';
            RAISE EXCEPTION 'Product UUID is invalid.';
            EXIT;
          end if;

          SELECT ARRAY_APPEND(productIds, productId) INTO productIds;
          SELECT ARRAY_APPEND(productPrices, productPrice) INTO productPrices;

          subtotalAmount := subtotalAmount + (productPrice * productQtys[iterator]);
          iterator := iterator + 1;
        END LOOP;
      END IF;
    END IF;

    -- CHECK & GET ORDER TYPE
    IF _order_type IS NULL THEN
      action_code := '00103';
      RAISE EXCEPTION 'Order type is empty.';

    ELSE
      SELECT order_type INTO orderType
      FROM "order".order_type
      WHERE id = _order_type :: INTEGER;

    END IF;

    IF orderType IS NULL OR _order_type = '3' THEN
      action_code := '00203';
      RAISE EXCEPTION 'Order type is invalid.';
    END IF;

    -- CHECK & GET USER ID
    IF _user_uuid = '' OR _user_uuid IS NULL THEN
      action_code := '00104';
      RAISE EXCEPTION 'User UUID is empty.';

    ELSE
      SELECT id, role INTO userId, userRoles
      FROM "user".user
      WHERE uuid = _user_uuid;

    END IF;

    IF userId IS NULL THEN
      action_code := '00204';
      RAISE EXCEPTION 'User UUID is invalid.';
    END IF;

    -- SUBTOTAL & TOTAL AMOUNT
    -- TEA TIME & BRONZE MASTER => totalAmount = 0
    IF _order_type = '4' THEN
      totalAmount := 0;
      IF userRoles NOT LIKE '%TEAM_LEADER%' THEN
        action_code := '00306';
        RAISE EXCEPTION 'User role is not available for this order type.';
      END IF;

      IF (
        SELECT COUNT(*)
        FROM "order".order o
        WHERE o.order_type = 'TEA_TIME'
        AND o.user_id = userId
        AND (DATE_PART('year', now())) - (DATE_PART('year', o.date)) = 0
        AND (DATE_PART('month', now())) - (DATE_PART('month', o.date)) = 0
      ) > 0 THEN
        action_code := '00307';
        RAISE EXCEPTION 'Order has reached the limit. Try again next month!';
      END IF;

    ELSEIF _order_type = '5' THEN
      totalAmount := 0;
      IF userRoles NOT LIKE '%BRONZE_MASTER%' THEN
        action_code := '00306';
        RAISE EXCEPTION 'User role is not available for this order type.';
      END IF;

      IF (
        SELECT COUNT(*)
        FROM "order".order o
        WHERE o.order_type = 'BRONZE_MASTER'
        AND o.user_id = userId
        AND (o.date::DATE) = (now()::DATE)
      ) > 0 THEN
        action_code := '00307';
        RAISE EXCEPTION 'Order has reached the limit. Try again tomorrow!';
      END IF;

    ELSE
      totalAmount := subtotalAmount;
    END IF;

    -- CREATE ORDER
    WITH new_order AS (
      INSERT INTO "order".order(order_type, subtotal, total, remark, user_id)
      VALUES (orderType, subtotalAmount, totalAmount, _remark, userId)
      RETURNING id, uuid, 1 AS result
    )
    SELECT new_order.id, new_order.uuid, new_order.result INTO orderId, orderUUID, rowCount
    FROM new_order;

    -- CREATE ORDER DETAILS & STOCK OUT FROM REFRIGERATOR
    iterator := 1;
    FOREACH productId IN ARRAY productIds LOOP
      INSERT INTO "order".order_detail(quantity, unit_price, order_id, product_id)
      VALUES (productQtys[iterator], productPrices[iterator], orderId, productId);

      SELECT * INTO stockOutCode
      FROM "stock".fn_order_from_refrigerator(productUUIDs[iterator], productQtys[iterator], orderUUID);

      IF stockOutCode != '00000' THEN
        action_code := '00304';
        RAISE EXCEPTION 'Failed to stock out from refrigerator.';
      END IF;

      rowCount := rowCount + 1;
      iterator := iterator + 1;
    END LOOP;

    IF _order_type = '1' THEN
      SELECT * INTO balanceCode
      FROM "user".fn_update_balance(_user_uuid, '-', totalAmount);

      IF balanceCode != '00000' THEN
        action_code := '00305';
        RAISE EXCEPTION 'Failed to update balance of user.';

      ELSE
        rowCount := rowCount + 1;
      END IF;

      IF rowCount = cardinality(productUUIDs) + 2 THEN -- detail + order + user
        action_code := '00000';
        RAISE NOTICE 'Ordered successfully.';
      END IF;
    END IF;

    IF rowCount = cardinality(productUUIDs) + 1 THEN -- detail + order
      action_code := '00000';
      RAISE NOTICE 'Ordered successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Ordered unsuccessfully.';
      END IF;

      RAISE INFO 'Error Name: %', SQLERRM;
      RAISE INFO 'Error State: %', SQLSTATE;
  END;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  RETURN DEBT MONEY
 *******************************************************/
SELECT * FROM "order".fn_return_debt_money('3203d33b-f6aa-4cbf-a230-b55224d12248');

CREATE OR REPLACE FUNCTION "order".fn_return_debt_money (
  IN _order_uuid    VARCHAR(50),
  OUT action_code   VARCHAR(10)
)
RETURNS VARCHAR(10)
AS $$
DECLARE
  orderId     INTEGER := 0;
  rowCount    INTEGER := 0;
BEGIN
  BEGIN
    action_code := '00001';

    IF _order_uuid = '' OR _order_uuid IS NULL THEN
      action_code := '00101';
      RAISE EXCEPTION 'Order UUID is empty.';

    ELSE
      SELECT id INTO orderId
      FROM "order".order
      WHERE uuid = _order_uuid;

    END IF;

    IF orderId IS NULL THEN
      action_code := '00201';
      RAISE EXCEPTION 'Order UUID is invalid.';
    END IF;

    IF (SELECT order_type FROM "order".order WHERE id = orderId) != 'DEBT' THEN
      action_code := '00301';
      RAISE EXCEPTION 'Order type is not support returning money.';
    END IF;

    WITH updated AS (
      UPDATE "order".order SET
        return_date = now(),
        order_type = (SELECT order_type FROM "order".order_type WHERE id = 3) -- PAID
      WHERE id = orderId
      RETURNING 1 AS result
    )
    SELECT result INTO rowCount
    FROM updated;

    IF rowCount = 1 THEN
      action_code := '00000';
      RAISE NOTICE 'Debt money has been returned successfully.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
      IF action_code = '00001' THEN
        RAISE INFO 'Debt money has been returned unsuccessfully.';
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
SELECT * FROM "order".fn_read_order_history_for_user('2688d7bf-8e7e-4217-a00f-a9d5edd5f134', 1, 100);

CREATE OR REPLACE FUNCTION "order".fn_read_order_history_for_user (
  IN _user_uuid             VARCHAR(50),
  IN _page                  INTEGER,
  IN _limit                 INTEGER
)
RETURNS TABLE (
  "order_type"              VARCHAR(50),
  "order_date"              TIMESTAMP,
  "order_return_date"       TIMESTAMP,
  "order_subtotal"          DOUBLE PRECISION,
  "order_total"             DOUBLE PRECISION,
  "order_remark"            VARCHAR(255),
  "order_uuid"              VARCHAR(50)
)
AS $$
BEGIN
  RETURN QUERY
    SELECT
      "order".order_type,
      "order".date,
      "order".return_date,
      "order".subtotal,
      "order".total,
      "order".remark,
      "order".uuid

    FROM "order".order
    INNER JOIN "user".user
      ON "order".user_id = "user".id
    WHERE "user".uuid = _user_uuid
    ORDER BY "order".date DESC
    LIMIT _limit
    OFFSET (_page - 1) * _limit;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  USER ORDER HISTORY PAGINATION BY DATE
 *******************************************************/
SELECT * FROM "order".fn_read_order_history_for_user('2688d7bf-8e7e-4217-a00f-a9d5edd5f134', '2019-01-01', '2019-12-31');

CREATE OR REPLACE FUNCTION "order".fn_read_order_history_for_user (
  IN _user_uuid             VARCHAR(50),
  IN _from_date             VARCHAR(10),
  IN _to_date               VARCHAR(10)
)
RETURNS TABLE (
  "order_type"              VARCHAR(50),
  "order_date"              TIMESTAMP,
  "order_return_date"       TIMESTAMP,
  "order_subtotal"          DOUBLE PRECISION,
  "order_total"             DOUBLE PRECISION,
  "order_remark"            VARCHAR(255),
  "order_uuid"              VARCHAR(50)
)
AS $$
BEGIN
  RETURN QUERY
    SELECT
      "order".order_type,
      "order".date,
      "order".return_date,
      "order".subtotal,
      "order".total,
      "order".remark,
      "order".uuid

    FROM "order".order
    INNER JOIN "user".user
      ON "order".user_id = "user".id
    WHERE "user".uuid = _user_uuid AND
      "order".date >=  CONCAT(_from_date, ' 00:00:00'):: TIMESTAMP AND
      "order".date <  CONCAT(_to_date, ' 00:00:00'):: TIMESTAMP
    ORDER BY "order".date ASC;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  TEA TIME ORDER HISTORY
 *******************************************************/
SELECT * FROM "order".fn_read_order_history_of_tea_time(1, 100);

CREATE OR REPLACE FUNCTION "order".fn_read_order_history_of_tea_time (
  IN _page                  INTEGER,
  IN _limit                 INTEGER
)
RETURNS TABLE (
  "order_type"              VARCHAR(50),
  "order_date"              TIMESTAMP,
  "order_subtotal"          DOUBLE PRECISION,
  "order_total"             DOUBLE PRECISION,
  "order_remark"            VARCHAR(255),
  "order_uuid"              VARCHAR(50),
  "user_uuid"               VARCHAR(50),
  "user_en_name"            VARCHAR(100),
  "user_kh_name"            VARCHAR(100),
  "user_kr_name"            VARCHAR(100),
  "user_gender"             VARCHAR(1),
  "user_image"              VARCHAR(110),
  "user_role"               VARCHAR(255),
  "user_created_date"       TIMESTAMP,
  "user_emplyment_status"   VARCHAR(50),
  "user_status"             VARCHAR(1),
  "position"                VARCHAR(100),
  "position_type"           VARCHAR(100),
  "position_uuid"           VARCHAR(50),
  "team_uuid"               VARCHAR(50),
  "team_name"               VARCHAR(100),
  "team_remark"             VARCHAR(100),
  "team_status"             VARCHAR(100),
  "department_uuid"         VARCHAR(50),
  "department_name"         VARCHAR(100),
  "department_remark"       VARCHAR(100),
  "department_status"       VARCHAR(100)
)
AS $$
BEGIN
  RETURN QUERY
    SELECT
      "order".order_type,
      "order".date,
      "order".subtotal,
      "order".total,
      "order".remark,
      "order".uuid,
      "user".uuid,
      "user".en_name,
      "user".kh_name,
      "user".kr_name,
      "user".gender,
      (
        SELECT CONCAT(image.name, image.type)
        FROM "user".image
        WHERE image.id = "user".image_id
      ) :: VARCHAR(110),
      "user".role,
      "user".created_date,
      employment_status.status,
      "user".status,
      p.position,
      p.type,
      p.uuid,
      team.uuid,
      team.name,
      team.remark,
      team.status,
      department.uuid,
      department.name,
      department.remark,
      department.status

    FROM "order".order
    INNER JOIN "user".user
      ON "order".user_id = "user".id
    LEFT JOIN "user".team
      ON "user".team_id = team.id
    LEFT JOIN "user".department
      ON team.department_id = department.id
    INNER JOIN "user".employment_status
      ON "user".employment_status = employment_status.id
    INNER JOIN "user".position p
      ON "user".position = p.id
    WHERE "order".order_type = 'TEA_TIME'
    ORDER BY "order".date DESC
    LIMIT _limit
    OFFSET (_page - 1) * _limit;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  BRONZE MASTER ORDER HISTORY
 *******************************************************/
SELECT * FROM "order".fn_read_order_history_of_bronze_master(1, 100);

CREATE OR REPLACE FUNCTION "order".fn_read_order_history_of_bronze_master (
  IN _page                  INTEGER,
  IN _limit                 INTEGER
)
RETURNS TABLE (
  "order_type"              VARCHAR(50),
  "order_date"              TIMESTAMP,
  "order_subtotal"          DOUBLE PRECISION,
  "order_total"             DOUBLE PRECISION,
  "order_remark"            VARCHAR(255),
  "order_uuid"              VARCHAR(50),
  "user_uuid"               VARCHAR(50),
  "user_en_name"            VARCHAR(100),
  "user_kh_name"            VARCHAR(100),
  "user_kr_name"            VARCHAR(100),
  "user_gender"             VARCHAR(1),
  "user_image"              VARCHAR(110),
  "user_role"               VARCHAR(255),
  "user_created_date"       TIMESTAMP,
  "user_emplyment_status"   VARCHAR(50),
  "user_status"             VARCHAR(1),
  "position"                VARCHAR(100),
  "position_type"           VARCHAR(100),
  "position_uuid"           VARCHAR(50),
  "team_uuid"               VARCHAR(50),
  "team_name"               VARCHAR(100),
  "team_remark"             VARCHAR(100),
  "team_status"             VARCHAR(100),
  "department_uuid"         VARCHAR(50),
  "department_name"         VARCHAR(100),
  "department_remark"       VARCHAR(100),
  "department_status"       VARCHAR(100)
)
AS $$
BEGIN
  RETURN QUERY
    SELECT
      "order".order_type,
      "order".date,
      "order".subtotal,
      "order".total,
      "order".remark,
      "order".uuid,
      "user".uuid,
      "user".en_name,
      "user".kh_name,
      "user".kr_name,
      "user".gender,
      (
        SELECT CONCAT(image.name, image.type)
        FROM "user".image
        WHERE image.id = "user".image_id
      ) :: VARCHAR(110),
      "user".role,
      "user".created_date,
      employment_status.status,
      "user".status,
      p.position,
      p.type,
      p.uuid,
      team.uuid,
      team.name,
      team.remark,
      team.status,
      department.uuid,
      department.name,
      department.remark,
      department.status

    FROM "order".order
    INNER JOIN "user".user
      ON "order".user_id = "user".id
    LEFT JOIN "user".team
      ON "user".team_id = team.id
    LEFT JOIN "user".department
      ON team.department_id = department.id
    INNER JOIN "user".employment_status
      ON "user".employment_status = employment_status.id
    INNER JOIN "user".position p
      ON "user".position = p.id
    WHERE "order".order_type = 'BRONZE_MASTER'
    ORDER BY "order".date DESC
    LIMIT _limit
    OFFSET (_page - 1) * _limit;
END;
$$
LANGUAGE 'plpgsql';


/********************************************************
  ORDER DETAIL
 *******************************************************/
SELECT * FROM "order".fn_read_order_detail('c01c5bdd-bdad-4d08-a711-2fd4775f7918');

CREATE OR REPLACE FUNCTION "order".fn_read_order_detail (
  IN _order_uuid            VARCHAR(50)
)
RETURNS TABLE (
  "product_uuid"             VARCHAR(50),
  "product_name"             VARCHAR(100),
  "product_image_name"       VARCHAR(110),
  "product_status"           VARCHAR(1),
  "product_price"            DOUBLE PRECISION,
  "order_quantity"           INTEGER
)
AS $$
DECLARE
  orderId                   INTEGER;
BEGIN
  SELECT id INTO orderId
  FROM "order"."order"
  WHERE uuid = _order_uuid;

  IF orderId IS NULL THEN
    RETURN;
  END IF;

  RETURN QUERY
    SELECT
      product.uuid,
      product.name,
      CONCAT(image.name, image.type) :: VARCHAR(110),
      product.status,
      order_detail.unit_price,
      order_detail.quantity

    FROM "order".order
    INNER JOIN "order".order_detail
      ON "order".id = order_detail.order_id
    INNER JOIN  "stock".product
      ON order_detail.product_id = product.id
    INNER JOIN "stock".image
      ON product.image_id = image.id
    WHERE order_detail.order_id = orderId
    ORDER BY order_detail.quantity DESC;
END;
$$
LANGUAGE 'plpgsql';
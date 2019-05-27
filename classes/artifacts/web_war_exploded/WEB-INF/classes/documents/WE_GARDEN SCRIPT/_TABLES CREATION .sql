-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP SCHEMA IF EXISTS "stock" CASCADE;
DROP SCHEMA IF EXISTS "order" CASCADE;
DROP SCHEMA IF EXISTS "user" CASCADE;

/*************************************************************
SCHEMA STOCK
*************************************************************/
CREATE SCHEMA IF NOT EXISTS "stock";

/* IMAGE */
DROP TABLE IF EXISTS "stock".IMAGE;
CREATE TABLE "stock".IMAGE (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    type            VARCHAR(10) NOT NULL,
    status          VARCHAR(1) NOT NULL DEFAULT '1',
    uuid            VARCHAR(50) NOT NULL DEFAULT public.uuid_generate_v4()
);

/* CATEGORY */
DROP TABLE IF EXISTS "stock".CATEGORY;
CREATE TABLE "stock".CATEGORY (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    remark          VARCHAR(255) DEFAULT NULL,
    status          VARCHAR(1) NOT NULL DEFAULT '1',
    uuid            VARCHAR(50) NOT NULL DEFAULT public.uuid_generate_v4()
);

/* PRODUCT */
DROP TABLE IF EXISTS "stock".PRODUCT;
CREATE TABLE "stock".PRODUCT (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    price           DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    status          VARCHAR(1) NOT NULL DEFAULT '1',
    uuid            VARCHAR(50) NOT NULL DEFAULT public.uuid_generate_v4()
);

/* STOCK */
DROP TABLE IF EXISTS "stock".STOCK;
CREATE TABLE "stock".STOCK (
    id              SERIAL PRIMARY KEY,
    stock_in        INTEGER NULL,
    stock_out       INTEGER NULL,
    quantity        INTEGER NOT NULL,
    updated_date    TIMESTAMP NOT NULL DEFAULT now()
);

/* REFRIGERATOR */
DROP TABLE IF EXISTS "stock".REFRIGERATOR;
CREATE TABLE "stock".REFRIGERATOR (
    id              SERIAL PRIMARY KEY,
    stock_in        INTEGER NULL,
    stock_out       INTEGER NULL,
    quantity        INTEGER NOT NULL,
    updated_date    TIMESTAMP NOT NULL DEFAULT now()
);


/*************************************************************
SCHEMA ORDER
*************************************************************/
CREATE SCHEMA IF NOT EXISTS "order";

/* ORDER */
DROP TABLE IF EXISTS "order".ORDER;
CREATE TABLE "order".ORDER (
    id              SERIAL PRIMARY KEY,
    order_type      VARCHAR(50) NOT NULL,
    subtotal        DOUBLE PRECISION NOT NULL,
    total           DOUBLE PRECISION NOT NULL,
    date            TIMESTAMP NOT NULL DEFAULT now(),
    remark          VARCHAR(255) NULL DEFAULT NULL,
    uuid            VARCHAR(50) NOT NULL DEFAULT public.uuid_generate_v4(),
    return_date     TIMESTAMP NULL DEFAULT NULL
);

/* ORDER_DETAIL */
DROP TABLE IF EXISTS "order".ORDER_DETAIL;
CREATE TABLE "order".ORDER_DETAIL (
    id              SERIAL PRIMARY KEY,
    quantity        INTEGER NOT NULL,
    unit_price      DOUBLE PRECISION NOT NULL
);

/* ORDER_TYPE */
DROP TABLE IF EXISTS "order".ORDER_TYPE;
CREATE TABLE "order".ORDER_TYPE (
    id              SERIAL PRIMARY KEY,
    order_type      VARCHAR(50) NOT NULL
);

INSERT INTO "order".ORDER_TYPE(order_type) VALUES ('CREDIT');
INSERT INTO "order".ORDER_TYPE(order_type) VALUES ('DEBT');
INSERT INTO "order".ORDER_TYPE(order_type) VALUES ('PAID');
INSERT INTO "order".ORDER_TYPE(order_type) VALUES ('TEA_TIME');
INSERT INTO "order".ORDER_TYPE(order_type) VALUES ('BRONZE_MASTER');


/*************************************************************
SCHEMA USER
*************************************************************/
CREATE SCHEMA IF NOT EXISTS "user";

/* IMAGE */
DROP TABLE IF EXISTS "user".IMAGE;
CREATE TABLE "user".IMAGE (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    type            VARCHAR(10) NOT NULL,
    status          VARCHAR(1) NOT NULL DEFAULT '1',
    uuid            VARCHAR(50) NOT NULL DEFAULT public.uuid_generate_v4()
);

/* DEPARTMENT */
DROP TABLE IF EXISTS "user".DEPARTMENT;
CREATE TABLE "user".DEPARTMENT (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    first_manager   INTEGER NOT NULL,
    second_manager  INTEGER NOT NULL,
    remark          VARCHAR(10) NULL DEFAULT NULL,
    status          VARCHAR(1) NOT NULL DEFAULT '1',
    uuid            VARCHAR(50) NOT NULL DEFAULT public.uuid_generate_v4()
);

/* TEAM */
DROP TABLE IF EXISTS "user".TEAM;
CREATE TABLE "user".TEAM (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    remark          VARCHAR(10) NULL DEFAULT NULL,
    status          VARCHAR(1) NOT NULL DEFAULT '1',
    uuid            VARCHAR(50) NOT NULL DEFAULT public.uuid_generate_v4()
);

/* EMPLOYMENT STATUS */
DROP TABLE IF EXISTS "user".EMPLOYMENT_STATUS;
CREATE TABLE "user".EMPLOYMENT_STATUS (
  id                INTEGER PRIMARY KEY,
  status            VARCHAR(50)
);

INSERT INTO "user".EMPLOYMENT_STATUS(id, status) VALUES (1, 'EXECUTIVE');
INSERT INTO "user".EMPLOYMENT_STATUS(id, status) VALUES (2, 'FEC');
INSERT INTO "user".EMPLOYMENT_STATUS(id, status) VALUES (3, 'PROBATION');

/* POSITION */
DROP TABLE IF EXISTS "user".POSITION;
CREATE TABLE "user".POSITION (
  id                SERIAL PRIMARY KEY,
  position          VARCHAR(100),
  type              VARCHAR(100)
);


/* USER */
DROP TABLE IF EXISTS "user".USER;
CREATE TABLE "user".USER (
    id                  SERIAL PRIMARY KEY,
    id_card_number      INTEGER NULL,
    en_name             VARCHAR(100) NOT NULL,
    kh_name             VARCHAR(100) NULL DEFAULT NULL,
    kr_name             VARCHAR(100) NULL DEFAULT NULL,
    duty                VARCHAR(255) NULL,

    gender              VARCHAR(1) NULL,
    dob                 DATE NULL,
    phone_number        VARCHAR(50) NULL,
    email               VARCHAR(255) NULL,

    username            VARCHAR(50) NULL,
    password            VARCHAR(255) NULL,

    credit_balance      DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    role                VARCHAR(255) NOT NULL,
    token               VARCHAR(255) NULL DEFAULT NULL,
    created_date        TIMESTAMP NOT NULL DEFAULT now(),
    uuid                VARCHAR(50) NOT NULL DEFAULT public.uuid_generate_v4()
);

/* NOTIFICATION */
DROP TABLE IF EXISTS "user".NOTIFICATION;
CREATE TABLE "user".NOTIFICATION (
    id              SERIAL PRIMARY KEY,
    key_id          VARCHAR(255) NOT NULL,
    title           VARCHAR(100) NOT NULL,
    message         VARCHAR(255) NOT NULL
);

/* TOP_UP */
DROP TABLE IF EXISTS "user".TOP_UP;
CREATE TABLE "user".TOP_UP (
    id              SERIAL PRIMARY KEY,
    amount          DOUBLE PRECISION NOT NULL,
    date            TIMESTAMP NOT NULL DEFAULT now()
);

/* ROLE_TYPE */
DROP TABLE IF EXISTS "user".ROLE_TYPE;
CREATE TABLE "user".ROLE_TYPE (
    id              SERIAL PRIMARY KEY,
    role_type       VARCHAR(50) NOT NULL
);

INSERT INTO "user".ROLE_TYPE(role_type) VALUES ('ADMIN');
INSERT INTO "user".ROLE_TYPE(role_type) VALUES ('USER');
INSERT INTO "user".ROLE_TYPE(role_type) VALUES ('TEAM LEADER');
INSERT INTO "user".ROLE_TYPE(role_type) VALUES ('BRONZE MASTER');




/*************************************************************
SCHEMA STOCK
*************************************************************/

/* CATEGORY CONSTRAINTS */
ALTER TABLE "stock".CATEGORY ADD CONSTRAINT uc_category_uuid UNIQUE (uuid);

/* PRODUCT CONSTRAINTS */
ALTER TABLE "stock".PRODUCT ADD CONSTRAINT uc_product_uuid UNIQUE (uuid);

ALTER TABLE "stock".PRODUCT
    ADD COLUMN category_id INTEGER NOT NULL,
    ADD CONSTRAINT fk_product_category
    FOREIGN KEY (category_id)
    REFERENCES "stock".CATEGORY (id);

ALTER TABLE "stock".PRODUCT
    ADD COLUMN image_id INTEGER NOT NULL,
    ADD CONSTRAINT fk_product_image
    FOREIGN KEY (image_id)
    REFERENCES "stock".IMAGE (id);

/* STOCK CONSTRAINTS */
ALTER TABLE "stock".STOCK
    ADD COLUMN product_id INTEGER NOT NULL,
    ADD CONSTRAINT fk_stock_product
    FOREIGN KEY (product_id)
    REFERENCES "stock".PRODUCT (id);

/* REFRIGERATOR CONSTRAINTS */
ALTER TABLE "stock".REFRIGERATOR
    ADD COLUMN product_id INTEGER NOT NULL,
    ADD CONSTRAINT fk_refrigerator_product
    FOREIGN KEY (product_id)
    REFERENCES "stock".PRODUCT (id);

ALTER TABLE "stock".REFRIGERATOR
    ADD COLUMN order_id INTEGER NULL DEFAULT NULL,
    ADD CONSTRAINT fk_refrigerator_order
    FOREIGN KEY (order_id)
    REFERENCES "order".ORDER (id);


/*************************************************************
SCHEMA ORDER
*************************************************************/

/* ORDER CONSTRAINTS */
ALTER TABLE "order".ORDER ADD CONSTRAINT uc_order_uuid UNIQUE (uuid);

ALTER TABLE "order".ORDER_TYPE ADD CONSTRAINT uc_order_type UNIQUE (order_type);

ALTER TABLE "order".ORDER
    ADD COLUMN user_id INTEGER NOT NULL,
    ADD CONSTRAINT fk_order_user
    FOREIGN KEY (user_id)
    REFERENCES "user".USER (id);

/* ORDER_DETAIL CONSTRAINTS */
ALTER TABLE "order".ORDER_DETAIL
    ADD COLUMN order_id INTEGER NOT NULL,
    ADD CONSTRAINT fk_order_detail_order
    FOREIGN KEY (order_id)
    REFERENCES "order".ORDER (id);

ALTER TABLE "order".ORDER_DETAIL
    ADD COLUMN product_id INTEGER NOT NULL,
    ADD CONSTRAINT fk_order_detail_product
    FOREIGN KEY (product_id)
    REFERENCES "stock".PRODUCT (id);


/*************************************************************
SCHEMA USER
*************************************************************/
ALTER TABLE "user".ROLE_TYPE ADD CONSTRAINT uc_role_type UNIQUE (role_type);

/* DEPARTMENT CONSTRAINTS */
ALTER TABLE "user".DEPARTMENT ADD CONSTRAINT uc_department_name UNIQUE (name);

ALTER TABLE "user".DEPARTMENT ADD CONSTRAINT uc_department_uuid UNIQUE (uuid);

ALTER TABLE "user".TEAM ADD CONSTRAINT uc_team_uuid UNIQUE (uuid);

/* USER CONSTRAINTS */
ALTER TABLE "user".USER ADD CONSTRAINT uc_user_id_card_number UNIQUE (id_card_number);

ALTER TABLE "user".USER ADD CONSTRAINT uc_user_phone_number UNIQUE (phone_number);

ALTER TABLE "user".USER ADD CONSTRAINT uc_user_username UNIQUE (username);

ALTER TABLE "user".USER ADD CONSTRAINT uc_user_token UNIQUE (token);

ALTER TABLE "user".USER ADD CONSTRAINT uc_user_uuid UNIQUE (uuid);

ALTER TABLE "user".TEAM
    ADD COLUMN department_id INTEGER NOT NULL,
    ADD CONSTRAINT fk_team_department
    FOREIGN KEY (department_id)
    REFERENCES "user".DEPARTMENT (id);

ALTER TABLE "user".USER
    ADD COLUMN first_manager INTEGER NULL,
    ADD CONSTRAINT fk_user_first_manager
    FOREIGN KEY (first_manager)
    REFERENCES "user".USER (id);

ALTER TABLE "user".USER
    ADD COLUMN second_manager INTEGER NULL,
    ADD CONSTRAINT fk_user_second_manager
    FOREIGN KEY (second_manager)
    REFERENCES "user".USER (id);

ALTER TABLE "user".USER
    ADD COLUMN position INTEGER NOT NULL,
    ADD CONSTRAINT fk_user_position
    FOREIGN KEY (position)
    REFERENCES "user".POSITION (id);

ALTER TABLE "user".USER
    ADD COLUMN employment_status INTEGER NOT NULL,
    ADD CONSTRAINT fk_user_employment_status
    FOREIGN KEY (employment_status)
    REFERENCES "user".EMPLOYMENT_STATUS (id);

ALTER TABLE "user".USER DROP CONSTRAINT fk_user_department;
ALTER TABLE "user".USER DROP team_id;
ALTER TABLE "user".USER
    ADD COLUMN team_id INTEGER NULL,
    ADD CONSTRAINT fk_user_department
    FOREIGN KEY (team_id)
    REFERENCES "user".TEAM (id);

ALTER TABLE "user".USER
    ADD COLUMN image_id INTEGER NULL,
    ADD CONSTRAINT fk_user_image
    FOREIGN KEY (image_id)
    REFERENCES "user".IMAGE (id);

/* NOTIFICATION CONSTRAINTS */
ALTER TABLE "user".NOTIFICATION
    ADD COLUMN user_id INTEGER NOT NULL,
    ADD CONSTRAINT fk_notification_user
    FOREIGN KEY (user_id)
    REFERENCES "user".USER (id);

/* TOP_UP CONSTRAINTS */
ALTER TABLE "user".TOP_UP
    ADD COLUMN user_id INTEGER NOT NULL,
    ADD CONSTRAINT fk_top_up_user
    FOREIGN KEY (user_id)
    REFERENCES "user".USER (id);
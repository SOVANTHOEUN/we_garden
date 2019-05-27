/********************************************************
  GET ALL NOTIFICATIONS BY USER
 *******************************************************/

CREATE OR REPLACE FUNCTION "user".fn_read_notifications (
  _user_uuid VARCHAR(50)
)
RETURNS TABLE (
  "key_id"          VARCHAR(255),
  "title"           VARCHAR(100),
  "message"         VARCHAR(255),
  "created_date"    TIMESTAMP
)
AS $$
DECLARE
  userId  INTEGER;
BEGIN
  IF _user_uuid = '' OR _user_uuid IS NULL THEN
    RETURN;
  END IF;

  SELECT id INTO userId
  FROM "user".user
  WHERE uuid = _user_uuid;

  IF userId IS NULL THEN
    RETURN;
  END IF;

  RETURN QUERY
    SELECT
      notification.key_id,
      COALESCE(notification.title, ''),
      COALESCE(notification.message, ''),
      notification.created_date

    FROM "user".notification
    WHERE notification.user_id = userId
    ORDER BY notification.created_date DESC;
END;
$$
LANGUAGE 'plpgsql';
--liquibase formatted sql

--changeset lukesukhanov:3 splitStatements:false
/* Trigger function for synchronizing 'created_at' column before INSERT */
CREATE FUNCTION sync_created_at_column_before_insert() RETURNS trigger AS $sync$
BEGIN
	NEW.created_at := now();
	RETURN NEW;
END;
$sync$ LANGUAGE plpgsql;
--rollback DROP FUNCTION sync_created_at_column_before_insert;

--changeset lukesukhanov:4 splitStatements:false
/* Trigger function for synchronizing 'created_at' column before UPDATE */
CREATE FUNCTION sync_created_at_column_before_update() RETURNS trigger AS $sync$
BEGIN
	NEW.created_at := OLD.created_at;
	RETURN NEW;
END;
$sync$ LANGUAGE plpgsql;
--rollback DROP FUNCTION sync_created_at_column_before_update;

--changeset lukesukhanov:5 splitStatements:false
/* Trigger function for synchronizing 'last_modified_at' column before INSERT or UPDATE */
CREATE FUNCTION sync_last_modified_at_column_before_insert_or_update() RETURNS trigger AS $sync$
BEGIN
	NEW.last_modified_at := now();
	RETURN NEW;
END;
$sync$ LANGUAGE plpgsql;
--rollback DROP FUNCTION sync_last_modified_at_column_before_insert_or_update;
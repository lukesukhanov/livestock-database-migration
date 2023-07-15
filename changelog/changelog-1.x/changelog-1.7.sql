--liquibase formatted sql

--changeset lukesukhanov:22
CREATE TABLE authorities (
	users_id bigint NOT NULL REFERENCES users(id) ON DELETE CASCADE,
	authority varchar NOT NULL,
	created_at timestamp with time zone NOT NULL,
	last_modified_at timestamp with time zone NOT NULL,
	PRIMARY KEY (users_id, authority)
);
-- rollback DROP TABLE authorities;

--changeset lukesukhanov:23
/* Trigger for synchronizing 'created_at' column before INSERT */
CREATE TRIGGER sync_created_at_column_before_insert
	BEFORE INSERT
	ON authorities
	FOR EACH ROW 
	EXECUTE FUNCTION sync_created_at_column_before_insert();
--rollback DROP TRIGGER sync_created_at_column_before_insert ON authorities;

--changeset lukesukhanov:24
/* Trigger for synchronizing 'created_at' column before UPDATE*/
CREATE TRIGGER sync_created_at_column_before_update
	BEFORE UPDATE
	ON authorities
	FOR EACH ROW 
	EXECUTE FUNCTION sync_created_at_column_before_update();
--rollback DROP TRIGGER sync_created_at_column_before_update ON authorities;

--changeset lukesukhanov:25
/* Trigger for synchronizing 'last_modified_at' column before INSERT or UPDATE*/
CREATE TRIGGER sync_last_modified_at_column_before_insert_or_update
	BEFORE INSERT OR UPDATE
	ON authorities
	FOR EACH ROW 
	EXECUTE FUNCTION sync_last_modified_at_column_before_insert_or_update();
--rollback DROP TRIGGER sync_last_modified_at_column_before_insert_or_update ON authorities;
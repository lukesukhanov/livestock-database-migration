--liquibase formatted sql

--changeset lukesukhanov:35
CREATE TABLE product_image (
	id bigint NOT NULL PRIMARY KEY DEFAULT nextval('common_id_seq'),
	image bytea NOT NULL,
	created_at timestamp with time zone NOT NULL,
	last_modified_at timestamp with time zone NOT NULL,
	product_id bigint NOT NULL REFERENCES product(id) ON DELETE CASCADE
);
--rollback DROP TABLE product_image;

--changeset lukesukhanov:36
/* Trigger for synchronizing 'created_at' column before INSERT */
CREATE TRIGGER sync_created_at_column_before_insert
	BEFORE INSERT
	ON product_image
	FOR EACH ROW 
	EXECUTE FUNCTION sync_created_at_column_before_insert();
--rollback DROP TRIGGER sync_created_at_column_before_insert ON product_image;

--changeset lukesukhanov:37
/* Trigger for synchronizing 'created_at' column before UPDATE*/
CREATE TRIGGER sync_created_at_column_before_update
	BEFORE UPDATE
	ON product_image
	FOR EACH ROW 
	EXECUTE FUNCTION sync_created_at_column_before_update();
--rollback DROP TRIGGER sync_created_at_column_before_update ON product_image;

--changeset lukesukhanov:38
/* Trigger for synchronizing 'last_modified_at' column before INSERT or UPDATE*/
CREATE TRIGGER sync_last_modified_at_column_before_insert_or_update
	BEFORE INSERT OR UPDATE
	ON product_image
	FOR EACH ROW 
	EXECUTE FUNCTION sync_last_modified_at_column_before_insert_or_update();
--rollback DROP TRIGGER sync_last_modified_at_column_before_insert_or_update ON product_image;
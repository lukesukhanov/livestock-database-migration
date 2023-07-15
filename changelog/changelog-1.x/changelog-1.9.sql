--liquibase formatted sql

--changeset lukesukhanov:30
CREATE TABLE product (
	id bigint NOT NULL PRIMARY KEY DEFAULT nextval('common_id_seq'),
	product_name varchar NOT NULL,
	description varchar,
	quantity integer NOT NULL CHECK(quantity >= 0),
	price numeric NOT NULL CHECK(price > 0),
	currency varchar(3) NOT NULL,
	created_at timestamp with time zone NOT NULL,
	last_modified_at timestamp with time zone NOT NULL,
	category_id bigint NOT NULL REFERENCES category(id) ON DELETE CASCADE
);
--rollback DROP TABLE product;

--changeset lukesukhanov:31
/* Trigger for synchronizing 'created_at' column before INSERT */
CREATE TRIGGER sync_created_at_column_before_insert
	BEFORE INSERT
	ON product
	FOR EACH ROW 
	EXECUTE FUNCTION sync_created_at_column_before_insert();
--rollback DROP TRIGGER sync_created_at_column_before_insert ON product;

--changeset lukesukhanov:32
/* Trigger for synchronizing 'created_at' column before UPDATE*/
CREATE TRIGGER sync_created_at_column_before_update
	BEFORE UPDATE
	ON product
	FOR EACH ROW 
	EXECUTE FUNCTION sync_created_at_column_before_update();
--rollback DROP TRIGGER sync_created_at_column_before_update ON product;

--changeset lukesukhanov:33
/* Trigger for synchronizing 'last_modified_at' column before INSERT or UPDATE*/
CREATE TRIGGER sync_last_modified_at_column_before_insert_or_update
	BEFORE INSERT OR UPDATE
	ON product
	FOR EACH ROW 
	EXECUTE FUNCTION sync_last_modified_at_column_before_insert_or_update();
--rollback DROP TRIGGER sync_last_modified_at_column_before_insert_or_update ON product;

--changeset lukesukhanov:34
CREATE INDEX category_id_idx
	ON product(category_id);
--rollback DROP INDEX category_id_idx;
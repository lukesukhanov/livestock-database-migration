--liquibase formatted sql

--changeset lukesukhanov:45
CREATE TABLE product_in_cart (
	id bigint NOT NULL PRIMARY KEY DEFAULT nextval('common_id_seq'),
	quantity integer NOT NULL CHECK (quantity > 0),
	created_at timestamp with time zone NOT NULL,
	last_modified_at timestamp with time zone NOT NULL,
	users_email varchar NOT NULL REFERENCES users(email) ON DELETE CASCADE,
	product_id bigint NOT NULL REFERENCES product(id) ON DELETE CASCADE
);
--rollback DROP TABLE product_in_cart;

--changeset lukesukhanov:46
/* Trigger for synchronizing 'created_at' column before INSERT */
CREATE TRIGGER sync_created_at_column_before_insert
	BEFORE INSERT
	ON product_in_cart
	FOR EACH ROW 
	EXECUTE FUNCTION sync_created_at_column_before_insert();
--rollback DROP TRIGGER sync_created_at_column_before_insert ON product_in_cart;

--changeset lukesukhanov:47
/* Trigger for synchronizing 'created_at' column before UPDATE*/
CREATE TRIGGER sync_created_at_column_before_update
	BEFORE UPDATE
	ON product_in_cart
	FOR EACH ROW 
	EXECUTE FUNCTION sync_created_at_column_before_update();
--rollback DROP TRIGGER sync_created_at_column_before_update ON product_in_cart;

--changeset lukesukhanov:48
/* Trigger for synchronizing 'last_modified_at' column before INSERT or UPDATE*/
CREATE TRIGGER sync_last_modified_at_column_before_insert_or_update
	BEFORE INSERT OR UPDATE
	ON product_in_cart
	FOR EACH ROW 
	EXECUTE FUNCTION sync_last_modified_at_column_before_insert_or_update();
--rollback DROP TRIGGER sync_last_modified_at_column_before_insert_or_update ON product_in_cart;
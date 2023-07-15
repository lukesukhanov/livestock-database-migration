--liquibase formatted sql

--changeset lukesukhanov:14
CREATE TABLE oauth2_authorization_consent (
    registered_client_id varchar(255) NOT NULL,
    principal_name varchar(255) NOT NULL,
    authorities varchar(1000) NOT NULL,
    created_at timestamp with time zone NOT NULL,
	last_modified_at timestamp with time zone NOT NULL,
    PRIMARY KEY (registered_client_id, principal_name)
);
--rollback DROP TABLE oauth2_authorization_consent;

--changeset lukesukhanov:15
/* Trigger for synchronizing 'created_at' column before INSERT */
CREATE TRIGGER sync_created_at_column_before_insert
	BEFORE INSERT
	ON oauth2_authorization_consent
	FOR EACH ROW 
	EXECUTE FUNCTION sync_created_at_column_before_insert();
--rollback DROP TRIGGER sync_created_at_column_before_insert ON oauth2_authorization_consent;

--changeset lukesukhanov:16
/* Trigger for synchronizing 'created_at' column before UPDATE*/
CREATE TRIGGER sync_created_at_column_before_update
	BEFORE UPDATE
	ON oauth2_authorization_consent
	FOR EACH ROW 
	EXECUTE FUNCTION sync_created_at_column_before_update();
-- rollback DROP TRIGGER sync_created_at_column_before_update ON oauth2_authorization_consent;

--changeset lukesukhanov:17
/* Trigger for synchronizing 'last_modified_at' column before INSERT or UPDATE*/
CREATE TRIGGER sync_last_modified_at_column_before_insert_or_update
	BEFORE INSERT OR UPDATE
	ON oauth2_authorization_consent
	FOR EACH ROW 
	EXECUTE FUNCTION sync_last_modified_at_column_before_insert_or_update();
--rollback DROP TRIGGER sync_last_modified_at_column_before_insert_or_update ON oauth2_authorization_consent;
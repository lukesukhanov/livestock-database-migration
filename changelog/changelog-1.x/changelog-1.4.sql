--liquibase formatted sql

--changeset lukesukhanov:10
CREATE TABLE oauth2_authorization (
	id varchar(255) NOT NULL PRIMARY KEY,
	registered_client_id varchar(255) NOT NULL,
    principal_name varchar(255) NOT NULL,
    authorization_grant_type varchar(255) NOT NULL,
    authorized_scopes varchar(1000),
    attributes varchar(4000),
    state varchar(500) DEFAULT NULL,
    authorization_code_value varchar(4000),
    authorization_code_issued_at timestamp,
    authorization_code_expires_at timestamp,
    authorization_code_metadata varchar(2000),
    access_token_value varchar(4000),
    access_token_issued_at timestamp,
    access_token_expires_at timestamp,
    access_token_metadata varchar(2000),
    access_token_type varchar(255),
    access_token_scopes varchar(1000),
    refresh_token_value varchar(4000),
    refresh_token_issued_at timestamp,
    refresh_token_expires_at timestamp,
    refresh_token_metadata varchar(2000),
    oidc_id_token_value varchar(4000),
    oidc_id_token_issued_at timestamp,
    oidc_id_token_expires_at timestamp,
    oidc_id_token_metadata varchar(2000),
    oidc_id_token_claims varchar(2000),
    user_code_value varchar(4000),
    user_code_issued_at timestamp,
    user_code_expires_at timestamp,
    user_code_metadata varchar(2000),
    device_code_value varchar(4000),
    device_code_issued_at timestamp,
    device_code_expires_at timestamp,
    device_code_metadata varchar(2000),
	created_at timestamp with time zone NOT NULL,
	last_modified_at timestamp with time zone NOT NULL
);
--rollback DROP TABLE oauth2_authorization;

--changeset lukesukhanov:11
/* Trigger for synchronizing 'created_at' column before INSERT */
CREATE TRIGGER sync_created_at_column_before_insert
	BEFORE INSERT
	ON oauth2_authorization
	FOR EACH ROW 
	EXECUTE FUNCTION sync_created_at_column_before_insert();
--rollback DROP TRIGGER sync_created_at_column_before_insert ON oauth2_authorization;

--changeset lukesukhanov:12
/* Trigger for synchronizing 'created_at' column before UPDATE*/
CREATE TRIGGER sync_created_at_column_before_update
	BEFORE UPDATE
	ON oauth2_authorization
	FOR EACH ROW 
	EXECUTE FUNCTION sync_created_at_column_before_update();
--rollback DROP TRIGGER sync_created_at_column_before_update ON oauth2_authorization;

--changeset lukesukhanov:13
/* Trigger for synchronizing 'last_modified_at' column before INSERT or UPDATE*/
CREATE TRIGGER sync_last_modified_at_column_before_insert_or_update
	BEFORE INSERT OR UPDATE
	ON oauth2_authorization
	FOR EACH ROW 
	EXECUTE FUNCTION sync_last_modified_at_column_before_insert_or_update();
--rollback DROP TRIGGER sync_last_modified_at_column_before_insert_or_update ON oauth2_authorization;
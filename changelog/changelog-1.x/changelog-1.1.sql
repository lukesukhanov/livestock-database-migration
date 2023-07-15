--liquibase formatted sql

--changeset lukesukhanov:2
/* Single sequence for all 'id' columns */
CREATE SEQUENCE common_id_seq
	AS bigint
	MINVALUE 1
	START 1
	INCREMENT BY 5
	CACHE 1;
--rollback DROP SEQUENCE common_id_seq;
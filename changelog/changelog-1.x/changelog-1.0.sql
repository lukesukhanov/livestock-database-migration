--liquibase formatted sql

--changeset lukesukhanov:1
CREATE SCHEMA livestock;
--rollback DROP SCHEMA livestock;
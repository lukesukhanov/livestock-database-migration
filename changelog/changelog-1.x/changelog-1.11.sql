--liquibase formatted sql

--changeset lukesukhanov:39
INSERT INTO category 
	(category_name)
VALUES 
	('Овцы'),
	('Коровы'),
	('Свиньи'),
	('Лошади'),
	('Козы');
--rollback TRUNCATE category
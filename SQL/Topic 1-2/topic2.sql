DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id			SERIAL PRIMARY KEY,
	nickname	VARCHAR(50) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
	id			SERIAL PRIMARY KEY,
	type_name	VARCHAR(20) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS keywords;
CREATE TABLE keywords (
	id				SERIAL PRIMARY KEY,
	keyword_name	VARCHAR(20) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS mediadb;
CREATE TABLE mediadb (
	id			SERIAL PRIMARY KEY,
	filepath	VARCHAR(255) NOT NULL,
	filename	VARCHAR(64) NOT NULL,
	description	TEXT,
	keywords	VARCHAR(255) COMMENT 'идентификаторы ключевых слов через запятую',
	user_id		INT UNSIGNED NOT NULL,
	uploaded	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	KEY index_of_users(user_id)
);


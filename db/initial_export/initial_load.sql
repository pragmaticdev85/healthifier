CREATE TABLE first_db.`User` (
	id varchar(100) auto_increment NOT NULL,
	username varchar(100) NOT NULL,
	firstName varchar(100) NOT NULL,
	lastName varchar(100) NOT NULL,
	CONSTRAINT User_PK PRIMARY KEY (id),
	CONSTRAINT User_UNIQUE UNIQUE KEY (username)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO first_db.`User` (username,firstName,lastName) VALUES
	 ('first.user','First','User'),
	 ('second.user','Second','User'),
	 ('third.user','Third','User');

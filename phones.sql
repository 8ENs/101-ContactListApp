CREATE TABLE phones (
  phone_id   serial NOT NULL PRIMARY KEY,
	phone      varchar(40) NOT NULL,
  label      varchar(40) NOT NULL,
  contact_id int NOT NULL
);

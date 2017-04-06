DROP TABLE IF EXISTS server;
DROP TABLE IF EXISTS clients;

CREATE TABLE server
(
	id INT,
	client1ID INT,
	client2ID INT,
	ip TEXT
);

CREATE TABLE clients
(
	id INT,
	ip TEXT,
	league TEXT,
	wins INT,
	losses INT
);



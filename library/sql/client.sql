-- Table: client

-- DROP TABLE client;

CREATE TABLE client
(
  id serial NOT NULL,
  prenom character varying,
  age integer,
  CONSTRAINT "CLIENT_PK" PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE client
  OWNER TO postgres;

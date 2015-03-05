-- Table: type

-- DROP TABLE type;

CREATE TABLE type
(
  id serial NOT NULL,
  nom character varying,
  CONSTRAINT type_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE type
  OWNER TO postgres;

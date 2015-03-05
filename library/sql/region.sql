-- Table: region

-- DROP TABLE region;

CREATE TABLE region
(
  id serial NOT NULL,
  nom character varying,
  CONSTRAINT region_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE region
  OWNER TO postgres;

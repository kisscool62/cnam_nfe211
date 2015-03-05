-- Table: departement

-- DROP TABLE departement;

CREATE TABLE departement
(
  id serial NOT NULL,
  nom character varying,
  region_id serial,
  CONSTRAINT departement_pk PRIMARY KEY (id),
  CONSTRAINT region_fk FOREIGN KEY (region_id)
      REFERENCES region (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE departement
  OWNER TO postgres;

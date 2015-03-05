-- Table: ville

-- DROP TABLE ville;

CREATE TABLE ville
(
  id serial NOT NULL,
  departement__id integer,
  nom character varying,
  CONSTRAINT ville_pk PRIMARY KEY (id),
  CONSTRAINT departement_fk FOREIGN KEY (departement__id)
      REFERENCES departement (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE ville
  OWNER TO postgres;

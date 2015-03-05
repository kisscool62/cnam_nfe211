-- Table: adresse

-- DROP TABLE adresse;

CREATE TABLE adresse
(
  id serial NOT NULL,
  adresse character varying,
  ville_id integer,
  CONSTRAINT adresse_pk PRIMARY KEY (id),
  CONSTRAINT ville_fk FOREIGN KEY (ville_id)
      REFERENCES ville (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE adresse
  OWNER TO postgres;

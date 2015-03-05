-- Table: boutique

-- DROP TABLE boutique;

CREATE TABLE boutique
(
  id serial NOT NULL,
  nom character varying,
  adresse_id integer,
  CONSTRAINT boutique_pk PRIMARY KEY (id),
  CONSTRAINT adresse_fk FOREIGN KEY (adresse_id)
      REFERENCES adresse (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE boutique
  OWNER TO postgres;

-- Index: fki_adresse_fk

-- DROP INDEX fki_adresse_fk;

CREATE INDEX fki_adresse_fk
  ON boutique
  USING btree
  (adresse_id);


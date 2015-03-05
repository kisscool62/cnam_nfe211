-- Table: facture

-- DROP TABLE facture;

CREATE TABLE facture
(
  id serial NOT NULL,
  date_achat date,
  boutique_id integer,
  client_id integer,
  livre_id integer,
  CONSTRAINT facture_pk PRIMARY KEY (id),
  CONSTRAINT boutique_fk FOREIGN KEY (boutique_id)
      REFERENCES boutique (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT client_fk FOREIGN KEY (client_id)
      REFERENCES client (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT livre_fk FOREIGN KEY (livre_id)
      REFERENCES livre (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE facture
  OWNER TO postgres;

-- Index: fki_boutique_fk

-- DROP INDEX fki_boutique_fk;

CREATE INDEX fki_boutique_fk
  ON facture
  USING btree
  (boutique_id);

-- Index: fki_client_fk

-- DROP INDEX fki_client_fk;

CREATE INDEX fki_client_fk
  ON facture
  USING btree
  (client_id);

-- Index: fki_livre_fk

-- DROP INDEX fki_livre_fk;

CREATE INDEX fki_livre_fk
  ON facture
  USING btree
  (livre_id);


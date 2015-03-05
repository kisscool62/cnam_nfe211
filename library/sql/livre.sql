-- Table: livre

-- DROP TABLE livre;

CREATE TABLE livre
(
  nom character varying,
  cout numeric,
  id serial NOT NULL,
  type_id integer,
  CONSTRAINT livre_pk PRIMARY KEY (id),
  CONSTRAINT type_fk FOREIGN KEY (type_id)
      REFERENCES type (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE livre
  OWNER TO postgres;

-- Index: fki_type_fk

-- DROP INDEX fki_type_fk;

CREATE INDEX fki_type_fk
  ON livre
  USING btree
  (type_id);


-- Creator:       MySQL Workbench 6.3.10/ExportSQLite Plugin 0.1.0
-- Author:        Hiba Jabri
-- Caption:       New Model
-- Project:       Name of the project
-- Changed:       2019-08-27 13:32
-- Created:       2019-08-06 11:11
PRAGMA foreign_keys = OFF;

-- Schema: MyHOST_META
ATTACH "MyHOST_META.sdb" AS "MyHOST_META";
BEGIN;
CREATE TABLE "MyHOST_META"."Description"(
  "iddescreption" CHAR(20) PRIMARY KEY NOT NULL,
  "pubmed" CHAR(250) DEFAULT NULL,
  "doi" CHAR(200) DEFAULT NULL,
  "description" VARCHAR(500) DEFAULT NULL
);
CREATE TABLE "MyHOST_META"."Taxons"(
  "idtaxon" CHAR(20) PRIMARY KEY NOT NULL,
  "organism" CHAR(250) DEFAULT NULL,
  "lineage" VARCHAR(500) DEFAULT NULL
);
CREATE TABLE "MyHOST_META"."Sequences"(
  "idsequence" CHAR(50) PRIMARY KEY NOT NULL,
  "iddescreption" CHAR(20) DEFAULT NULL,
  "idtaxon" CHAR(20) DEFAULT NULL,
  "seq" VARCHAR(2000) DEFAULT NULL,
  CONSTRAINT "fk_SEQ_Source1"
    FOREIGN KEY("iddescreption")
    REFERENCES "Description"("iddescreption"),
  CONSTRAINT "fk_SEQ_Taxon1"
    FOREIGN KEY("idtaxon")
    REFERENCES "Taxons"("idtaxon")
);
CREATE INDEX "MyHOST_META"."Sequences.fk_SEQ_Source1_idx" ON "Sequences" ("iddescreption");
CREATE INDEX "MyHOST_META"."Sequences.fk_SEQ_Taxon1_idx" ON "Sequences" ("idtaxon");
CREATE TABLE "MyHOST_META"."Wordsets"(
  "idwordset" CHAR(100) PRIMARY KEY NOT NULL,
  "definition" VARCHAR(500) DEFAULT NULL
);
CREATE TABLE "MyHOST_META"."Keywords"(
  "idkeyword" CHAR(100) PRIMARY KEY NOT NULL,
  "idwordset" CHAR(100) DEFAULT NULL,
  CONSTRAINT "fk_Key_Word_SET1"
    FOREIGN KEY("idwordset")
    REFERENCES "Wordsets"("idwordset")
);
CREATE INDEX "MyHOST_META"."Keywords.fk_Key_Word_SET1_idx" ON "Keywords" ("idwordset");
CREATE TABLE "MyHOST_META"."Sources"(
  "idsequence" CHAR(50) NOT NULL,
  "idkeyword" CHAR(100) NOT NULL,
  PRIMARY KEY("idsequence","idkeyword"),
  CONSTRAINT "fk_Keywords_has_Sequences_Keywords1"
    FOREIGN KEY("idkeyword")
    REFERENCES "Keywords"("idkeyword"),
  CONSTRAINT "fk_Keywords_has_Sequences_Sequences1"
    FOREIGN KEY("idsequence")
    REFERENCES "Sequences"("idsequence")
);
CREATE INDEX "MyHOST_META"."Sources.fk_Keywords_has_Sequences_Sequences1_idx" ON "Sources" ("idsequence");
CREATE INDEX "MyHOST_META"."Sources.fk_Keywords_has_Sequences_Keywords1_idx" ON "Sources" ("idkeyword");
COMMIT;

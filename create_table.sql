--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE "NTG"."MARKUP" 
   (	"ID" NUMBER(18,0), 
	"CLIENT" VARCHAR2(255 BYTE), 
	"GDS" VARCHAR2(50 BYTE), 
	"POS" VARCHAR2(50 BYTE), 
	"VALIDATING_CARRIER" VARCHAR2(10 BYTE), 
	"CLASS_OF_SERVICE" VARCHAR2(20 BYTE), 
	"SEGMENT" VARCHAR2(1 BYTE), 
	"HUMAN" VARCHAR2(1 BYTE), 
	"V_FROM" NUMBER, 
	"V_TO" NUMBER, 
	"ABSOLUT" VARCHAR2(1 BYTE), 
	"ABSOLUT_AMOUNT" NUMBER, 
	"PERCENT" VARCHAR2(1 BYTE), 
	"PERCENT_AMOUNT" NUMBER, 
	"MIN_ABSOLUT" NUMBER, 
	"MAX_ABSOLUT" NUMBER, 
	"AMND_DATE" DATE, 
	"AMND_PREV" NUMBER, 
	"AMND_USER" VARCHAR2(50 BYTE), 
	"AMND_STATE" VARCHAR2(1 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX "NTG"."MKP_ID_IDX" ON "NTG"."MARKUP" ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE "NTG"."MARKUP" MODIFY ("ID" CONSTRAINT "MKP_ID_NN" NOT NULL ENABLE);
  ALTER TABLE "NTG"."MARKUP" ADD CONSTRAINT "MKP_ID_PK" PRIMARY KEY ("ID")
  USING INDEX (CREATE INDEX "NTG"."MKP_ID_IDX" ON "NTG"."MARKUP" ("ID") 
  TABLESPACE "USERS")  ENABLE;
  ALTER TABLE "NTG"."M_TRANSACTION" ADD CONSTRAINT "MTR_DOC_OID_FK" FOREIGN KEY ("ID")
  REFERENCES "NTG"."DOC" ("ID") ENABLE;
  
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  mtr_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "NTG"."MKP_TRGR" 
BEFORE
INSERT
ON markup
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select mkp_seq.nextval into :new.id from dual; 
/*  if :new.amnd_prev is null then select :new.id into :new.amnd_prev from dual; end if;
  if :new.amnd_date is null then select sysdate into :new.amnd_date from dual; end if;
  if :new.amnd_state is null then select 'A' into :new.amnd_state from dual; end if;
  if :new.amnd_user is null then select user into :new.amnd_user from dual; end if;*/
end;
/
ALTER TRIGGER "NTG"."MKP_TRGR" ENABLE;

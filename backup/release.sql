
alter table ord.ticket add partner_FEE_AMOUNT NUMBER(20,2);
grant select on ntg.markup_type to ord;


alter table ord.commission 
add contract_oid number(18,0);

alter table ord.commission 
add min_absolut number(20,2);

alter table ord.commission 
add RULE_TYPE number(18,0);

alter table ord.commission 
add MARKUP_TYPE number(18,0);

alter table ord.commission 
add per_segment varchar2(1);

alter table ord.commission 
add currency number(18,0);

alter table ord.commission 
add per_fare varchar2(1);

ALTER TABLE ord.commission ADD CONSTRAINT CMN_CNTR_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;


  CREATE TABLE hdbk.currency 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   code varchar2(10),
   name varchar2(50),
   nls_name varchar2(50),
   is_currency varchar2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX hdbk.curr_ID_IDX ON hdbk.currency ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE hdbk.currency MODIFY ("ID" CONSTRAINT curr_ID_NN NOT NULL ENABLE);
  ALTER TABLE hdbk.currency MODIFY (AMND_DATE CONSTRAINT "curr_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.currency MODIFY (AMND_USER CONSTRAINT "curr_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.currency MODIFY (AMND_STATE CONSTRAINT "curr_AST_NN" NOT NULL ENABLE);
ALTER TABLE hdbk.currency  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE hdbk.currency  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE hdbk.currency  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE hdbk.currency ADD CONSTRAINT curr_ID_PK PRIMARY KEY (ID)
  USING INDEX hdbk.curr_ID_IDX ENABLE;


  
INSERT INTO hdbk.CURRENCY (ID, AMND_PREV, CODE, NAME, NLS_NAME, IS_CURRENCY) VALUES ('810', '810', 'RUB', 'RUB', 'руб.', 'Y');
INSERT INTO hdbk.CURRENCY (ID, AMND_PREV, CODE, NAME, NLS_NAME, IS_CURRENCY) VALUES ('840', '840', 'USD', 'USD', '$', 'Y');
INSERT INTO hdbk.CURRENCY (ID, AMND_PREV, CODE, NAME, IS_CURRENCY) VALUES ('978', '978', 'EUR', 'EUR', 'Y');
INSERT INTO hdbk.CURRENCY (ID, AMND_PREV, CODE, NAME, IS_CURRENCY) VALUES ('1', '1', '%', 'PERCENT', 'N');


INSERT INTO "NTG"."MARKUP_TYPE" (NAME) VALUES ('SUPPLIER');
INSERT INTO "NTG"."MARKUP_TYPE" (NAME) VALUES ('COMMISSION');
INSERT INTO "NTG"."MARKUP_TYPE" (NAME) VALUES ('MARKUP');


commit;
 
update ORD.commission set rule_type = 4;
commit;


INSERT INTO "ORD"."COMMISSION" (AIRLINE, DETAILS, FIX, PRIORITY, CONTRACT_OID, rule_type, MARKUP_TYPE, PER_SEGMENT, CURRENCY) VALUES ('1597', 'MARKUP', '400', '0', '0', 5 ,'1', 'N', '810');
INSERT INTO "ORD"."COMMISSION" (AIRLINE, DETAILS, PERCENT, PRIORITY, CONTRACT_OID, MIN_ABSOLUT, rule_type, MARKUP_TYPE, PER_SEGMENT, CURRENCY) VALUES ('1597', 'MARKUP', '0', '0', '25', '0',5 , '1', 'N', '1');
INSERT INTO "ORD"."COMMISSION" (AIRLINE, DETAILS, PERCENT, PRIORITY, CONTRACT_OID, MIN_ABSOLUT, rule_type, MARKUP_TYPE, PER_SEGMENT, CURRENCY) VALUES ('1597', 'MARKUP', '4', '0', '24', '0',5 ,'1', 'N', '1');
commit;


/* ntg.note  */


--------------------------------------------------------
--  DDL for Table
--------------------------------------------------------

  CREATE TABLE ntg.note 
   (		ID NUMBER(18,0), 
	AMND_DATE DATE, 
	AMND_USER VARCHAR2(50 BYTE), 
	AMND_STATE VARCHAR2(1 BYTE), 
	AMND_PREV NUMBER(18,0), 
	NAME VARCHAR2(4000 BYTE), 
	client_oid NUMBER(18,0)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ntg.note_ID_IDX ON ntg.note ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints
--------------------------------------------------------

  ALTER TABLE ntg.note MODIFY ("ID" CONSTRAINT note_ID_NN NOT NULL ENABLE);
  ALTER TABLE ntg.note MODIFY (AMND_DATE CONSTRAINT "note_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.note MODIFY (AMND_USER CONSTRAINT "note_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.note MODIFY (AMND_STATE CONSTRAINT "note_AST_NN" NOT NULL ENABLE);
ALTER TABLE ntg.note  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ntg.note  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ntg.note  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ntg.note ADD CONSTRAINT note_ID_PK PRIMARY KEY (ID)
  USING INDEX ntg.note_ID_IDX ENABLE;

  
  ALTER TABLE ntg.note ADD CONSTRAINT note_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;


  create sequence  ntg.note_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ntg.note_TRGR 
BEFORE
INSERT
ON ntg.note
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select note_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER ntg.note_TRGR ENABLE;

/


/* ntg.note_ticket  */

--------------------------------------------------------
--  DDL for Table
--------------------------------------------------------

  CREATE TABLE ntg.note_ticket 
   (		ID NUMBER(18,0), 
	AMND_DATE DATE, 
	AMND_USER VARCHAR2(50 BYTE), 
	AMND_STATE VARCHAR2(1 BYTE), 
	AMND_PREV NUMBER(18,0), 
	note_oid NUMBER(18,0), 
	tickets clob
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ntg.ntt_ID_IDX ON ntg.note_ticket ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints
--------------------------------------------------------

  ALTER TABLE ntg.note_ticket MODIFY ("ID" CONSTRAINT ntt_ID_NN NOT NULL ENABLE);
  ALTER TABLE ntg.note_ticket MODIFY (AMND_DATE CONSTRAINT "ntt_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.note_ticket MODIFY (AMND_USER CONSTRAINT "ntt_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.note_ticket MODIFY (AMND_STATE CONSTRAINT "ntt_AST_NN" NOT NULL ENABLE);
ALTER TABLE ntg.note_ticket  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ntg.note_ticket  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ntg.note_ticket  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ntg.note_ticket ADD CONSTRAINT ntt_ID_PK PRIMARY KEY (ID)
  USING INDEX ntg.ntt_ID_IDX ENABLE;
  

  ALTER TABLE ntg.note_ticket ADD CONSTRAINT ntt_note_OID_FK FOREIGN KEY (note_oid)
  REFERENCES ntg.note ("ID") ENABLE;

  create sequence  ntg.ntt_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ntg.ntt_TRGR 
BEFORE
INSERT
ON ntg.note_ticket
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select ntt_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER ntg.ntt_TRGR ENABLE;

/

as system

grant execute on blng.blng_api to ntg;
grant execute on hdbk.dtype to ntg;
grant execute on hdbk.log_api to ntg;

drop package ntg.log_api;
drop package ntg.dtype;



/


@dba/GRANTS.sql;
@metadata/view.sql;
@data/pkg/hdbk.fwdr.sql;
@data/pkg/hdbk.log_api.sql;
@data/pkg/hdbk.dtype.sql;
@data/pkg/blng.blng_api.sql;
@data/pkg/blng.core.sql;
@data/pkg/blng.fwdr.sql;
@data/pkg/ntg.ntg_api.sql;
@data/pkg/ntg.fwdr.sql;
--@data/pkg/ntg.log_api.sql;
--@data/pkg/ntg.dtype.sql;
@data/pkg/ord.ord_api.sql;
@data/pkg/ord.core.sql;
@data/pkg/ord.fwdr.sql;

--@metadata/dict_implement.sql
--@data/pkg/dict.dtype.sql;
--@data/pkg/dict.dict_api.sql;
--@data/pkg/dict.fwdr.sql;
--@data/pkg/dict.log_api.sql;


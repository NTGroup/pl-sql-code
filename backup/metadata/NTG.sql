/* ntg.airline  */


--------------------------------------------------------
--  DDL for Table
--------------------------------------------------------

  CREATE TABLE ntg.airline 
   (		ID NUMBER(18,0), 
	AMND_DATE DATE, 
	AMND_USER VARCHAR2(50 BYTE), 
	AMND_STATE VARCHAR2(1 BYTE), 
	AMND_PREV NUMBER(18,0), 
	NAME VARCHAR2(500 BYTE), 
	NLS_NAME VARCHAR2(500 BYTE), 
	IATA VARCHAR2(10 BYTE), 
	CRT VARCHAR2(10 BYTE), 
	IATA_N VARCHAR2(10 BYTE), 
	IKAO VARCHAR2(10 BYTE), 
	IS_SABRE_INCLUDED NUMBER, 
	IS_AMADEUS_INCLUDED NUMBER, 
	IS_SIRENA2000_INCLUDED NUMBER, 
	IS_AUTO_ISSUE_ENABLE NUMBER, 
	STATUS VARCHAR2(1 BYTE)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ntg.al_ID_IDX ON ntg.airline ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints
--------------------------------------------------------

  ALTER TABLE ntg.airline MODIFY ("ID" CONSTRAINT al_ID_NN NOT NULL ENABLE);
  ALTER TABLE ntg.airline MODIFY (AMND_DATE CONSTRAINT "al_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.airline MODIFY (AMND_USER CONSTRAINT "al_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.airline MODIFY (AMND_STATE CONSTRAINT "al_AST_NN" NOT NULL ENABLE);
ALTER TABLE ntg.airline  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ntg.airline  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ntg.airline  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ntg.airline ADD CONSTRAINT al_ID_PK PRIMARY KEY (ID)
  USING INDEX ntg.al_ID_IDX ENABLE;
  

  /*
  ALTER TABLE ntg.airline ADD CONSTRAINT bill_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;
   */
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  ntg.al_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ntg.al_TRGR 
BEFORE
INSERT
ON ntg.airline
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select al_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER ntg.al_TRGR ENABLE;

/




/* ntg.airplane */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ntg.airplane
   (	   ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
  name VARCHAR2(255), 
 nls_name VARCHAR2(255),
 code VARCHAR2(10),
 code_nls VARCHAR2(10),
 ru number(1,0),
 t_doc_id	 number
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ntg.AP_ID_IDX ON ntg.airplane ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ntg.airplane MODIFY ("ID" CONSTRAINT AP_ID_NN NOT NULL ENABLE);
  ALTER TABLE ntg.airplane MODIFY (AMND_DATE CONSTRAINT "AP_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.airplane MODIFY (AMND_USER CONSTRAINT "AP_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.airplane MODIFY (AMND_STATE CONSTRAINT "AP_AST_NN" NOT NULL ENABLE);
ALTER TABLE ntg.airplane  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ntg.airplane  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ntg.airplane  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ntg.airplane ADD CONSTRAINT AP_ID_PK PRIMARY KEY (ID)
  USING INDEX ntg.AP_ID_IDX ENABLE;


/*
ALTER TABLE ntg.airplane ADD CONSTRAINT AP_ETT_OID_FK FOREIGN KEY (event_type_oid)
  REFERENCES BLNG.event_type ("ID") ENABLE;
ALTER TABLE ntg.airplane ADD CONSTRAINT AP_TRN_OID_FK FOREIGN KEY (transaction_oid)
  REFERENCES BLNG.transaction ("ID") ENABLE;
ALTER TABLE ntg.airplane ADD CONSTRAINT AP_CNTR_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;
*/

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  ntg.AP_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ntg.AP_TRGR 
BEFORE
INSERT
ON ntg.airplane
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select ntg.AP_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER ntg.AP_TRGR ENABLE;

/


/* ntg.geo  */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ntg.geo 
   (ID NUMBER, 
  amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
	PARENT_ID NUMBER, 
	NAME VARCHAR2(255 BYTE), 
	NLS_NAME VARCHAR2(255 BYTE), 
	IATA VARCHAR2(5 BYTE), 
	CODE VARCHAR2(5 BYTE), 
	OBJECT_TYPE VARCHAR2(20 BYTE), 
	COUNTRY_ID NUMBER, 
	CITY_ID NUMBER, 
	IS_ACTIVE VARCHAR2(20 BYTE), 
	NEW_PARENT_ID NUMBER, 
	UTC_OFFSET NUMBER, 
	SEARCH_RATING NUMBER,
	NLS_NAME_ip VARCHAR2(255 BYTE), 
	NLS_NAME_rp VARCHAR2(255 BYTE), 
	NLS_NAME_dp VARCHAR2(255 BYTE), 
	NLS_NAME_vp VARCHAR2(255 BYTE), 
	NLS_NAME_tp VARCHAR2(255 BYTE), 
	NLS_NAME_pp VARCHAR2(255 BYTE) 
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ntg.geo_ID_IDX ON ntg.geo ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ntg.geo MODIFY ("ID" CONSTRAINT geo_ID_NN NOT NULL ENABLE);
  ALTER TABLE ntg.geo MODIFY (AMND_DATE CONSTRAINT "geo_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.geo MODIFY (AMND_USER CONSTRAINT "geo_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.geo MODIFY (AMND_STATE CONSTRAINT "geo_AST_NN" NOT NULL ENABLE);
ALTER TABLE ntg.geo  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ntg.geo  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ntg.geo  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ntg.geo ADD CONSTRAINT geo_ID_PK PRIMARY KEY (ID)
  USING INDEX ntg.geo_ID_IDX ENABLE;
ALTER TABLE ntg.geo MODIFY (UTC_OFFSET CONSTRAINT "geo_UOF_NN" NOT NULL ENABLE);
ALTER TABLE ntg.geo  MODIFY (UTC_OFFSET DEFAULT  on null  '0' );
  

  /*
  ALTER TABLE ntg.geo ADD CONSTRAINT bill_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;
   */
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  ntg.geo_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ntg.geo_TRGR 
BEFORE
INSERT
ON ntg.geo
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select geo_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER ntg.geo_TRGR ENABLE;





/* ntg.log  */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ntg.log 
   (ID NUMBER, 
  amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
	PROC_NAME VARCHAR2(50 BYTE), 
	MSG VARCHAR2(4000 BYTE), 
	MSG_TYPE VARCHAR2(50 BYTE), 
	INFO VARCHAR2(4000 BYTE), 
	ALERT_LEVEL NUMBER(18,0)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ntg.log_ID_IDX ON ntg.log ("ID") 
  TABLESPACE "USERS" ;
 
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ntg.log MODIFY ("ID" CONSTRAINT log_ID_NN NOT NULL ENABLE);
  ALTER TABLE ntg.log MODIFY (AMND_DATE CONSTRAINT "log_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.log MODIFY (AMND_USER CONSTRAINT "log_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.log MODIFY (AMND_STATE CONSTRAINT "log_AST_NN" NOT NULL ENABLE);
ALTER TABLE ntg.log  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ntg.log  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ntg.log  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ntg.log ADD CONSTRAINT log_ID_PK PRIMARY KEY (ID)
  USING INDEX ntg.log_ID_IDX ENABLE;


  /*
  ALTER TABLE ntg.log ADD CONSTRAINT bill_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;
   */
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  ntg.log_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ntg.log_TRGR 
BEFORE
INSERT
ON ntg.log
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select log_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER ntg.log_TRGR ENABLE;

/




/* ntg.markup  */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ntg.markup 
   (ID NUMBER, 
  amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
	CLIENT VARCHAR2(255 BYTE), 
	GDS VARCHAR2(50 BYTE), 
	POS VARCHAR2(50 BYTE), 
	VALIDATING_CARRIER NUMBER, 
	CLASS_OF_SERVICE VARCHAR2(20 BYTE), 
	SEGMENT VARCHAR2(1 BYTE), 
	HUMAN VARCHAR2(1 BYTE), 
	V_FROM NUMBER, 
	V_TO NUMBER, 
	ABSOLUT VARCHAR2(1 BYTE), 
	ABSOLUT_AMOUNT NUMBER, 
	PERCENT VARCHAR2(1 BYTE), 
	PERCENT_AMOUNT NUMBER, 
	MIN_ABSOLUT NUMBER, 
	MAX_ABSOLUT NUMBER,
  markup_type_oid NUMBER(18,0)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ntg.mkp_ID_IDX ON ntg.markup ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ntg.markup MODIFY ("ID" CONSTRAINT mkp_ID_NN NOT NULL ENABLE);
  ALTER TABLE ntg.markup MODIFY (AMND_DATE CONSTRAINT "mkp_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.markup MODIFY (AMND_USER CONSTRAINT "mkp_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.markup MODIFY (AMND_STATE CONSTRAINT "mkp_AST_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.markup  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
  ALTER TABLE ntg.markup  MODIFY (AMND_USER DEFAULT  on null  user );
  ALTER TABLE ntg.markup  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ntg.markup ADD CONSTRAINT mkp_ID_PK PRIMARY KEY (ID)
  USING INDEX ntg.mkp_ID_IDX ENABLE;


  /*
  ALTER TABLE ntg.markup ADD CONSTRAINT bill_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;
   */
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  ntg.mkp_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ntg.mkp_TRGR 
BEFORE
INSERT
ON ntg.markup
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select mkp_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER ntg.mkp_TRGR ENABLE;



/

/* ntg.gds_nationality  */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ntg.gds_nationality 
   (
id number(18,0),
code varchar2(10),
nls_name varchar2(255)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ntg.gnt_ID_IDX ON ntg.gds_nationality ("ID") 
  TABLESPACE "USERS" ;
  CREATE INDEX ntg.gnt_CD_IDX ON ntg.gds_nationality (code) 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ntg.gds_nationality MODIFY ("ID" CONSTRAINT gnt_ID_NN NOT NULL ENABLE);
  ALTER TABLE ntg.gds_nationality ADD CONSTRAINT gnt_ID_PK PRIMARY KEY (ID)
  USING INDEX ntg.gnt_ID_IDX ENABLE;


  /*
  ALTER TABLE ntg.markup ADD CONSTRAINT bill_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;
   */
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  ntg.gnt_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ntg.gnt_TRGR 
BEFORE
INSERT
ON ntg.gds_nationality
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select gnt_SEQ.nextval into :new.id from dual; 
--  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER ntg.gnt_TRGR ENABLE;

/



/* markup_type */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ntg.markup_type 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   name varchar2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ntg.MKPT_ID_IDX ON ntg.markup_type ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ntg.markup_type MODIFY ("ID" CONSTRAINT "MKPT_ID_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.markup_type MODIFY (AMND_DATE CONSTRAINT "MKPT_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.markup_type MODIFY (AMND_USER CONSTRAINT "MKPT_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.markup_type MODIFY (AMND_STATE CONSTRAINT "MKPT_AST_NN" NOT NULL ENABLE);
ALTER TABLE ntg.markup_type  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ntg.markup_type  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ntg.markup_type  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ntg.markup_type ADD CONSTRAINT MKPT_ID_PK PRIMARY KEY (ID)
  USING INDEX ntg.MKPT_ID_IDX ENABLE;

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  ntg.MKPT_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------


CREATE OR REPLACE EDITIONABLE TRIGGER ntg.MKPT_TRGR 
BEFORE
INSERT
ON ntg.markup_type
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select ntg.MKPT_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;

/
ALTER TRIGGER ntg.MKPT_TRGR ENABLE;

/


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


CREATE bitmap INDEX ntg.geo_AS_IDX ON ntg.geo (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX ntg.log_AS_IDX ON ntg.log (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX ntg.mkp_AS_IDX ON ntg.markup (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX ntg.al_AS_IDX ON ntg.airline (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX ntg.ap_AS_IDX ON ntg.airplane (amnd_state) TABLESPACE "USERS" ;

--------------------------------------------------------
--  DDL for Grants
--------------------------------------------------------

grant select on ntg.airline to ord;
grant select on ntg.airplane to ord;
grant select on ntg.geo to ord;
grant select on ntg.markup to ord;
grant select on ntg.gds_nationality to ord;
grant select on ntg.airline to blng;
grant select on ntg.airplane to blng;
grant select on ntg.geo to blng;
grant select on ntg.markup to blng;
grant select on ntg.gds_nationality to blng;

--Foreign keys between tables in different schemas
grant references on ntg.airline to ord;
grant references on ntg.airplane to ord;
grant references on ntg.geo to ord;
grant references on ntg.markup to ord;
grant references on ntg.gds_nationality to ord;
grant references on ntg.airline to blng;
grant references on ntg.airplane to blng;
grant references on ntg.geo to blng;
grant references on ntg.markup to blng;
grant references on ntg.gds_nationality to blng;


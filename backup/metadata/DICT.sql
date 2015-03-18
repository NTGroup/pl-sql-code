/* dict.airline  */


--------------------------------------------------------
--  DDL for Table
--------------------------------------------------------

  CREATE TABLE dict.airline 
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

  CREATE INDEX dict.al_ID_IDX ON dict.airline ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints
--------------------------------------------------------

  ALTER TABLE dict.airline MODIFY ("ID" CONSTRAINT al_ID_NN NOT NULL ENABLE);
  ALTER TABLE dict.airline MODIFY (AMND_DATE CONSTRAINT "al_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE dict.airline MODIFY (AMND_USER CONSTRAINT "al_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE dict.airline MODIFY (AMND_STATE CONSTRAINT "al_AST_NN" NOT NULL ENABLE);
ALTER TABLE dict.airline  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE dict.airline  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE dict.airline  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE dict.airline ADD CONSTRAINT al_ID_PK PRIMARY KEY (ID)
  USING INDEX dict.al_ID_IDX ENABLE;
  

  /*
  ALTER TABLE dict.airline ADD CONSTRAINT bill_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;
   */
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  dict.al_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER dict.al_TRGR 
BEFORE
INSERT
ON dict.airline
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select al_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER dict.al_TRGR ENABLE;

/




/* dict.airplane */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE dict.airplane
   (	   ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
  name VARCHAR2(255), 
 nls_name VARCHAR2(255),
 iata VARCHAR2(10),
 nls_iata VARCHAR2(10),
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

  CREATE INDEX dict.AP_ID_IDX ON dict.airplane ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE dict.airplane MODIFY ("ID" CONSTRAINT AP_ID_NN NOT NULL ENABLE);
  ALTER TABLE dict.airplane MODIFY (AMND_DATE CONSTRAINT "AP_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE dict.airplane MODIFY (AMND_USER CONSTRAINT "AP_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE dict.airplane MODIFY (AMND_STATE CONSTRAINT "AP_AST_NN" NOT NULL ENABLE);
ALTER TABLE dict.airplane  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE dict.airplane  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE dict.airplane  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE dict.airplane ADD CONSTRAINT AP_ID_PK PRIMARY KEY (ID)
  USING INDEX dict.AP_ID_IDX ENABLE;


/*
ALTER TABLE dict.airplane ADD CONSTRAINT AP_ETT_OID_FK FOREIGN KEY (event_type_oid)
  REFERENCES BLNG.event_type ("ID") ENABLE;
ALTER TABLE dict.airplane ADD CONSTRAINT AP_TRN_OID_FK FOREIGN KEY (transaction_oid)
  REFERENCES BLNG.transaction ("ID") ENABLE;
ALTER TABLE dict.airplane ADD CONSTRAINT AP_CNTR_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;
*/

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  dict.AP_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER dict.AP_TRGR 
BEFORE
INSERT
ON dict.airplane
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select AP_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER dict.AP_TRGR ENABLE;

/


/* dict.geo  */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE dict.geo 
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

  CREATE INDEX dict.geo_ID_IDX ON dict.geo ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE dict.geo MODIFY ("ID" CONSTRAINT geo_ID_NN NOT NULL ENABLE);
  ALTER TABLE dict.geo MODIFY (AMND_DATE CONSTRAINT "geo_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE dict.geo MODIFY (AMND_USER CONSTRAINT "geo_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE dict.geo MODIFY (AMND_STATE CONSTRAINT "geo_AST_NN" NOT NULL ENABLE);
ALTER TABLE dict.geo  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE dict.geo  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE dict.geo  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE dict.geo ADD CONSTRAINT geo_ID_PK PRIMARY KEY (ID)
  USING INDEX dict.geo_ID_IDX ENABLE;
ALTER TABLE dict.geo MODIFY (UTC_OFFSET CONSTRAINT "geo_UOF_NN" NOT NULL ENABLE);
ALTER TABLE dict.geo  MODIFY (UTC_OFFSET DEFAULT  on null  '0' );
  

  /*
  ALTER TABLE dict.geo ADD CONSTRAINT bill_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;
   */
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  dict.geo_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER dict.geo_TRGR 
BEFORE
INSERT
ON dict.geo
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select geo_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER dict.geo_TRGR ENABLE;





/* dict.loger  */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------
  CREATE TABLE dict.loger 
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

  CREATE INDEX dict.log_ID_IDX ON dict.loger ("ID") 
  TABLESPACE "USERS" ;
 
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE dict.loger MODIFY ("ID" CONSTRAINT log_ID_NN NOT NULL ENABLE);
  ALTER TABLE dict.loger MODIFY (AMND_DATE CONSTRAINT "log_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE dict.loger MODIFY (AMND_USER CONSTRAINT "log_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE dict.loger MODIFY (AMND_STATE CONSTRAINT "log_AST_NN" NOT NULL ENABLE);
ALTER TABLE dict.loger  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE dict.loger  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE dict.loger  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE dict.loger ADD CONSTRAINT log_ID_PK PRIMARY KEY (ID)
  USING INDEX dict.log_ID_IDX ENABLE;


  /*
  ALTER TABLE dict.log ADD CONSTRAINT bill_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;
   */
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  dict.log_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER dict.log_TRGR 
BEFORE
INSERT
ON dict.loger
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select log_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER dict.log_TRGR ENABLE;

/

/* dict.markup  */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE dict.markup 
   (ID NUMBER, 
  amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
	contract_oid number(18,0), 
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

  CREATE INDEX dict.mkp_ID_IDX ON dict.markup ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE dict.markup MODIFY ("ID" CONSTRAINT mkp_ID_NN NOT NULL ENABLE);
  ALTER TABLE dict.markup MODIFY (AMND_DATE CONSTRAINT "mkp_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE dict.markup MODIFY (AMND_USER CONSTRAINT "mkp_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE dict.markup MODIFY (AMND_STATE CONSTRAINT "mkp_AST_NN" NOT NULL ENABLE);
  ALTER TABLE dict.markup  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
  ALTER TABLE dict.markup  MODIFY (AMND_USER DEFAULT  on null  user );
  ALTER TABLE dict.markup  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE dict.markup ADD CONSTRAINT mkp_ID_PK PRIMARY KEY (ID)
  USING INDEX dict.mkp_ID_IDX ENABLE;


  /*
  ALTER TABLE dict.markup ADD CONSTRAINT bill_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;
   */
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  dict.mkp_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER dict.mkp_TRGR 
BEFORE
INSERT
ON dict.markup
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select mkp_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER dict.mkp_TRGR ENABLE;



/

/* dict.gds_nationality  */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE dict.gds_nationality 
   (
id number(18,0),
code varchar2(10),
nls_name varchar2(255)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX dict.gnt_ID_IDX ON dict.gds_nationality ("ID") 
  TABLESPACE "USERS" ;
  CREATE INDEX dict.gnt_CD_IDX ON dict.gds_nationality (code) 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE dict.gds_nationality MODIFY ("ID" CONSTRAINT gnt_ID_NN NOT NULL ENABLE);
  ALTER TABLE dict.gds_nationality ADD CONSTRAINT gnt_ID_PK PRIMARY KEY (ID)
  USING INDEX dict.gnt_ID_IDX ENABLE;


  /*
  ALTER TABLE dict.markup ADD CONSTRAINT bill_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;
   */
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  dict.gnt_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER dict.gnt_TRGR 
BEFORE
INSERT
ON dict.gds_nationality
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select gnt_SEQ.nextval into :new.id from dual; 
--  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER dict.gnt_TRGR ENABLE;

/



/* markup_type */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE dict.markup_type 
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

  CREATE INDEX dict.MKPT_ID_IDX ON dict.markup_type ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE dict.markup_type MODIFY ("ID" CONSTRAINT "MKPT_ID_NN" NOT NULL ENABLE);
  ALTER TABLE dict.markup_type MODIFY (AMND_DATE CONSTRAINT "MKPT_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE dict.markup_type MODIFY (AMND_USER CONSTRAINT "MKPT_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE dict.markup_type MODIFY (AMND_STATE CONSTRAINT "MKPT_AST_NN" NOT NULL ENABLE);
ALTER TABLE dict.markup_type  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE dict.markup_type  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE dict.markup_type  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE dict.markup_type ADD CONSTRAINT MKPT_ID_PK PRIMARY KEY (ID)
  USING INDEX dict.MKPT_ID_IDX ENABLE;

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  dict.MKPT_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------


CREATE OR REPLACE EDITIONABLE TRIGGER dict.MKPT_TRGR 
BEFORE
INSERT
ON dict.markup_type
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select MKPT_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;

/
ALTER TRIGGER dict.MKPT_TRGR ENABLE;

/

CREATE bitmap INDEX dict.geo_AS_IDX ON dict.geo (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX dict.log_AS_IDX ON dict.log (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX dict.mkp_AS_IDX ON dict.markup (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX dict.al_AS_IDX ON dict.airline (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX dict.ap_AS_IDX ON dict.airplane (amnd_state) TABLESPACE "USERS" ;

--------------------------------------------------------
--  DDL for Grants
--------------------------------------------------------

grant select on dict.airline to ord;
grant select on dict.airplane to ord;
grant select on dict.geo to ord;
grant select on dict.markup to ord;
grant select on dict.gds_nationality to ord;
grant select on dict.airline to blng;
grant select on dict.airplane to blng;
grant select on dict.geo to blng;
grant select on dict.markup to blng;
grant select on dict.gds_nationality to blng;
/*
grant select on dict.airline to po_fwdr;
grant select on dict.airplane to blng;
grant select on dict.geo to blng;
grant select on dict.markup to blng;
grant select on dict.gds_nationality to blng;
*/

--Foreign keys between tables in different schemas
grant references on dict.airline to ord;
grant references on dict.airplane to ord;
grant references on dict.geo to ord;
grant references on dict.markup to ord;
grant references on dict.gds_nationality to ord;
grant references on dict.airline to blng;
grant references on dict.airplane to blng;
grant references on dict.geo to blng;
grant references on dict.markup to blng;
grant references on dict.gds_nationality to blng;


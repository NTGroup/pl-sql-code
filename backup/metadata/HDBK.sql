
/* hdbk.log  */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE hdbk.log 
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

  CREATE INDEX hdbk.log_ID_IDX ON hdbk.log ("ID") 
  TABLESPACE "USERS" ;
 
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE hdbk.log MODIFY ("ID" CONSTRAINT log_ID_NN NOT NULL ENABLE);
  ALTER TABLE hdbk.log MODIFY (AMND_DATE CONSTRAINT "log_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.log MODIFY (AMND_USER CONSTRAINT "log_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.log MODIFY (AMND_STATE CONSTRAINT "log_AST_NN" NOT NULL ENABLE);
ALTER TABLE hdbk.log  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE hdbk.log  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE hdbk.log  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE hdbk.log ADD CONSTRAINT log_ID_PK PRIMARY KEY (ID)
  USING INDEX hdbk.log_ID_IDX ENABLE;


  /*
  ALTER TABLE hdbk.log ADD CONSTRAINT bill_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;
   */
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  hdbk.log_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.log_TRGR 
BEFORE
INSERT
ON hdbk.log
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select log_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER hdbk.log_TRGR ENABLE;

/

/* hdbk.airline  */


--------------------------------------------------------
--  DDL for Table
--------------------------------------------------------

  CREATE TABLE hdbk.airline 
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

  CREATE INDEX hdbk.al_ID_IDX ON hdbk.airline ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints
--------------------------------------------------------

  ALTER TABLE hdbk.airline MODIFY ("ID" CONSTRAINT al_ID_NN NOT NULL ENABLE);
  ALTER TABLE hdbk.airline MODIFY (AMND_DATE CONSTRAINT "al_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.airline MODIFY (AMND_USER CONSTRAINT "al_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.airline MODIFY (AMND_STATE CONSTRAINT "al_AST_NN" NOT NULL ENABLE);
ALTER TABLE hdbk.airline  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE hdbk.airline  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE hdbk.airline  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE hdbk.airline ADD CONSTRAINT al_ID_PK PRIMARY KEY (ID)
  USING INDEX hdbk.al_ID_IDX ENABLE;
  

  /*
  ALTER TABLE hdbk.airline ADD CONSTRAINT bill_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;
   */
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  hdbk.al_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.al_TRGR 
BEFORE
INSERT
ON hdbk.airline
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select al_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER hdbk.al_TRGR ENABLE;

/




/* hdbk.airplane */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE hdbk.airplane
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

  CREATE INDEX hdbk.AP_ID_IDX ON hdbk.airplane ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE hdbk.airplane MODIFY ("ID" CONSTRAINT AP_ID_NN NOT NULL ENABLE);
  ALTER TABLE hdbk.airplane MODIFY (AMND_DATE CONSTRAINT "AP_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.airplane MODIFY (AMND_USER CONSTRAINT "AP_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.airplane MODIFY (AMND_STATE CONSTRAINT "AP_AST_NN" NOT NULL ENABLE);
ALTER TABLE hdbk.airplane  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE hdbk.airplane  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE hdbk.airplane  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE hdbk.airplane ADD CONSTRAINT AP_ID_PK PRIMARY KEY (ID)
  USING INDEX hdbk.AP_ID_IDX ENABLE;


/*
ALTER TABLE hdbk.airplane ADD CONSTRAINT AP_ETT_OID_FK FOREIGN KEY (event_type_oid)
  REFERENCES BLNG.event_type ("ID") ENABLE;
ALTER TABLE hdbk.airplane ADD CONSTRAINT AP_TRN_OID_FK FOREIGN KEY (transaction_oid)
  REFERENCES BLNG.transaction ("ID") ENABLE;
ALTER TABLE hdbk.airplane ADD CONSTRAINT AP_CNTR_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;
*/

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  hdbk.AP_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.AP_TRGR 
BEFORE
INSERT
ON hdbk.airplane
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select AP_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER hdbk.AP_TRGR ENABLE;

/


/* hdbk.geo  */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE hdbk.geo 
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

  CREATE INDEX hdbk.geo_ID_IDX ON hdbk.geo ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE hdbk.geo MODIFY ("ID" CONSTRAINT geo_ID_NN NOT NULL ENABLE);
  ALTER TABLE hdbk.geo MODIFY (AMND_DATE CONSTRAINT "geo_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.geo MODIFY (AMND_USER CONSTRAINT "geo_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.geo MODIFY (AMND_STATE CONSTRAINT "geo_AST_NN" NOT NULL ENABLE);
ALTER TABLE hdbk.geo  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE hdbk.geo  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE hdbk.geo  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE hdbk.geo ADD CONSTRAINT geo_ID_PK PRIMARY KEY (ID)
  USING INDEX hdbk.geo_ID_IDX ENABLE;
ALTER TABLE hdbk.geo MODIFY (UTC_OFFSET CONSTRAINT "geo_UOF_NN" NOT NULL ENABLE);
ALTER TABLE hdbk.geo  MODIFY (UTC_OFFSET DEFAULT  on null  '0' );
  

  /*
  ALTER TABLE hdbk.geo ADD CONSTRAINT bill_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;
   */
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  hdbk.geo_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.geo_TRGR 
BEFORE
INSERT
ON hdbk.geo
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select geo_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER hdbk.geo_TRGR ENABLE;


/
/* hdbk.gds_nationality  */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE hdbk.gds_nationality 
   (
id number(18,0),
code varchar2(10),
nls_name varchar2(255)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX hdbk.gnt_ID_IDX ON hdbk.gds_nationality ("ID") 
  TABLESPACE "USERS" ;
  CREATE INDEX hdbk.gnt_CD_IDX ON hdbk.gds_nationality (code) 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE hdbk.gds_nationality MODIFY ("ID" CONSTRAINT gnt_ID_NN NOT NULL ENABLE);
  ALTER TABLE hdbk.gds_nationality ADD CONSTRAINT gnt_ID_PK PRIMARY KEY (ID)
  USING INDEX hdbk.gnt_ID_IDX ENABLE;


  /*
  ALTER TABLE hdbk.markup ADD CONSTRAINT bill_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;
   */
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  hdbk.gnt_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.gnt_TRGR 
BEFORE
INSERT
ON hdbk.gds_nationality
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select gnt_SEQ.nextval into :new.id from dual; 
--  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER hdbk.gnt_TRGR ENABLE;

/



/* markup_type */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE hdbk.markup_type 
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

  CREATE INDEX hdbk.MKPT_ID_IDX ON hdbk.markup_type ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE hdbk.markup_type MODIFY ("ID" CONSTRAINT "MKPT_ID_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.markup_type MODIFY (AMND_DATE CONSTRAINT "MKPT_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.markup_type MODIFY (AMND_USER CONSTRAINT "MKPT_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.markup_type MODIFY (AMND_STATE CONSTRAINT "MKPT_AST_NN" NOT NULL ENABLE);
ALTER TABLE hdbk.markup_type  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE hdbk.markup_type  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE hdbk.markup_type  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE hdbk.markup_type ADD CONSTRAINT MKPT_ID_PK PRIMARY KEY (ID)
  USING INDEX hdbk.MKPT_ID_IDX ENABLE;

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  hdbk.MKPT_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------


CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.MKPT_TRGR 
BEFORE
INSERT
ON hdbk.markup_type
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select MKPT_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;

/
ALTER TRIGGER hdbk.MKPT_TRGR ENABLE;

/

/* hdbk.note  */


--------------------------------------------------------
--  DDL for Table
--------------------------------------------------------

  CREATE TABLE hdbk.note 
   (		ID NUMBER(18,0), 
	AMND_DATE DATE, 
	AMND_USER VARCHAR2(50 BYTE), 
	AMND_STATE VARCHAR2(1 BYTE), 
	AMND_PREV NUMBER(18,0), 
	NAME VARCHAR2(4000 BYTE), 
	client_oid NUMBER(18,0),
  guid VARCHAR2(255 BYTE)
  
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX hdbk.note_ID_IDX ON hdbk.note ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints
--------------------------------------------------------

  ALTER TABLE hdbk.note MODIFY ("ID" CONSTRAINT note_ID_NN NOT NULL ENABLE);
  ALTER TABLE hdbk.note MODIFY (AMND_DATE CONSTRAINT "note_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.note MODIFY (AMND_USER CONSTRAINT "note_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.note MODIFY (AMND_STATE CONSTRAINT "note_AST_NN" NOT NULL ENABLE);
ALTER TABLE hdbk.note  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE hdbk.note  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE hdbk.note  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE hdbk.note ADD CONSTRAINT note_ID_PK PRIMARY KEY (ID)
  USING INDEX hdbk.note_ID_IDX ENABLE;

   
grant references on blng.client TO hdbk;
 
  ALTER TABLE hdbk.note ADD CONSTRAINT note_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;


  create sequence  hdbk.note_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.note_TRGR 
BEFORE
INSERT
ON hdbk.note
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select note_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER hdbk.note_TRGR ENABLE;

/


/* hdbk.note_ticket  */

--------------------------------------------------------
--  DDL for Table
--------------------------------------------------------

  CREATE TABLE hdbk.note_ticket 
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

  CREATE INDEX hdbk.ntt_ID_IDX ON hdbk.note_ticket ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints
--------------------------------------------------------

  ALTER TABLE hdbk.note_ticket MODIFY ("ID" CONSTRAINT ntt_ID_NN NOT NULL ENABLE);
  ALTER TABLE hdbk.note_ticket MODIFY (AMND_DATE CONSTRAINT "ntt_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.note_ticket MODIFY (AMND_USER CONSTRAINT "ntt_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.note_ticket MODIFY (AMND_STATE CONSTRAINT "ntt_AST_NN" NOT NULL ENABLE);
ALTER TABLE hdbk.note_ticket  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE hdbk.note_ticket  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE hdbk.note_ticket  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE hdbk.note_ticket ADD CONSTRAINT ntt_ID_PK PRIMARY KEY (ID)
  USING INDEX hdbk.ntt_ID_IDX ENABLE;


  ALTER TABLE hdbk.note_ticket ADD CONSTRAINT ntt_note_OID_FK FOREIGN KEY (note_oid)
  REFERENCES hdbk.note ("ID") ENABLE;

  create sequence  hdbk.ntt_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.ntt_TRGR 
BEFORE
INSERT
ON hdbk.note_ticket
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select ntt_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER hdbk.ntt_TRGR ENABLE;

/


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

/



/* hdbk.rate  */
  --------------------------------------------------------
  --  DDL for Table
  --------------------------------------------------------
  
    CREATE TABLE hdbk.rate 
     (		ID NUMBER(18,0), 
    AMND_DATE DATE, 
    AMND_USER VARCHAR2(50 BYTE), 
    AMND_STATE VARCHAR2(1 BYTE), 
    AMND_PREV NUMBER(18,0), 
    currency_oid NUMBER(18,0), 
    code VARCHAR2(10 BYTE), 
    rate  NUMBER(20,2),
    date_from  date,
    date_to  date
    
    
     ) SEGMENT CREATION IMMEDIATE
    TABLESPACE "USERS" ;
  --------------------------------------------------------
  --  DDL for Index 
  --------------------------------------------------------
  
    CREATE INDEX hdbk.rate_ID_IDX ON hdbk.rate ("ID") 
    TABLESPACE "USERS" ;
  --------------------------------------------------------
  --  Constraints
  --------------------------------------------------------
  
    ALTER TABLE hdbk.rate MODIFY ("ID" CONSTRAINT rate_ID_NN NOT NULL ENABLE);
    ALTER TABLE hdbk.rate MODIFY (AMND_DATE CONSTRAINT "rate_ADT_NN" NOT NULL ENABLE);
    ALTER TABLE hdbk.rate MODIFY (AMND_USER CONSTRAINT "rate_AUR_NN" NOT NULL ENABLE);
    ALTER TABLE hdbk.rate MODIFY (AMND_STATE CONSTRAINT "rate_AST_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.rate  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
  ALTER TABLE hdbk.rate  MODIFY (AMND_USER DEFAULT  on null  user );
  ALTER TABLE hdbk.rate  MODIFY (AMND_STATE DEFAULT  on null  'A' );
    ALTER TABLE hdbk.rate ADD CONSTRAINT rate_ID_PK PRIMARY KEY (ID)
    USING INDEX hdbk.rate_ID_IDX ENABLE;
  
     
    ALTER TABLE hdbk.rate ADD CONSTRAINT rate_curr_OID_FK FOREIGN KEY (currency_oid)
    REFERENCES hdbk.currency ("ID") ENABLE;
  
  
    create sequence  hdbk.rate_seq
    increment by 1
    start with 1
    nomaxvalue
    nocache /*!!!*/
    nocycle
    order;
  --------------------------------------------------------
  --  DDL for Trigger 
  --------------------------------------------------------
  
  CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.rate_TRGR 
  BEFORE
  INSERT
  ON hdbk.rate
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
   WHEN (new.id is null) BEGIN
    select rate_SEQ.nextval into :new.id from dual; 
    select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
  end;
  /
  ALTER TRIGGER hdbk.rate_TRGR ENABLE;
  
  /
  

  CREATE TABLE hdbk.calendar 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   date_to date,
   day_type NUMBER(18,0),
   contract_oid NUMBER(18,0)
  
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX hdbk.cal_ID_IDX ON hdbk.calendar ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------


  ALTER TABLE hdbk.calendar MODIFY ("ID" CONSTRAINT cal_ID_NN NOT NULL ENABLE);
  ALTER TABLE hdbk.calendar MODIFY (AMND_DATE CONSTRAINT "cal_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.calendar MODIFY (AMND_USER CONSTRAINT "cal_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.calendar MODIFY (AMND_STATE CONSTRAINT "cal_AST_NN" NOT NULL ENABLE);
ALTER TABLE hdbk.calendar  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE hdbk.calendar  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE hdbk.calendar  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE hdbk.calendar ADD CONSTRAINT cal_ID_PK PRIMARY KEY (ID)
  USING INDEX hdbk.cal_ID_IDX ENABLE;





/*
ALTER TABLE hdbk.calendar ADD CONSTRAINT cal_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES hdbk.client ("ID") ENABLE;
*/

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  hdbk.cal_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.cal_TRGR 
BEFORE
INSERT
ON hdbk.calendar
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select hdbk.cal_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER hdbk.cal_TRGR ENABLE;

/  
  


  CREATE TABLE hdbk.dictionary 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   code  VARCHAR2(50),
   name  VARCHAR2(255),
   INFO  VARCHAR2(255),
   dictionary_type varchar2(50)
   
  
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX hdbk.dict_ID_IDX ON hdbk.dictionary ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------


  ALTER TABLE hdbk.dictionary MODIFY ("ID" CONSTRAINT dict_ID_NN NOT NULL ENABLE);
  ALTER TABLE hdbk.dictionary MODIFY (AMND_DATE CONSTRAINT "dict_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.dictionary MODIFY (AMND_USER CONSTRAINT "dict_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.dictionary MODIFY (AMND_STATE CONSTRAINT "dict_AST_NN" NOT NULL ENABLE);
ALTER TABLE hdbk.dictionary  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE hdbk.dictionary  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE hdbk.dictionary  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE hdbk.dictionary ADD CONSTRAINT dict_ID_PK PRIMARY KEY (ID)
  USING INDEX hdbk.dict_ID_IDX ENABLE;

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  hdbk.dict_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.dict_TRGR 
BEFORE
INSERT
ON hdbk.dictionary
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select hdbk.dict_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER hdbk.dict_TRGR ENABLE;

/  
  


/
CREATE bitmap INDEX hdbk.log_AS_IDX ON hdbk.log (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX hdbk.geo_AS_IDX ON hdbk.geo (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX hdbk.al_AS_IDX ON hdbk.airline (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX hdbk.ap_AS_IDX ON hdbk.airplane (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX hdbk.rate_AS_IDX ON hdbk.rate (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX hdbk.cal_AS_IDX ON hdbk.calendar (amnd_state) TABLESPACE "USERS" ;

CREATE INDEX hdbk.cal_dtt_IDX ON hdbk.calendar (date_to) TABLESPACE "USERS" ;



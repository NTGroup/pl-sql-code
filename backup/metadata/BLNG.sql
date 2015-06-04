
/*company*/

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.company 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   name varchar2(255),
   status VARCHAR2(1),
   utc_offset number
   
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.cmp_ID_IDX ON blng.company ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE blng.company MODIFY ("ID" CONSTRAINT "cmp_ID_NN" NOT NULL ENABLE);
 ALTER TABLE blng.company MODIFY (AMND_DATE CONSTRAINT "cmp_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE blng.company MODIFY (AMND_USER CONSTRAINT "cmp_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE blng.company MODIFY (AMND_STATE CONSTRAINT "cmp_AST_NN" NOT NULL ENABLE);
  ALTER TABLE BLNG.company  MODIFY (AMND_DATE DEFAULT on null sysdate);
  ALTER TABLE BLNG.company  MODIFY (AMND_USER DEFAULT  on null user );
  ALTER TABLE BLNG.company  MODIFY (AMND_STATE DEFAULT  on null 'A' );

  ALTER TABLE blng.company ADD CONSTRAINT cmp_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.cmp_ID_IDX ENABLE;


--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.cmp_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.cmp_TRGR 
BEFORE
INSERT
ON BLNG.company
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.cmp_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER BLNG.cmp_TRGR ENABLE;

/






/*usr*/


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.usr 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   company_oid NUMBER(18,0), 
   last_name varchar2(255),
   first_name varchar2(255),   
   birth_date date,
   gender varchar2(1),
   email VARCHAR2(255),
   nationality VARCHAR2(255),
   status VARCHAR2(1),
   phone VARCHAR2(255),
   utc_offset number,
   is_tester varchar2(1)
   
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.usr_ID_IDX ON blng.usr ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE blng.usr MODIFY ("ID" CONSTRAINT "usr_ID_NN" NOT NULL ENABLE);
 ALTER TABLE blng.usr MODIFY (AMND_DATE CONSTRAINT "usr_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE blng.usr MODIFY (AMND_USER CONSTRAINT "usr_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE blng.usr MODIFY (AMND_STATE CONSTRAINT "usr_AST_NN" NOT NULL ENABLE);
  ALTER TABLE BLNG.usr  MODIFY (AMND_DATE DEFAULT on null sysdate);
  ALTER TABLE BLNG.usr  MODIFY (AMND_USER DEFAULT  on null user );
  ALTER TABLE BLNG.usr  MODIFY (AMND_STATE DEFAULT  on null 'A' );

  ALTER TABLE blng.usr ADD CONSTRAINT usr_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.usr_ID_IDX ENABLE;

ALTER TABLE BLNG.usr ADD CONSTRAINT usr_cmp_OID_FK FOREIGN KEY (company_oid)
  REFERENCES BLNG.company ("ID") ENABLE;

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.usr_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.usr_TRGR 
BEFORE
INSERT
ON BLNG.usr
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.usr_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER BLNG.usr_TRGR ENABLE;

/




/*permission*/

/*
--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.permission 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   name varchar2(255),
   permission varchar2(1),  
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.prm_ID_IDX ON blng.permission ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE blng.permission MODIFY ("ID" CONSTRAINT "prm_ID_NN" NOT NULL ENABLE);
  ALTER TABLE BLNG.permission  MODIFY (AMND_DATE DEFAULT on null sysdate);
  ALTER TABLE BLNG.permission  MODIFY (AMND_USER DEFAULT  on null user );
  ALTER TABLE BLNG.permission  MODIFY (AMND_STATE DEFAULT  on null 'A' );

  ALTER TABLE blng.permission ADD CONSTRAINT prm_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.prm_ID_IDX ENABLE;


--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.prm_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache 
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.prm_TRGR 
BEFORE
INSERT
ON BLNG.permission
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.prm_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER BLNG.prm_TRGR ENABLE;
*/

/


/*usr2permission*/
/*
--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.usr2permission 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0),
   user_oid NUMBER(18,0),
   permission_oid NUMBER(18,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.cl2p_ID_IDX ON blng.usr2permission ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE blng.usr2permission MODIFY ("ID" CONSTRAINT "cl2p_ID_NN" NOT NULL ENABLE);
  ALTER TABLE BLNG.usr2permission  MODIFY (AMND_DATE DEFAULT on null sysdate);
  ALTER TABLE BLNG.usr2permission  MODIFY (AMND_USER DEFAULT  on null user );
  ALTER TABLE BLNG.usr2permission  MODIFY (AMND_STATE DEFAULT  on null 'A' );

  ALTER TABLE blng.usr2permission ADD CONSTRAINT cl2p_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.cl2p_ID_IDX ENABLE;


ALTER TABLE BLNG.usr2permission ADD CONSTRAINT cl2p_usr_OID_FK FOREIGN KEY (user_oid)
  REFERENCES BLNG.usr ("ID") ENABLE;
ALTER TABLE BLNG.usr2permission ADD CONSTRAINT cl2p_prm_OID_FK FOREIGN KEY (permission_oid)
  REFERENCES BLNG.permission ("ID") ENABLE;

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.cl2p_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache 
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.cl2p_TRGR 
BEFORE
INSERT
ON BLNG.usr2permission
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.cl2p_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER BLNG.cl2p_TRGR ENABLE;
*/


/*permission2contract*/
/*
--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.permission2contract 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   permission_oid NUMBER(18,0),
   contract_oid NUMBER(18,0)
   
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.p2cntr_ID_IDX ON blng.permission2contract ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE blng.permission2contract MODIFY ("ID" CONSTRAINT "p2cntr_ID_NN" NOT NULL ENABLE);
  ALTER TABLE BLNG.permission2contract  MODIFY (AMND_DATE DEFAULT on null sysdate);
  ALTER TABLE BLNG.permission2contract  MODIFY (AMND_USER DEFAULT  on null user );
  ALTER TABLE BLNG.permission2contract  MODIFY (AMND_STATE DEFAULT  on null 'A' );

  ALTER TABLE blng.permission2contract ADD CONSTRAINT p2cntr_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.p2cntr_ID_IDX ENABLE;



ALTER TABLE BLNG.permission2contract ADD CONSTRAINT p2cntr_cntr_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;
ALTER TABLE BLNG.permission2contract ADD CONSTRAINT p2cntr_prm_OID_FK FOREIGN KEY (permission_oid)
  REFERENCES BLNG.permission ("ID") ENABLE;


--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.p2cntr_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache 
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.p2cntr_TRGR 
BEFORE
INSERT
ON BLNG.permission2contract
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.p2cntr_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER BLNG.p2cntr_TRGR ENABLE;
*/


/

/*USR2CONTRACT*/

--------------------------------------------------------
--  DDL for Table
--------------------------------------------------------

  CREATE TABLE blng.USR2CONTRACT 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   user_oid NUMBER(18,0),
   permission VARCHAR2(1),
   contract_oid NUMBER(18,0)
   
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.u2cntr_ID_IDX ON blng.USR2CONTRACT ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE blng.USR2CONTRACT MODIFY ("ID" CONSTRAINT "u2cntr_ID_NN" NOT NULL ENABLE);
 ALTER TABLE blng.USR2CONTRACT MODIFY (AMND_DATE CONSTRAINT "u2cntr_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE blng.USR2CONTRACT MODIFY (AMND_USER CONSTRAINT "u2cntr_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE blng.USR2CONTRACT MODIFY (AMND_STATE CONSTRAINT "u2cntr_AST_NN" NOT NULL ENABLE);
  ALTER TABLE BLNG.USR2CONTRACT  MODIFY (AMND_DATE DEFAULT on null sysdate);
  ALTER TABLE BLNG.USR2CONTRACT  MODIFY (AMND_USER DEFAULT  on null user );
  ALTER TABLE BLNG.USR2CONTRACT  MODIFY (AMND_STATE DEFAULT  on null 'A' );

  ALTER TABLE blng.USR2CONTRACT ADD CONSTRAINT u2cntr_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.u2cntr_ID_IDX ENABLE;



ALTER TABLE BLNG.USR2CONTRACT ADD CONSTRAINT u2cntr_cntr_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;
ALTER TABLE BLNG.USR2CONTRACT ADD CONSTRAINT u2cntr_usr_OID_FK FOREIGN KEY (user_oid)
  REFERENCES BLNG.usr ("ID") ENABLE;


--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.u2cntr_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.u2cntr_TRGR 
BEFORE
INSERT
ON BLNG.USR2CONTRACT
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.u2cntr_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER BLNG.u2cntr_TRGR ENABLE;

/




/*contract*/

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.contract 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   contract_number VARCHAR2(50),
   status VARCHAR2(1),
   company_oid NUMBER(18,0),
   utc_offset number,
   name  VARCHAR2(255),
   contact_name varchar2(255),
   contact_phone varchar2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.CNTR_ID_IDX ON blng.contract ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

ALTER TABLE blng.contract MODIFY ("ID" CONSTRAINT "CNTR_ID_NN" NOT NULL ENABLE);
ALTER TABLE blng.contract MODIFY ("AMND_STATE" CONSTRAINT "CNTR_AST_NN" NOT NULL ENABLE);
ALTER TABLE blng.contract MODIFY ("AMND_DATE" CONSTRAINT "CNTR_ADT_NN" NOT NULL ENABLE);
ALTER TABLE blng.contract MODIFY ("AMND_USER" CONSTRAINT "CNTR_AUR_NN" NOT NULL ENABLE);

ALTER TABLE BLNG.CONTRACT  MODIFY (AMND_DATE DEFAULT  on null sysdate );
ALTER TABLE BLNG.CONTRACT  MODIFY (AMND_USER DEFAULT  on null user );
ALTER TABLE BLNG.CONTRACT  MODIFY (AMND_STATE DEFAULT on null 'A' );



  ALTER TABLE blng.contract ADD CONSTRAINT CNTR_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.CNTR_ID_IDX ENABLE;


ALTER TABLE BLNG.contract ADD CONSTRAINT cntr_cmp_OID_FK FOREIGN KEY (company_oid)
  REFERENCES BLNG.company ("ID") ENABLE;

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.cntr_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

create or replace TRIGGER BLNG.cntr_TRGR 
BEFORE
INSERT
ON BLNG.contract
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.cntr_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.CNTR_TRGR ENABLE;

/



/* account_type */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.account_type 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   name varchar2(255),
   code varchar2(10),
   priority number,
   details varchar2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.ACCT_ID_IDX ON blng.account_type ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE blng.account_type MODIFY ("ID" CONSTRAINT "ACCT_ID_NN" NOT NULL ENABLE);
 ALTER TABLE blng.account_type MODIFY (AMND_DATE CONSTRAINT "ACCT_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE blng.account_type MODIFY (AMND_USER CONSTRAINT "ACCT_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE blng.account_type MODIFY (AMND_STATE CONSTRAINT "ACCT_AST_NN" NOT NULL ENABLE);
ALTER TABLE BLNG.account_type  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE BLNG.account_type  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE BLNG.account_type  MODIFY (AMND_STATE DEFAULT  on null  'A' );

  ALTER TABLE blng.account_type ADD CONSTRAINT ACCT_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.ACCT_ID_IDX ENABLE;




--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.acct_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.ACCT_TRGR 
BEFORE
INSERT
ON BLNG.account_type
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.acct_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.acct_TRGR ENABLE;

/





/*accounts*/

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.account
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
	 contract_oid NUMBER(18,0),
   code varchar2(10),
   amount number,
   priority number,
   account_type_oid number(18,0)
   
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.ACC_ID_IDX ON blng.account ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE blng.account MODIFY ("ID" CONSTRAINT "ACC_ID_NN" NOT NULL ENABLE);
 ALTER TABLE blng.account MODIFY (AMND_DATE CONSTRAINT "ACC_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE blng.account MODIFY (AMND_USER CONSTRAINT "ACC_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE blng.account MODIFY (AMND_STATE CONSTRAINT "ACC_AST_NN" NOT NULL ENABLE);
ALTER TABLE BLNG.account  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE BLNG.account  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE BLNG.account  MODIFY (AMND_STATE DEFAULT  on null  'A' );

  ALTER TABLE blng.account ADD CONSTRAINT ACC_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.ACC_ID_IDX ENABLE;

ALTER TABLE BLNG.account ADD CONSTRAINT ACC_CNTR_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;

  
ALTER TABLE BLNG.account ADD CONSTRAINT ACC_ACCT_OID_FK FOREIGN KEY (account_type_oid)
  REFERENCES BLNG.account_type ("ID") ENABLE;
  
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.acc_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.ACC_TRGR 
BEFORE
INSERT
ON BLNG.account
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.acc_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.acc_TRGR ENABLE;

/


/* trans_type */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.trans_type 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   name varchar2(50),
   code varchar2(10),
   details varchar2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.TRT_ID_IDX ON blng.trans_type ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE blng.trans_type MODIFY ("ID" CONSTRAINT "TRT_ID_NN" NOT NULL ENABLE);
  ALTER TABLE blng.trans_type MODIFY (AMND_DATE CONSTRAINT "TRT_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE blng.trans_type MODIFY (AMND_USER CONSTRAINT "TRT_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE blng.trans_type MODIFY (AMND_STATE CONSTRAINT "TRT_AST_NN" NOT NULL ENABLE);
ALTER TABLE BLNG.trans_type  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE BLNG.trans_type  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE BLNG.trans_type  MODIFY (AMND_STATE DEFAULT  on null  'A' );

  ALTER TABLE blng.trans_type ADD CONSTRAINT TRT_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.TRT_ID_IDX ENABLE;

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.trt_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.trt_TRGR 
BEFORE
INSERT
ON BLNG.trans_type
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.trt_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.trt_TRGR ENABLE;

end;


/* documents */
begin

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.document
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
	 contract_oid NUMBER(18,0),
   doc_date date,
   --code varchar2(10),
   amount NUMBER(20,2),
   status VARCHAR2(1),
   trans_type_oid NUMBER(18,0),
   bill_oid NUMBER(18,0),
   account_trans_type_oid NUMBER(18,0)
   
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.doc_ID_IDX ON blng.document ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE blng.document MODIFY ("ID" CONSTRAINT "DOC_ID_NN" NOT NULL ENABLE);

ALTER TABLE blng.document MODIFY ("AMND_STATE" CONSTRAINT "DOC_AST_NN" NOT NULL ENABLE);
ALTER TABLE blng.document MODIFY ("AMND_DATE" CONSTRAINT "DOC_ADT_NN" NOT NULL ENABLE);
ALTER TABLE blng.document MODIFY ("AMND_USER" CONSTRAINT "DOC_AUR_NN" NOT NULL ENABLE);
ALTER TABLE blng.document MODIFY ("STATUS" CONSTRAINT "DOC_ST_NN" NOT NULL ENABLE);

ALTER TABLE BLNG.document  MODIFY (AMND_DATE DEFAULT  on null sysdate );
ALTER TABLE BLNG.document  MODIFY (AMND_USER DEFAULT  on null user );
ALTER TABLE BLNG.document  MODIFY (AMND_STATE DEFAULT on null 'A' );
ALTER TABLE BLNG.document  MODIFY (STATUS DEFAULT on null 'W' );



  ALTER TABLE blng.document ADD CONSTRAINT DOC_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.DOC_ID_IDX ENABLE;

ALTER TABLE BLNG.document ADD CONSTRAINT DOC_CNTR_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;

ALTER TABLE BLNG.document ADD CONSTRAINT DOC_TRT_OID_FK FOREIGN KEY (trans_type_oid)
  REFERENCES BLNG.trans_type ("ID") ENABLE;

ALTER TABLE BLNG.document ADD CONSTRAINT DOC_BILL_OID_FK FOREIGN KEY (bill_oid)
  REFERENCES ord.bill ("ID") ENABLE;
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.doc_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.doc_TRGR 
BEFORE
INSERT
ON BLNG.document
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.doc_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.doc_TRGR ENABLE;

end;



/* transactions */
begin

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.transaction
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
	 doc_oid NUMBER(18,0),
   target_account_oid NUMBER(18,0),
   trans_date date,
    trans_type_oid number(18,0),
   --code varchar2(10),
   amount number(20,2),
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.trn_ID_IDX ON blng.transaction ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE blng.transaction MODIFY ("ID" CONSTRAINT "TRN_ID_NN" NOT NULL ENABLE);
  ALTER TABLE blng.transaction MODIFY (AMND_DATE CONSTRAINT "TRN_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE blng.transaction MODIFY (AMND_USER CONSTRAINT "TRN_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE blng.transaction MODIFY (AMND_STATE CONSTRAINT "TRN_AST_NN" NOT NULL ENABLE);
ALTER TABLE BLNG.transaction  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE BLNG.transaction  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE BLNG.transaction  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE blng.transaction ADD CONSTRAINT TRN_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.trn_ID_IDX ENABLE;

ALTER TABLE BLNG.transaction ADD CONSTRAINT TRN_ACC_OID_FK FOREIGN KEY (target_account_oid)
  REFERENCES BLNG.account ("ID") ENABLE;


ALTER TABLE BLNG.transaction ADD CONSTRAINT TRN_TRT_OID_FK FOREIGN KEY (trans_type_oid)
  REFERENCES BLNG.trans_type ("ID") ENABLE;

ALTER TABLE BLNG.transaction ADD CONSTRAINT TRN_DOC_OID_FK FOREIGN KEY (doc_oid)
  REFERENCES BLNG.document ("ID") ENABLE;

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.trn_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.trn_TRGR 
BEFORE
INSERT
ON BLNG.transaction
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.trn_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.trn_TRGR ENABLE;

end;




/* event */
begin

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.event
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   event_type_oid NUMBER(18,0),
   transaction_oid NUMBER(18,0),
   date_to date,
   contract_oid number(18,0),
   amount number(20,2),
   status VARCHAR2(1),
   priority number
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.evnt_ID_IDX ON blng.event ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE blng.event MODIFY ("ID" CONSTRAINT "EVNT_ID_NN" NOT NULL ENABLE);
  ALTER TABLE blng.event MODIFY (AMND_DATE CONSTRAINT "EVNT_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE blng.event MODIFY (AMND_USER CONSTRAINT "EVNT_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE blng.event MODIFY (AMND_STATE CONSTRAINT "EVNT_AST_NN" NOT NULL ENABLE);
ALTER TABLE BLNG.event  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE BLNG.event  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE BLNG.event  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE blng.event ADD CONSTRAINT EVNT_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.EVNT_ID_IDX ENABLE;
 
ALTER TABLE BLNG.event ADD CONSTRAINT EVNT_ETT_OID_FK FOREIGN KEY (event_type_oid)
  REFERENCES BLNG.event_type ("ID") ENABLE;
ALTER TABLE BLNG.event ADD CONSTRAINT EVNT_TRN_OID_FK FOREIGN KEY (transaction_oid)
  REFERENCES BLNG.transaction ("ID") ENABLE;
ALTER TABLE BLNG.event ADD CONSTRAINT EVNT_CNTR_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;


--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.evnt_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.evnt_TRGR 
BEFORE
INSERT
ON BLNG.event
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.evnt_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.evnt_TRGR ENABLE;

end;



/* event_type */
begin

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.event_type 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   name varchar2(50),
   code varchar2(10),
   details varchar2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.ETT_ID_IDX ON blng.event_type ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE blng.event_type MODIFY ("ID" CONSTRAINT "ETT_ID_NN" NOT NULL ENABLE);
  ALTER TABLE blng.event_type MODIFY (AMND_DATE CONSTRAINT "ETT_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE blng.event_type MODIFY (AMND_USER CONSTRAINT "ETT_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE blng.event_type MODIFY (AMND_STATE CONSTRAINT "ETT_AST_NN" NOT NULL ENABLE);
ALTER TABLE BLNG.event_type  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE BLNG.event_type  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE BLNG.event_type  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE blng.event_type ADD CONSTRAINT ETT_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.ETT_ID_IDX ENABLE;

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.ett_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------


CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.ett_TRGR 
BEFORE
INSERT
ON BLNG.event_type
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.ett_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER BLNG.ett_TRGR ENABLE;


end;

/


/* status_type */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.status_type 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   name varchar2(50),
   code varchar2(1),
   details varchar2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.STT_ID_IDX ON blng.status_type ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE blng.status_type MODIFY ("ID" CONSTRAINT "STT_ID_NN" NOT NULL ENABLE);
  ALTER TABLE blng.status_type MODIFY (AMND_DATE CONSTRAINT "STT_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE blng.status_type MODIFY (AMND_USER CONSTRAINT "STT_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE blng.status_type MODIFY (AMND_STATE CONSTRAINT "STT_AST_NN" NOT NULL ENABLE);
ALTER TABLE BLNG.status_type  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE BLNG.status_type  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE BLNG.status_type  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE blng.status_type ADD CONSTRAINT STT_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.STT_ID_IDX ENABLE;

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.stt_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------


CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.stt_TRGR 
BEFORE
INSERT
ON BLNG.status_type
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.stt_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;

/
ALTER TRIGGER BLNG.stt_TRGR ENABLE;







/* delay */
begin

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.delay
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   event_type_oid NUMBER(18,0),
   transaction_oid NUMBER(18,0),
   date_to date,
   contract_oid number(18,0),
   amount number(20,2),
   status VARCHAR2(1),
   priority number,
   amnd_amount number(20,2),
   parent_id number(18,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.dly_ID_IDX ON blng.delay ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE blng.delay MODIFY ("ID" CONSTRAINT dly_ID_NN NOT NULL ENABLE);
  ALTER TABLE blng.delay MODIFY (AMND_DATE CONSTRAINT "DLY_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE blng.delay MODIFY (AMND_USER CONSTRAINT "DLY_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE blng.delay MODIFY (AMND_STATE CONSTRAINT "DLY_AST_NN" NOT NULL ENABLE);
ALTER TABLE BLNG.delay  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE BLNG.delay  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE BLNG.delay  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE blng.delay ADD CONSTRAINT DLY_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.DLY_ID_IDX ENABLE;

ALTER TABLE BLNG.delay ADD CONSTRAINT DLY_ETT_OID_FK FOREIGN KEY (event_type_oid)
  REFERENCES BLNG.event_type ("ID") ENABLE;
ALTER TABLE BLNG.delay ADD CONSTRAINT DLY_TRN_OID_FK FOREIGN KEY (transaction_oid)
  REFERENCES BLNG.transaction ("ID") ENABLE;
ALTER TABLE BLNG.delay ADD CONSTRAINT DLY_CNTR_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;


--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.DLY_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.DLY_TRGR 
BEFORE
INSERT
ON BLNG.delay
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.DLY_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.DLY_TRGR ENABLE;

end;

/


/* domain */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.domain
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   name VARCHAR2(255),
   contract_oid NUMBER(18,0),
   status VARCHAR2(1),
   is_domain VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.dmn_ID_IDX ON blng.domain ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE blng.domain MODIFY ("ID" CONSTRAINT dmn_ID_NN NOT NULL ENABLE);
  ALTER TABLE blng.domain MODIFY (AMND_DATE CONSTRAINT "dmn_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE blng.domain MODIFY (AMND_USER CONSTRAINT "dmn_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE blng.domain MODIFY (AMND_STATE CONSTRAINT "dmn_AST_NN" NOT NULL ENABLE);
ALTER TABLE BLNG.domain  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE BLNG.domain  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE BLNG.domain  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE blng.domain ADD CONSTRAINT dmn_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.dmn_ID_IDX ENABLE;


ALTER TABLE BLNG.domain ADD CONSTRAINT dmn_cntr_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;


--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.dmn_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.dmn_TRGR 
BEFORE
INSERT
ON BLNG.domain
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.dmn_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.dmn_TRGR ENABLE;



/

/*USR_DATA*/


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE blng.USR_DATA 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   user_oid NUMBER(18,0),
   last_name varchar2(255),
   first_name varchar2(255),
   birth_date date,
   gender varchar2(1),
   nationality varchar2(10),
   doc_number varchar2(50),
   expiry_date date,
   open_date date,
   owner varchar2(1),
   phone VARCHAR2(255)
  
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX blng.usrd_ID_IDX ON blng.USR_DATA ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------


  ALTER TABLE blng.USR_DATA MODIFY ("ID" CONSTRAINT usrd_ID_NN NOT NULL ENABLE);
  ALTER TABLE blng.USR_DATA MODIFY (AMND_DATE CONSTRAINT "usrd_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE blng.USR_DATA MODIFY (AMND_USER CONSTRAINT "usrd_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE blng.USR_DATA MODIFY (AMND_STATE CONSTRAINT "usrd_AST_NN" NOT NULL ENABLE);
ALTER TABLE BLNG.USR_DATA  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE BLNG.USR_DATA  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE BLNG.USR_DATA  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE blng.USR_DATA ADD CONSTRAINT usrd_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.usrd_ID_IDX ENABLE;






ALTER TABLE BLNG.USR_DATA ADD CONSTRAINT usrd_usr_OID_FK FOREIGN KEY (user_oid)
  REFERENCES BLNG.usr ("ID") ENABLE;


--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  BLNG.usrd_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.usrd_TRGR 
BEFORE
INSERT
ON BLNG.USR_DATA
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.usrd_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER BLNG.usrd_TRGR ENABLE;

/


CREATE bitmap INDEX blng.cmp_AS_IDX ON blng.company (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.usr_AS_IDX ON blng.usr (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.cntr_AS_IDX ON blng.contract (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.u2cntr_AS_IDX ON blng.USR2CONTRACT (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.doc_AS_IDX ON blng.document (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.trn_AS_IDX ON blng.transaction (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.acc_AS_IDX ON blng.account (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.dly_AS_IDX ON blng.delay (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.dmn_AS_IDX ON blng.domain (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.usrd_AS_IDX ON blng.USR_DATA (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.trt_AS_IDX ON blng.trans_type (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.ett_AS_IDX ON blng.event_type (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.stt_AS_IDX ON blng.status_type (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.acct_AS_IDX ON blng.account_type (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.evnt_AS_IDX ON blng.event (amnd_state) TABLESPACE "USERS" ;


CREATE INDEX blng.doc_dd_IDX ON blng.document (doc_date) TABLESPACE "USERS" ;
CREATE INDEX blng.trn_td_IDX ON blng.transaction (trans_date) TABLESPACE "USERS" ;
CREATE INDEX blng.dly_dt_IDX ON blng.delay (date_to) TABLESPACE "USERS" ;

--------------------------------------------------------
--  DDL for Grants
--------------------------------------------------------

grant select on blng.contract to ord;
grant select on blng.usr to ord;
grant select on blng.company to ord;
grant select on blng.domain to ord;
grant select on blng.USR2CONTRACT to ord;
grant select on blng.USR_DATA to ord;
grant select on blng.account to ord;
grant select on blng.document to ord;
grant select on blng.transaction to ord;
grant select on blng.delay to ord;
grant select on blng.event to ord;
grant select on blng.account_type to ord;
grant select on blng.status_type to ord;
grant select on blng.trans_type to ord;
grant select on blng.event_type to ord;

grant select on blng.contract to ntg;
grant select on blng.usr to ntg;
grant select on blng.company to ntg;
grant select on blng.domain to ntg;
grant select on blng.USR2CONTRACT to ntg;
grant select on blng.USR_DATA to ntg;
grant select on blng.account to ntg;
grant select on blng.document to ntg;
grant select on blng.transaction to ntg;
grant select on blng.delay to ntg;
grant select on blng.event to ntg;
grant select on blng.account_type to ntg;
grant select on blng.status_type to ntg;
grant select on blng.trans_type to ntg;
grant select on blng.event_type to ntg;


--Foreign keys between tables in different schemas

grant references on blng.contract to ord;
grant references on blng.usr to ord;
grant references on blng.company to ord;
grant references on blng.domain to ord;
grant references on blng.USR2CONTRACT to ord;
grant references on blng.USR_DATA to ord;
grant references on blng.account to ord;
grant references on blng.document to ord;
grant references on blng.transaction to ord;
grant references on blng.delay to ord;
grant references on blng.event to ord;
grant references on blng.account_type to ord;
grant references on blng.status_type to ord;
grant references on blng.trans_type to ord;
grant references on blng.event_type to ord;

grant references on blng.contract to ntg;
grant references on blng.usr to ntg;
grant references on blng.company to ntg;
grant references on blng.domain to ntg;
grant references on blng.USR2CONTRACT to ntg;
grant references on blng.USR_DATA to ntg;
grant references on blng.account to ntg;
grant references on blng.document to ntg;
grant references on blng.transaction to ntg;
grant references on blng.delay to ntg;
grant references on blng.event to ntg;
grant references on blng.account_type to ntg;
grant references on blng.status_type to ntg;
grant references on blng.trans_type to ntg;
grant references on blng.event_type to ntg;



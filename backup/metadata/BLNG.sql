
/*company*/
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE blng.company 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   name varchar2(255),
   status VARCHAR2(1)
   
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX blng.cmp_ID_IDX ON blng.company ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE blng.company MODIFY ("ID" CONSTRAINT "cmp_ID_NN" NOT NULL ENABLE);
  ALTER TABLE BLNG.company  MODIFY (AMND_DATE DEFAULT on null sysdate);
  ALTER TABLE BLNG.company  MODIFY (AMND_USER DEFAULT  on null user );
  ALTER TABLE BLNG.company  MODIFY (AMND_STATE DEFAULT  on null 'A' );

  ALTER TABLE blng.company ADD CONSTRAINT cmp_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.cmp_ID_IDX ENABLE;


--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  BLNG.cmp_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
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

end;






/*client*/
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE blng.client 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   company_oid NUMBER(18,0), 
   name varchar2(255),
   status VARCHAR2(1)
   
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX blng.CLT_ID_IDX ON blng.client ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE blng.client MODIFY ("ID" CONSTRAINT "CLT_ID_NN" NOT NULL ENABLE);
  ALTER TABLE BLNG.client  MODIFY (AMND_DATE DEFAULT on null sysdate);
  ALTER TABLE BLNG.client  MODIFY (AMND_USER DEFAULT  on null user );
  ALTER TABLE BLNG.client  MODIFY (AMND_STATE DEFAULT  on null 'A' );

  ALTER TABLE blng.client ADD CONSTRAINT CLT_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.CLT_ID_IDX ENABLE;

ALTER TABLE BLNG.client ADD CONSTRAINT clt_cmp_OID_FK FOREIGN KEY (company_oid)
  REFERENCES BLNG.company ("ID") ENABLE;

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  BLNG.clt_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.CLT_TRGR 
BEFORE
INSERT
ON BLNG.client
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.clt_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;

ALTER TRIGGER BLNG.CLT_TRGR ENABLE;

end;




/*permission*/
begin
/*
--------------------------------------------------------
--  DDL for Table MARKUP
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
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX blng.prm_ID_IDX ON blng.permission ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE blng.permission MODIFY ("ID" CONSTRAINT "prm_ID_NN" NOT NULL ENABLE);
  ALTER TABLE BLNG.permission  MODIFY (AMND_DATE DEFAULT on null sysdate);
  ALTER TABLE BLNG.permission  MODIFY (AMND_USER DEFAULT  on null user );
  ALTER TABLE BLNG.permission  MODIFY (AMND_STATE DEFAULT  on null 'A' );

  ALTER TABLE blng.permission ADD CONSTRAINT prm_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.prm_ID_IDX ENABLE;


--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  BLNG.prm_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache 
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
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
end;





/*client2permission*/
begin
/*
--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE blng.client2permission 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0),
   client_oid NUMBER(18,0),
   permission_oid NUMBER(18,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX blng.cl2p_ID_IDX ON blng.client2permission ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE blng.client2permission MODIFY ("ID" CONSTRAINT "cl2p_ID_NN" NOT NULL ENABLE);
  ALTER TABLE BLNG.client2permission  MODIFY (AMND_DATE DEFAULT on null sysdate);
  ALTER TABLE BLNG.client2permission  MODIFY (AMND_USER DEFAULT  on null user );
  ALTER TABLE BLNG.client2permission  MODIFY (AMND_STATE DEFAULT  on null 'A' );

  ALTER TABLE blng.client2permission ADD CONSTRAINT cl2p_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.cl2p_ID_IDX ENABLE;


ALTER TABLE BLNG.client2permission ADD CONSTRAINT cl2p_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES BLNG.client ("ID") ENABLE;
ALTER TABLE BLNG.client2permission ADD CONSTRAINT cl2p_prm_OID_FK FOREIGN KEY (permission_oid)
  REFERENCES BLNG.permission ("ID") ENABLE;

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  BLNG.cl2p_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache 
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.cl2p_TRGR 
BEFORE
INSERT
ON BLNG.client2permission
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.cl2p_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER BLNG.cl2p_TRGR ENABLE;
*/
end;





/*permission2contract*/
begin
/*
--------------------------------------------------------
--  DDL for Table MARKUP
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
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX blng.p2cntr_ID_IDX ON blng.permission2contract ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
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
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  BLNG.p2cntr_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache 
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
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
end;




/*client2contract*/
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE blng.client2contract 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   client_oid NUMBER(18,0),
   permission VARCHAR2(1),
   contract_oid NUMBER(18,0)
   
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX blng.cl2cntr_ID_IDX ON blng.client2contract ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE blng.client2contract MODIFY ("ID" CONSTRAINT "cl2cntr_ID_NN" NOT NULL ENABLE);
  ALTER TABLE BLNG.client2contract  MODIFY (AMND_DATE DEFAULT on null sysdate);
  ALTER TABLE BLNG.client2contract  MODIFY (AMND_USER DEFAULT  on null user );
  ALTER TABLE BLNG.client2contract  MODIFY (AMND_STATE DEFAULT  on null 'A' );

  ALTER TABLE blng.client2contract ADD CONSTRAINT cl2cntr_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.cl2cntr_ID_IDX ENABLE;



ALTER TABLE BLNG.client2contract ADD CONSTRAINT cl2cntr_cntr_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;
ALTER TABLE BLNG.client2contract ADD CONSTRAINT cl2cntr_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES BLNG.client ("ID") ENABLE;


--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  BLNG.cl2cntr_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.cl2cntr_TRGR 
BEFORE
INSERT
ON BLNG.client2contract
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.cl2cntr_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER BLNG.cl2cntr_TRGR ENABLE;

end;




/*contract*/
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE blng.contract 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
	 client_oid NUMBER(18,0),
   --name varchar2(255),
   contract_number VARCHAR2(50),
   status VARCHAR2(1)
   
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX blng.CNTR_ID_IDX ON blng.contract ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
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

--ALTER TABLE BLNG.contract ADD CONSTRAINT CNTR_CLT_OID_FK FOREIGN KEY (client_oid)
--  REFERENCES BLNG.client ("ID") ENABLE;

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  BLNG.cntr_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
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

ALTER TRIGGER BLNG.CNTR_TRGR ENABLE;

end;



/* account_type */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE blng.account_type 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
--	 contract_oid NUMBER(18,0),
   name varchar2(255),
--   account_name VARCHAR2(50),
   code varchar2(10),
   
--   amount number,
   priority number,
   details varchar2(255)
   /*,
   status VARCHAR2(1)*/
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX blng.ACCT_ID_IDX ON blng.account_type ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE blng.account_type MODIFY ("ID" CONSTRAINT "ACCT_ID_NN" NOT NULL ENABLE);
ALTER TABLE BLNG.account_type  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE BLNG.account_type  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE BLNG.account_type  MODIFY (AMND_STATE DEFAULT  on null  'A' );

  ALTER TABLE blng.account_type ADD CONSTRAINT ACCT_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.ACCT_ID_IDX ENABLE;




--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  BLNG.acct_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
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

ALTER TRIGGER BLNG.acct_TRGR ENABLE;

end;





/*accounts*/
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE blng.account
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
	 contract_oid NUMBER(18,0),
   --name varchar2(255),
  -- account_name VARCHAR2(50),
   code varchar2(10),
   amount number,
   priority number,
   last_document number(18,0)
   
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX blng.ACC_ID_IDX ON blng.account ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE blng.account MODIFY ("ID" CONSTRAINT "ACC_ID_NN" NOT NULL ENABLE);
ALTER TABLE BLNG.account  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE BLNG.account  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE BLNG.account  MODIFY (AMND_STATE DEFAULT  on null  'A' );

  ALTER TABLE blng.account ADD CONSTRAINT ACC_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.ACC_ID_IDX ENABLE;

ALTER TABLE BLNG.account ADD CONSTRAINT ACC_CNTR_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;



  ALTER TABLE blng.account ADD account_type_oid number(18,0);
  
ALTER TABLE BLNG.account ADD CONSTRAINT ACC_ACCT_OID_FK FOREIGN KEY (account_type_oid)
  REFERENCES BLNG.account_type ("ID") ENABLE;
  
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  BLNG.acc_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
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

ALTER TRIGGER BLNG.acc_TRGR ENABLE;

end;


/* trans_type */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE blng.trans_type 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
	 --contract_oid NUMBER(18,0),
   name varchar2(50),
   code varchar2(10),
   details varchar2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX blng.TRT_ID_IDX ON blng.trans_type ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE blng.trans_type MODIFY ("ID" CONSTRAINT "TRT_ID_NN" NOT NULL ENABLE);
ALTER TABLE BLNG.trans_type  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE BLNG.trans_type  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE BLNG.trans_type  MODIFY (AMND_STATE DEFAULT  on null  'A' );

  ALTER TABLE blng.trans_type ADD CONSTRAINT TRT_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.TRT_ID_IDX ENABLE;

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  BLNG.trt_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
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

ALTER TRIGGER BLNG.trt_TRGR ENABLE;

end;


/* documents */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
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
   amount number,
   status VARCHAR2(1),
   trans_type_oid number
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX blng.doc_ID_IDX ON blng.document ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
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

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  BLNG.doc_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
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

ALTER TRIGGER BLNG.doc_TRGR ENABLE;

end;



/* transactions */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
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
   amount number,
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX blng.trn_ID_IDX ON blng.transaction ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE blng.transaction MODIFY ("ID" CONSTRAINT "TRN_ID_NN" NOT NULL ENABLE);
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
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  BLNG.trn_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
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

ALTER TRIGGER BLNG.trn_TRGR ENABLE;

end;




/* event */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
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
   amount number,
   status VARCHAR2(1),
   priority number
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX blng.evnt_ID_IDX ON blng.event ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
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
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  BLNG.evnt_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
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

ALTER TRIGGER BLNG.evnt_TRGR ENABLE;

end;



/* event_type */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE blng.event_type 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
	 --contract_oid NUMBER(18,0),
   name varchar2(50),
   code varchar2(10),
   details varchar2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX blng.ETT_ID_IDX ON blng.event_type ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE blng.event_type MODIFY ("ID" CONSTRAINT "ETT_ID_NN" NOT NULL ENABLE);
ALTER TABLE BLNG.event_type  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE BLNG.event_type  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE BLNG.event_type  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE blng.event_type ADD CONSTRAINT ETT_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.ETT_ID_IDX ENABLE;

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  BLNG.ett_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
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


ALTER TRIGGER BLNG.ett_TRGR ENABLE;


end;




/* status_type */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE blng.status_type 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
	 --contract_oid NUMBER(18,0),
   name varchar2(50),
   code varchar2(1),
   details varchar2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX blng.STT_ID_IDX ON blng.status_type ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE blng.status_type MODIFY ("ID" CONSTRAINT "STT_ID_NN" NOT NULL ENABLE);
ALTER TABLE BLNG.status_type  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE BLNG.status_type  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE BLNG.status_type  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE blng.status_type ADD CONSTRAINT STT_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.STT_ID_IDX ENABLE;

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  BLNG.stt_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
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


ALTER TRIGGER BLNG.stt_TRGR ENABLE;


end;




/* delay */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
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
   amount number,
   status VARCHAR2(1),
   priority number
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX blng.dly_ID_IDX ON blng.delay ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
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
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  BLNG.DLY_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
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

ALTER TRIGGER BLNG.DLY_TRGR ENABLE;

end;





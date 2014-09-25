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
	 --client_oid NUMBER(18,0),
   name varchar2(255),
   --contract_number VARCHAR2(50),
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

  ALTER TABLE blng.client ADD CONSTRAINT CLT_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.CLT_ID_IDX ENABLE;

/*  ALTER TABLE "BLNG"."M_TRANSACTION" ADD CONSTRAINT "MTR_DOC_OID_FK" FOREIGN KEY ("ID")
  REFERENCES "BLNG"."DOC" ("ID") ENABLE;
*/

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
end;

ALTER TRIGGER BLNG.CLT_TRGR ENABLE;

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

  ALTER TABLE blng.contract ADD CONSTRAINT CNTR_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.CNTR_ID_IDX ENABLE;

ALTER TABLE BLNG.contract ADD CONSTRAINT CNTR_CLT_OID_FK FOREIGN KEY (client_oid)
  REFERENCES BLNG.client ("ID") ENABLE;


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

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.CNTR_TRGR 
BEFORE
INSERT
ON BLNG.contract
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.cntr_seq.nextval into :new.id from dual; 
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
   info  varchar2(255)
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
end;

ALTER TRIGGER BLNG.acct_TRGR ENABLE;

end;





/*account*/
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
   priority number /*,
   status VARCHAR2(1)*/
   
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
end;

ALTER TRIGGER BLNG.acc_TRGR ENABLE;

end;



/* document */
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
   doc_type_oid number
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

  ALTER TABLE blng.account ADD CONSTRAINT ACC_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.ACC_ID_IDX ENABLE;

ALTER TABLE BLNG.account ADD CONSTRAINT ACC_CNTR_OID_FK FOREIGN KEY (account_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;


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
end;

ALTER TRIGGER BLNG.acc_TRGR ENABLE;

end;



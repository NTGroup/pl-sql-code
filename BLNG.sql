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





/*accounts*/
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE blng.accounts 
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
   code varchar2(10)
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
end;

ALTER TRIGGER BLNG.trt_TRGR ENABLE;

end;


/* documents */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE blng.documents 
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
end;

ALTER TRIGGER BLNG.doc_TRGR ENABLE;

end;



/* transactions */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE blng.transactions
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

  CREATE INDEX blng.trn_ID_IDX ON blng.transactions ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE blng.transactions MODIFY ("ID" CONSTRAINT "TRN_ID_NN" NOT NULL ENABLE);

  ALTER TABLE blng.transactions ADD CONSTRAINT TRN_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.trn_ID_IDX ENABLE;

ALTER TABLE BLNG.transactions ADD CONSTRAINT TRN_ACC_OID_FK FOREIGN KEY (target_account_oid)
  REFERENCES BLNG.account ("ID") ENABLE;


ALTER TABLE BLNG.transactions ADD CONSTRAINT TRN_TRT_OID_FK FOREIGN KEY (trans_type_oid)
  REFERENCES BLNG.trans_type ("ID") ENABLE;

ALTER TABLE BLNG.transactions ADD CONSTRAINT TRN_DOC_OID_FK FOREIGN KEY (doc_oid)
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
ON BLNG.transactions
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.trn_seq.nextval into :new.id from dual; 
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
	-- doc_oid NUMBER(18,0),
   event_type_oid NUMBER(18,0),
   transaction_oid NUMBER(18,0),
   --target_account_oid NUMBER(18,0),
   date_to date,
   cotract_oid number(18,0),
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

  CREATE INDEX blng.evnt_ID_IDX ON blng.event ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE blng.event MODIFY ("ID" CONSTRAINT "EVNT_ID_NN" NOT NULL ENABLE);

  ALTER TABLE blng.event ADD CONSTRAINT EVNT_ID_PK PRIMARY KEY (ID)
  USING INDEX BLNG.EVNT_ID_IDX ENABLE;

ALTER TABLE BLNG.event ADD CONSTRAINT EVNT_ETT_OID_FK FOREIGN KEY (event_type_oid)
  REFERENCES BLNG.event_type ("ID") ENABLE;
ALTER TABLE BLNG.event ADD CONSTRAINT EVNT_TRN_OID_FK FOREIGN KEY (transaction_oid)
  REFERENCES BLNG.transaction ("ID") ENABLE;
ALTER TABLE BLNG.event ADD CONSTRAINT EVNT_CNTR_OID_FK FOREIGN KEY (cotract_oid)
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
end;


ALTER TRIGGER BLNG.stt_TRGR ENABLE;


end;





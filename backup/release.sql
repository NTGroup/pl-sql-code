alter table BLNG.CLIENT rename to USR;
alter table BLNG.CLIENT_DATA rename to USR_DATA;
alter table BLNG.CLIENT2CONTRACT rename to USR2CONTRACT;

ALTER TABLE BLNG.USR_DATA RENAME COLUMN CLIENT_OID TO USER_OID;
ALTER TABLE BLNG.USR2CONTRACT RENAME COLUMN CLIENT_OID TO USER_OID;

ALTER TABLE ord.ord RENAME COLUMN CLIENT_OID TO USER_OID;
ALTER TABLE hdbk.note RENAME COLUMN CLIENT_OID TO USER_OID;


alter table BLNG.company rename to client;
ALTER TABLE BLNG.USR RENAME COLUMN company_OID TO CLIENT_OID;
ALTER TABLE BLNG.contract RENAME COLUMN company_OID TO CLIENT_OID;


insert into hdbk.dictionary (code, name, info, dictionary_type) values('GOD','god@ntg-one.com','super user','CONSTANT');
insert into hdbk.dictionary (code, name, info, dictionary_type) values('TASK_INTERVAL','30','interval for repeat get task','1C');
insert into hdbk.dictionary (code, name, info, dictionary_type) values('BILL_ADD','BILL_ADD','BILL_ADD','1C');
commit;



/* ord.task1c */

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.task1c 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   task_type NUMBER(18,0), 
   number_1c VARCHAR2(50), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.t1c_ID_IDX ON ord.task1c (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.task1c MODIFY (ID CONSTRAINT t1c_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.task1c MODIFY (AMND_DATE CONSTRAINT t1c_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.task1c MODIFY (AMND_USER CONSTRAINT t1c_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.task1c MODIFY (AMND_STATE CONSTRAINT t1c_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.task1c  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.task1c  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.task1c  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.task1c ADD CONSTRAINT t1c_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.t1c_ID_IDX ENABLE;
 
  
/*  ALTER TABLE ord.task1c ADD CONSTRAINT t1c_ord_OID_FK FOREIGN KEY (order_oid)
  REFERENCES ord.ord (ID) ENABLE;

  ALTER TABLE ord.task1c ADD CONSTRAINT t1c_cntr_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES blng.contract (ID) ENABLE;
  */
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ord.t1c_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.t1c_TRGR 
BEFORE
INSERT
ON ord.task1c
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select t1c_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.t1c_TRGR ENABLE;

/

/* ord.bill2task */

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.bill2task 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   bill_oid NUMBER(18,0), 
   task_oid NUMBER(18,0)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.b2t_ID_IDX ON ord.bill2task (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.bill2task MODIFY (ID CONSTRAINT b2t_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.bill2task MODIFY (AMND_DATE CONSTRAINT b2t_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.bill2task MODIFY (AMND_USER CONSTRAINT b2t_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.bill2task MODIFY (AMND_STATE CONSTRAINT b2t_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.bill2task  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.bill2task  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.bill2task  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.bill2task ADD CONSTRAINT b2t_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.b2t_ID_IDX ENABLE;
 
  

  ALTER TABLE ord.bill2task ADD CONSTRAINT b2t_bill_OID_FK FOREIGN KEY (bill_oid)
  REFERENCES ord.bill (ID) ENABLE;

  ALTER TABLE ord.bill2task ADD CONSTRAINT b2t_t1c_OID_FK FOREIGN KEY (task_oid)
  REFERENCES ord.task1c (ID) ENABLE;
  
  
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ord.b2t_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.b2t_TRGR 
BEFORE
INSERT
ON ord.bill2task
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select b2t_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.b2t_TRGR ENABLE;

/

CREATE bitmap INDEX ord.t1c_AS_IDX ON ord.task1c (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.p2t_AS_IDX ON ord.bill2task (amnd_state) TABLESPACE USERS ;
/


@dba/GRANTS.sql;
@metadata/view.sql;
@data/pkg/hdbk.hdbk_api.sql;
@data/pkg/hdbk.fwdr.sql;
@data/pkg/hdbk.log_api.sql;
@data/pkg/hdbk.dtype.sql;
@data/pkg/hdbk.core.sql;
@data/pkg/blng.blng_api.sql;
@data/pkg/blng.core.sql;
@data/pkg/blng.fwdr.sql;
@data/pkg/ord.ord_api.sql;
@data/pkg/ord.core.sql;
@data/pkg/ord.fwdr.sql;
--@data/pkg/erp.erp_api.sql;
--@data/pkg/erp.gate.sql;
--@metadata/get_ddl.sql;







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

drop table ord.passenger;
drop table ord.flight_stop;
drop table ord.price_quote;
drop table ord.item_insurance;
drop table ord.item_hotel;
drop table ord.segment;
drop table ord.leg;
drop table ord.itinerary;
drop table ord.pnr;

drop sequence ord.ihtl_seq;
drop sequence ord.IINS_SEQ;
drop sequence ord.ITIN_SEQ;
drop sequence ord.LEG_SEQ;
drop sequence ord.PAX_SEQ;
drop sequence ord.PNR_SEQ;
drop sequence ord.PQ_SEQ;
drop sequence ord.SGM_SEQ;
drop sequence ord.STOP_SEQ;


/

/* itinerary */


  CREATE TABLE ord.itinerary
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   item_avia_oid NUMBER(18,0)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ord.itin_ID_IDX ON ord.itinerary (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.itinerary MODIFY (ID CONSTRAINT itin_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.itinerary MODIFY (AMND_DATE CONSTRAINT itin_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.itinerary MODIFY (AMND_USER CONSTRAINT itin_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.itinerary MODIFY (AMND_STATE CONSTRAINT itin_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.itinerary  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.itinerary  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.itinerary  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.itinerary ADD CONSTRAINT itin_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.itin_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.itinerary ADD CONSTRAINT itin_iav_OID_FK FOREIGN KEY (item_avia_oid)
  REFERENCES ord.item_avia (ID) ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  ORD.itin_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache 
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.itin_TRGR 
BEFORE
INSERT
ON ord.itinerary
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select itin_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.itin_TRGR ENABLE;

/



/* leg */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ord.leg
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   itinerary_oid NUMBER(18,0),
   sequence_number NUMBER(18,0),
   departure_iata varchar2(10),
   departure_city NUMBER(18,0),
   departure_date date,
   arrival_iata varchar2(10),
   arrival_city NUMBER(18,0),
   arrival_date date
   
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ord.leg_ID_IDX ON ord.leg (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.leg MODIFY (ID CONSTRAINT leg_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.leg MODIFY (AMND_DATE CONSTRAINT leg_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.leg MODIFY (AMND_USER CONSTRAINT leg_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.leg MODIFY (AMND_STATE CONSTRAINT leg_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.leg  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.leg  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.leg  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.leg ADD CONSTRAINT leg_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.leg_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.leg ADD CONSTRAINT leg_itin_OID_FK FOREIGN KEY (itinerary_oid)
  REFERENCES ord.itinerary (ID) ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  ORD.leg_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache 
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.leg_TRGR 
BEFORE
INSERT
ON ord.leg
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select leg_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.leg_TRGR ENABLE;

/


/* segment */

  CREATE TABLE ord.segment
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   leg_oid NUMBER(18,0), 
   sequence_number NUMBER(18,0),
   departure_iata varchar2(10),
   departure_city NUMBER(18,0),
   departure_date date,
   arrival_iata varchar2(10),
   arrival_city NUMBER(18,0),
   arrival_date date

   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ord.sgm_ID_IDX ON ord.segment (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.segment MODIFY (ID CONSTRAINT sgm_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.segment MODIFY (AMND_DATE CONSTRAINT sgm_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.segment MODIFY (AMND_USER CONSTRAINT sgm_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.segment MODIFY (AMND_STATE CONSTRAINT sgm_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.segment  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.segment  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.segment  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.segment ADD CONSTRAINT sgm_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.sgm_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.segment ADD CONSTRAINT sgm_leg_oid_FK FOREIGN KEY (leg_oid)
  REFERENCES ord.leg (ID) ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  ORD.sgm_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache 
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.sgm_TRGR 
BEFORE
INSERT
ON ord.segment
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select sgm_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.sgm_TRGR ENABLE;

/

CREATE bitmap INDEX ord.itin_AS_IDX ON ord.itinerary (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.leg_AS_IDX ON ord.leg (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.sgm_AS_IDX ON ord.segment (amnd_state) TABLESPACE USERS ;
/

update  blng.contract  set name = contract_number where  amnd_state = 'A' and name is null;
commit;
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







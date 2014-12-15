select * from t_document@dblctagan
select * from C##TAGAN.T_DOC_AIRLINE--@dblctagan





/* commission_template */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.commission_template
   (	   ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   template_type VARCHAR2(50), 
   class varchar(10),
   flight_ac varchar(10),
   flight_not_ac varchar(10),
   flight_mc varchar(10),
   flight_oc varchar(10),
   flight_vc varchar(10),
   flight_segment varchar(10),
   country_from varchar(10),
   country_to varchar(10),
   country_inside varchar(10),
   country_outside varchar(10),
   tariff varchar(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.CT_ID_IDX ON ord.commission_template ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.commission_template MODIFY ("ID" CONSTRAINT CT_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.commission_template MODIFY (AMND_DATE CONSTRAINT "CT_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.commission_template MODIFY (AMND_USER CONSTRAINT "CT_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.commission_template MODIFY (AMND_STATE CONSTRAINT "CT_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.commission_template  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.commission_template  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.commission_template  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.commission_template ADD CONSTRAINT CT_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.CT_ID_IDX ENABLE;


/*
ALTER TABLE ord.commission_template ADD CONSTRAINT CT_ETT_OID_FK FOREIGN KEY (event_type_oid)
  REFERENCES BLNG.event_type ("ID") ENABLE;
ALTER TABLE ord.commission_template ADD CONSTRAINT CT_TRN_OID_FK FOREIGN KEY (transaction_oid)
  REFERENCES BLNG.transaction ("ID") ENABLE;
ALTER TABLE ord.commission_template ADD CONSTRAINT CT_CNTR_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;
*/

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ord.CT_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.CT_TRGR 
BEFORE
INSERT
ON ord.commission_template
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select CT_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER ord.CT_TRGR ENABLE;

end;





/* commission */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.commission
   (	   ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   avia_company NUMBER(18,0),
   details varchar2(255),
   fix number,
   percent number   
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.CMN_ID_IDX ON ord.commission ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.commission MODIFY ("ID" CONSTRAINT CMN_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.commission MODIFY (AMND_DATE CONSTRAINT "CMN_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.commission MODIFY (AMND_USER CONSTRAINT "CMN_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.commission MODIFY (AMND_STATE CONSTRAINT "CMN_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.commission  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.commission  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.commission  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.commission ADD CONSTRAINT CMN_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.CMN_ID_IDX ENABLE;


/*
ALTER TABLE ord.commission ADD CONSTRAINT CMN_ETT_OID_FK FOREIGN KEY (event_type_oid)
  REFERENCES BLNG.event_type ("ID") ENABLE;
ALTER TABLE ord.commission ADD CONSTRAINT CMN_TRN_OID_FK FOREIGN KEY (transaction_oid)
  REFERENCES BLNG.transaction ("ID") ENABLE;
ALTER TABLE ord.commission ADD CONSTRAINT CMN_CNTR_OID_FK FOREIGN KEY (contraCMN_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;
*/

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ord.CMN_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.CMN_TRGR 
BEFORE
INSERT
ON ord.commission
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select CMN_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER ord.CMN_TRGR ENABLE;

end;




/* commission_details */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.commission_details
   (	   ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   commission_oid NUMBER(18,0),
   commission_template_oid NUMBER(18,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.CD_ID_IDX ON ord.commission_details ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.commission_details MODIFY ("ID" CONSTRAINT CD_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.commission_details MODIFY (AMND_DATE CONSTRAINT "CD_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.commission_details MODIFY (AMND_USER CONSTRAINT "CD_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.commission_details MODIFY (AMND_STATE CONSTRAINT "CD_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.commission_details  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.commission_details  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.commission_details  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.commission_details ADD CONSTRAINT CD_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.CD_ID_IDX ENABLE;



ALTER TABLE ord.commission_details ADD CONSTRAINT CD_CMN_OID_FK FOREIGN KEY (commission_oid)
  REFERENCES ord.commission ("ID") ENABLE;
ALTER TABLE ord.commission_details ADD CONSTRAINT CD_CT_OID_FK FOREIGN KEY (commission_template_oid)
  REFERENCES ord.commission_template ("ID") ENABLE;

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ord.CD_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.CD_TRGR 
BEFORE
INSERT
ON ord.commission_details
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select CD_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER ord.CD_TRGR ENABLE;

end;




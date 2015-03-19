
ALTER TABLE blng.domain drop CONSTRAINT DMN_CMP_OID_FK;

ALTER TABLE BLNG.DOMAIN RENAME COLUMN company_oid TO contract_oid;

update BLNG.DOMAIN set contract_oid = (select id from blng.contract where amnd_state = 'A' and company_oid = DOMAIN.contract_oid);
commit;

ALTER TABLE blng.domain add CONSTRAINT DMN_cntr_OID_FK FOREIGN KEY (contract_oid)
REFERENCES blng.contract ("ID") ENABLE;


grant execute on ntg.fwdr to ord ;


alter table blng.client add is_tester varchar2(1);

alter table ntg.markup add markup_type_oid number(18,0);
--alter table ntg.markup drop COLUMN markup_type;


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

INSERT INTO "NTG"."MARKUP_TYPE" (NAME) VALUES ('BASE');
INSERT INTO "NTG"."MARKUP_TYPE" (NAME) VALUES ('PARTNER');
COMMIT;
/

UPDATE NTG.MARKUP SET MARKUP_TYPE_OID = 1;
COMMIT;

UPDATE BLNG.CLIENT SET IS_TESTER = 'N' where IS_TESTER is null;
commit;
/

/* create new user shcheme inside pdb */
create user dict identified by DICTasdf1234;
     
/* inside pdb */ 
alter user dict 
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
ACCOUNT LOCK ;

GRANT create session TO dict;
/

@metadata/DICT.sql;

/



insert into dict.airline
select * from ntg.airline;
commit;

insert into dict.airplane
select * from ntg.airplane;
commit;

insert into dict.GDS_NATIONALITY
select * from ntg.GDS_NATIONALITY;
commit;

insert into dict.geo
select  ID,
  AMND_DATE,
  AMND_USER,
  AMND_STATE,
  AMND_PREV,
  PARENT_ID,
  NAME,
  NLS_NAME,
  IATA,
  CODE,
  OBJECT_TYPE,
  COUNTRY_ID,
  CITY_ID,
  IS_ACTIVE,
  NEW_PARENT_ID,
  UTC_OFFSET,
  SEARCH_RATING,
  NLS_NAME_IP,
  NLS_NAME_RP,
  NLS_NAME_DP,
  NLS_NAME_VP,
  NLS_NAME_TP,
  NLS_NAME_PP from ntg.geo;
commit;

/*insert into dict.log
select * from ntg.log;
commit;*/

insert into dict.markup
select   ID,
  AMND_DATE,
  AMND_USER,
  AMND_STATE,
  AMND_PREV,
  contract_oid,
  GDS,
  POS,
  VALIDATING_CARRIER,
  CLASS_OF_SERVICE,
  SEGMENT,
  HUMAN,
  V_FROM,
  V_TO,
  ABSOLUT,
  ABSOLUT_AMOUNT,
  PERCENT,
  PERCENT_AMOUNT,
  MIN_ABSOLUT,
  MAX_ABSOLUT,
  MARKUP_TYPE_OID from ntg.markup;
commit;

/*insert into dict.markup_type
select * from ntg.markup_type;
commit;*/

/

INSERT INTO "DICT"."MARKUP_TYPE" (NAME) VALUES ('BASE');
INSERT INTO "DICT"."MARKUP_TYPE" (NAME) VALUES ('PARTNER');
COMMIT;
/


drop sequence dict.al_seq;
drop sequence dict.ap_seq;
drop sequence dict.geo_seq;
drop sequence dict.mkp_seq;
drop sequence dict.gnt_seq;

----


  create sequence  dict.al_seq
  increment by 1
  start with 1598
  nomaxvalue
  nocache 
  nocycle
  order;

  create sequence  dict.AP_seq
  increment by 1
  start with 128
  nomaxvalue
  nocache 
  nocycle
  order;
  
    create sequence  dict.geo_seq
  increment by 1
  start with 26039
  nomaxvalue
  nocache 
  nocycle
  order;
  

    create sequence  dict.mkp_seq
  increment by 1
  start with 35
  nomaxvalue
  nocache 
  nocycle
  order;
  
    create sequence  dict.gnt_seq
  increment by 1
  start with 232
  nomaxvalue
  nocache 
  nocycle
  order;

/



grant references on ord.bill to dict;
grant references on ord.ord to dict;
grant references on ord.ticket to dict;
grant references on ord.item_avia to dict;
grant references on ord.item_avia_status to dict;
grant references on ord.commission to dict;
grant references on ord.commission_details to dict;
grant references on ord.commission_template to dict;
grant references on ord.pos_rule to dict;

grant select on ord.bill to dict;
grant select on ord.ord to dict;
grant select on ord.ticket to dict;
grant select on ord.item_avia to dict;
grant select on ord.item_avia_status to dict;
grant select on ord.commission to dict;
grant select on ord.commission_details to dict;
grant select on ord.commission_template to dict;
grant select on ord.pos_rule to dict;

/


@metadata/view.sql;
@data/pkg/blng.blng_api.sql;
@data/pkg/blng.core.sql;
@data/pkg/blng.fwdr.sql;
@data/pkg/ntg.ntg_api.sql;
@data/pkg/ntg.fwdr.sql;
@data/pkg/ntg.log_api.sql;
@data/pkg/ntg.dtype.sql;
@data/pkg/ord.ord_api.sql;
@data/pkg/ord.core.sql;
@data/pkg/ord.fwdr.sql;

@data/pkg/dict.dtype.sql;
@data/pkg/dict.dict_api.sql;
@data/pkg/dict.fwdr.sql;
@data/pkg/dict.log_api.sql;


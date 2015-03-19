/* create new user shcheme inside pdb */
create user dict identified by ***;
     
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

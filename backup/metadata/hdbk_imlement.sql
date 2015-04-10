/* create new user shcheme inside pdb */
create user hdbk identified by cccCCC111;
     
/* inside pdb */ 
alter user hdbk 
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
ACCOUNT LOCK ;
/

@metadata/hdbk.sql;

/



insert into hdbk.airline
select * from ntg.airline;
commit;

insert into hdbk.airplane
select * from ntg.airplane;
commit;

insert into hdbk.GDS_NATIONALITY
select * from ntg.GDS_NATIONALITY;
commit;

insert into hdbk.markup_type
select * from ntg.markup_type;
commit;


insert into hdbk.geo
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


drop sequence hdbk.al_seq;
drop sequence hdbk.ap_seq;
drop sequence hdbk.geo_seq;
drop sequence hdbk.gnt_seq;
drop sequence hdbk.mkpt_seq;

----


  create sequence  hdbk.al_seq
  increment by 1
  start with 1598
  nomaxvalue
  nocache 
  nocycle
  order;

  create sequence  hdbk.AP_seq
  increment by 1
  start with 128
  nomaxvalue
  nocache 
  nocycle
  order;
  
    create sequence  hdbk.geo_seq
  increment by 1
  start with 26039
  nomaxvalue
  nocache 
  nocycle
  order;
  
  
    create sequence  hdbk.gnt_seq
  increment by 1
  start with 232
  nomaxvalue
  nocache 
  nocycle
  order;

  
  create sequence  hdbk.mkpt_seq
  increment by 1
  start with 6
  nomaxvalue
  nocache 
  nocycle
  order;

/


/*
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
*/

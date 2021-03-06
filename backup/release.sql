
alter table blng.delay add doc_oid number(18,0) ;

ALTER TABLE BLNG.delay ADD CONSTRAINT DLY_DOC_OID_FK FOREIGN KEY (DOC_oid)
  REFERENCES BLNG.DOCUMENT (ID) ENABLE;

update  blng.delay set doc_oid = (select doc_oid from blng.transaction where id = delay.transaction_oid);
commit;

insert into hdbk.dictionary (code, name, info, dictionary_type) values('BILL_DEPOSIT','BILL_DEPOSIT','deposit bill for client','TASK');
insert into hdbk.dictionary (code, name, info, dictionary_type) values('DEPOSIT','0','1c product and vat value','1C_PRODUCT_W_VAT');

insert into hdbk.dictionary (code, name, info, dictionary_type) values('LOAN','','','TRANS_TYPE');

commit;


update blng.document set account_trans_type_oid = HDbk.core.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>HDbk.core.dictionary_get_code(account_trans_type_oid)) 
where account_trans_type_oid is not null;
commit;

delete from hdbk.dictionary where dictionary_type = 'ACCOUNT_TYPE';
commit;


insert into hdbk.dictionary (code, name, info, dictionary_type)
select 
--id,
decode(code, 'd','DEPOSIT','l','LOAN','cl','CREDIT_LIMIT','clb','CREDIT_LIMIT_BLOCK',
'do','DEBIT_ONLINE','co','CREDIT_ONLINE','ult','UP_LIM_TRANS','dd','DELAY_DAYS') a,
code,
details,
'ACCOUNT_TYPE'
from blng.account_type;
commit;




ALTER TABLE BLNG.account DROP CONSTRAINT ACC_ACCT_OID_FK; 


update BLNG.ACCOUNT set /*code=
decode(code, 'd','DEPOSIT','l','LOAN','cl','CREDIT_LIMIT','clb','CREDIT_LIMIT_BLOCK',
'do','DEBIT_ONLINE','co','CREDIT_ONLINE','ult','UP_LIM_TRANS','dd','DELAY_DAYS'),*/
ACCOUNT_TYPE_OID = HDbk.core.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=> decode(code, 'd','DEPOSIT','l','LOAN','cl','CREDIT_LIMIT','clb','CREDIT_LIMIT_BLOCK',
'do','DEBIT_ONLINE','co','CREDIT_ONLINE','ult','UP_LIM_TRANS','dd','DELAY_DAYS') ) ;
commit;


update hdbk.dictionary set code = 'DELAY_DAYS' where code = 'DELAY_DAY';
commit;


alter table blng.account drop column code;

alter table blng.account add code VARCHAR2(50);
update  blng.account set code = (select code from hdbk.dictionary where id = account_type_oid) where amnd_state = 'A';
commit;


alter TABLE blng.delay DROP COLUMN transaction_oid;

-------------
ALTER TABLE BLNG.event drop CONSTRAINT EVNT_ETT_OID_FK;
ALTER TABLE BLNG.delay drop CONSTRAINT DLY_ETT_OID_FK; 


insert into hdbk.dictionary (code, name, info, dictionary_type)
select 
--id,
decode(code, 'b','BUY','ci','CASH_IN','clu','CREDIT_LIMIT_UNBLOCK') a,
code,
--details,
name,
'EVENT_TYPE'
from blng.event_type where id in (3,6,7);
commit;


update BLNG.delay set 
event_TYPE_OID = HDbk.core.dictionary_get_id(p_dictionary_type=>'EVENT_TYPE',p_code=> decode((select code from BLNG.EVENT_TYPE where id = event_type_oid), 'b','BUY','ci','CASH_IN','clu','CREDIT_LIMIT_UNBLOCK') ) 
where event_TYPE_OID is not null
;
commit;


--------------


insert into hdbk.dictionary (code, name, info, dictionary_type)
select 'MARKUP','MARKUP',null,'RULE_TYPE' from dual
union all
select 'COMMISSION','COMMISSION',null,'RULE_TYPE' from dual

union all
select 'BASE','BASE',null,'MARKUP_TYPE' from dual
union all
select 'PARTNER','PARTNER',null,'MARKUP_TYPE' from dual
union all
select 'SUPPLIER','SUPPLIER',null,'MARKUP_TYPE' from dual
commit;


update  ord.commission set rule_type = hdbk.core.dictionary_get_id(p_dictionary_type=>'RULE_TYPE',p_code=> (select name from hdbk.markup_type where id = rule_type)),
markup_type = hdbk.core.dictionary_get_id(p_dictionary_type=>'MARKUP_TYPE',p_code=> (select name from hdbk.markup_type where id = markup_type))

where amnd_state!='I' ;
commit;
------------

ALTER TABLE BLNG.document DROP CONSTRAINT DOC_TRT_OID_FK;
ALTER TABLE BLNG.transaction DROP CONSTRAINT TRN_TRT_OID_FK;


insert into hdbk.dictionary (code, name, info, dictionary_type)
select 
decode(code, 'da','DEBIT_ADJUSTMENT','ca','CREDIT_ADJUSTMENT','clb','CREDIT_LIMIT_BLOCK','clu','CREDIT_LIMIT_UNBLOCK','rvk','REVOKE') a,
code,
---name,
details,
'TRANS_TYPE'
from blng.trans_type
where code in ('da','ca','clb','clu','rvk');
commit;

update blng.transaction  set trans_type_oid = hdbk.core.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=> decode((select code from blng.trans_type where id = trans_type_oid),'b','BUY','da','DEBIT_ADJUSTMENT','ca','CREDIT_ADJUSTMENT','clb','CREDIT_LIMIT_BLOCK','clu','CREDIT_LIMIT_UNBLOCK','rvk','REVOKE',
'd','DEPOSIT','l','LOAN','cl','CREDIT_LIMIT','clb','CREDIT_LIMIT_BLOCK',
'do','DEBIT_ONLINE','co','CREDIT_ONLINE','ult','UP_LIM_TRANS','dd','DELAY_DAYS','ci','CASH_IN'));
commit;

-------------
drop table HDBK.MARKUP_TYPE;
drop table BLNG.ACCOUNT_TYPE;
drop table BLNG.STATUS_TYPE;
drop table BLNG.TRANS_TYPE;
drop table BLNG.EVENT_TYPE;

drop SEQUENCE BLNG.acct_seq;
drop SEQUENCE BLNG.ett_seq;
drop SEQUENCE BLNG.stt_seq;
drop SEQUENCE BLNG.trt_seq;
drop SEQUENCE hdbk.mkpt_seq;

-------------
  CREATE TABLE ord.event
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   task varchar2(50),
   contract_oid NUMBER(18,0),
   user_oid number(18,0),
   pnr_id varchar2(50),
   request clob,
   status varchar2(1),
   result  varchar2(50),
   error  varchar2(255)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ord.evnt_ID_IDX ON ord.event (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.event MODIFY (ID CONSTRAINT evnt_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.event MODIFY (AMND_DATE CONSTRAINT evnt_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.event MODIFY (AMND_USER CONSTRAINT evnt_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.event MODIFY (AMND_STATE CONSTRAINT evnt_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.event  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.event  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.event  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.event ADD CONSTRAINT evnt_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.evnt_ID_IDX ENABLE;
 
 
  
/*  ALTER TABLE ord.event ADD CONSTRAINT evnt_leg_oid_FK FOREIGN KEY (leg_oid)
  REFERENCES ord.leg (ID) ENABLE;
 */
 
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  ORD.evnt_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache 
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.evnt_TRGR 
BEFORE
INSERT
ON ord.event
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select evnt_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.evnt_TRGR ENABLE;

/

CREATE bitmap INDEX ord.evnt_AS_IDX ON ord.event (amnd_state) TABLESPACE USERS ;
/

BEGIN
DBMS_SCHEDULER.CREATE_SCHEDULE (    	   
  repeat_interval   => 'FREQ=SECONDLY;INTERVAL=2',     
  start_date        => SYSTIMESTAMP,
  comments          => 'Every 10 second',
  schedule_name     => 'HDBK.EVENT_HANDLER_SCHEDULE');    
END;
/

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'HDBK.EVENT_HANDLER',
   schedule_name      =>  'HDBK.EVENT_HANDLER_SCHEDULE',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'ORD.CORE.EVENT_HANDLER',
   enabled            =>  TRUE,
   COMMENTS           =>  'check event tasks from NQT' );
END;
/



alter table blng.contract    add   legal_name varchar2(4000);
alter table blng.contract   add    inn varchar2(50);
alter table blng.contract   add    kpp varchar2(50);
alter table blng.contract   add    ogrn varchar2(50);
alter table blng.contract   add    legal_address varchar2(4000);
alter table blng.contract   add    bank_bik varchar2(50);
alter table blng.contract   add    bank_account varchar2(50);
alter table blng.contract  add     signatory_name varchar2(4000);
alter table blng.contract  add     signatory_title varchar2(255);
      
      
      

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
-- @metadata/get_ddl.sql;
-- @metadata/get_ddl_md.sql;
@metadata/get_ddl_table.sql;







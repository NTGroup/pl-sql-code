

alter table blng.contract add name varchar2(255);
alter table ord.bill add bill_oid number(18,0);
alter table ord.bill add trans_type_oid number(18,0);
alter table blng.document add account_trans_type_oid number(18,0);


INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('LOAN', 'ACCOUNT_TYPE');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('BUY', 'ACCOUNT_TYPE');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('CASH_IN', 'ACCOUNT_TYPE');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('PAY_BILL', 'ACCOUNT_TYPE');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('CREDIT_LIMIT', 'ACCOUNT_TYPE');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('DELAY_DAY', 'ACCOUNT_TYPE');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('UP_LIM_TRANS', 'ACCOUNT_TYPE');
INSERT INTO "HDBK"."DICTIONARY" ( CODE, NAME, INFO, DICTIONARY_TYPE) VALUES ('ERROR', 'ERROR', 'ERROR', 'CONSTANT');
INSERT INTO "HDBK"."DICTIONARY" ( CODE, NAME, INFO, DICTIONARY_TYPE) VALUES ('NULL', 'NULL', 'NULL', 'CONSTANT');
INSERT INTO "HDBK"."DICTIONARY" ( CODE, NAME, INFO, DICTIONARY_TYPE) VALUES ('UNDEFINED', 'UNDEFINED', 'UNDEFINED', 'CONSTANT');
INSERT INTO "HDBK"."DICTIONARY" ( CODE, NAME, INFO, DICTIONARY_TYPE) VALUES ('DEFAULT', 'DEFAULT', 'DEFAULT', 'CONSTANT');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('BUY', 'TRANS_TYPE');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('CASH_IN', 'TRANS_TYPE');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('PAY_BILL', 'TRANS_TYPE');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('CREDIT_LIMIT', 'TRANS_TYPE');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('DELAY_DAY', 'TRANS_TYPE');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('UP_LIM_TRANS', 'TRANS_TYPE');

-- ??? INSERT INTO "ORD"."COMMISSION_TEMPLATE" (TEMPLATE_TYPE, PRIORITY, DETAILS, IS_CONTRACT_TYPE, NAME, NLS_NAME, IS_VALUE) VALUES ('ANY', '0', 'ANY', 'Y', 'ANY', 'ANY', 'N');

commit;

update blng.document set account_trans_type_oid = 
 case 
          when (select id from blng.delay where  amnd_state in ('A','C') and event_type_oid = 6 and transaction_oid = (select id from blng.transaction where doc_oid = document.id and amnd_state = 'A' and trans_type_oid in (select id from blng.trans_type where code in ('b','ci','cl')) )) is not null and (select code from blng.trans_type where id = document.trans_type_oid) = 'b' then hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'LOAN')
          when (select code from blng.trans_type where id = document.trans_type_oid) = 'b' then hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'BUY')
          when (select code from blng.trans_type where id = document.trans_type_oid) = 'ci' then hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'CASH_IN')
          when (select code from blng.trans_type where id = document.trans_type_oid) = 'cl' then hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'CREDIT_LIMIT')
          when (select code from blng.trans_type where id = document.trans_type_oid) = 'dd' then hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'DELAY_DAY')
          when (select code from blng.trans_type where id = document.trans_type_oid) = 'ult' then hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'UP_LIM_TRANS')
          else null
        end  where amnd_state = 'A'
and account_trans_type_oid is null;
commit;



 /* create new user shcheme inside pdb */
create user erp identified by ***;
/     
/* inside pdb */ 
alter user erp
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
ACCOUNT LOCK ;


alter user erp account lock;

create user erp_gate identified by ***;
/     
/* inside pdb */ 
alter user erp_gate
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
ACCOUNT UNLOCK ;


/*grant execute on hdbk.dtype to ntg_usr1
grant execute on hdbk.dtype to po_fwdr
grant execute on hdbk.fwdr to po_fwdr
*/

alter user erp_gate account UNLOCK;
--GRANT RESTRICTED SESSION to erp
GRANT create SESSION to erp_gate;



  CREATE TABLE hdbk.pdf_printer 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   code  VARCHAR2(50),
   name  VARCHAR2(255),
   INFO  VARCHAR2(255),
   pdf_printer_type varchar2(50)
   
  
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX hdbk.pdfp_ID_IDX ON hdbk.pdf_printer ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------


  ALTER TABLE hdbk.pdf_printer MODIFY ("ID" CONSTRAINT pdfp_ID_NN NOT NULL ENABLE);
  ALTER TABLE hdbk.pdf_printer MODIFY (AMND_DATE CONSTRAINT "pdfp_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.pdf_printer MODIFY (AMND_USER CONSTRAINT "pdfp_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.pdf_printer MODIFY (AMND_STATE CONSTRAINT "pdfp_AST_NN" NOT NULL ENABLE);
ALTER TABLE hdbk.pdf_printer  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE hdbk.pdf_printer  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE hdbk.pdf_printer  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE hdbk.pdf_printer ADD CONSTRAINT pdfp_ID_PK PRIMARY KEY (ID)
  USING INDEX hdbk.pdfp_ID_IDX ENABLE;

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  hdbk.pdfp_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.pdfp_TRGR 
BEFORE
INSERT
ON hdbk.pdf_printer
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select hdbk.pdfp_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER hdbk.pdfp_TRGR ENABLE;

/  
  CREATE bitmap INDEX hdbk.pdfp_AS_IDX ON hdbk.pdf_printer (amnd_state) TABLESPACE "USERS" ;


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




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


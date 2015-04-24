

alter table ord.bill add bill_oid number(18,0);
alter table ord.bill add trans_type_oid number(18,0);
alter table blng.document add account_trans_type_oid number(18,0);


INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('LOAN', 'ACCOUNT_TYPE');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('BUY', 'ACCOUNT_TYPE');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('CASH_IN', 'ACCOUNT_TYPE');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('CREDIT_LIMIT', 'ACCOUNT_TYPE');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('DELAY_DAY', 'ACCOUNT_TYPE');
INSERT INTO "HDBK"."DICTIONARY" (CODE, DICTIONARY_TYPE) VALUES ('UP_LIM_TRANS', 'ACCOUNT_TYPE');
INSERT INTO "HDBK"."DICTIONARY" ( CODE, NAME, INFO, DICTIONARY_TYPE) VALUES ('ERROR', 'ERROR', 'ERROR', 'DEFAULT');
INSERT INTO "HDBK"."DICTIONARY" ( CODE, NAME, INFO, DICTIONARY_TYPE) VALUES ('NULL', 'NULL', 'NULL', 'DEFAULT');
INSERT INTO "HDBK"."DICTIONARY" ( CODE, NAME, INFO, DICTIONARY_TYPE) VALUES ('UNDEFINED', 'UNDEFINED', 'UNDEFINED', 'DEFAULT');
INSERT INTO "ORD"."COMMISSION_TEMPLATE" (TEMPLATE_TYPE, PRIORITY, DETAILS, IS_CONTRACT_TYPE, NAME, NLS_NAME, IS_VALUE) VALUES ('ANY', '0', 'ANY', 'Y', 'ANY', 'ANY', 'N');

commit;



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


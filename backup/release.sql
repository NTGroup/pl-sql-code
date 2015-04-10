@metadata/HDBK.sql;

@metadata/hdbk_implement.sql;

/

alter table ord.ticket add partner_FEE_AMOUNT NUMBER(20,2);
grant select on hdbk.markup_type to ord;


alter table ord.commission 
add contract_oid number(18,0);

alter table ord.commission 
add min_absolut number(20,2);

alter table ord.commission 
add RULE_TYPE number(18,0);

alter table ord.commission 
add MARKUP_TYPE number(18,0);

alter table ord.commission 
add per_segment varchar2(1);

alter table ord.commission 
add currency number(18,0);

alter table ord.commission 
add per_fare varchar2(1);

ALTER TABLE ord.commission ADD CONSTRAINT CMN_CNTR_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;


  
INSERT INTO hdbk.CURRENCY (ID, AMND_PREV, CODE, NAME, NLS_NAME, IS_CURRENCY) VALUES ('810', '810', 'RUB', 'RUB', 'руб.', 'Y');
INSERT INTO hdbk.CURRENCY (ID, AMND_PREV, CODE, NAME, NLS_NAME, IS_CURRENCY) VALUES ('840', '840', 'USD', 'USD', '$', 'Y');
INSERT INTO hdbk.CURRENCY (ID, AMND_PREV, CODE, NAME, IS_CURRENCY) VALUES ('978', '978', 'EUR', 'EUR', 'Y');
INSERT INTO hdbk.CURRENCY (ID, AMND_PREV, CODE, NAME, IS_CURRENCY) VALUES ('1', '1', '%', 'PERCENT', 'N');


INSERT INTO hdbk.MARKUP_TYPE (NAME) VALUES ('SUPPLIER');
INSERT INTO hdbk.MARKUP_TYPE (NAME) VALUES ('COMMISSION');
INSERT INTO hdbk.MARKUP_TYPE (NAME) VALUES ('MARKUP');


commit;
 
update ORD.commission set rule_type = 4;
commit;


INSERT INTO "ORD"."COMMISSION" (AIRLINE, DETAILS, FIX, PRIORITY, CONTRACT_OID, rule_type, MARKUP_TYPE, PER_SEGMENT, CURRENCY) VALUES ('1597', 'MARKUP', '400', '0', '0', 5 ,'1', 'N', '810');
INSERT INTO "ORD"."COMMISSION" (AIRLINE, DETAILS, PERCENT, PRIORITY, CONTRACT_OID, MIN_ABSOLUT, rule_type, MARKUP_TYPE, PER_SEGMENT, CURRENCY) VALUES ('1597', 'MARKUP', '0', '0', '25', '0',5 , '1', 'N', '1');
INSERT INTO "ORD"."COMMISSION" (AIRLINE, DETAILS, PERCENT, PRIORITY, CONTRACT_OID, MIN_ABSOLUT, rule_type, MARKUP_TYPE, PER_SEGMENT, CURRENCY) VALUES ('1597', 'MARKUP', '4', '0', '24', '0',5 ,'1', 'N', '1');
commit;

/


grant execute on blng.blng_api to hdbk;

drop package ntg.log_api;
drop package ntg.dtype;
drop table ntg.log;
drop sequence ntg.log_seq;


/


@dba/GRANTS.sql;
@metadata/view.sql;
@data/pkg/hdbk.hdbk_api.sql;
@data/pkg/hdbk.fwdr.sql;
@data/pkg/hdbk.log_api.sql;
@data/pkg/hdbk.dtype.sql;
@data/pkg/blng.blng_api.sql;
@data/pkg/blng.core.sql;
@data/pkg/blng.fwdr.sql;
@data/pkg/ord.ord_api.sql;
@data/pkg/ord.core.sql;
@data/pkg/ord.fwdr.sql;

не забыть исправить sphinx


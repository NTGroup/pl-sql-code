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



Insert into ORD.COMMISSION_TEMPLATE (AMND_DATE,AMND_USER,AMND_STATE,AMND_PREV,TEMPLATE_TYPE,CLASS,FLIGHT_AC,FLIGHT_NOT_AC,FLIGHT_MC,FLIGHT_OC,FLIGHT_VC,FLIGHT_SEGMENT,COUNTRY_FROM,COUNTRY_TO,COUNTRY_INSIDE,COUNTRY_OUTSIDE,TARIFF,PRIORITY,DETAILS,IS_CONTRACT_TYPE,NAME,NLS_NAME,IS_VALUE) values (to_date('07.04.2015 10:14:43','DD.MM.YYYY HH24:MI:SS'),'NTG','A',24,'FARE_BASIS_CODE_CONTAINS_ANY',null,null,null,null,null,null,null,null,null,null,null,null,5,'Код тарифа содержится хотя бы на одном сегменте','N','FARE_BASIS_CODE_CONTAINS_ANY','код тарифа содержится везде','Y');
Insert into ORD.COMMISSION_TEMPLATE (AMND_DATE,AMND_USER,AMND_STATE,AMND_PREV,TEMPLATE_TYPE,CLASS,FLIGHT_AC,FLIGHT_NOT_AC,FLIGHT_MC,FLIGHT_OC,FLIGHT_VC,FLIGHT_SEGMENT,COUNTRY_FROM,COUNTRY_TO,COUNTRY_INSIDE,COUNTRY_OUTSIDE,TARIFF,PRIORITY,DETAILS,IS_CONTRACT_TYPE,NAME,NLS_NAME,IS_VALUE) values (to_date('07.04.2015 12:51:56','DD.MM.YYYY HH24:MI:SS'),'NTG','A',25,'BOOKING_CODE_ANY',null,null,null,null,null,null,null,null,null,null,null,null,6,'Код бронирования хотя бы у одного сегмента','N','BOOKING_CODE_ANY','код брони хотя бы 1 сегмента','Y');
Insert into ORD.COMMISSION_TEMPLATE (AMND_DATE,AMND_USER,AMND_STATE,AMND_PREV,TEMPLATE_TYPE,CLASS,FLIGHT_AC,FLIGHT_NOT_AC,FLIGHT_MC,FLIGHT_OC,FLIGHT_VC,FLIGHT_SEGMENT,COUNTRY_FROM,COUNTRY_TO,COUNTRY_INSIDE,COUNTRY_OUTSIDE,TARIFF,PRIORITY,DETAILS,IS_CONTRACT_TYPE,NAME,NLS_NAME,IS_VALUE) values (to_date('07.04.2015 12:55:25','DD.MM.YYYY HH24:MI:SS'),'NTG','A',26,'BOOKING_CODE_ALL',null,null,null,null,null,null,null,null,null,null,null,null,null,'Код бронирования всех сегментов','N','BOOKING_CODE_ALL','Код брони всех сегментов','Y');
Insert into ORD.COMMISSION_TEMPLATE (AMND_DATE,AMND_USER,AMND_STATE,AMND_PREV,TEMPLATE_TYPE,CLASS,FLIGHT_AC,FLIGHT_NOT_AC,FLIGHT_MC,FLIGHT_OC,FLIGHT_VC,FLIGHT_SEGMENT,COUNTRY_FROM,COUNTRY_TO,COUNTRY_INSIDE,COUNTRY_OUTSIDE,TARIFF,PRIORITY,DETAILS,IS_CONTRACT_TYPE,NAME,NLS_NAME,IS_VALUE) values (to_date('07.04.2015 12:58:10','DD.MM.YYYY HH24:MI:SS'),'NTG','A',27,'BOOKING_CODE_NOT',null,null,null,null,null,null,null,null,null,null,null,null,null,'Код бронирования исключение','N','BOOKING_CODE_NOT','Код брони исключен','Y');
Insert into ORD.COMMISSION_TEMPLATE (AMND_DATE,AMND_USER,AMND_STATE,AMND_PREV,TEMPLATE_TYPE,CLASS,FLIGHT_AC,FLIGHT_NOT_AC,FLIGHT_MC,FLIGHT_OC,FLIGHT_VC,FLIGHT_SEGMENT,COUNTRY_FROM,COUNTRY_TO,COUNTRY_INSIDE,COUNTRY_OUTSIDE,TARIFF,PRIORITY,DETAILS,IS_CONTRACT_TYPE,NAME,NLS_NAME,IS_VALUE) values (to_date('08.04.2015 07:32:43','DD.MM.YYYY HH24:MI:SS'),'NTG','A',28,'CLASS_OF_SERVICE_ANY',null,null,null,null,null,null,null,null,null,null,null,null,null,'класс обслуживания хотя бы у одного сегмента','N','CLASS_OF_SERVICE_ANY','класс сервиса хотя бы у 1 сегмента','Y');
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

drop package ntg.fwdr;
drop package ntg.ntg_api;

drop view ntg.v_geo_suggest;
drop view ntg.v_geo;


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


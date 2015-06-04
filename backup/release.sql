alter table BLNG.CLIENT rename to USR;
alter table BLNG.CLIENT_DATA rename to USR_DATA;
alter table BLNG.CLIENT2CONTRACT rename to USR2CONTRACT;

ALTER TABLE BLNG.USR_DATA RENAME COLUMN CLIENT_OID TO USER_OID;
ALTER TABLE BLNG.USR2CONTRACT RENAME COLUMN CLIENT_OID TO USER_OID;

ALTER TABLE ord.ord RENAME COLUMN CLIENT_OID TO USER_OID;
ALTER TABLE hdbk.note RENAME COLUMN CLIENT_OID TO USER_OID;


alter table BLNG.company rename to client;
ALTER TABLE BLNG.USR RENAME COLUMN company_OID TO CLIENT_OID;
ALTER TABLE BLNG.contract RENAME COLUMN company_OID TO CLIENT_OID;


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
--@data/pkg/erp.erp_api.sql;
--@data/pkg/erp.gate.sql;
--@metadata/get_ddl.sql;




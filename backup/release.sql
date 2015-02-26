drop package ntg.geo_test;
drop package ntg.markup_api;
drop package ntg.geo_api;
drop package ntg.dp;
drop package blng.info;
drop procedure ntg.test;
drop function ntg.hello;
drop type ntg.iata_o;
drop type ntg.dnames_tab;
drop type ntg.dnames_tab1;
drop user EXP CASCADE;
--drop view ntg.v_markup;


update markup set client = null;
commit;
ALTER TABLE MARKUP RENAME COLUMN CLIENT TO CONTRACT_OID;

ALTER TABLE MARKUP  
MODIFY (CONTRACT_OID NUMBER(18) );

update blng.client set utc_offset = 3;
update blng.contract set utc_offset = 3;
update blng.company set utc_offset = 3;
commit;

/*
ALTER TABLE ntg.MARKUP RENAME COLUMN CLIENT TO CONTRACT_OID;
alter table markup drop column contract_oid;

alter table markup drop column CLIENT;
alter table markup add contract_oid number(18,0);
update markup set contract_oid = null;
commit;
*/

@metadata/view.sql;
@data/pkg/blng.blng_api.sql;
@data/pkg/blng.core.sql;
@data/pkg/blng.fwdr.sql;
--@data/pkg/blng.info.sql;
@data/pkg/ntg.ntg_api.sql;
@data/pkg/ntg.fwdr.sql;
--@data/pkg/ntg.markup_api.sql;
--@data/pkg/ntg.geo_api.sql;
@data/pkg/ntg.log_api.sql;
@data/pkg/ntg.dtype.sql;
@data/pkg/ord.ord_api.sql;
@data/pkg/ord.core.sql;
@data/pkg/ord.fwdr.sql;


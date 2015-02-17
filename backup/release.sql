alter table blng.client_data add phone varchar2(255);
alter table  blng.contract add utc_offset number;
alter table blng.client add phone varchar2(255);
alter table  blng.client add utc_offset number;
alter table  blng.company add utc_offset number;

@metadata/view.sql;
@data/pkg/blng.blng_api.sql;
@data/pkg/blng.fwdr.sql;
@data/pkg/blng.info.sql;
@data/pkg/ntg.ntg_api.sql;
@data/pkg/ord.fwdr.sql;


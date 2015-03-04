

ALTER TABLE ORD.ITEM_AVIA RENAME COLUMN PNR_ID TO PNR_LOCATOR;
ALTER TABLE ORD.ITEM_AVIA RENAME COLUMN NQT_ID TO PNR_ID;

/*
ALTER TABLE ORD.ITEM_AVIA add pnr_id_temp varchar2(50);
update ORD.ITEM_AVIA set pnr_id_temp = nqt_id;
commit;

ALTER TABLE ORD.ITEM_AVIA drop column nqt_id;
ALTER TABLE ORD.ITEM_AVIA RENAME COLUMN pnr_id_temp TO PNR_ID;

*/

@metadata/view.sql;
@data/pkg/blng.blng_api.sql;
@data/pkg/blng.core.sql;
@data/pkg/blng.fwdr.sql;
@data/pkg/ntg.ntg_api.sql;
@data/pkg/ntg.fwdr.sql;
@data/pkg/ntg.log_api.sql;
@data/pkg/ntg.dtype.sql;
@data/pkg/ord.ord_api.sql;
@data/pkg/ord.core.sql;
@data/pkg/ord.fwdr.sql;


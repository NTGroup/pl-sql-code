
--drop view ntg.v_markup


ALTER TABLE ORD.ticket RENAME COLUMN PNR_OID TO item_avia_oid;

ALTER TABLE ORD.ticket add pnr_locator varchar2(10);
ALTER TABLE ORD.ticket add ticket_number varchar2(50);
ALTER TABLE ORD.ticket add passenger_name varchar2(255);
ALTER TABLE ORD.ticket add passenger_type varchar2(10);
ALTER TABLE ORD.ticket add fare_amount number(20,2);
ALTER TABLE ORD.ticket add taxes_amount number(20,2);
ALTER TABLE ORD.ticket add service_fee_amount number(20,2);

ALTER TABLE ord.ticket drop CONSTRAINT tkt_pnr_OID_FK;

 ALTER TABLE ord.ticket ADD CONSTRAINT tkt_iav_OID_FK FOREIGN KEY (item_avia_oid)
  REFERENCES ord.item_avia ("ID") ENABLE;
  
CREATE bitmap INDEX ord.tkt_AS_IDX ON ord.ticket (amnd_state) TABLESPACE "USERS" ;


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


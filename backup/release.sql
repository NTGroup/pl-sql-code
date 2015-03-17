
ALTER TABLE blng.domain drop CONSTRAINT DMN_CMP_OID_FK;

ALTER TABLE BLNG.DOMAIN RENAME COLUMN company_oid TO contract_oid;

update BLNG.DOMAIN set contract_oid = (select id from blng.contract where amnd_state = 'A' and company_oid = DOMAIN.contract_oid);
commit;

ALTER TABLE blng.domain add CONSTRAINT DMN_cntr_OID_FK FOREIGN KEY (contract_oid)
REFERENCES blng.contract ("ID") ENABLE;




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



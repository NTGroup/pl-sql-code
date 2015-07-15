
alter table blng.delay add doc_oid number(18,0) ;

ALTER TABLE BLNG.delay ADD CONSTRAINT DLY_DOC_OID_FK FOREIGN KEY (DOC_oid)
  REFERENCES BLNG.DOCUMENT (ID) ENABLE;

update  blng.delay set doc_oid = (select doc_oid from blng.transaction where id = delay.transaction_oid);
commit;

insert into hdbk.dictionary (code, name, info, dictionary_type) values('BILL_DEPOSIT','BILL_DEPOSIT','deposit bill for client','TASK');
insert into hdbk.dictionary (code, name, info, dictionary_type) values('DEPOSIT','0','1c product and vat value','1C_PRODUCT_W_VAT');

commit;


alter TABLE blng.delay DROP COLUMN transaction_oid;

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
-- @metadata/get_ddl.sql;
-- @metadata/get_ddl_md.sql;
@metadata/get_ddl_table.sql;







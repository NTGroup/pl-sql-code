
insert into hdbk.dictionary (code, name, info, dictionary_type) values('1C_FIN_ACTS','1C_FIN_ACTS','fin doc ACTS from 1C','TASK');
--insert into hdbk.dictionary (code, name, info, dictionary_type) values('1C_FIN_INVOICE','1C_FIN_INVOICE','fin doc INVOICE from 1C','TASK');
insert into hdbk.dictionary (code, name, info, dictionary_type) values('AVIA_ETICKET','AVIA_ETICKET','avia eticket for client','TASK');
commit;

alter table  ord.task1c add request clob;



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
--@metadata/get_ddl.sql;







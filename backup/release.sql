insert into hdbk.dictionary (code,name,info,dictionary_type)
                    values  ('HOLYDAY','HOLYDAY','Выходной День, праздник','CALENDAR');
insert into hdbk.dictionary (code,name,info,dictionary_type)
                    values  ('WORKDAY','WORKDAY','Рабочий день','CALENDAR');
insert into hdbk.dictionary (code,name,info,dictionary_type)
                    values  ('PAYDAY','PAYDAY','День оплаты. С клиента в этот день будет запрошена оплата независимо от обстоятельств.','CALENDAR');
commit;


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


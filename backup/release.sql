
insert into hdbk.dictionary (code, name, info, dictionary_type) values('1C_FIN_ACTS','1C_FIN_ACTS','fin doc ACTS from 1C','TASK');
--insert into hdbk.dictionary (code, name, info, dictionary_type) values('1C_FIN_INVOICE','1C_FIN_INVOICE','fin doc INVOICE from 1C','TASK');
insert into hdbk.dictionary (code, name, info, dictionary_type) values('AVIA_ETICKET','AVIA_ETICKET','avia eticket for client','TASK');
commit;

alter table  ord.task1c add request clob;

alter table  ORD.ITINERARY add validating_carrier number(18);
alter table  ORD.segment add marketing_carrier number(18);
alter table  ORD.segment add operating_carrier number(18);

/*
                  json_table  
                    ( p_itinerary,'$[*]' 
                    columns (
                              validating_carrier VARCHAR2(250) path '$.validating_carrier',
                              leg_num number(18,0) path '$.leg_num',
                              leg_departure_iata VARCHAR2(250) path '$.departure_location',
                              leg_departure_date VARCHAR2(250) path '$.departure_datetime',
                              leg_arrival_iata VARCHAR2(250) path '$.arrival_location',
                              leg_arrival_date VARCHAR2(250) path '$.arrival_datetime',
                              NESTED PATH '$.segments[*]' COLUMNS (
                                segment_num number(20,2) path '$.segment_num',
                                segment_marketing_carrier VARCHAR2(250) path '$.marketing_carrier',
                                segment_operating_carrier VARCHAR2(250) path '$.operating_carrier',
                                segment_departure_iata VARCHAR2(250) path '$.departure_location',
                                segment_departure_date VARCHAR2(250) path '$.departure_datetime',
                                segment_arrival_iata VARCHAR2(250) path '$.arrival_location',
                                segment_arrival_date VARCHAR2(250) path '$.arrival_datetime'
                                )
                              )
                    ) as j
*/




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







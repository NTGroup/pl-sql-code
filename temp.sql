
select * from dba_objects
where /*object_name like '%DOCUMENT%'
and*/ owner = 'BLNG'



 
SELECT sysdate FROM DUAL;


ALTER session SET NLS_DATE_FORMAT='DD.MM.YYYY HH24:MI:SS' SCOPE=SPFILE;

NLS_NUMERIC_CHARACTERS 


commit
select * from v$parameter where name = 'nls_date_format';
select * from nls_database_parameters
select * from nls_session_parameters
select * from nls_instance_parameters




NLS_LANGUAGE	RUSSIAN
NLS_TERRITORY	RUSSIA
NLS_CURRENCY	р.
NLS_ISO_CURRENCY	RUSSIA
NLS_NUMERIC_CHARACTERS	, 
NLS_CALENDAR	GREGORIAN
NLS_DATE_FORMAT	DD.MM.YYYY HH24:MI:SS
NLS_DATE_LANGUAGE	RUSSIAN
NLS_SORT	RUSSIAN
NLS_TIME_FORMAT	HH24:MI:SSXFF
NLS_TIMESTAMP_FORMAT	DD.MM.YYYY HH24:MI:SS
NLS_TIME_TZ_FORMAT	HH24:MI:SSXFF TZR
NLS_TIMESTAMP_TZ_FORMAT	DD.MM.YYYY HH24:MI:SS TZR
NLS_DUAL_CURRENCY	р.
NLS_COMP	BINARY
NLS_LENGTH_SEMANTICS	BYTE
NLS_NCHAR_CONV_EXCP	FALSE



create table temp_d (
id number,
d date
);
insert into temp_d

select 1, sysdate from dual

;
commit;


select * from temp_d
select * from dual

select * from nls_session_parameters
where parameter in ('NLS_DATE_FORMAT','NLS_DATE_LANGUAGE'); 


select * from blng.event




select 
d.parameter, d.value "database",i.value "instance", s.value "session"
from nls_database_parameters d,
nls_session_parameters s,
nls_instance_parameters i
where s.parameter(+)=d.parameter
and i.parameter(+)=d.parameter


update markup set client = 'default', gds = 'Sabre', pos = 'CJ8H';
commit;


select * from DBA_TAB_STATS_HISTORY
where owner = 'NTG'


SELECT * FROM markup
    AS OF TIMESTAMP 
    
    (SYSTIMESTAMP - INTERVAL '1' MINUTE);
    
    
    SELECT * 
    --NAME, VALUE/60 MINUTES_RETAINED
FROM   V$PARAMETER WHERE  NAME = 'undo_retention';
SELECT NAME, SCN, TIME FROM V$RESTORE_POINT;


SELECT CURRENT_SCN FROM V$DATABASE;


SELECT * FROM RECYCLEBIN;


SELECT * -- xid, operation, start_scn, commit_scn, logon_user, undo_sql
FROM flashback_transaction_query




select a.ID, a.validating_carrier new_sal, b.validating_carrier old_sal
      from markup a, markup as of SCN &SCN b
    where a.ID = b.ID
    AND A.ID = 5


select b.*,
versions_xid XID, versions_startscn START_SCN,
  versions_endscn END_SCN, versions_operation OPERATION
from  markup 
VERSIONS BETWEEN SCN  minvalue and maxvalue b
where ID = 5


select a.ID, a.validating_carrier new_sal, b.validating_carrier old_sal
      from (
      select 
      ) a, markup as of SCN &SCN b
    where a.ID = b.ID
    AND A.ID = 5
    
    
    

select thread, scn_bas, to_char(time_dp, 'yyyy-mm-dd hh24:mi:ss') from sys.smon_scn_time order 
by time_dp DESC;

select *
      from markup  VERSIONS BETWEEN SCN minvalue AND maxvalue
     where ID = 5
   
   

     


SELECT * FROM markup AS OF TIMESTAMP 
   TO_TIMESTAMP('2014-10-01 01:00:00', 'YYYY-MM-DD HH:MI:SS')
   WHERE id = 5;
   
SELECT * FROM markup AS OF TIMESTAMP 
   to_date()
   WHERE id = 5;
   
   
   
   
   
   
   SELECT * FROM t 
   VERSIONS BETWEEN TIMESTAMP  TO_TIMESTAMP('2014-10-01 16:00:00', 'YYYY-MM-DD HH24:MI:SS') 
   and TO_TIMESTAMP('2014-10-02 18:00:00', 'YYYY-MM-DD HH24:MI:SS') 
   WHERE id = 5;
   
   
   SELECT xid, start_scn, commit_scn, operation, table_name, table_owner
FROM flashback_transaction_query
where table_owner = 'NTG'


select thread, scn_bas, to_char(time_dp, 'yyyy-mm-dd hh24:mi:ss') from sys.smon_scn_time order 
by time_dp;


 select * from markup as of timestamp(sysdate - interval '380' minute);
 create view v_scn as select * from markup as of scn &SCN
 



  select *
    from markup versions between timestamp
     systimestamp - interval '30' minute and systimestamp
     where id = 5
     
     
     SELECT CURRENT_SCN FROM V$DATABASE;
     
     SELECT NAME, SCN, TIME FROM V$RESTORE_POINT;

     
     SELECT * --NAME, VALUE/60 MINUTES_RETAINED
FROM   V$PARAMETER
WHERE  NAME = 'undo_retention';

SELECT other.owner, other.table_name
FROM   sys.all_constraints this, sys.all_constraints other
WHERE  this.owner = 'NTG'
--AND    this.table_name = 'T'
AND    this.r_owner = other.owner
AND    this.r_constraint_name = other.constraint_name
--AND    this.constraint_type='R';


ALTER PLUGGABLE DATABASE ALL OPEN;


SELECT * 
FROM   V$FLASHBACK_DATABASE_LOG;

select * from 
FLASHBACK_TRANSACTION_TABLE 



select b.*,
versions_xid XID, versions_startscn START_SCN,
  versions_endscn END_SCN, versions_operation OPERATION
from  t 
VERSIONS BETWEEN SCN  minvalue and maxvalue b


select --b.*,
versions_xid XID, versions_startscn START_SCN,
  versions_endscn END_SCN, versions_operation OPERATION
from  markup
VERSIONS BETWEEN SCN  minvalue and maxvalue b


select maxvalue from scn

2	goe	07000300A9100000	5417446		U
2	go	0A000200BC160000	5417205	5417446	I
1	hello	05001300D5130000	5417197		I

2	god	02001800CB100000	5418826		U
1	hell	02001800CB100000	5418826		U
2	goe	07000300A9100000	5417446	5418826	U
1	hello			5418826	
2	go			5417446	

select * from USER_TAB_STATS_HISTORY 

select * from "BIN$BFfHyZ4PUB/gVQAAAAAAAg==$0"


select '    audit_pkg.check_val( ''&1'', ''' || column_name ||
          ''', ' || ':new.' || column_name || ', :old.' || 
             column_name || ');'
from user_tab_columns where table_name = upper('&1')






CREATE USER wsmgmt IDENTIFIED BY wsmgmt;
GRANT dba to wsmgmt;
grant execute on dbms_lock to wsmgmt;


begin
            DBMS_WM.GrantSystemPriv
        ('ACCESS_ANY_WORKSPACE, MERGE_ANY_WORKSPACE, ' ||
         'CREATE_ANY_WORKSPACE, REMOVE_ANY_WORKSPACE, ' ||
   'ROLLBACK_ANY_WORKSPACE', 'WSMGMT', 'YES');
    end;
    
    
    
    create table t as  select * from ntg.t
     alter table t add constraint t_pk primary key(id);
     alter table t add constraint t_fk_t foreign key(mgr) references 
t(id);


begin
           DBMS_WM.EnableVersioning ('t',  'VIEW_WO_OVERWRITE');
    end;
    
    
    
    update wsmgmt.t set name = name ||'q';
    commit;
    
    select E.* from T_hist e
    
    select -- ename, sal, comm, workspace, type_of_change,
           to_char(wm_createtime,'dd-mon hh24:mi:ss') created,
           to_char(wm_retiretime,'dd-mon hh24:mi:ss') retired
      from t_hist

    
    select * from wsmgmt.t_
    
    select * --rpad('*',level*2,'*') || ename
      from t

    select * from wsmgmt.t


    exec dbms_wm.gotoDate( sysdate - 1/24);
    
    
    exec dbms_wm.gotoDate( to_date( '02-окт-2014 08:31:44', 'dd-mon-yyyy hh24:mi:ss'));
    exec dbms_wm.gotoDate( sysdate);
    dbms_wm.
    
    insert into wsmgmt.t select 3 , 'nono' from dual;
    
    
    create table   addresses
   ( empno       number,
     addr_data   varchar2(30),
     start_date  date,
     end_date    date,
     period for valid(start_date,end_date)
   )
   
   
   
   select * from addresses
   
   insert into addresses (empno, addr_data, start_date, end_date )
   values ( 1234, '123 Main Street', trunc(sysdate-5), trunc(sysdate-2) );
   insert into addresses (empno, addr_data, start_date, end_date )
  values ( 1234, '456 Fleet Street', trunc(sysdate-1), trunc(sysdate+1) );
insert into addresses (empno, addr_data, start_date, end_date )
   values ( 1234, '789 1st Ave', trunc(sysdate+2), null );
   
   select /* for update */ * from addresses;
   
   select * from addresses as of period for valid sysdate;
commit;


desc addresses



create or replace function addRow(markup%rowtype) return number
is 
id number;
begin
--insert into table1 (description) values (desc) returning table1ID
--into id;
--return(id);
return 0;
--exception
--when others then return(-1)
end;




declare
type GEO_tapi_rec
IS
  record
  (
    ID GEO.ID%type ,
    PARENT_ID GEO.PARENT_ID%type ,
    NAME GEO.NAME%type ,
    NLS_NAME GEO.NLS_NAME%type ,
    IATA GEO.IATA%type ,
    CODE GEO.CODE%type ,
    OBJECT_TYPE GEO.OBJECT_TYPE%type ,
    COUNTRY_ID GEO.COUNTRY_ID%type ,
    CITY_ID GEO.CITY_ID%type ,
    IS_ACTIVE GEO.IS_ACTIVE%type ,
    NEW_PARENT_ID GEO.NEW_PARENT_ID%type ,
    UTC_OFFSET GEO.UTC_OFFSET%type); 

begin

select * into GEO_tapi_rec  from geo where id=5;
dbms_output.put_line(GEO_tapi_rec.name);
  
end;


 ALTER USER ord ACCOUNT LOCK;

select * from gba_users


           select * from blng.delay d
           where transaction_oid = 272
           order by contract_oid asc, date_to asc, id asc
           
        
        begin
        blng.core.credit_online;
        end;
        
                  select * from blng.delay d
           where amnd_prev = (
             select amnd_prev from blng.delay d
             where transaction_oid = 310)
           order by contract_oid asc, date_to asc, id asc



http://www.youtube.com/watch?v=4xD0SRXtXDI





      SELECT
      g.iata,
      trim(g.name) name,
      trim(g.nls_name) nls_name,
      case
      when parents.object_type in ('region','country') then g.iata
      else parents.iata
      end city_iata,
      case
      when parents.object_type in ('region','country') then trim(g.name)
      else trim(parents.name)
      end city_name,
      case
      when parents.object_type in ('region','country') then trim(g.nls_name)
      else trim(parents.nls_name)
      end city_nls_name
      FROM GEO g, geo parents --, table(v_iata_tab) iata_list
      WHERE g.IS_ACTIVE IN ('Y')
      and g.iata is not null
      and g.iata not like '%@%'
      and g.object_type in ('airport real')
      and parents.IS_ACTIVE(+) IN ('Y')
      and g.parent_id = parents.id(+)








select * from geo where name = 'Nottingham'
select 

update geo set iata = 'NQT', NLS_NAME='Ноттингем' where id = 1335; commit;

select distinct object_type from geo


airport
airport real
city
country
city-airport
region

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
select * from 
geo g where g.IS_ACTIVE IN ('Y')
      and g.iata is not null
      and g.iata not like '%@%'
      and g.object_type in ('airport real')
and parent_id in (
select id from 
geo g where object_type = 'country'
and g.IS_ACTIVE IN ('Y')
)
--and iata = 'KGF'
and code = 'RU'

select * from geo where id = 153

select * from 
wwaas

select * from geo where UPPER(name) like '%GELEND%'

select * from geo where UPPER(name) like '%NORFOLK%'

select * from geo where id = 127

select * from geo where name = 'Russia'

127
390 a


select * from geo where parent_id = 390
and object_type = 'region'




     select 
      id,
      iata,
      name,
      nls_name/*,
      airline.**/
      from airline
      where iata is not null
      and regexp_like(name, '^([А-я]|[0-9]|[A-z])') 
      order by nls_name desc;






select 
g.*,
a.*
from geo g, exp.airport a
WHERE g.IS_ACTIVE IN ('Y')
and g.iata is not null
and g.iata not like '%@%'
and g.object_type in ('airport real')
and a.airportcode=g.iata
AND g.iata = 'HAN'



select * from exp.city where regionid=6054458

select * from exp.city where regionid=6054458

6000277
6054458


select * from exp.airport where maincityid = 6054458

select * from exp.parentregion
where regionid in(6054458,6000277,1428)




select * from exp.city where regionid=6054458

select * from exp.city where regionid=6054458

6000277
6054458



select * from exp.airport where airportcode='MOW'



select  
iata,
name,
nvl(nls_name,name) NLS_NAME,
nvl(city_iata,iata) city_iata,
city_name,
nvl(city_nls_name,city_name) city_nls_name
from (
      SELECT
      g.iata,
      trim(g.name) name,
      trim(g.nls_name) nls_name,
      case
      when parents.object_type in ('region','country') then g.iata
      when parents.object_type is null then g.iata
      else parents.iata
      end city_iata,
      case
      when parents.object_type in ('region','country') then trim(g.name)
      when parents.object_type is null then trim(g.name)
      else trim(parents.name)
      end city_name,
      case
      when parents.object_type in ('region','country') then trim(g.nls_name)
      when parents.object_type is null then trim(g.nls_name)
      else trim(parents.nls_name)
      end city_nls_name
      FROM GEO g, geo parents --, table(v_iata_tab) iata_list
      WHERE g.IS_ACTIVE IN ('Y')
      and g.iata is not null
      and g.iata not like '%@%'
      and g.object_type in ('airport real')
      and parents.IS_ACTIVE(+) IN ('Y')
      and g.parent_id = parents.id(+)
--      and g.iata = 'OHH'
      order by 1
)



select * from 
      
      
      
EIK	Eisk	Ейск			
SLY	Salekhard	Салехард			
KMW	Sokerkino	Сокеркино			
OVS	Sovetskiy	Советский			
ODO	Bodaybo	Бодайбо			
TQL	Tarko-Sale	Тарко-Сале			
ULK	Lensk	Ленск			
KKQ	Krasnoselkup	Красноселькуп			
RGK	Gorno-Altajsk	Горно-Алтайск			
IRM	Igrim	Игрим			
EZV	Berezovo	Березово			
OHH	Oha	Оха			
IGT	Magas	Магас			
LDG	Leshukonskoye	Лешуконское			
THX	Turukhansk	Туруханск			
EYK	Beloyarskiy	Белоярский			
NVI	Navoi	Навои			
NGK	Nogliki	Ноглики			
AFS	Zarafshan	Зерафшан			

select * from geo where 
iata = 'OHH'

select * from geo where id = 12696

select * from geo where id = 762

select count(*) from geo where is_active = 'W'


select * from geo where 
iata = 'BLA'

select * from geo where id = 13138

select * from geo where id = 762

select count(*) from geo where is_active = 'W'


--update geo set iata = 'BCN' where id = 13138; commit;

select * from ord.item_avia order by id desc

select * from ord.item_avia where amnd_state = 'A' order by id desc

select * from ord.bill where amnd_state = 'A' order by id desc

select * from ord.ord order by id desc

select * from log order by id desc

select * from blng.document where amnd_state = 'A' order by id desc



create or replace view ord.v_commission as
select /* TEXT */
al.id al_oid,
al.name,
al.IATA,
cmn.id cmn_oid,
cmn.details,
ct.template_type,
--ct.constant,
ct.class,
ct.flight_oc,
flight_segment,
cmn.priority,
cmn.fix,
cmn.percent
from 
ord.commission cmn,
ord.commission_template ct,
ord.commission_details cd,
ntg.airline al
where 
al.amnd_state = 'A'
and cmn.amnd_state = 'A'
and cd.amnd_state = 'A'
and ct.amnd_state = 'A'
and cmn.id= cd.commission_oid
and ct.id = cd.commission_template_oid
and cmn.avia_company = ct.avia_company
and cmn.avia_company = al.id
order by cmn.priority desc, class asc



China Southern Airlines	CZ	константа 3%	constant	
China Southern Airlines	CZ	класс A/B/Y/C 2%	class	A
China Southern Airlines	CZ	класс A/B/Y/C 2%	class	B
China Southern Airlines	CZ	класс A/B/Y/C 2%	class	Y
China Southern Airlines	CZ	класс A/B/Y/C 2%	class	C
China Southern Airlines	CZ	класс Z/X/V 5%	class	X
China Southern Airlines	CZ	класс Z/X/V 5%	class	Z
China Southern Airlines	CZ	класс Z/X/V 5%	class	V


SELECT * FROM
() JSON,
() COM
WHERE
JSON.VC = COM.VC


SELECT * FROM
ord.v_commission COM
WHERE
JSON.CLASS = 'A'
or
JSON.CLASS = 'B'
or
JSON.CLASS = 'Y'
or
JSON.CLASS = 'C'



grant select on ntg.airline to ord





declare
  p_iata varchar2(255):= 'CZ';
  v_start varchar2(255):= 'select * from xxx where ';
  v_out varchar2(4000):= '';
  v_and varchar2(5):= '';
  v_or varchar2(5):= '';
  v_crlf  varchar2(5):=|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack
  
  ;
  v_value number :=null; 
begin
  for rule in (
    select distinct  cmn_oid from ord.v_commission where iata = p_iata order by cmn_oid desc
  )
  loop
    dbms_output.put_line(rule.cmn_oid);

    --- select renew. in this circle select begin forming
    v_out:=v_start;
    v_and := ''; 
    for template_type in (
      select distinct template_type from ord.v_commission where cmn_oid = rule.cmn_oid
    )
    loop
      dbms_output.put_line(template_type.template_type);
      v_out:=v_out||v_and||' ( '||v_crlf;
      v_or := ''; 
    
      for i in (
        select * from ord.v_commission where cmn_oid = rule.cmn_oid and template_type = template_type.template_type
      )
      loop
        dbms_output.put_line(i.class);

        v_out:=v_out||v_or||' ( '||v_crlf;
   --     dbms_output.put_line(rule.details||i.template_type||i.class);

        if i.template_type='constant' then 
          dbms_output.put_line('test');    
          v_value:=i.percent; 
--          exit; 
--          exit; 
        end if;

        if i.template_type='class' then 
--          dbms_output.put_line('test');    
     --     v_value:=i.percent; 
          null;
--          exit; 
        end if;
        
        v_out:=v_out||' ) '||v_crlf;
        v_or := ' OR '; 
        if v_value is not null then exit; end if;
        dbms_output.put_line('exit1');            
      end loop;
      v_out:=v_out||' ) '||v_crlf;
      v_and := ' AND '; 
      if v_value is not null then exit; end if;
      dbms_output.put_line('exit2');            
    end loop;
      dbms_output.put_line(v_out);    
    if v_value is not null then exit; end if;
    dbms_output.put_line('exit3');            
  end loop; 
end;





select 
pnr_object
from ord.item_avia
where id = 123
order by id desc








create or replace view ord.v_json as

SELECT 
ia.id,
jt.*
FROM ord.item_avia ia,
json_table(pnr_object, '$'
  COLUMNS (
    book_id VARCHAR2(250) PATH '$.id',
    row_number FOR ORDINALITY,
    paxType VARCHAR2(250) PATH '$.passengersQueried[0].paxType',
    quantity VARCHAR2(250) PATH '$.passengersQueried[0].quantity',
    seats VARCHAR2(250) PATH '$.passengersQueried[0].seats',
    
    
    NESTED PATH '$.airItinerary.legs[*]' COLUMNS (
      NESTED PATH '$.flightSegments[*]' COLUMNS (
        dep_location VARCHAR2(256 CHAR) PATH '$.departure.location',
        dep_dateTime VARCHAR2(256 CHAR) PATH '$.departure.dateTime',
        arr_location VARCHAR2(256 CHAR) PATH '$.arrival.location',
        arr_dateTime VARCHAR2(256 CHAR) PATH '$.arrival.dateTime',
        elapsedTime VARCHAR2(256 CHAR) PATH '$.elapsedTime',
        stop_location VARCHAR2(256 CHAR) PATH '$.stops[0].location',
        arrivalDateTime VARCHAR2(256 CHAR) PATH '$.stops[0].timing.arrivalDateTime',
        departureDateTime VARCHAR2(256 CHAR) PATH '$.stops[0].timing.departureDateTime',
        stops_timing_elapsedTime VARCHAR2(256 CHAR) PATH '$.stops[0].timing.elapsedTime',
        o_flightNumber VARCHAR2(256 CHAR) PATH '$.operating.flightNumber',
        o_airline VARCHAR2(256 CHAR) PATH '$.operating.airline',
        m_flightNumber VARCHAR2(256 CHAR) PATH '$.marketing.flightNumber',
        m_airline VARCHAR2(256 CHAR) PATH '$.marketing.airline',
        planeType VARCHAR2(256 CHAR) PATH '$.planeType',
        marriageGroup VARCHAR2(256 CHAR) PATH '$.marriageGroup',
        bookingCode VARCHAR2(256 CHAR) PATH '$.bookingCode',
        fs_timeWasChanged VARCHAR2(256 CHAR) PATH '$.timeWasChanged'
      ),
      flightTime VARCHAR2(256 CHAR) PATH '$.flightTime'
    ),
    totalOfFlightSegments number(3) PATH '$.airItinerary.totalOfFlightSegments',
    pi_tf_fareAmount number(20,2) PATH '$.pricingInfo.totalFareBreakdown.fareAmount',
    pi_tf_taxesAmount number(20,2) PATH '$.pricingInfo.totalFareBreakdown.taxesAmount',
    pi_tf_totalAmount number(20,2) PATH '$.pricingInfo.totalFareBreakdown.totalAmount',

    pi_ptcf_pk_paxType VARCHAR2(100) PATH '$.pricingInfo.ptcFareBreakdowns[0].paxKit.paxType',
    pi_ptcf_pk_quantity number(18) PATH '$.pricingInfo.ptcFareBreakdowns[0].paxKit.quantity',
    pi_ptcf_pk_seats number(18) PATH '$.pricingInfo.ptcFareBreakdowns[0].paxKit.seats',
    pi_ptcf_bd_fareAmount number(20,2) PATH '$.pricingInfo.ptcFareBreakdowns[0].breakdown.fareAmount',
    pi_ptcf_bd_taxesAmount number(20,2) PATH '$.pricingInfo.ptcFareBreakdowns[0].breakdown.taxesAmount',
    pi_ptcf_bd_totalAmount number(20,2) PATH '$.pricingInfo.ptcFareBreakdowns[0].breakdown.totalAmount',

/*!!!*/    pi_ptcf_fareBasisCodes  VARCHAR2(100) FORMAT JSON  PATH '$.pricingInfo.ptcFareBreakdowns[0].fareBasisCodes',
    validatingCarrier VARCHAR2(100) PATH '$.pricingInfo.validatingCarrier',
    seemsToBeInvalid VARCHAR2(100) PATH '$.pricingInfo.seemsToBeInvalid',
    perSegment number(20,2) PATH '$.markupValue.perSegment',
    perPtcBreakdowns number(20,2) PATH '$.markupValue.perPtcBreakdowns[0]',

    totalAmount number(20,2) PATH '$.totalAmount',
    totalMarkup number(20,2) PATH '$.totalMarkup',
    pax_givenName varchar2(120) PATH '$.paxDetails.paxes[0].givenName',
    pax_surname varchar2(120) PATH '$.paxDetails.paxes[0].surname',
    pax_dateOfBirth varchar2(120) PATH '$.paxDetails.paxes[0].dateOfBirth',
    pax_paxType varchar2(120) PATH '$.paxDetails.paxes[0].paxType',
    phone varchar2(120) PATH '$.paxDetails.phone',
    email varchar2(120) PATH '$.paxDetails.email',
    systemTimeLimit VARCHAR2(250) PATH '$.systemTimeLimit',
    priceWasChanged VARCHAR2(250) PATH '$.priceWasChanged',
    timeWasChanged VARCHAR2(250) PATH '$.timeWasChanged',
    isFailed VARCHAR2(250) PATH '$.isFailed',
    pnrRecordLocator VARCHAR2(250) PATH '$.pnrRecordLocator'
    
  )
) AS "JT"
order by ia.id desc



select 
*
from ord.v_json
where id in (214)


select * from ord.item_avia order by id desc


select 
distinct
--id,
validatingcarrier --,
--bookingcode
from ord.v_json
where id =121



 select * from ord.v_commission

desc ord.v_json


                        
ALTER SESSION SET 
NLS_NUMERIC_CHARACTERS = '.,';


select * from 




declare
  c number;
begin
  ord.fwdr.commission_get('0a54d0088054433b8af000cfbf889d3e');
end;

select * from ord.v_json where id = 121

select * from 
v_



select
distinct id,
validatingcarrier,
ord.fwdr.commission_get(id)
from ord.v_json 
where id > 33
order by id desc



select validatingcarrier, count(*) from ord.v_json
where id >=11
group by validatingcarrier

  select * from ntg.airline where iata = 'CZ' and amnd_state= 'A';



declare
  avia_code varchar2(3):='S7';
  avia_id number;
  com number;
  tem1 number;

begin

  select id into avia_id from ntg.airline where iata = avia_code and amnd_state= 'A';

  insert into ord.commission ( airline, details, fix, percent,priority)
  values( avia_id, 'default 1р',1, null,0) returning id into com;

      insert into ord.commission_details( commission_oid, commission_template_oid,value )  
      values (com, 1,null);

  insert into ord.commission ( airline, details, fix, percent,priority)
  values( avia_id, 'interline default 2р',2, null, 10) returning id into com;

      insert into ord.commission_details( commission_oid, commission_template_oid,value  )  
      values (com, 18, null);
      insert into ord.commission_details( commission_oid, commission_template_oid,value  )  
      values (com, 1, null);

  insert into ord.commission ( airline, details, fix, percent,priority)
  values( avia_id, 'interline для классов E 5p%',5, null, 20) returning id into com;

      insert into ord.commission_details( commission_oid, commission_template_oid,value  )  
      values (com, 18, null);

      insert into ord.commission_details( commission_oid, commission_template_oid,value  )  
      values (com, 2,'E');

  insert into ord.commission ( airline, details, fix, percent,priority)
  values( avia_id, 'self default 2%',null, 2, 10) returning id into com;

      insert into ord.commission_details( commission_oid, commission_template_oid,value  )  
      values (com, 20, null);
      insert into ord.commission_details( commission_oid, commission_template_oid,value  )  
      values (com, 1, null);

  insert into ord.commission ( airline, details, fix, percent,priority)
  values( avia_id, 'self для классов Y 5%',null, 5, 20) returning id into com;

      insert into ord.commission_details( commission_oid, commission_template_oid,value  )  
      values (com, 20, null);

      insert into ord.commission_details( commission_oid, commission_template_oid,value  )  
      values (com, 2,'Y');

  insert into ord.commission ( airline, details, fix, percent,priority)
  values( avia_id, 'self для классов Z 6%',null, 6, 25) returning id into com;

      insert into ord.commission_details( commission_oid, commission_template_oid,value  )  
      values (com, 20, null);

      insert into ord.commission_details( commission_oid, commission_template_oid,value  )  
      values (com, 2,'Z');

commit;
end;





select * from ord.v_commission 
where  al_oid=415
order by priority

select * from ord.v_json where id = 121 and validatingcarrier = 'SN'

select * from ord.v_json where id = 121 and validatingcarrier = 'SN'

update ord.commission_details set commission_template_oid=2 where commission_template_oid in (
select id from ord.commission_template where template_type = 'class' --order by id desc
);
commit;



select * from ord.commission_template order by priority desc nulls last


select * from ord.v_commission where al_oid = 444 ;
/

declare
  v_id number;
  v_percent number;
  v_fix number;
  
begin
  for i in (
 select 
  
  distinct j.book_id nqt_id
  
  
  from ORD.v_json j
  where j.pnrrecordlocator is not null
  and j.validatingcarrier not in ('UN',
'S7',
'SU',
'HY',
'R2')
  and id >600
   and book_id in (
  'd494ad8469874e7da6aa629804c83b48','dfdbe320e8ad47f98c12f74460ea07d5','557a72da77fc4450851f23b2dbb01b6d','23500d51668347d786beb6d63f45ba09'
  
  )
  )
  loop
          dbms_output.put_line('='||i.nqt_id);      
    ord.fwdr.commission_get(i.nqt_id,v_fix,v_percent);
  end loop;
end;

/
select * from ord.item_avia where id = 121 order by id desc

292 - code-share
121 - interline
123 - vc=mc=oc
270 - JJ, interline, (class = E,W,P,Y)


select * from ord.v_json where id = 123 order by id desc

select * from ord.v_json where id > 121 and validatingcarrier = 'JJ' order by id desc 

select* from ord.v_commission where iata='JJ'
/*
update ord.commission set fix=null where 
avia_company = 1397;
commit;
*/


select * from ord.commission


airline=1397
commission_oid = 34


select * from log order by id desc



truncate table ntg.log;
truncate table blng.delay;
truncate table blng.event;
truncate table blng.client2contract;

--truncate table blng.company;
--truncate table blng.client;


delete from blng.transaction; commit;
delete from blng.document; commit;
delete from blng.account; commit;
delete from blng.client2contract; commit;
delete from blng.contract; commit;
delete from blng.client; commit;
delete from blng.company; commit;

truncate table blng.company;


truncate table blng.document;
truncate table blng.contract;
truncate table blng.account;
truncate table blng.transaction;
truncate table blng.company;


delete from ord.item_avia; commit;
delete from ord.ord; commit;
delete from ord.item_hotel; commit;
delete from ord.bill; commit;
delete from ord.ticket; commit;



SELECT dd.tablespace_name tablespace_name, dd.file_name file_name, dd.bytes/1024 TABLESPACE_KB, SUM(fs.bytes)/1024 KBYTES_FREE, MAX(fs.bytes)/1024 NEXT_FREE
FROM sys.dba_free_space fs, sys.dba_data_files dd
WHERE dd.tablespace_name = fs.tablespace_name
AND dd.file_id = fs.file_id
GROUP BY dd.tablespace_name, dd.file_name, dd.bytes/1024
ORDER BY dd.tablespace_name, dd.file_name;

select * from V$SYSAUX_OCCUPANTS

SELECT TABLESPACE_NAME "TABLESPACE",
   INITIAL_EXTENT "INITIAL_EXT",
   NEXT_EXTENT "NEXT_EXT",
   MIN_EXTENTS "MIN_EXT",
   MAX_EXTENTS "MAX_EXT",
   PCT_INCREASE
   FROM DBA_TABLESPACES;
   
   
   
SELECT p.PDB_ID, p.PDB_NAME, t.OWNER, t.TABLE_NAME 
  FROM DBA_PDBS p, CDB_TABLES t 
  WHERE p.PDB_ID > 2 AND
      --  t.OWNER IN('HR','OE') AND
        p.PDB_ID = t.CON_ID
        and owner='NTG'
  ORDER BY p.PDB_ID;
  
SELECT * FROM DBA_PDBS p

create tablespace dict datafile '/home/oracle/app/oracle/oradata/orcl/my_test/ORCL/0A57CA28ACDC7FB9E055000000000002/datafile/dict01.dbf' SIZE 25M;

/* by user with dba role (NTG) */
ALTER USER ntg quota unlimited on dict;
??? ALTER TABLESPACE dict READ WRITE;

alter table geo move tablespace dict;
alter index geo_ix modify default attribute tablespace dict;

select * from all_tables
where owner = 'NTG'

ALTER INDEX GEO_IX REBUILD 
TABLESPACE DICT;

alter pluggable database my_test close immediate; 
alter pluggable database my_test open read write; 
ALTER TABLESPACE dict OFFLINE NORMAL;



/* by user with dba role (NTG) */
create tablespace airline datafile '/home/oracle/app/oracle/oradata/orcl/my_test/ORCL/0A57CA28ACDC7FB9E055000000000002/datafile/airline01.dbf' SIZE 25M;
ALTER USER ntg quota unlimited on airline;
alter tablespace airline ONLINE;
alter table airline move tablespace airline;
ALTER INDEX al_id_idx REBUILD 
TABLESPACE airline;

select * from all_tables
where owner = 'NTG'


select * from log


create tablespace users datafile '/home/oracle/app/oracle/oradata/orcl/my_test1/ORCL/0A57CA28ACDC7FB9E055000000000002/datafile/users01.dbf' SIZE 25M;
ALTER USER ntg quota unlimited on users;


ALTER TABLESPACE users
    ADD DATAFILE '/home/oracle/app/oracle/oradata/orcl/my_test1/ORCL/0A5A4A353E62231EE055000000000002/datafile/o1_mf_users_b90mk9qw_.dbf' 
      
 ALTER TABLESPACE users online   
 
 ALTER DATABASE DATAFILE '/home/oracle/app/oracle/oradata/orcl/my_test1/ORCL/0A5A4A353E62231EE055000000000002/datafile/o1_mf_users_b90mk9qw_.dbf' ONLINE;
 
 
 ALTER TABLESPACE dict OFFLINE NORMAL;
 
 ALTER TABLESPACE dict ONLINE
 
 ALTER TABLESPACE users close;
 
 SELECT * from DBA_TEMP_FREE_SPACE;
 
 
alter pluggable database my_test1 close immediate;
 drop pluggable database my_test1 including datafiles;


ALTER TABLESPACE dict
   ADD DATAFILE '/home/oracle/app/oracle/oradata/orcl/my_test1/ORCL/0A5A4A353E64231EE055000000000002/datafile/dict02.dbf' SIZE 1M;
   
 ALTER TABLESPACE dict OFFLINE IMMEDIATE; 
 ALTER DATABASE DATAFILE '/home/oracle/app/oracle/oradata/orcl/my_test1/ORCL/0A5A4A353E64231EE055000000000002/datafile/o1_mf_dict_b910bydw_.dbf' offline;
 


 alter pluggable database salespdb close immediate;
 drop pluggable database salespdb including datafiles;
 
 
 
alter pluggable database my_test close immediate;  
alter pluggable database my_test open read only; 
alter system set db_create_file_dest='/home/oracle/app/oracle/oradata/orcl/my_test1';
CREATE PLUGGABLE DATABASE my_test1 FROM my_test 
NO DATA
NOLOGGING;
alter pluggable database my_test1 open read write; 




alter pluggable database my_test1 open read write;


alter pluggable database my_test1 close immediate;
ALTER PLUGGABLE DATABASE my_test1 UNPLUG INTO '/home/oracle/app/oracle/oradata/orcl/my_test1/my_test1.xml';

DECLARE
  l_result BOOLEAN;
BEGIN
  l_result := DBMS_PDB.check_plug_compatibility(
                pdb_descr_file => '/home/oracle/app/oracle/oradata/orcl/my_test1/my_test1.xml',
                pdb_name       => 'my_test2');

  IF l_result THEN
    DBMS_OUTPUT.PUT_LINE('compatible');
  ELSE
    DBMS_OUTPUT.PUT_LINE('incompatible');
  END IF;
END;
/
alter system set db_create_file_dest='/home/oracle/app/oracle/oradata/orcl/my_test2'
create pluggable database my_test2 
AS CLONE using '/home/oracle/app/oracle/oradata/orcl/my_test1/my_test1.xml' 
;
alter pluggable database my_test2 open read write; 

drop pluggable database my_test1 keep datafiles;
alter system set db_create_file_dest='/home/oracle/app/oracle/oradata/orcl/my_test1'
create pluggable database my_test1
using '/home/oracle/app/oracle/oradata/orcl/my_test1/my_test1.xml' 
NOCOPY
  TEMPFILE REUSE;
alter pluggable database my_test1 open read write; 

SELECT --name, open_mode
*
FROM   v$pdbs
ORDER BY name;

create pluggable database pdb3 
admin user odb3_admin identified by oracle
roles = (DBA)
FILE_NAME_CONVERT=('/u01/app/oracle/oradata/cdb1/pdbseed','/u01/app/oracle/oradata/cdb1/pdb3');


create pluggable database pdb3 
admin user odb3_admin identified by oracle
roles = (DBA)
FILE_NAME_CONVERT=('/u01/app/oracle/oradata/cdb1/pdbseed','/u01/app/oracle/oradata/cdb1/pdb3');


SELECT TABLE_NAME, PRIVILEGE, GRANTABLE FROM DBA_TAB_PRIVS
    WHERE GRANTEE = 'BLNG';

SELECT * FROM SESSION_PRIVS;

SELECT * FROM DBA_ROLE_PRIVS   WHERE GRANTEE = 'NTG';

select name from v$datafile where con_id=2;


select
*
from 
--all_objects
all_source
where owner = 'ORD'



select * from ntg.log order by id desc

select * from ord.ord order by id desc


select * from ord.item_avia order by id desc
select * from blng.v_account order by id desc



select ord.fwdr.order_number_generate(31)
from dual


grant execute on ord.ord_api to blng;
grant execute on blng.blng_api to ord;

alter user default scheme 

declare
 q dtype.t_id;
begin
q:=ord.fwdr.order_create;

commit;
end;



declare
 q dtype.t_id;
s varchar2(233);
begin
s:=ord.fwdr.order_number_generate(31);
q:=  ord.ord_api.ord_add(p_date => sysdate,
                          p_order_number =>s ,
                          p_client => 31,
                          p_status => 'A'
    );

commit;
end;


select * from ntg.log order by id desc

select * from ord.ord order by id desc

select * from ord.item_avia order by id desc


select * from ord.bill order by id desc

select * from blng.document order by id desc


select * from blng.document 
where contract_oid = 21 and amount = 2244
and amnd_STATE = 'A'
order by id desc



DECLARE
  P_NQT_ID VARCHAR2(50);
  P_PNR_ID VARCHAR2(50);
  P_TIME_LIMIT DATE;
  P_TOTAL_AMOUNT NUMBER;
  P_TOTAL_MARKUP NUMBER;
  P_PNR_OBJECT CLOB;
  P_STATUS VARCHAR2(1);
  P_CLIENT NUMBER;    
BEGIN
  P_NQT_ID := 'qwe1';
  P_PNR_ID := 'qwe1';
  P_TIME_LIMIT := sysdate;
  P_TOTAL_AMOUNT := 555;
  P_TOTAL_MARKUP := 55;
  P_PNR_OBJECT := '{"id": "KGIDRD"}21';
  P_STATUS := 'W';
  P_CLIENT := NULL;

  ORD.FWDR.avia_register (  P_NQT_ID,
P_PNR_ID,
P_TIME_LIMIT,
P_TOTAL_AMOUNT,
P_TOTAL_MARKUP,
P_PNR_OBJECT,
P_STATUS) ;  
END;

begin
  ord.core.bill_pay;
end;


-608124
DECLARE
  P_NQT_ID VARCHAR2(50);    
BEGIN
  P_NQT_ID := NULL;

  ORD.FWDR.avia_pay (  P_NQT_ID => 'qwe1') ;  
END;


begin
FOR I IN (
select * from blng.document 
where contract_oid = 21 and amount = 2244
and amnd_STATE = 'A'
order by id desc
)
loop
  blng.core.revoke_document(i.id);
end loop;
commit;
end;

begin
     NTG.LOG_API.LOG_ADD(p_proc_name=>'get_table', p_msg_type=>'UNHANDLED_ERROR', 
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select&p_table=markup&p_date=' 
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
end;


SELECT 
ia.id,
jt.*
FROM ord.item_avia ia,
json_table(pnr_object, '$'


select 
jr.status
from 
(select
'[{ "status": "NEW" }, {"status": "INPROC" }]' a
from dual),
json_table (a,'$'
columns status path '$.status'
) jr



select 
jr.status
from 
(select
'[{ "status": "NEW" }, {"status": "INPROC" }]' a
from dual),
json_table (a,'$'
columns (

nested path '$.[*]'
columns (status VARCHAR2(250) path '$.status'))
) AS jr;



SELECT json_query(a, '$[*].status'
                               WITH WRAPPER
                               )
  FROM (select
'[{ "status": "NEW" }, {"status": "INPROC" }]' a
from dual) ;







select 
jr.status
from 
(
  select
  '[{ "status": "NEW" }, {"status": "INPROC" }]' a 
  from dual
), json_table (a,'$[*]' columns (status VARCHAR2(250) path '$.status')
) AS jr



select jr.status from 
(
  select  p_status_list from dual
), 
json_table  (a,'$[*]' 
            columns (status VARCHAR2(250) path '$.status')
            ) AS jr
;


select status
from
json_table  
  ( '[{ "status": "NEW" }, {"status": "INPROC" }]','$[*]' 
  columns (status VARCHAR2(250) path '$.status')
  ) 
  ;




select * from blng.v_account

--test revoke_document
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  ntg.dtype.t_id:=21;
  P_number VARCHAR2(255);
  v_DOC ntg.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* ins doc buy 100 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT =>0.25,P_TRANS_TYPE => 2);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);

  commit;
  --revoke 100
end;


select * from blng.document 

order by id desc

;


select * from ntg.log order by id desc;

grant select on ord.item_avia to blng;


select * from ntg.log order by id desc;

select * from ord.ord order by id desc;

select * from ord.item_avia 
--where amnd_prev = 371
--order by amnd_date desc;
order by id desc;


select * from ord.bill order by id desc;


select * from blng.document order by id desc; 


DECLARE
  P_NQT_ID VARCHAR2(50);
  P_PNR_ID VARCHAR2(50);
  P_TIME_LIMIT DATE;
  P_TOTAL_AMOUNT NUMBER;
  P_TOTAL_MARKUP NUMBER;
  P_PNR_OBJECT CLOB;
  P_NQT_STATUS VARCHAR2(1);
  P_CLIENT NUMBER;    
BEGIN
  P_NQT_ID := NULL;
  P_PNR_ID := NULL;
  P_TIME_LIMIT := NULL;
  P_TOTAL_AMOUNT := NULL;
  P_TOTAL_MARKUP := NULL;
  P_PNR_OBJECT := NULL;
  P_NQT_STATUS := NULL;
  P_CLIENT := NULL;

  ORD.FWDR.avia_register ( 
P_NQT_ID => '45ba55eff8e94a8fbae29973e2366ba3',
P_NQT_STATUS => 'NEW') ;  
END;


/
        SELECT
        ia.nqt_id, ia.nqt_status, ia.po_status, 'po_msg' po_msg, 'avia' item_type
        from ord.item_avia ia,
        json_table  
          ( '[{ "status": "NEW" }, {"status": "INPROC1" }]','$[*]' 
          columns (status VARCHAR2(250) path '$.status')
          ) as j
        where ia.nqt_status = j.status and amnd_state = 'A'
        order by id;
        
        
  
    DECLARE
  P_NQT_ID VARCHAR2(50);    
BEGIN
  P_NQT_ID := '085b230ac8084cb08f89d0bb25d8d020';

  ORD.FWDR.avia_pay (  P_NQT_ID => P_NQT_ID) ;  
END;

  --05386bfde5fe421b9363d52cdb56373b


select * from ord.item_avia where nqt_id = '05386bfde5fe421b9363d52cdb56373b'
select * from ord.item_avia where nqt_id = 'f0b41fd486364a358e5df2b2e447cb21'


--cddc17c6b2384d0c8aced2885d4b1f34
--3983

select text from all_source
where owner in ('NTG','BLNG','ORD')


set spool off


spool on to '../../../output.txt';

spool off;



grant select on ntg.geo to po_fwdr


select * from ntg.geo


keyswitch(name,'en'),keyswitch(nls_name,'ru')
select id,parent_id,name,nls_name, iata code,object_type, nls_name as res_name, iata as res_code from ntg.geo where is_active in ('Y', 'W') and iata is not null  union all select id,parent_id,,iata code,object_type, nls_name as res_name, iata as res_code from ntg.geo  where is_active in ('Y', 'W') and iata is not null


select 


connect system

ALTER SESSION SET CONTAINER = PDB$SEED

select * from ntg.geo g,
T_DOC_SEARCH_RATING_DISTINCT@ctagan sr
where g.nls_name = sr.name




CREATE PUBLIC DATABASE LINK CTAGAN 
CONNECT TO c##tagan IDENTIFIED BY cccCCC111
   USING 'orcl';
   
   
   ALTER USER C##TAGAN IDENTIFIED BY cccCCC111
   
   
   
ACCOUNT UNLOCK ;






select * from ntg.geo g,
T_DOC_SEARCH_RATING_DISTINCT@ctagan sr
where g.nls_name = sr.name
and is_active = 'Y'
and object_type in 
('country') 


select distinct  object_type from ntg.geo g,
T_DOC_SEARCH_RATING_DISTINCT@ctagan sr
where g.nls_name = sr.name
and is_active = 'Y'
and object_type in (
) 



update ntg.geo g set search_rating = (
select cnt from T_DOC_SEARCH_RATING_DISTINCT@ctagan sr where sr.name = g.nls_name
)
where is_active = 'Y';
commit;


airport
airport real
city
country
city-airport
region




select distinct iata from ntg.geo iata,
(
  select * from ntg.geo where 
  is_active = 'Y'
  and iata in (  
    select distinct iata from ntg.geo
    where object_type in (
    'airport',
    'airport real',
    'city',
    'city-airport'
    )
    and iata is not null
    and length(iata) = 3
    and is_active = 'Y'
  )
  and object_type in (
  'airport real'
  )
) airport,
(
  select * from ntg.geo where 
  is_active = 'Y'
  and iata in (  
    select distinct iata from ntg.geo
    where object_type in (
    'airport',
    'airport real',
    'city',
    'city-airport'
    )
    and iata is not null
    and length(iata) = 3
    and is_active = 'Y'
  )
  and object_type in (
    'airport',
    'city',
    'city-airport'
    )
) city
where object_type in (
'airport',
'airport real',
'city',
'city-airport'
)
and iata is not null
and length(iata) = 3
and is_active = 'Y'

 
select * from ntg.geo where 
is_active = 'Y'
and iata in (  
  select distinct iata from ntg.geo
  where object_type in (
  'airport',
  'airport real',
  'city',
  'city-airport'
  )
  and iata is not null
  and length(iata) = 3
  and is_active = 'Y'
)



CREATE TABLE j_purchaseorder
(id RAW (16) NOT NULL,
date_loaded TIMESTAMP (6) WITH TIME ZONE,
po_document CLOB
CONSTRAINT ensure_json CHECK (po_document IS JSON));


INSERT INTO ORD.ITEM_AVIA (PNR_OBJECT)
SELECT '{"id": "KGIDRD"} SELECT' A FROM DUAL;
COMMIT;



INSERT INTO ORD.ITEM_AVIA (PNR_OBJECT)
SELECT A FROM (SELECT 'ASD {"id": "KGIDRD"} 21' A FROM DUAL) WHERE A IS JSON;
COMMIT;


SELECT * FROM ORD.ITEM_AVIA ORDER BY ID DESC


SELECT * FROM ORD.ITEM_AVIA_status ORDER BY ID DESC


SELECT * FROM log ORDER BY ID DESC


grant select on ord.item_avia_status to blng;

        
  
    DECLARE
  P_NQT_ID VARCHAR2(50);    
BEGIN
  P_NQT_ID := '06ca5dccdf3d4fe8bfc3e6e02e5acd7f';

  ORD.FWDR.avia_pay (  P_NQT_ID => P_NQT_ID) ;  
END;


select * from ord.item_avia where amnd_state = 'A'
and nqt_status = 'NEW'



        SELECT
        ia.nqt_id, ia.nqt_status, ias.po_status, ias.nqt_status_cur, null po_msg, 'avia' item_type
        from ord.item_avia ia, ord.item_avia_status ias,
        json_table  
          ( '[{"id": "085b230ac8084cb08f89d0bb25d8d020"}]','$[*]' 
          columns (id VARCHAR2(250) path '$.id')
          ) as j
        where ia.nqt_id = upper(j.id) 
        and ia.amnd_state = 'A'
        and ias.amnd_state = 'A'
        and ia.id = ias.item_avia_oid
        order by ia.id;
        
       
       
       
        SELECT
       *
        from
        json_table  
          ( '[{"id": "085b230ac8084cb08f89d0bb25d8d020"}]','$[*]' 
          columns (id VARCHAR2(250) path '$.id')
          ) as j
          
          
          select * from ord.item_avia where nqt_id = '085b230ac8084cb08f89d0bb25d8d020'
          
          
          select * from blng.client
          
          delete from ord.item_hotel; commit;
          delete from ord.ticket; commit;
          
          
          select * from blng.company
          
          truncate table blng.event;
          
          
          
          
          delete from blng.transaction; commit;
delete from blng.document where contract_oid !=21; commit;
delete from blng.account where contract_oid != 21; commit;
delete from blng.client2contract where client_oid !=31; commit;
delete from blng.contract where id != 21; commit;
delete from blng.client where id != 31; commit;
delete from blng.company where id != 4; commit;


select * from  blng.client2contract


select * from blng.transaction
select * from blng.document order by id desc

select id from blng.document where contract_oid !=21;


delete from blng.document where contract_oid !=21;


delete from blng.transaction where doc_oid in (select id from blng.document where contract_oid !=21) ;commit;

delete from blng.transaction where doc_oid is null; commit;

select * from blng.delay order by id desc

delete from blng.delay where  contract_oid !=21;commit;
delete from blng.delay where  contract_oid is null ;commit;


select * from blng.account


select * from blng.document order by id desc

select * from ord.bill order by id desc

select * from ord.item_avia order by id desc

select * from ord.item_avia_status order by id desc

delete from ord.item_avia_status; commit;

select * from ord.item_avia order by id
select * from ord.ord order by id desc



select * from ord.item_avia order by id desc
select * from ord.item_avia_status order by id desc

select * from ord.bill order by id desc

select * from ntg.log order by id desc


select * from 

select * from blng.v_account


select * from blng.document order by id desc

select * from blng.document order by id desc

select * from containers(ntg.log)

SELECT *
FROM   CONTAINERS(common_user_tab);


ALTER SESSION SET CONTAINER = NTG;

SELECT * FROM CONTAINERS(ntg.log) WHERE CON_ID IN(9);
SELECT * FROM ntg.log WHERE CON_ID IN(9);


select * from v$pdbs


alter session set PLSQL_WARNINGS='ENABLE:ALL'


select * from log order by id desc


select * 
from ord.item_avia where nqt_id in (
'2840438e263f4947a5c161fc4d531ff7',
'8db8b71c7dad4273bbb1de711c7d561d',
'ad6c826b70c4418bb1abe8ff336f5d67',
'd494ad8469874e7da6aa629804c83b48',
'2cff44db54d144288b5e3e7ad020277a',
'a15a8e6d78494cd4b2c29c1d1f5abb5d'
) 
and amnd_state = 'A'
order by id desc


select nqt_id,count(*)
from ord.item_avia 
where amnd_date >= sysdate - 1/2
group by nqt_id

order by id desc


select amnd_prev, count(*) from ord.item_avia --where nqt_id in ('d494ad8469874e7da6aa629804c83b48') 
where --amnd_date > sysdate -1
amnd_prev = 2976

group by amnd_prev

--order by id desc



select * from ord.item_avia_status where item_avia_oid in (21434)
order by id desc

update ord.item_avia_status set po_status = 'ERROR' where id = 22; commit

select * from ord.item_avia where nqt_id = '11'

select * from ord.bill where order_oid = 323

begin
ord.fwdr.avia_manual('11','SUCCESS');
end;

s
        
select * from ord.item        

        SELECT
        ia.nqt_id, ia.nqt_status, ias.po_status, ias.nqt_status_cur, null po_msg, 'avia' item_type, ia.pnr_id
        from ord.item_avia ia, ord.item_avia_status ias,
        json_table  
          ( '[{"status": "INMANUAL"}]','$[*]' 
          columns (status VARCHAR2(250) path '$.status')
          ) as j
        where ia.nqt_status = upper(j.status) 
        and ia.amnd_state = 'A'
        and ias.amnd_state = 'A'
        and ia.id = ias.item_avia_oid
        order by ia.id;
        


select * 
from ord.item_avia /*where nqt_status = 'INMANUAL'
and amnd_state = 'A'*/
order by id desc

select distinct nqt_status --,count(*)
from ord.item_avia 
where amnd_date >= sysdate - 1
group by nqt_id



select distinct to_char(pnr_object)
from ord.item_avia 
where amnd_date >= sysdate - 1/2



group by nqt_id



select * from 


declare
  v_id number;
  v_percent number;
  v_fix number;
  
begin
  for i in (
    select
    distinct nqt_id nqt_id
   -- *
    from ord.item_avia 
    where amnd_date >= sysdate - 2
    and nqt_id='d494ad8469874e7da6aa629804c83b48'
  )
  loop
          dbms_output.put_line('='||i.nqt_id);      
    ord.fwdr.commission_get(i.nqt_id,v_fix,v_percent);
  end loop;
end;




    select distinct al.id, al.iata   from ord.v_json j, ntg.airline al where j.id = 21434
    and al.AMND_STATE = 'A'
    and j.validatingcarrier = al.iata
    ;

select * from ord.v_json where id = 21434







select * from ord.item_avia 
where nqt_status = 'INMANUAL'
order by id desc


select * from ord.item_avia 
where id = 21434
order by id desc

    select distinct al.id, al.iata  from ord.v_json j, ntg.airline al where j.id = 21434
    and al.AMND_STATE = 'A'
    and j.validatingcarrier = al.iata
    ;
    
    
    



--test set/update increase/decrease limit
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  ntg.dtype.t_id:=21;
  P_number VARCHAR2(255);
  v_DOC ntg.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* ins doc limit 1000 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 1200000,P_TRANS_TYPE =>7);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
end;




select ord.ord_api.commission_template_get_id('default')
from dual


          select value from ord.commission_details 
          where /*commission_oid = i_rule.id 
          and commission_template_oid = i_template_type.commission_template_oid*/
      amnd_state = 'A'
          group by value



DECLARE
  P_NQT_ID VARCHAR2(50);
  O_FIX NUMBER;
  O_PERCENT NUMBER;
BEGIN
  P_NQT_ID := 'd494ad8469874e7da6aa629804c83b48';

  ORD.FWDR.COMMISSION_GET(
    P_NQT_ID => P_NQT_ID,
    O_FIX => O_FIX,
    O_PERCENT => O_PERCENT
  );
  /* Legacy output: 
DBMS_OUTPUT.PUT_LINE('O_FIX = ' || O_FIX);
*/ 
  :O_FIX := O_FIX;
  /* Legacy output: 
DBMS_OUTPUT.PUT_LINE('O_PERCENT = ' || O_PERCENT);
*/ 
  :O_PERCENT := O_PERCENT;
--rollback; 
END;



select * from ord.v_commission

@C:/Users/SQLDeveloper/Documents/GitHub/pl-sql-code/spool.sql



select  
iata,
name,
nvl(nls_name,name) NLS_NAME,
nvl(city_iata,iata) city_iata,
city_name,
nvl(city_nls_name,city_name) city_nls_name
from (
      SELECT
      g.iata,
      trim(g.name) name,
      trim(g.nls_name) nls_name,
      case
      when parents.object_type in ('region','country') then g.iata
      when parents.object_type is null then g.iata
      else parents.iata
      end city_iata,
      case
      when parents.object_type in ('region','country') then trim(g.name)
      when parents.object_type is null then trim(g.name)
      else trim(parents.name)
      end city_name,
      case
      when parents.object_type in ('region','country') then trim(g.nls_name)
      when parents.object_type is null then trim(g.nls_name)
      else trim(parents.nls_name)
      end city_nls_name
      FROM GEO g, geo parents --, table(v_iata_tab) iata_list
      WHERE g.IS_ACTIVE IN ('Y')
      and g.iata is not null
      and g.iata not like '%@%'
      and g.object_type in ('airport real')
      and parents.IS_ACTIVE(+) IN ('Y')
      and g.parent_id = parents.id(+)
     -- and g.iata = 'KGF'
      order by 1
)
where city_iata = 'MOW'


      SELECT
      *
      --id, trans_type_oid, amount, doc_date
      from blng.document
      where id = nvl(null,id)
      and contract_oid = nvl(null,contract_oid)
      and trans_type_oid = nvl(null,trans_type_oid)
      and status = nvl(null,status)
      and ((bill_oid = p_bill and p_bill is not null) or (bill_oid is null and p_bill is null))
      and amnd_state = 'A'
      order by p_contract, id asc;
      
      
      select * from blng.document where bill_oid is not null and amnd_state = 'A'


select * from log order by id desc

select * from ord.bill order by id desc

select * from blng.document order by id desc

select * from ord.item_avia 
where amnd_state = 'A'
and nqt_status = 'INMANUAL'
and id = 606
order by id desc

select * from ord.item_avia_status where item_avia_oid = 606  order by id desc

select * from blng.v_account

  ALTER TABLE ord.item_avia ADD CONSTRAINT iav_ensure_json CHECK (pnr_object IS JSON (STRICT));
  
  
CREATE TABLESPACE TEMPDICT DATAFILE '/home/oracle/app/oracle/oradata/orcl/ORCL/032A6356A8B256D7E055000000000002/datafile/TEMPDICT01.dbf' SIZE 250M EXTENT MANAGEMENT LOCAL AUTOALLOCATE;
CREATE TABLESPACE DICT DATAFILE '/home/oracle/app/oracle/oradata/orcl/ORCL/032A6356A8B256D7E055000000000002/datafile/DICT01.dbf' SIZE 250M EXTENT MANAGEMENT LOCAL AUTOALLOCATE;
--create tablespace TEMPDICT datafile '/home/oracle/app/oracle/oradata/orcl/my_test2/ORCL/0A67DE5661406850E055000000000002/datafile/TEMPDICT.dbf' SIZE 25M EXTENT MANAGEMENT LOCAL AUTOALLOCATE;
ALTER USER ntg quota unlimited on TEMPDICT;
ALTER USER po_fwdr quota unlimited on TEMPDICT;
ALTER USER ntg quota unlimited on DICT;
ALTER USER po_fwdr quota unlimited on DICT;
alter tablespace TEMPDICT ONLINE;
alter tablespace DICT ONLINE;
alter table EXP.AIRPORT move tablespace TEMPDICT;
alter table EXP.city move tablespace TEMPDICT;
alter table EXP.country move tablespace TEMPDICT;
alter table EXP.parentregion move tablespace TEMPDICT;
ALTER INDEX "EXP"."SYS_IL0000093080C00003$$" REBUILD 
TABLESPACE TEMPDICT;


-- get tablespaces
SELECT dd.tablespace_name tablespace_name, dd.file_name file_name, dd.bytes/1024 TABLESPACE_KB, SUM(fs.bytes)/1024 KBYTES_FREE, MAX(fs.bytes)/1024 NEXT_FREE
FROM sys.dba_free_space fs, sys.dba_data_files dd
WHERE dd.tablespace_name = fs.tablespace_name
AND dd.file_id = fs.file_id
GROUP BY dd.tablespace_name, dd.file_name, dd.bytes/1024
ORDER BY dd.tablespace_name, dd.file_name;

alter database \


update ntg.geo set amnd_PREV = ID, AMND_STATE = DECODE(IS_ACTIVE,'Y','A','C'), amnd_date = sysdate, amnd_user = 'NTG'; commit;

update ntg.markup set  amnd_user = 'NTG' where amnd_user is null; commit;

select distinct type from dba_source
where type



      SELECT al.id, al.iata, al.name, al.nls_name 
      FROM markup mkp, airline al
      where mkp.validating_carrier = al.id
   --   and mkp.gds = nvl(p_gds,mkp.gds)
   --   and mkp.pos = nvl(p_pos,mkp.pos)
      and mkp.amnd_state = 'A'
      and al.amnd_state = 'A'
      group by al.id, al.nls_name , al.name, al.iata;
      
      
      
        SELECT *
        FROM v_markup;
        
        update ord.commission set amnd_state = 'C'; commit;
        
        select * from dba_objects where owner = 'NTG' and object_type = 'SEQUENCE';
        select * from all_objects where owner = 'NTG' and object_type = 'SEQUENCE';
        
        
         select * from session_privs
         where privilege like '%RESTR%'
         
         
         
GRANT RESTRICTED SESSION to ord
GRANT RESTRICTED SESSION to blng
GRANT RESTRICTED SESSION to po_fwdr
ORA-01950: нет привилегий на раздел 'USERS'
alter tablespace users online;


---start
 
alter pluggable database ntg1 close immediate;
 drop pluggable database ntg1 including datafiles;

--alter system set db_create_file_dest='/home/oracle/app/oracle/oradata';
--alter session set DB_UNIQUE_NAME = 'ntg3';

create pluggable database TEMPDICT
admin user ntg identified by cccCCC111 --default tablespace USERS
roles = (DBA)
STORAGE (MAXSIZE UNLIMITED)
  DEFAULT TABLESPACE USERS 
    DATAFILE /*'/home/oracle/app/oracle/oradata/orcl/ntg1/ntg1.dbf'*/ 
    SIZE 100M AUTOEXTEND ON;




 
--alter pluggable database ntg_dbf close immediate;
-- drop pluggable database ntg_dbf including datafiles;

alter pluggable database TEMPDICT close immediate; 
alter pluggable database TEMPDICT open read write; 

--alter user ntg default tablespace USERS;
-- WITH DBA USER NTG
alter user ntg DEFAULT TABLESPACE users QUOTA unlimited ON users;
create user BLNG IDENTIFIED BY cccCCC111 DEFAULT TABLESPACE users QUOTA unlimited ON users;
create user ORD IDENTIFIED BY cccCCC111 DEFAULT TABLESPACE users QUOTA unlimited ON users;
create user EXP IDENTIFIED BY cccCCC111 DEFAULT TABLESPACE users QUOTA unlimited ON users;
create user po_fwdr IDENTIFIED BY cccCCC111 DEFAULT TABLESPACE users QUOTA unlimited ON users;

GRANT RESTRICTED SESSION to ord;
GRANT RESTRICTED SESSION to blng;
GRANT RESTRICTED SESSION to po_fwdr;
GRANT RESTRICTED SESSION to EXP;

--ORA-01950: нет привилегий на раздел 'USERS' 
SELECT * FROM V$DIAG_INFO --oracle logs 
select * from PDB_PLUG_IN_VIOLATIONS --check pdb warnings 
--public synonym ntg.dtype
-----end


begin
ord.core.bill_pay;
end;


  CREATE OR REPLACE PUBLIC SYNONYM "DTYPE" FOR "NTG"."DTYPE";

select * from ntg.airport@ntg1


DROP TABLESPACE airline INCLUDING CONTENTS AND DATAFILES;


create tablespace airline datafile '/home/oracle/app/oracle/oradata/orcl/ntg1/ORCL/0B27427958986611E055000000000002/datafile/airline01.dbf' SIZE 25M;
ALTER USER ntg quota unlimited on airline;
alter tablespace airline ONLINE;


/home/oracle/app/oracle/oradata/orcl/ntg1/ORCL/0B27427958986611E055000000000002/datafile/o1_mf_system_b9vv48w3_.dbf


ALTER DATABASE
    RENAME FILE '/home/oracle/app/oracle/oradata/orcl/ntg1/ntg1.dbf'              
             TO '/home/oracle/app/oracle/oradata/orcl/ntg1/ORCL/0B27427958986611E055000000000002/datafile/ntg1.dbf'
                
ALTER DATABASE
    RENAME FILE '/home/oracle/app/oracle/oradata/orcl/ntg1/ORCL/0B27427958986611E055000000000002/datafile/ntg1.dbf'              
             TO '/home/oracle/app/oracle/oradata/orcl/ntg1/ntg1.dbf'


/home/oracle/app/oracle/oradata/orcl/ntg1/ORCL/0B27427958986611E055000000000002/datafile/o1_mf_sysaux_b9vv48w4_.dbf
/home/oracle/app/oracle/oradata/orcl/ntg1/ORCL/0B27427958986611E055000000000002/datafile/o1_mf_system_b9vv48w3_.dbf
/home/oracle/app/oracle/oradata/orcl/ntg1/ntg1.dbf
/home/oracle/app/oracle/oradata/orcl/ntg1/ORCL/0B38B973B8BE2567E055000000000002/datafile/o1_mf_temp_b9y2fhsl_.dbf 
alter pluggable database ntg1 close immediate;
 drop pluggable database ntg1 including datafiles;

alter pluggable database ntg1 open read write; 
alter pluggable database ntg1 open read only; 

select * from v$database

select * from v$data_files

ALTER SESSION SET CONTAINER = CDB$ROOT;

alter pluggable database test close immediate;
drop pluggable database ntg2 including datafiles;
drop pluggable database ntg3 including datafiles;
drop pluggable database ntg4 including datafiles;
drop pluggable database ntg5 including datafiles;
drop pluggable database test including datafiles;
drop pluggable database my_test including datafiles;
drop pluggable database my_test1 including datafiles;
drop pluggable database my_test2 including datafiles;


select * from V$PDBS




select * from ntg.log order by id desc

select * from ord.bill order by id desc


select * from ord.ord order by id desc

select * from ord.item_avia_status order by id desc

select * from ord.item_avia order by id desc

7ad2ddc8926643e8bd2d33c78222deb7

select * from blng.document order by id desc

declare
  v_id number;
  v_percent number;
  v_fix number;
  
begin
  for i in (
    select
    distinct nqt_id nqt_id
   -- *
    from ord.item_avia 
    where amnd_date >= sysdate - 2
    and nqt_id = '2d11bcec395e4778919ca3b665d7b1d3'
    --where id = 123 --> 33
    --order by id desc
  )
  loop
          dbms_output.put_line('='||i.nqt_id);      
    ord.fwdr.commission_get(i.nqt_id,v_fix,v_percent);
  end loop;
end;

2d11bcec395e4778919ca3b665d7b1d3
MDQTZI


select * from ord.item_avia order by id desc

select * from blng.document order by id desc

select * from blng.v_account 
select * from ord.commission
select * from airline where iata like '%R2%'

DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  ntg.dtype.t_id:=21;
  P_number VARCHAR2(255);
  v_DOC ntg.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* ins doc limit 1000 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 1300000,P_TRANS_TYPE =>7);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
end;

--- all that I NEED
alter pluggable database ntg close immediate;  
alter pluggable database ntg open read only; 

CREATE PLUGGABLE DATABASE prod FROM ntg 
no data
NOLOGGING;
alter pluggable database prod open read write; 




select  
iata,
name,
nvl(nls_name,name) NLS_NAME,
nvl(city_iata,iata) city_iata,
city_name,
nvl(city_nls_name,city_name) city_nls_name
from (
      SELECT
      g.iata,
      trim(g.name) name,
      trim(g.nls_name) nls_name,
      case
      when parents.object_type in ('region','country') then g.iata
      when parents.object_type is null then g.iata
      else parents.iata
      end city_iata,
      case
      when parents.object_type in ('region','country') then trim(g.name)
      when parents.object_type is null then trim(g.name)
      else trim(parents.name)
      end city_name,
      case
      when parents.object_type in ('region','country') then trim(g.nls_name)
      when parents.object_type is null then trim(g.nls_name)
      else trim(parents.nls_name)
      end city_nls_name
      FROM GEO g, geo parents --, table(v_iata_tab) iata_list
      WHERE g.IS_ACTIVE IN ('Y')
      and g.iata is not null
      and g.iata not like '%@%'
      and g.object_type in ('airport real')
      and parents.IS_ACTIVE(+) IN ('Y')
      and g.parent_id = parents.id(+)
--      and g.iata = 'OHH'
      order by 1
)
where iata = 'OPO'

select * from geo where iata = 'OPO'


select * from ord.v_commission
where iata = 'OPO'


NTG.AIRLINE,NTG.AIRPORT,NTG.GEO,NTG.MARKUP,BLNG.ACCOUNT_TYPE,BLNG.EVENT_TYPE,BLNG.STATUS_TYPE,BLNG.TRANS_TYPE,ORD.COMMISSION,ORD.COMMISSION_DETAILS,ORD.COMMISSION_TEMPLATE
BLNG.CLIENT,BLNG.CLIENT2CONTRACT,BLNG.COMPANY,BLNG.CONTRACT
NTG.LOG
BLNG.ACCOUNT,BLNG.DELAY,BLNG.DOCUMENT,BLNG.TRANSACTION,ORD.BILL,ORD.ITEM_AVIA,ORD.ITEM_AVIA_STATUS,ORD.ORD
BLNG.EVENT,ORD.FLIGHT_STOP,ORD.ITEM_HOTEL,ORD.ITEM_INSURANCE,ORD.ITINERARY,ORD.LEG,ORD.PASSENGER,ORD.PNR,ORD.PRICE_QUOTE,ORD.SEGMENT,ORD.TICKET
ORD.AIRPORT,ORD.CITY,ORD.COUNTRY,ORD.PARENTREGION


select * from blng.contract

begin

end;

--
--initialize 
BEGIN
  BLNG.BLNG_API.account_init ( 21) ;  
  commit;
END;
--test set/update increase/decrease limit
DECLARE
  v_contract  ntg.dtype.t_id:=21;
  v_DOC ntg.dtype.t_id;
BEGIN
  /* ins doc limit 1000 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 200000,P_TRANS_TYPE =>7);
  commit;
  /* set delay days 50 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 30,P_TRANS_TYPE =>11);
  commit;
  /* set max loan trans amount 200 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 0,P_TRANS_TYPE =>8);
  commit; 
-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX          0          0          999                  0            0                   200             0         50        999 
end;



INSERT INTO "ORD"."COMMISSION" (AIRLINE, DETAILS, PERCENT, PRIORITY) VALUES ('1376', 'собственные рейсы 1.5%', '1.5', '0');
INSERT INTO "ORD"."COMMISSION_DETAILS" (COMMISSION_OID, COMMISSION_TEMPLATE_OID) VALUES ('64', '20');
commit;







declare
  v_id number;
  v_percent number;
  v_fix number;
  
begin
  for i in (
    select
    distinct nqt_id nqt_id
   -- *
    from ord.item_avia 
    where amnd_date >= sysdate - 2
    and nqt_id = '0a54d0088054433b8af000cfbf889d3e'
    --where id = 123 --> 33
    --order by id desc
  )
  loop
          dbms_output.put_line('='||i.nqt_id);      
    ord.fwdr.commission_get(i.nqt_id,v_fix,v_percent);
  end loop;
end;


    select distinct al.id, al.iata   from ord.v_json j, ntg.airline al where j.id = 25107
    and al.AMND_STATE = 'A'
    and j.validatingcarrier = al.iata
    ;
    
INSERT INTO "ORD"."COMMISSION" (AIRLINE, DETAILS, PERCENT, PRIORITY) VALUES ('1376', 'interline 0%', '0', '0'); --65 --18
INSERT INTO "ORD"."COMMISSION" (AIRLINE, DETAILS, PERCENT, PRIORITY) VALUES ('1376', 'code-share 1.5%', '1.5', '0'); --66 --19
INSERT INTO "ORD"."COMMISSION_DETAILS" (COMMISSION_OID, COMMISSION_TEMPLATE_OID) VALUES ('66', '19');
INSERT INTO "ORD"."COMMISSION_DETAILS" (COMMISSION_OID, COMMISSION_TEMPLATE_OID) VALUES ('65', '18');
commit;


select *
from log 
where ROWNUM <= rownum
and id > 222



alter pluggable database prod open read write;

CONNECT TARGET "sbu@prod AS SYSBACKUP"

select * from V$ARCHIVED_LOG
select * from V$ARCHIVE_PROCESSES
select * from V$BACKUP_REDOLOG
select * from V$LOG_HISTORY
SELECT dest_name, status, destination FROM v$archive_dest;


SELECT name, value FROM v$sysstat WHERE name = 'redo wastage';

SELECT * FROM V$LOG;

SELECT * FROM V$LOGFILE


select * from airline where iata = 'S7'

67	1073	собственные рейсы 0%
68	1073	interline 0%
69	1073	code-share 0%

20	self
18	interline
19	code-share



UPDATE "ORD"."BILL" SET AMND_STATE = 'C' WHERE ROWID = 'AAAWpAAAYAAAAPOAAA' AND ORA_ROWSCN = '41498738'
UPDATE "ORD"."BILL" SET AMND_STATE = 'C' WHERE ROWID = 'AAAWpAAAYAAAAPOAAB' AND ORA_ROWSCN = '41498738'

Commit Successful


UPDATE "ORD"."ITEM_AVIA" SET AMND_STATE = 'C' WHERE ROWID = 'AAAWpZAAYAAAADWAAA' AND ORA_ROWSCN = '41498738'
UPDATE "ORD"."ITEM_AVIA" SET AMND_STATE = 'C' WHERE ROWID = 'AAAWpZAAYAAAADWAAB' AND ORA_ROWSCN = '41498738'

Commit Successful


UPDATE "ORD"."ORD" SET AMND_STATE = 'C' WHERE ROWID = 'AAAWo8AAYAAAADGAAA' AND ORA_ROWSCN = '41498738'
UPDATE "ORD"."ORD" SET AMND_STATE = 'C' WHERE ROWID = 'AAAWo8AAYAAAADGAAB' AND ORA_ROWSCN = '41498738'

Commit Successful

70	866	собственные рейсы 0%
71	866	interline 0%
72	866	code-share 0%

20	self
18	interline
19	code-share
INSERT INTO "ORD"."COMMISSION" (AIRLINE, DETAILS, PERCENT, PRIORITY) VALUES ('866', 'собственные рейсы 0%', '0', '0');
INSERT INTO "ORD"."COMMISSION" (AIRLINE, DETAILS, PERCENT, PRIORITY) VALUES ('866', 'interline 0%', '0', '0');
INSERT INTO "ORD"."COMMISSION" (AIRLINE, DETAILS, PERCENT, PRIORITY) VALUES ('866', 'code-share 0%', '0', '0');
Commit;
INSERT INTO "ORD"."COMMISSION_DETAILS" (COMMISSION_OID, COMMISSION_TEMPLATE_OID) VALUES ('70', '20');
INSERT INTO "ORD"."COMMISSION_DETAILS" (COMMISSION_OID, COMMISSION_TEMPLATE_OID) VALUES ('71', '18');
INSERT INTO "ORD"."COMMISSION_DETAILS" (COMMISSION_OID, COMMISSION_TEMPLATE_OID) VALUES ('72', '19');
commit;


866
--delete from ord.commission where 

select * from airline where iata = 'UN'

74	562	1% от опубликованных тарифов туристического класса (L,V,X,T,N,I,W)
75	562	2% от опубликованных тарифов экономического класса (Y,H,Q,B,K)
76	562	5% от опубликованных тарифов империал/бизнес/премиального классов(F,J,C,D,S,M)
73	562	interline 3%



alter pluggable database prod open read write; 
alter pluggable database test open read write; 
alter pluggable database dev open read write; 




select * from geo where iata = 'PUW'

select * from V$SQLAREA where parsing_schema_name in ('PO_FWDR'/*,'NTG'*/)
order by last_load_time desc


SELECT GROUP#, BYTES FROM V$LOG;
SELECT GROUP#, BYTES FROM V$STANDBY_LOG;
SELECT CLIENT_PROCESS, PROCESS, THREAD#, SEQUENCE#, STATUS FROM 
V$MANAGED_STANDBY WHERE CLIENT_PROCESS='LGWR' OR PROCESS='MRP0';

select * from V$CONTAINERS


select * from geo
where amnd_state is null
and is_active != 'Y'

select id, nls_name from geo
where amnd_state ='A'


--and is_active != 'Y'


select * from v$parameter

select * from geo
where id in (25,260,4,2116,
2889,
2191,
2898,
2942,
2943
)


alter table blng.client add email varchar2(255);
alter table blng.company add domen varchar2(255);



select 
blng.fwdr.get_tenant(p_email=>'ceo@ntg-one.com')
from dual

grant execute on blng.fwdr to po_fwdr;


--test set/update increase/decrease limit
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  ntg.dtype.t_id:=21;
  P_number VARCHAR2(255);
  v_DOC ntg.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* ins doc cash in 500 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 3000000,P_TRANS_TYPE =>2);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;


  /* ins doc limit 1000 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 0,P_TRANS_TYPE =>7);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;


end;


  create sequence  zcts_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER zcts_TRGR 
BEFORE
INSERT
ON zcts_orders
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select zcts_SEQ.nextval into :new.id from dual; 
 -- select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER zcts_TRGR ENABLE;








declare
  v_geo_id number;
begin
  for i in (
    select  rowid from zcts_orders
  )
  loop
    select zcts_seq.nextval into v_geo_id from dual;
    update zcts_orders a set id = v_geo_id
    where rowid = i.rowid;
  end loop;
  commit;
end;



select 
rowid,
a.* from zcts_orders a
where rowid = 'AAAWajACGAAAADrAAM'



selec
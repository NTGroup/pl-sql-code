
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

select * from ord.ord order by id desc

select * from log order by id desc



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
  v_crlf  varchar2(5):= chr(13)||chr(10);
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
  c:= ord.fwdr.commission_get(121);
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
  avia_code varchar2(3):='CZ';
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


select * from ord.v_commission where al_oid = 444 

declare
  v_id number;
  v_percent number;
  v_fix number;
  
begin
  for i in (
    select
    distinct id
    from ord.v_json 
    where id = 123 --> 33
    order by id desc
  )
  loop
    ord.fwdr.commission_get(i.id,v_fix,v_percent);
  end loop;
end;

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


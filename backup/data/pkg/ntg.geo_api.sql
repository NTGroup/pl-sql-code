--------------------------------------------------------
--  DDL for Package GEO_API
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "NTG"."GEO_API" 
IS

 /*
 
 pkg: garbage 
 
 */


type geo_record IS record (
    ID            GEO.ID%type ,
    PARENT_ID     GEO.PARENT_ID%type ,
    NAME          GEO.NAME%type ,
    NLS_NAME      GEO.NLS_NAME%type ,
    IATA          GEO.IATA%type ,
    CODE          GEO.CODE%type ,
    OBJECT_TYPE   GEO.OBJECT_TYPE%type ,
    COUNTRY_ID    GEO.COUNTRY_ID%type ,
    CITY_ID       GEO.CITY_ID%type ,
    IS_ACTIVE     GEO.IS_ACTIVE%type,
    NEW_PARENT_ID GEO.NEW_PARENT_ID%type ,
    UTC_OFFSET    GEO.UTC_OFFSET%type );

type iata_record IS record (IATA GEO.IATA%type);
type iata_table is table of iata_record  index by pls_integer;
type iata_array is table of GEO.IATA%type index by pls_integer;



    
--type GEO_api_tab IS TABLE OF GEO_api_rec;
--type iata_tab_type IS TABLE OF GEO.IATA%type;

function get_utc_offset (p_iata in iata_array)
return SYS_REFCURSOR;

function get_utc_offset
return SYS_REFCURSOR;

function get_utc_offset_obj(p_iata in ntg.iata_o )
return SYS_REFCURSOR;

function geo_get_list
return SYS_REFCURSOR;

function airline_get_list
return SYS_REFCURSOR;

function airplane_get_list
return SYS_REFCURSOR;

Z

END GEO_api;

/

--------------------------------------------------------
--  DDL for Package Body GEO_API
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "NTG"."GEO_API" 
IS

function get_utc_offset(p_iata in iata_array)
return SYS_REFCURSOR
is
  v_iata_tab iata_table;
  v_results SYS_REFCURSOR; 
begin
  
  if p_iata.COUNT>0 then
    FOR i IN p_iata.FIRST..p_iata.LAST loop 
    v_iata_tab(i).iata := p_iata(i);
    end loop;
   
    OPEN v_results FOR
      SELECT 
      g.iata, max(utc_offset) utc_offset
      FROM GEO g , table(v_iata_tab) iata_list
      WHERE g.IS_ACTIVE IN ('W','Y')
      and g.iata is not null
      and g.iata not like '%@%'
      and g.iata = iata_list.IATA
      group by g.iata;
  else
    OPEN v_results FOR
      SELECT 
      g.iata, max(utc_offset) utc_offset
      FROM GEO g --, table(v_iata_tab) iata_list
      WHERE g.IS_ACTIVE IN ('W','Y')
      and g.iata is not null
      and g.iata not like '%@%'
--      and g.iata = iata_list.IATA
      group by g.iata;    
  end if;  
  NTG.LOG_API.LOG_ADD(p_proc_name=>'client_set_name', p_msg_type=>'Error');
  return v_results;
end;

function get_utc_offset
return SYS_REFCURSOR
is
  v_iata_tab iata_table;
  v_results SYS_REFCURSOR; 
begin

    OPEN v_results FOR
      SELECT 
      g.iata, max(utc_offset) utc_offset
      FROM GEO g --, table(v_iata_tab) iata_list
      WHERE g.IS_ACTIVE IN ('W','Y')
      and g.iata is not null
      and g.iata not like '%@%'
--      and g.iata = iata_list.IATA
      group by g.iata;    

  return v_results;
end;


function get_utc_offset_obj(p_iata in ntg.iata_o)
return SYS_REFCURSOR

is
  v_iata_tab iata_table;
  v_results SYS_REFCURSOR; 
  v_results1 clob; 
begin
  null;
  return v_results;
end;



function geo_get_list
return SYS_REFCURSOR
is
  v_iata_tab iata_table;
  v_results SYS_REFCURSOR; 
begin

    OPEN v_results FOR
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
); 

  return v_results;
end;



function airline_get_list
return SYS_REFCURSOR
is
  v_iata_tab iata_table;
  v_results SYS_REFCURSOR; 
begin

    OPEN v_results FOR
      select 
     -- id,
      iata,
      name,
      nls_name/*,
      airline.**/
      from airline
      where iata is not null
      and amnd_state = 'A';    

  return v_results;
end;


function airplane_get_list
return SYS_REFCURSOR
is
  v_iata_tab iata_table;
  v_results SYS_REFCURSOR; 
begin

    OPEN v_results FOR
      select 
      iata,
      name,
      nls_name
      from airplane
      ;    

  return v_results;
end;


END GEO_api;

/


select * from c##tagan.hello
where alfa = '�'


select max(length(f_name_en)) from c##tagan.t_doc_country
where id is not null


select * from c##tagan.t_doc_country
where id is not null

to_encode()

create table alias
(
geo_id number,
name varchar2(255)
)

create table geo  
(
id number not null
)

CREATE INDEX alias_ix
      ON geo(id);

select * from alias

alter table geo 
add parent_id number not null


select * from  c##tagan.t_doc_airport
where id is not null
and country_id is null


and f_iata = 'IST'

select * from c##tagan.t_version where f_version_id in (
'{E702B16C-9D4A-49E1-879D-56BA13440B2D}',
'{B64594FA-7CA1-4415-9230-4F970E1D4693}',
'{49BFC3C7-2D27-4479-AB7E-6297595CA4A3}',
'{CADB30D6-5649-4E3D-8D26-6C47066D6C0C}'
)

select * from  c##tagan.t_doc_airport
where
f_iata = 'SAW'

11337,
12630

select * from c##tagan.t_doc_city
where id is not null
and id in (11337,
12630)
iata
crt


select * from c##tagan.t_doc_city
where id is not null
and f_iata_code = 'IST'


select * from c##tagan.t_doc_airport
where id is not null
and f_iata_code = 'IST'



select
*

from c##tagan.t_doc_country

alter table c##ntg.geo 
add 


where id is not null
and 
group by country_Id

An error was encountered performing the requested operation:

Закрытое соединение
Закрытое соединение
Закрытое соединение



select convert('a','utf8','koir8-r') from dual;


SELECT * FROM V$NLS_VALID_VALUES WHERE parameter = 'CHARACTERSET'

SELECT CONVERT('Закрытое соединение', 'WE8MSWIN1252', 'AL32UTF8') 
   FROM DUAL; 
   

select * from c##tagan.hello
where CONVERT(alfa, 'AL32UTF8', 'WE8MSWIN1252') ='a' 

select * from c##tagan.hello


where alfa = 'a' 
where alfa = 'a' 



where alfa = 'a' 
where alfa = 'a' 


select h.* ,
CONVERT(alfa, 'AL32UTF8', 'WE8MSWIN1252') --,
-- CONVERT(alfa,  'WE8MSWIN1252', 'AL32UTF8')
 from c##tagan.hello h
 where CONVERT(alfa,'AL32UTF8', 'WE8MSWIN1252')='�'
 
 
 
 select *
from v$nls_parameters p
where p.PARAMETER like '%CHAR%';


 
 /*  
   US7ASCII: US 7-bit ASCII character set
WE8ISO8859P1: ISO 8859-1 West European 8-bit character set
EE8MSWIN1250: Microsoft Windows East European Code Page 1250
WE8MSWIN1252: Microsoft Windows West European Code Page 1252
WE8EBCDIC1047: IBM West European EBCDIC Code Page 1047
JA16SJISTILDE: Japanese Shift-JIS Character Set, compatible with MS Code Page 932
ZHT16MSWIN950: Microsoft Windows Traditional Chinese Code Page 950
UTF8: Unicode 3.0 Universal character set CESU-8 encoding form
AL32UTF8: Unicode 5.0 Universal character set UTF-8 encoding form*/


select * from geo

insert into geo
select 
id,
'-1',
f_name_en,
f_name_ru,
null,
f_code
from c##tagan.t_doc_country
where id is not null;
commit;

select * from  c##tagan.t_doc_region
where id is not null;



insert into geo
select 
id,
parent_id,
f_name_en,
f_name_ru,
null,
f_code,
'region'
from c##tagan.t_doc_region
where id is not null;
commit;


insert into geo
select 
id,
parent_id,
f_name_en,
f_name_ru,
f_iata_code,
f_iso_code,
geo_type
from c##tagan.t_doc_city
where id is not null;
commit;


select * from c##tagan.t_version where f_parent_id in (
  select f_document_id from c##tagan.t_version where f_version_id in (
    select f_version_id from c##tagan.t_doc_city where id is not null
  )
)
and f_actuality =2  


select * from  c##tagan.t_doc_airport where id is not null


insert into geo

select 
id,
nvl(nvl(city_id,country_id),-1),
f_name_en,
f_name_ru,
f_iata,
f_iso_code,
'airport real',
country_id,
city_id
from c##tagan.t_doc_airport
where id is not null
;

commit;


select * from 
(
select
iata, count(*) c
from geo
where iata is not null
group by iata
)
order by c desc

select
*
from geo
where iata ='@STW'

select * from geo where id in (127,
390) 


select lpad(' ',2*(level-1)) || to_char(nls_name) s 
  from geo 
    where nls_name is not null
  start with parent_id = -1
  connect by prior id = parent_id;



    CREATE TABLE "C##NTG"."ALIAS_N" 
   (	"GEO_ID" NUMBER, 
	"NAME" VARCHAR2(255 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING  
  TABLESPACE "USERS" ;










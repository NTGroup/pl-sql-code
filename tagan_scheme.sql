create table hello(
id number,
alfa varchar2(100)
);
commit;

select * from hello where id = 1


insert into hello
select 1,'a' from dual
union all
select 2,'b' from dual
union all
select 2,'с' from dual

union all
select 2,'д' from dual;
commit;



select * from dual


select * from t_doc_airline

select * from t_doc_airplane



select * from t_version where f_version_id in ('{C289A50F-289E-4BBE-8E85-06942E7FDE7B}')

select * from t_document where f_document_id in ('{203B821D-1E85-46BF-B1EC-B289F1004885}')

select * from t_type where f_type_id in ('{9D879F56-ADE3-4DC8-929B-359CF1585F9D}')




select count (*) from t_doc_city 
where id is not null
and f_type = 'ГА'
and geo_type is null


update t_doc_city  set geo_type = 'city-airport'
where id is not null
and f_type = 'ГА';
commit;



select * from t_version
where geo_id is not null
and geo_type = 'city'




select 
t.*,
(select geo_id from t_version where f_document_id = t.f_parent_id and geo_id is not null) geo_parent_id,
(select geo_type from t_version where f_document_id = t.f_parent_id and geo_id is not null) geo_parent_type
from 
t_version t
where geo_id is not null
and geo_type <> 'country'



update t_version t set geo_parent_id = (select geo_id from t_version where f_document_id = t.f_parent_id and geo_id is not null)
where geo_id is not null
and geo_type <> 'country';
commit;


update  t_version t set geo_parent_id = -1
where  geo_type = 'country' and geo_id is not null;
commit;


update t_doc_city t set 
parent_id = (select geo_parent_id from t_version where geo_id = t.id)
where t.id is not null;
commit;



select * from t_doc_region where id is null and parent_id is not null

select * from t_doc_city where id is not null


select * from t_doc_region where id in (949,
1112)


select * from t_doc_country
where id in (
184,
176
)



select 
  *
from 
t_doc_city
where id is not null
and 

select * from t_doc_airport



select * from (
select
a.*,
(select c.id from t_doc_country c, t_version cv where c.f_version_id = cv.f_version_id and cv.f_actuality = 2 and cv.f_document_id = a.f_country and  a.f_country is not null) country,
(select c.id from t_doc_city c, t_version cv where c.f_version_id = cv.f_version_id and cv.f_actuality = 2 and cv.f_document_id = a.f_city and  a.f_city is not null) city_id,
(select c.geo_type from t_doc_city c, t_version cv where c.f_version_id = cv.f_version_id and cv.f_actuality = 2 and cv.f_document_id = a.f_city and  a.f_city is not null) city_type
from
t_doc_airport a,
t_version v
where 
a.f_version_id = v.f_version_id
and v.f_actuality = 2
)
where country is not null and city_id is not null


update t_doc_airport a set 
country_id = (select c.id from t_doc_country c, t_version cv where c.f_version_id = cv.f_version_id and cv.f_actuality = 2 and cv.f_document_id = a.f_country and  a.f_country is not null),
city_id = (select c.id from t_doc_city c, t_version cv where c.f_version_id = cv.f_version_id and cv.f_actuality = 2 and cv.f_document_id = a.f_city and  a.f_city is not null)
where f_version_id in 
(
  select
  a.f_version_id
  from
  t_doc_airport a,
  t_version v
  where 
  a.f_version_id = v.f_version_id
  and v.f_actuality = 2
);
commit;


declare
  v_geo_id number;
begin
  for i in (
  
    select  f_version_id from t_doc_airport 
    where f_version_id in 
    (
      select
      a.f_version_id
      from
      t_doc_airport a,
      t_version v
      where 
      a.f_version_id = v.f_version_id
      and v.f_actuality = 2
    )
  )
  loop
    select doc_seq.nextval into v_geo_id from dual;
  
    update t_doc_airport a set id = v_geo_id
    where f_version_id = i.f_version_id;
  
  end loop;
  commit;
end;




--32 без данных
--6 авиалиний



select convert('a','utf8','us7ascii') from dual;
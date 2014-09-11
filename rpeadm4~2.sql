select * from 
(
select 
name, object_type,
count(*) c
from  geo@dblntg where parent_Id in
(
select id from geo@dblntg where is_active = 'A' and object_type = 'country' 
)
and name != 'Primary'
group by name, object_type
)
order by c desc


select * from


select * from   geo@dblntg
where name in (
'Watertown',
'Waterloo',
'City County',
'Santa Cruz',
'Pointe Noire',
'Stolport',
'Patenga',
'Civil',
'Esperance',
'Rio Grande',
'Futuna Island',
'Sinop',
'San Julian',
'Santa Rosa'
)

and parent_Id in
(
select id from geo@dblntg where is_active = 'A' and object_type = 'country' 
)
order by name


select * from t_doc_airport@dbltagan where id in
  (select id from   geo@dblntg
  where name in (
  'Watertown',
  'Waterloo',
  'City County',
  'Santa Cruz',
  'Pointe Noire',
  'Stolport',
  'Patenga',
  'Civil',
  'Esperance',
  'Rio Grande',
  'Futuna Island',
  'Sinop',
  'San Julian',
  'Santa Rosa'
  )
  and parent_Id in
  (
  select id from geo@dblntg where is_active = 'A' and object_type = 'country' 
  )
--  order by name
)
order by f_name_en


select * from GEO@dblntg
select * from GEO@dblntg
where code in ('CD','CG')


where id in (135,137)
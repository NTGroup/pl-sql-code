/* troubles1 */
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

/* troubles2*/
select
*
from  GEO@dblntg
where parent_id in (
      /*region*/
      select 
      id
      from  GEO@dblntg
      where object_type = 'region'
      and is_active = 'Y'
      and parent_id in (
            /* country */
            select id
            from  GEO@dblntg
            where object_type = 'country'
            and is_active = 'Y'
      )
)
and iata is not null

group by name
order by 2 desc

and name in ('Noginsk','Blagoveschensk','Dudinka','Zelenogorsk','Kirovsk','Zapolyarny','Mezhdurechensky','Sosnovka','Severnyj','Cheremshanka','Novyj Urengoj','Zheleznogorsk','Krasnoarmejjsk','Bely Yar','Snezhnogorsk','Sosnovy Bor','Svetlogorsk','Yartsevo','Nakhodka','Tarko-Sale','Bor','Tura','Oktiabrskij','Nojabrxsk','Belogorje','Bykovo','Olenegorsk','Nizhnevartovsk')
order by 3 desc, object_type



/*country*/
select * 
from  GEO@dblntg
where object_type = 'country'
and is_active = 'A'

/*region*/
select 
*
from  GEO@dblntg
where object_type = 'region'
and is_active = 'Y'
and parent_id in (
      /* country */
      select id
      from  GEO@dblntg
      where object_type = 'country'
      and is_active = 'Y'
)


/*city */
select
*
from  GEO@dblntg
where parent_id in (
      /*region*/
      select 
      id
      from  GEO@dblntg
      where object_type = 'region'
      and is_active = 'Y'
      and parent_id in (
            /* country */
            select id
            from  GEO@dblntg
            where object_type = 'country'
            and is_active = 'Y'
      )
)
and  is_active in ('W','Y')


/* airport */
select
distinct object_type
from  GEO@dblntg
where parent_id in (
/*city */
    select
    id
    from  GEO@dblntg
    where parent_id in (
          /*region*/
          select 
          id
          from  GEO@dblntg
          where object_type = 'region'
          and is_active = 'Y'
          and parent_id in (
                /* country */
                select id
                from  GEO@dblntg
                where object_type = 'country'
                and is_active = 'Y'
          )
    )
    and  is_active in ('W','Y')

)




/* UPDATE BLOCK */
declare
begin
  for i in (
      select
      *
      from  GEO@dblntg
      where id in (10729)
  )
  loop
    update GEO@dblntg set is_active = 'N' where id = i.id;
  end loop;
commit;
end;




/* UPDATE BY ID */
UPDATE GEO@dblntg SET is_active = 'N' WHERE ID = 21663
; COMMIT;

/*COUNTRY BY ID*/
select *
from  GEO@dblntg
where object_type = 'country'
AND ID IN (148)



/*tree*/
select 
id,
lpad(' ',2*(level-1)) || to_char(nls_name) s, 
lpad(' ',2*(level-1)) || to_char(name) s, 
geo.object_type, iata
from GEO@dblntg
where is_active = 'Y'
start with parent_id = -1
connect by prior id = parent_id;


/* airport */
select
*
from  GEO@dblntg
where parent_id in (
    /*city */
    select
    id
    from  GEO@dblntg
    where parent_id in (
          /*region*/
          select 
          id
          from  GEO@dblntg
          where object_type = 'region'
          and is_active = 'Y'
          and parent_id in (
                /* country */
                select id
                from  GEO@dblntg
                where object_type = 'country'
                and is_active = 'Y'
          )
    )
    and  is_active in ('W','Y')
)
and is_active is not null





/* ниже чем airport */
select
*
from  GEO@dblntg
where parent_id in (

      /* airport */
      select
      id
      from  GEO@dblntg
      where parent_id in (
          /*city */
          select
          id
          from  GEO@dblntg
          where parent_id in (
                /*region*/
                select 
                id
                from  GEO@dblntg
                where object_type = 'region'
                and is_active = 'Y'
                and parent_id in (
                      /* country */
                      select id
                      from  GEO@dblntg
                      where object_type = 'country'
                      and is_active = 'Y'
                )
          )
          and  is_active in ('W','Y')
      )
      and is_active is not null

)

select
*
from  GEO@dblntg
where object_type = 'airport real'
and is_active is not null
and is_active ='Y'
and iata is null 


select * from geo

alter table geo add (primary key on id)

ALTER TABLE geo
ADD CONSTRAINT geo_pk PRIMARY KEY (id);




commit;




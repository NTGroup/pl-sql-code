select * from t_document@dblctagan
select * from C##TAGAN.T_DOC_AIRLINE--@dblctagan



select id from (
select distinct airline.f_name_en ,
MAX(v.F_VERSION_ID) KEEP (DENSE_RANK LAST ORDER BY v.f_date) OVER (PARTITION BY airline.f_name_en) ID
from C##TAGAN.T_DOC_AIRLINE airline,
C##TAGAN.T_version v
where
v.f_version_id = airline.f_version_id
and v.f_actuality=2
--and F_NAME_EN='Air Berlin';
)

/
select *
from C##TAGAN.T_DOC_AIRLINE airline,
C##TAGAN.T_version v
where
v.f_version_id = airline.f_version_id
and v.f_actuality=2
and F_NAME_EN='Air Berlin'
and id is not null

select 
F_iata iata,
F_CRT crt, F_ACCOUNTING_CODE iata_n,F_IKAO_CODE ikao, F_NAME_EN name, F_NAME_RU nls_name,
F_INCLUDED_TO_AMADEUS is_amadeus_included,  F_INCLUDED_TO_SIRENA2000 is_sirena2000_included, F_ENABLE_AUTO_ISSUE is_auto_issue_enable,
F_INCLUDED_TO_SABRE is_sabre_included
from (
select * from C##TAGAN.T_DOC_AIRLINE airline
where
/*f_NAME_EN='Air Berlin'
and*/ id is not null
order by F_ACCOUNTING_CODE
)


select * from C##TAGAN.T_DOC_AIRLINE
where F_NAME_EN='Air Berlin'

declare
  v_geo_id number;
begin
  for i in (
  

      select id from (
        select distinct airline.f_name_en ,
        MAX(v.F_VERSION_ID) KEEP (DENSE_RANK LAST ORDER BY v.f_date) OVER (PARTITION BY airline.f_name_en) ID
        from C##TAGAN.T_DOC_AIRLINE airline,
        C##TAGAN.T_version v
        where
        v.f_version_id = airline.f_version_id
        and v.f_actuality=2
        --and F_NAME_EN='Air Berlin';
      )
  )
  loop
    select doc_seq.nextval into v_geo_id from dual;
  
    update t_doc_airline a set id = v_geo_id
    where f_version_id = i.id;
  
  end loop;
  commit;
end;




select 
F_NAME_EN name, 
F_NAME_RU nls_name,
F_iata iata,
F_CRT crt, 
F_ACCOUNTING_CODE iata_n,
F_IKAO_CODE ikao, 
F_INCLUDED_TO_SABRE is_sabre_included,
F_INCLUDED_TO_AMADEUS is_amadeus_included,  
F_INCLUDED_TO_SIRENA2000 is_sirena2000_included, 
F_ENABLE_AUTO_ISSUE is_auto_issue_enable,
id t_doc_id
from (
select * from T_DOC_AIRLINE@dblctagan airline
where
/*f_NAME_EN='Air Berlin'
and*/ id is not null
--order by F_ACCOUNTING_CODE
)




begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE airline 
   (	
   ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
name VARCHAR2(255), 
 nls_name VARCHAR2(255),
 iata VARCHAR2(10),
 crt VARCHAR2(10), 
iata_n  VARCHAR2(10),
ikao VARCHAR2(10), 
is_sabre_included number,
 is_amadeus_included number,  
 is_sirena2000_included number, 
 is_auto_issue_enable number,
 t_doc_id	 number, 
   status VARCHAR2(1)
   
   
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX AL_ID_IDX ON airline (ID) 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE airline MODIFY ("ID" CONSTRAINT "AL_ID_NN" NOT NULL ENABLE);

  ALTER TABLE airline ADD CONSTRAINT AL_ID_PK PRIMARY KEY (ID)
  USING INDEX AL_ID_IDX ENABLE;

/*  ALTER TABLE "BLNG"."M_TRANSACTION" ADD CONSTRAINT "MTR_DOC_OID_FK" FOREIGN KEY ("ID")
  REFERENCES "BLNG"."DOC" ("ID") ENABLE;
*/

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  al_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER al_TRGR 
BEFORE
INSERT
ON airline
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select al_seq.nextval into :new.id from dual; 
end;

ALTER TRIGGER al_TRGR ENABLE;

end;


select sysdate from dual;

insert into airline
select 
null,
sysdate, 
user, 
'A' q, 
null,
F_NAME_EN name, 
F_NAME_RU nls_name,
F_iata iata,
F_CRT crt, 
F_ACCOUNTING_CODE iata_n,
F_IKAO_CODE ikao, 
F_INCLUDED_TO_SABRE is_sabre_included,
F_INCLUDED_TO_AMADEUS is_amadeus_included,  
F_INCLUDED_TO_SIRENA2000 is_sirena2000_included, 
F_ENABLE_AUTO_ISSUE is_auto_issue_enable,
id t_doc_id,
'A'

from (
select * from T_DOC_AIRLINE@dblctagan airline
where
/*f_NAME_EN='Air Berlin'
and*/ id is not null
--order by F_ACCOUNTING_CODE
)
;
commit;


select * from markup

update markup set VALIDATING_CARRIER=null;
commit;


select * from v_markup;



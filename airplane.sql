select * from t_document@dblctagan
select * from C##TAGAN.T_DOC_AIRLINE--@dblctagan



declare
  v_geo_id number;
begin
  for i in (
  
    select  f_version_id from t_doc_airplane 
    where f_version_id in 
    (
      select 
      a.f_version_id
      from 
      t_doc_airplane a,
      t_version v
      where v.f_version_id = a.f_version_id
      and f_actuality=2
    )
  )
  loop
    select doc_seq.nextval into v_geo_id from dual;
  
    update t_doc_airplane a set id = v_geo_id
    where f_version_id = i.f_version_id;
  
  end loop;
  commit;
end;



      select 
        *
      from 
      t_doc_airplane a
      where id is not null
      



      

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




/* airplane */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ntg.airplane
   (	   ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
  name VARCHAR2(255), 
 nls_name VARCHAR2(255),
 code VARCHAR2(10),
 code_nls VARCHAR2(10),
 ru number(1,0),
 t_doc_id	 number
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ntg.AP_ID_IDX ON ntg.airplane ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ntg.airplane MODIFY ("ID" CONSTRAINT AP_ID_NN NOT NULL ENABLE);
  ALTER TABLE ntg.airplane MODIFY (AMND_DATE CONSTRAINT "AP_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.airplane MODIFY (AMND_USER CONSTRAINT "AP_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ntg.airplane MODIFY (AMND_STATE CONSTRAINT "AP_AST_NN" NOT NULL ENABLE);
ALTER TABLE ntg.airplane  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ntg.airplane  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ntg.airplane  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ntg.airplane ADD CONSTRAINT AP_ID_PK PRIMARY KEY (ID)
  USING INDEX ntg.AP_ID_IDX ENABLE;


/*
ALTER TABLE ntg.airplane ADD CONSTRAINT AP_ETT_OID_FK FOREIGN KEY (event_type_oid)
  REFERENCES BLNG.event_type ("ID") ENABLE;
ALTER TABLE ntg.airplane ADD CONSTRAINT AP_TRN_OID_FK FOREIGN KEY (transaction_oid)
  REFERENCES BLNG.transaction ("ID") ENABLE;
ALTER TABLE ntg.airplane ADD CONSTRAINT AP_CNTR_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract ("ID") ENABLE;
*/

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ntg.AP_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ntg.AP_TRGR 
BEFORE
INSERT
ON ntg.airplane
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select ntg.AP_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER ntg.AP_TRGR ENABLE;

end;



select * from AIRPLANE

select sysdate from dual;

insert into airplane
select 
null,
sysdate, 
user, 
'A' q, 
null,
F_NAME_EN name, 
F_NAME_RU nls_name,
F_code_en iata,
F_code_ru crt, 
f_ru iata_n,
id is_sabre_included
from (
select * from T_DOC_AIRplane@dblctagan airline
where
 id is not null

)
;
commit;


select * from AIRPLANE
where name in (
'Boeing 737-700',
'Airbus A310',
'Boeing 737-800',
'Boeing 737-400',
'Boeing 737-300',
'Boeing 747-400',
'British Aerospace 146'
)
order by name


--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.pos_rule 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   contract_OID NUMBER(18,0),
   airline_OID NUMBER(18,0),
   booking_pos varchar2(10),
   ticketing_pos  varchar2(10),
   stock VARCHAR2(10),
   printer VARCHAR2(10)  
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.posr_ID_IDX ON ord.pos_rule ("ID") 
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.pos_rule MODIFY ("ID" CONSTRAINT posr_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.pos_rule MODIFY (AMND_DATE CONSTRAINT "posr_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.pos_rule MODIFY (AMND_USER CONSTRAINT "posr_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.pos_rule MODIFY (AMND_STATE CONSTRAINT "posr_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.pos_rule  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.pos_rule  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.pos_rule  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.pos_rule ADD CONSTRAINT posr_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.posr_ID_IDX ENABLE;
 
 
  

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.posr_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.posr_TRGR 
BEFORE
INSERT
ON ord.pos_rule
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select posr_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.posr_TRGR ENABLE;

drop TRIGGER ord.isr_TRGR;
drop sequence ORD.isr_SEQ;
drop TABLE ord.issue_rule ;
drop INDEX ord.isr_ID_IDX;

INSERT INTO "BLNG"."COMPANY" (ID, AMND_PREV, NAME, STATUS, UTC_OFFSET) VALUES ('0', '0', 'default', 'A', '3');
INSERT INTO "BLNG"."CONTRACT" (ID, AMND_PREV, CONTRACT_NUMBER, STATUS, COMPANY_OID, UTC_OFFSET) VALUES ('0', '0', 'default', 'A', '0', '3');
commit;




grant select on ord.bill to blng;
grant select on ord.ord to blng;
grant select on ord.ticket to blng;
grant select on ord.item_avia to blng;
grant select on ord.item_avia_status to blng;
grant select on ord.commission to blng;
grant select on ord.commission_details to blng;
grant select on ord.commission_template to blng;
grant select on ord.pos_rule to blng;

grant select on ord.bill to ntg;
grant select on ord.ord to ntg;
grant select on ord.ticket to ntg;
grant select on ord.item_avia to ntg;
grant select on ord.item_avia_status to ntg;
grant select on ord.commission to ntg;
grant select on ord.commission_details to ntg;
grant select on ord.commission_template to ntg;
grant select on ord.pos_rule to ntg;

--Foreign keys between tables in different schemas
grant references on ord.bill to blng;
grant references on ord.ord to blng;
grant references on ord.ticket to blng;
grant references on ord.item_avia to blng;
grant references on ord.item_avia_status to blng;
grant references on ord.commission to blng;
grant references on ord.commission_details to blng;
grant references on ord.commission_template to blng;
grant references on ord.pos_rule to blng;

grant references on ord.bill to ntg;
grant references on ord.ord to ntg;
grant references on ord.ticket to ntg;
grant references on ord.item_avia to ntg;
grant references on ord.item_avia_status to ntg;
grant references on ord.commission to ntg;
grant references on ord.commission_details to ntg;
grant references on ord.commission_template to ntg;
grant references on ord.pos_rule to ntg;



  ALTER TABLE ord.pos_rule ADD CONSTRAINT posr_cntr_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES blng.contract ("ID") ENABLE;

  ALTER TABLE ord.pos_rule ADD CONSTRAINT posr_al_OID_FK FOREIGN KEY (airline_oid)
  REFERENCES ntg.airline ("ID") ENABLE;




@metadata/view.sql;
@data/pkg/blng.blng_api.sql;
@data/pkg/blng.core.sql;
@data/pkg/blng.fwdr.sql;
@data/pkg/ntg.ntg_api.sql;
@data/pkg/ntg.fwdr.sql;
@data/pkg/ntg.log_api.sql;
@data/pkg/ntg.dtype.sql;
@data/pkg/ord.ord_api.sql;
@data/pkg/ord.core.sql;
@data/pkg/ord.fwdr.sql;


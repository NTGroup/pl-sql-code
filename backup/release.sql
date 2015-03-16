
--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.issue_rule 
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

  CREATE INDEX ord.isr_ID_IDX ON ord.issue_rule ("ID") 
  TABLESPACE "USERS" ;
  

  ALTER TABLE ord.issue_rule MODIFY ("ID" CONSTRAINT isr_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.issue_rule MODIFY (AMND_DATE CONSTRAINT "isr_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.issue_rule MODIFY (AMND_USER CONSTRAINT "isr_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.issue_rule MODIFY (AMND_STATE CONSTRAINT "isr_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.issue_rule  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.issue_rule  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.issue_rule  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.issue_rule ADD CONSTRAINT isr_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.isr_ID_IDX ENABLE;
 

  create sequence  ORD.isr_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;


CREATE OR REPLACE EDITIONABLE TRIGGER ord.isr_TRGR 
BEFORE
INSERT
ON ord.issue_rule
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select isr_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.isr_TRGR ENABLE;



-- as system


grant select on ntg.airline to ord;
grant select on ntg.airplane to ord;
grant select on ntg.geo to ord;
grant select on ntg.markup to ord;
grant select on ntg.gds_nationality to ord;
grant select on ntg.airline to blng;
grant select on ntg.airplane to blng;
grant select on ntg.geo to blng;
grant select on ntg.markup to blng;
grant select on ntg.gds_nationality to blng;

grant select on blng.contract to ord;
grant select on blng.client to ord;
grant select on blng.company to ord;
grant select on blng.domain to ord;
grant select on blng.client2contract to ord;
grant select on blng.client_data to ord;
grant select on blng.account to ord;
grant select on blng.document to ord;
grant select on blng.transaction to ord;
grant select on blng.delay to ord;
grant select on blng.event to ord;
grant select on blng.account_type to ord;
grant select on blng.status_type to ord;
grant select on blng.trans_type to ord;
grant select on blng.event_type to ord;

grant select on blng.contract to ntg;
grant select on blng.client to ntg;
grant select on blng.company to ntg;
grant select on blng.domain to ntg;
grant select on blng.client2contract to ntg;
grant select on blng.client_data to ntg;
grant select on blng.account to ntg;
grant select on blng.document to ntg;
grant select on blng.transaction to ntg;
grant select on blng.delay to ntg;
grant select on blng.event to ntg;
grant select on blng.account_type to ntg;
grant select on blng.status_type to ntg;
grant select on blng.trans_type to ntg;
grant select on blng.event_type to ntg;

grant select on ord.bill to blng;
grant select on ord.ord to blng;
grant select on ord.ticket to blng;
grant select on ord.item_avia to blng;
grant select on ord.item_avia_status to blng;
grant select on ord.commission to blng;
grant select on ord.commission_details to blng;
grant select on ord.commission_template to blng;
grant select on ord.issue_rule to blng;

grant select on ord.bill to ntg;
grant select on ord.ord to ntg;
grant select on ord.ticket to ntg;
grant select on ord.item_avia to ntg;
grant select on ord.item_avia_status to ntg;
grant select on ord.commission to ntg;
grant select on ord.commission_details to ntg;
grant select on ord.commission_template to ntg;
grant select on ord.issue_rule to ntg;



grant references on ntg.airline to ord;
grant references on ntg.airplane to ord;
grant references on ntg.geo to ord;
grant references on ntg.markup to ord;
grant references on ntg.gds_nationality to ord;
grant references on ntg.airline to blng;
grant references on ntg.airplane to blng;
grant references on ntg.geo to blng;
grant references on ntg.markup to blng;
grant references on ntg.gds_nationality to blng;

grant references on blng.contract to ord;
grant references on blng.client to ord;
grant references on blng.company to ord;
grant references on blng.domain to ord;
grant references on blng.client2contract to ord;
grant references on blng.client_data to ord;
grant references on blng.account to ord;
grant references on blng.document to ord;
grant references on blng.transaction to ord;
grant references on blng.delay to ord;
grant references on blng.event to ord;
grant references on blng.account_type to ord;
grant references on blng.status_type to ord;
grant references on blng.trans_type to ord;
grant references on blng.event_type to ord;

grant references on blng.contract to ntg;
grant references on blng.client to ntg;
grant references on blng.company to ntg;
grant references on blng.domain to ntg;
grant references on blng.client2contract to ntg;
grant references on blng.client_data to ntg;
grant references on blng.account to ntg;
grant references on blng.document to ntg;
grant references on blng.transaction to ntg;
grant references on blng.delay to ntg;
grant references on blng.event to ntg;
grant references on blng.account_type to ntg;
grant references on blng.status_type to ntg;
grant references on blng.trans_type to ntg;
grant references on blng.event_type to ntg;

grant references on ord.bill to blng;
grant references on ord.ord to blng;
grant references on ord.ticket to blng;
grant references on ord.item_avia to blng;
grant references on ord.item_avia_status to blng;
grant references on ord.commission to blng;
grant references on ord.commission_details to blng;
grant references on ord.commission_template to blng;
grant references on ord.issue_rule to blng;

grant references on ord.bill to ntg;
grant references on ord.ord to ntg;
grant references on ord.ticket to ntg;
grant references on ord.item_avia to ntg;
grant references on ord.item_avia_status to ntg;
grant references on ord.commission to ntg;
grant references on ord.commission_details to ntg;
grant references on ord.commission_template to ntg;
grant references on ord.issue_rule to ntg;


ALTER TABLE ord.issue_rule ADD CONSTRAINT isr_cntr_OID_FK FOREIGN KEY (contract_oid)
REFERENCES blng.contract ("ID") ENABLE;

ALTER TABLE ord.issue_rule ADD CONSTRAINT isr_al_OID_FK FOREIGN KEY (airline_oid)
REFERENCES ntg.airline ("ID") ENABLE;


drop VIEW "ORD"."V_COMMISSION_BAK"
drop view ntg.v_markup;


ALTER TABLE ORD.ticket RENAME COLUMN PNR_OID TO item_avia_oid;

ALTER TABLE ORD.ticket add pnr_locator varchar2(10);
ALTER TABLE ORD.ticket add ticket_number varchar2(50);
ALTER TABLE ORD.ticket add passenger_name varchar2(255);
ALTER TABLE ORD.ticket add passenger_type varchar2(10);
ALTER TABLE ORD.ticket add fare_amount number(20,2);
ALTER TABLE ORD.ticket add taxes_amount number(20,2);
ALTER TABLE ORD.ticket add service_fee_amount number(20,2);

ALTER TABLE ord.ticket drop CONSTRAINT tkt_pnr_OID_FK;

 ALTER TABLE ord.ticket ADD CONSTRAINT tkt_iav_OID_FK FOREIGN KEY (item_avia_oid)
  REFERENCES ord.item_avia ("ID") ENABLE;
  
CREATE bitmap INDEX ord.tkt_AS_IDX ON ord.ticket (amnd_state) TABLESPACE "USERS" ;


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


/* ord */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.ord 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   order_date date,
   order_number varchar2(50),
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.ord_ID_IDX ON ord.ord ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.ord MODIFY ("ID" CONSTRAINT ord_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.ord MODIFY (AMND_DATE CONSTRAINT "ord_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.ord MODIFY (AMND_USER CONSTRAINT "ord_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.ord MODIFY (AMND_STATE CONSTRAINT "ord_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.ord  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.ord  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.ord  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.ord ADD CONSTRAINT ord_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.ord_ID_IDX ENABLE;
  
   
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ord.ord_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.ord_TRGR 
BEFORE
INSERT
ON ord.ord
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select ORD_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER ord.ord_TRGR ENABLE;

end;



/* bill */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.bill 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   order_oid NUMBER(18,0), 
   amount NUMBER(23,2), 
   bill_date NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.bill_ID_IDX ON ord.bill ("ID") 
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.bill MODIFY ("ID" CONSTRAINT bill_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.bill MODIFY (AMND_DATE CONSTRAINT "bill_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.bill MODIFY (AMND_USER CONSTRAINT "bill_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.bill MODIFY (AMND_STATE CONSTRAINT "bill_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.bill  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.bill  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.bill  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.bill ADD CONSTRAINT bill_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.bill_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.bill ADD CONSTRAINT bill_ord_OID_FK FOREIGN KEY (order_oid)
  REFERENCES ord.ord ("ID") ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ord.bill_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.bill_TRGR 
BEFORE
INSERT
ON ord.bill
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select bill_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.bill_TRGR ENABLE;

alter table blng.document 
add bill_oid number(18,0);

grant references on  ord.bill TO blng;

  ALTER TABLE blng.document ADD CONSTRAINT doc_bill_OID_FK FOREIGN KEY (bill_oid)
  REFERENCES ord.bill ("ID") ENABLE;
end;



/* item_avia */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.item_avia 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   order_oid NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.iav_ID_IDX ON ord.item_avia ("ID") 
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.item_avia MODIFY ("ID" CONSTRAINT iav_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.item_avia MODIFY (AMND_DATE CONSTRAINT "iav_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.item_avia MODIFY (AMND_USER CONSTRAINT "iav_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.item_avia MODIFY (AMND_STATE CONSTRAINT "iav_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.item_avia  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.item_avia  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.item_avia  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.item_avia ADD CONSTRAINT iav_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.iav_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.item_avia ADD CONSTRAINT iav_ord_OID_FK FOREIGN KEY (order_oid)
  REFERENCES ord.ord ("ID") ENABLE;
 

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.iav_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.iav_TRGR 
BEFORE
INSERT
ON ord.item_avia
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select iav_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.iav_TRGR ENABLE;

end; 



/* item_hotel */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.item_hotel 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   order_oid NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.ihtl_ID_IDX ON ord.item_hotel ("ID") 
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.item_hotel MODIFY ("ID" CONSTRAINT ihtl_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.item_hotel MODIFY (AMND_DATE CONSTRAINT "ihtl_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.item_hotel MODIFY (AMND_USER CONSTRAINT "ihtl_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.item_hotel MODIFY (AMND_STATE CONSTRAINT "ihtl_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.item_hotel  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.item_hotel  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.item_hotel  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.item_hotel ADD CONSTRAINT ihtl_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.ihtl_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.item_hotel ADD CONSTRAINT ihtl_ord_OID_FK FOREIGN KEY (order_oid)
  REFERENCES ord.ord ("ID") ENABLE;
  
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.ihtl_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.ihtl_TRGR 
BEFORE
INSERT
ON ord.item_hotel
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select ihtl_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.ihtl_TRGR ENABLE;

end; 


/* item_insurance */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.item_insurance
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   order_oid NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.iins_ID_IDX ON ord.item_insurance ("ID") 
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.item_insurance MODIFY ("ID" CONSTRAINT iins_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.item_insurance MODIFY (AMND_DATE CONSTRAINT "iins_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.item_insurance MODIFY (AMND_USER CONSTRAINT "iins_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.item_insurance MODIFY (AMND_STATE CONSTRAINT "iins_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.item_insurance  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.item_insurance  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.item_insurance  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.item_insurance ADD CONSTRAINT iins_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.iins_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.item_insurance ADD CONSTRAINT iins_ord_OID_FK FOREIGN KEY (order_oid)
  REFERENCES ord.ord ("ID") ENABLE;
  
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.iins_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.iins_TRGR 
BEFORE
INSERT
ON ord.item_insurance
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select iins_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.iins_TRGR ENABLE;

end; 



/* pnr */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.pnr
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   item_avia_oid NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.pnr_ID_IDX ON ord.pnr ("ID") 
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.pnr MODIFY ("ID" CONSTRAINT pnr_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.pnr MODIFY (AMND_DATE CONSTRAINT "pnr_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.pnr MODIFY (AMND_USER CONSTRAINT "pnr_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.pnr MODIFY (AMND_STATE CONSTRAINT "pnr_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.pnr  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.pnr  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.pnr  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.pnr ADD CONSTRAINT pnr_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.pnr_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.pnr ADD CONSTRAINT pnr_iav_OID_FK FOREIGN KEY (item_avia_oid)
  REFERENCES ord.item_avia ("ID") ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.pnr_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.pnr_TRGR 
BEFORE
INSERT
ON ord.pnr
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select pnr_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.pnr_TRGR ENABLE;

end; 



/* ticket */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.ticket
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   pnr_oid NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.tkt_ID_IDX ON ord.ticket ("ID") 
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.ticket MODIFY ("ID" CONSTRAINT tkt_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.ticket MODIFY (AMND_DATE CONSTRAINT "tkt_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.ticket MODIFY (AMND_USER CONSTRAINT "tkt_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.ticket MODIFY (AMND_STATE CONSTRAINT "tkt_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.ticket  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.ticket  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.ticket  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.ticket ADD CONSTRAINT tkt_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.tkt_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.ticket ADD CONSTRAINT tkt_pnr_OID_FK FOREIGN KEY (pnr_oid)
  REFERENCES ord.pnr ("ID") ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.tkt_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.tkt_TRGR 
BEFORE
INSERT
ON ord.ticket
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select tkt_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.tkt_TRGR ENABLE;

end; 

/* price_quote */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.price_quote
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   pnr_oid NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.pq_ID_IDX ON ord.price_quote ("ID") 
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.price_quote MODIFY ("ID" CONSTRAINT pq_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.price_quote MODIFY (AMND_DATE CONSTRAINT "pq_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.price_quote MODIFY (AMND_USER CONSTRAINT "pq_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.price_quote MODIFY (AMND_STATE CONSTRAINT "pq_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.price_quote  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.price_quote  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.price_quote  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.price_quote ADD CONSTRAINT pq_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.pq_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.price_quote ADD CONSTRAINT pq_pnr_OID_FK FOREIGN KEY (pnr_oid)
  REFERENCES ord.pnr ("ID") ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.pq_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.pq_TRGR 
BEFORE
INSERT
ON ord.price_quote
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select pq_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.pq_TRGR ENABLE;

end; 



/* passenger */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.passenger
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   pnr_oid NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.pax_ID_IDX ON ord.passenger ("ID") 
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.passenger MODIFY ("ID" CONSTRAINT pax_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.passenger MODIFY (AMND_DATE CONSTRAINT "pax_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.passenger MODIFY (AMND_USER CONSTRAINT "pax_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.passenger MODIFY (AMND_STATE CONSTRAINT "pax_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.passenger  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.passenger  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.passenger  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.passenger ADD CONSTRAINT pax_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.pax_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.passenger ADD CONSTRAINT pax_pnr_OID_FK FOREIGN KEY (pnr_oid)
  REFERENCES ord.pnr ("ID") ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.pax_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.pax_TRGR 
BEFORE
INSERT
ON ord.passenger
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select pax_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.pax_TRGR ENABLE;

end; 



/* itinerary */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.itinerary
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   pnr_oid NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.itin_ID_IDX ON ord.itinerary ("ID") 
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.itinerary MODIFY ("ID" CONSTRAINT itin_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.itinerary MODIFY (AMND_DATE CONSTRAINT "itin_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.itinerary MODIFY (AMND_USER CONSTRAINT "itin_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.itinerary MODIFY (AMND_STATE CONSTRAINT "itin_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.itinerary  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.itinerary  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.itinerary  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.itinerary ADD CONSTRAINT itin_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.itin_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.itinerary ADD CONSTRAINT itin_pnr_OID_FK FOREIGN KEY (pnr_oid)
  REFERENCES ord.pnr ("ID") ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.itin_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.itin_TRGR 
BEFORE
INSERT
ON ord.itinerary
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select itin_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.itin_TRGR ENABLE;

end; 





/* leg */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.leg
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   itinerary_oid NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.leg_ID_IDX ON ord.leg ("ID") 
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.leg MODIFY ("ID" CONSTRAINT leg_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.leg MODIFY (AMND_DATE CONSTRAINT "leg_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.leg MODIFY (AMND_USER CONSTRAINT "leg_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.leg MODIFY (AMND_STATE CONSTRAINT "leg_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.leg  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.leg  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.leg  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.leg ADD CONSTRAINT leg_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.leg_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.leg ADD CONSTRAINT leg_itin_OID_FK FOREIGN KEY (itinerary_oid)
  REFERENCES ord.itinerary ("ID") ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.leg_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.leg_TRGR 
BEFORE
INSERT
ON ord.leg
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select leg_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.leg_TRGR ENABLE;

end; 



/* segment */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.segment
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   leg_oid NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.sgm_ID_IDX ON ord.segment ("ID") 
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.segment MODIFY ("ID" CONSTRAINT sgm_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.segment MODIFY (AMND_DATE CONSTRAINT "sgm_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.segment MODIFY (AMND_USER CONSTRAINT "sgm_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.segment MODIFY (AMND_STATE CONSTRAINT "sgm_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.segment  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.segment  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.segment  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.segment ADD CONSTRAINT sgm_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.sgm_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.segment ADD CONSTRAINT sgm_leg_oid_FK FOREIGN KEY (leg_oid)
  REFERENCES ord.leg ("ID") ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.sgm_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.sgm_TRGR 
BEFORE
INSERT
ON ord.segment
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select sgm_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.sgm_TRGR ENABLE;

end; 



/* stop */
begin

--------------------------------------------------------
--  DDL for Table MARKUP
--------------------------------------------------------

  CREATE TABLE ord.flight_stop
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   segment_oid NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.stop_ID_IDX ON ord.flight_stop ("ID") 
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
--  Constraints for Table MARKUP
--------------------------------------------------------

  ALTER TABLE ord.flight_stop MODIFY ("ID" CONSTRAINT stop_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.flight_stop MODIFY (AMND_DATE CONSTRAINT "stop_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE ord.flight_stop MODIFY (AMND_USER CONSTRAINT "stop_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE ord.flight_stop MODIFY (AMND_STATE CONSTRAINT "stop_AST_NN" NOT NULL ENABLE);
ALTER TABLE ord.flight_stop  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.flight_stop  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.flight_stop  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.flight_stop ADD CONSTRAINT stop_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.stop_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.flight_stop ADD CONSTRAINT stop_sgm_oid_FK FOREIGN KEY (segment_oid)
  REFERENCES ord.segment ("ID") ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.stop_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.stop_TRGR 
BEFORE
INSERT
ON ord.flight_stop
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select stop_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.stop_TRGR ENABLE;

end; 


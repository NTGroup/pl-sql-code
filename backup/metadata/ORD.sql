
/* ord */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ord.ord 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   order_date date,
   order_number varchar2(50),
   status VARCHAR2(1),
   user_oid number(18,0)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.ord_ID_IDX ON ord.ord (ID) 
  TABLESPACE USERS ;
--------------------------------------------------------
--  Constraints for Table
--------------------------------------------------------

  ALTER TABLE ord.ord MODIFY (ID CONSTRAINT ord_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.ord MODIFY (AMND_DATE CONSTRAINT ord_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.ord MODIFY (AMND_USER CONSTRAINT ord_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.ord MODIFY (AMND_STATE CONSTRAINT ord_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.ord  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.ord  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.ord  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.ord ADD CONSTRAINT ord_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.ord_ID_IDX ENABLE;
  

  
  ALTER TABLE ord.ord ADD CONSTRAINT bill_usr_OID_FK FOREIGN KEY (user_oid)
  REFERENCES blng.usr (ID) ENABLE;
   
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

/

/* bill */

--------------------------------------------------------
--  DDL for Table
--------------------------------------------------------

  CREATE TABLE ord.bill 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   order_oid NUMBER(18,0), 
   amount NUMBER(20,2),
   bill_date date,
   status VARCHAR2(1),
   contract_oid NUMBER(18,0), 
   bill_oid NUMBER(18,0), 
   trans_type_oid NUMBER(18,0),
   vat_type_oid NUMBER(18,0)
   
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.bill_ID_IDX ON ord.bill (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.bill MODIFY (ID CONSTRAINT bill_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.bill MODIFY (AMND_DATE CONSTRAINT bill_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.bill MODIFY (AMND_USER CONSTRAINT bill_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.bill MODIFY (AMND_STATE CONSTRAINT bill_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.bill  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.bill  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.bill  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.bill ADD CONSTRAINT bill_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.bill_ID_IDX ENABLE;
 
  grant references on  ord.bill TO blng;
 
  
  ALTER TABLE ord.bill ADD CONSTRAINT bill_ord_OID_FK FOREIGN KEY (order_oid)
  REFERENCES ord.ord (ID) ENABLE;

  ALTER TABLE ord.bill ADD CONSTRAINT bill_cntr_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES blng.contract (ID) ENABLE;
  
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



/

/* item_avia */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ord.item_avia 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
	ORDER_OID NUMBER(18,0), 
	STATUS VARCHAR2(1 BYTE), 
	PNR_LOCATOR VARCHAR2(50 BYTE), 
	TIME_LIMIT DATE, 
	TOTAL_AMOUNT NUMBER(20,2), 
	TOTAL_MARKUP NUMBER(20,2), 
	PNR_OBJECT CLOB, 
	pnr_id VARCHAR2(50 BYTE), 
	NQT_STATUS VARCHAR2(50 BYTE), 
	PO_STATUS VARCHAR2(50 BYTE), 
	NQT_STATUS_CUR VARCHAR2(50 BYTE)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.iav_ID_IDX ON ord.item_avia (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.item_avia MODIFY (ID CONSTRAINT iav_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.item_avia MODIFY (AMND_DATE CONSTRAINT iav_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.item_avia MODIFY (AMND_USER CONSTRAINT iav_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.item_avia MODIFY (AMND_STATE CONSTRAINT iav_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.item_avia  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.item_avia  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.item_avia  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.item_avia ADD CONSTRAINT iav_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.iav_ID_IDX ENABLE;
 
   ALTER TABLE ord.item_avia ADD CONSTRAINT iav_ensure_json CHECK (pnr_object IS JSON (STRICT));
  
  ALTER TABLE ord.item_avia ADD CONSTRAINT iav_ord_OID_FK FOREIGN KEY (order_oid)
  REFERENCES ord.ord (ID) ENABLE;
 

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

/


/* item_hotel */

/*
--------------------------------------------------------
--  DDL for Table 
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
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.ihtl_ID_IDX ON ord.item_hotel (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.item_hotel MODIFY (ID CONSTRAINT ihtl_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.item_hotel MODIFY (AMND_DATE CONSTRAINT ihtl_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.item_hotel MODIFY (AMND_USER CONSTRAINT ihtl_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.item_hotel MODIFY (AMND_STATE CONSTRAINT ihtl_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.item_hotel  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.item_hotel  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.item_hotel  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.item_hotel ADD CONSTRAINT ihtl_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.ihtl_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.item_hotel ADD CONSTRAINT ihtl_ord_OID_FK FOREIGN KEY (order_oid)
  REFERENCES ord.ord (ID) ENABLE;
  
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.ihtl_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache 
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
*/

/

/* item_insurance */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------
/*
  CREATE TABLE ord.item_insurance
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   order_oid NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.iins_ID_IDX ON ord.item_insurance (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.item_insurance MODIFY (ID CONSTRAINT iins_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.item_insurance MODIFY (AMND_DATE CONSTRAINT iins_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.item_insurance MODIFY (AMND_USER CONSTRAINT iins_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.item_insurance MODIFY (AMND_STATE CONSTRAINT iins_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.item_insurance  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.item_insurance  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.item_insurance  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.item_insurance ADD CONSTRAINT iins_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.iins_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.item_insurance ADD CONSTRAINT iins_ord_OID_FK FOREIGN KEY (order_oid)
  REFERENCES ord.ord (ID) ENABLE;
  
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.iins_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache 
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
*/

/


/* pnr */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------
/*
  CREATE TABLE ord.pnr
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   item_avia_oid NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.pnr_ID_IDX ON ord.pnr (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.pnr MODIFY (ID CONSTRAINT pnr_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.pnr MODIFY (AMND_DATE CONSTRAINT pnr_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.pnr MODIFY (AMND_USER CONSTRAINT pnr_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.pnr MODIFY (AMND_STATE CONSTRAINT pnr_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.pnr  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.pnr  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.pnr  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.pnr ADD CONSTRAINT pnr_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.pnr_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.pnr ADD CONSTRAINT pnr_iav_OID_FK FOREIGN KEY (item_avia_oid)
  REFERENCES ord.item_avia (ID) ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.pnr_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache 
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
*/

/

/* ticket */

  CREATE TABLE ord.ticket
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   item_avia_oid NUMBER(18,0), 
   status VARCHAR2(1),
    pnr_locator varchar2(10),
    ticket_number varchar2(50),
    passenger_name varchar2(255),
    passenger_type varchar2(10),
    fare_amount number(20,2),
    taxes_amount number(20,2),
    service_fee_amount number(20,2),
    partner_fee_amount number(20,2)   
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.tkt_ID_IDX ON ord.ticket (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.ticket MODIFY (ID CONSTRAINT tkt_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.ticket MODIFY (AMND_DATE CONSTRAINT tkt_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.ticket MODIFY (AMND_USER CONSTRAINT tkt_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.ticket MODIFY (AMND_STATE CONSTRAINT tkt_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.ticket  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.ticket  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.ticket  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.ticket ADD CONSTRAINT tkt_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.tkt_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.ticket ADD CONSTRAINT tkt_iav_OID_FK FOREIGN KEY (item_avia_oid)
  REFERENCES ord.item_avia (ID) ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.tkt_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache 
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

/

/* price_quote */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------
/*
  CREATE TABLE ord.price_quote
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   pnr_oid NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.pq_ID_IDX ON ord.price_quote (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.price_quote MODIFY (ID CONSTRAINT pq_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.price_quote MODIFY (AMND_DATE CONSTRAINT pq_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.price_quote MODIFY (AMND_USER CONSTRAINT pq_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.price_quote MODIFY (AMND_STATE CONSTRAINT pq_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.price_quote  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.price_quote  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.price_quote  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.price_quote ADD CONSTRAINT pq_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.pq_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.price_quote ADD CONSTRAINT pq_pnr_OID_FK FOREIGN KEY (pnr_oid)
  REFERENCES ord.pnr (ID) ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.pq_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache 
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
*/

/


/* passenger */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------
/*
  CREATE TABLE ord.passenger
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   pnr_oid NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.pax_ID_IDX ON ord.passenger (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.passenger MODIFY (ID CONSTRAINT pax_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.passenger MODIFY (AMND_DATE CONSTRAINT pax_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.passenger MODIFY (AMND_USER CONSTRAINT pax_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.passenger MODIFY (AMND_STATE CONSTRAINT pax_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.passenger  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.passenger  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.passenger  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.passenger ADD CONSTRAINT pax_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.pax_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.passenger ADD CONSTRAINT pax_pnr_OID_FK FOREIGN KEY (pnr_oid)
  REFERENCES ord.pnr (ID) ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.pax_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache 
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
*/


/

/* stop */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------
/*
  CREATE TABLE ord.flight_stop
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   segment_oid NUMBER(18,0), 
   status VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.stop_ID_IDX ON ord.flight_stop (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.flight_stop MODIFY (ID CONSTRAINT stop_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.flight_stop MODIFY (AMND_DATE CONSTRAINT stop_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.flight_stop MODIFY (AMND_USER CONSTRAINT stop_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.flight_stop MODIFY (AMND_STATE CONSTRAINT stop_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.flight_stop  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.flight_stop  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.flight_stop  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.flight_stop ADD CONSTRAINT stop_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.stop_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.flight_stop ADD CONSTRAINT stop_sgm_oid_FK FOREIGN KEY (segment_oid)
  REFERENCES ord.segment (ID) ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.stop_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache
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
*/

/

/* commission */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ord.commission
   (	   ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
    AIRLINE NUMBER(18,0), 
    DETAILS VARCHAR2(255 BYTE), 
    FIX NUMBER(20,2), 
    PERCENT NUMBER(20,2), 
    DATE_FROM DATE, 
    DATE_TO DATE, 
    PRIORITY NUMBER,
    contract_type number(18,0),
    contract_oid number(18,0),
    min_absolut number(20,2),
    markup_type number(18,0),
    per_segment VARCHAR2(1),
    currency  number(18,0),
    per_fare VARCHAR2(1),
    rule_type number(18,0)    
    
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.CMN_ID_IDX ON ord.commission (ID) 
  TABLESPACE USERS ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.commission MODIFY (ID CONSTRAINT CMN_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.commission MODIFY (AMND_DATE CONSTRAINT CMN_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.commission MODIFY (AMND_USER CONSTRAINT CMN_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.commission MODIFY (AMND_STATE CONSTRAINT CMN_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.commission  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.commission  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.commission  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.commission ADD CONSTRAINT CMN_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.CMN_ID_IDX ENABLE;


/*
ALTER TABLE ord.commission ADD CONSTRAINT CMN_ETT_OID_FK FOREIGN KEY (event_type_oid)
  REFERENCES BLNG.event_type (ID) ENABLE;
ALTER TABLE ord.commission ADD CONSTRAINT CMN_TRN_OID_FK FOREIGN KEY (transaction_oid)
  REFERENCES BLNG.transaction (ID) ENABLE;
ALTER TABLE ord.commission ADD CONSTRAINT CMN_CNTR_OID_FK FOREIGN KEY (contraCMN_oid)
  REFERENCES BLNG.contract (ID) ENABLE;
*/

ALTER TABLE ord.commission ADD CONSTRAINT CMN_CNTR_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract (ID) ENABLE;

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ord.CMN_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.CMN_TRGR 
BEFORE
INSERT
ON ord.commission
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select CMN_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER ord.CMN_TRGR ENABLE;

/

/* commission_template */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ord.commission_template
   (	   ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
	TEMPLATE_TYPE VARCHAR2(50 BYTE), 
	CLASS VARCHAR2(10 BYTE), 
	FLIGHT_AC VARCHAR2(10 BYTE), 
	FLIGHT_NOT_AC VARCHAR2(10 BYTE), 
	FLIGHT_MC VARCHAR2(10 BYTE), 
	FLIGHT_OC VARCHAR2(10 BYTE), 
	FLIGHT_VC VARCHAR2(10 BYTE), 
	FLIGHT_SEGMENT VARCHAR2(10 BYTE), 
	COUNTRY_FROM VARCHAR2(10 BYTE), 
	COUNTRY_TO VARCHAR2(10 BYTE), 
	COUNTRY_INSIDE VARCHAR2(10 BYTE), 
	COUNTRY_OUTSIDE VARCHAR2(10 BYTE), 
	TARIFF VARCHAR2(10 BYTE), 
	PRIORITY NUMBER, 
	DETAILS VARCHAR2(255 BYTE),
  is_contract_type varchar2(1),
  name  varchar2(255),
  nls_name  varchar2(255),
  is_value  varchar2(1) 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.CT_ID_IDX ON ord.commission_template (ID) 
  TABLESPACE USERS ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.commission_template MODIFY (ID CONSTRAINT CT_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.commission_template MODIFY (AMND_DATE CONSTRAINT CT_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.commission_template MODIFY (AMND_USER CONSTRAINT CT_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.commission_template MODIFY (AMND_STATE CONSTRAINT CT_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.commission_template  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.commission_template  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.commission_template  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.commission_template ADD CONSTRAINT CT_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.CT_ID_IDX ENABLE;


/*
ALTER TABLE ord.commission_template ADD CONSTRAINT CT_ETT_OID_FK FOREIGN KEY (event_type_oid)
  REFERENCES BLNG.event_type (ID) ENABLE;
ALTER TABLE ord.commission_template ADD CONSTRAINT CT_TRN_OID_FK FOREIGN KEY (transaction_oid)
  REFERENCES BLNG.transaction (ID) ENABLE;
ALTER TABLE ord.commission_template ADD CONSTRAINT CT_CNTR_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES BLNG.contract (ID) ENABLE;
*/

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ord.CT_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.CT_TRGR 
BEFORE
INSERT
ON ord.commission_template
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select CT_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER ord.CT_TRGR ENABLE;


/


/* commission_details */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ord.commission_details
   (	   ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   commission_oid NUMBER(18,0),
   commission_template_oid NUMBER(18,0),
   value varchar(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ;
  
  --drop table  blng.account 
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.CD_ID_IDX ON ord.commission_details (ID) 
  TABLESPACE USERS ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.commission_details MODIFY (ID CONSTRAINT CD_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.commission_details MODIFY (AMND_DATE CONSTRAINT CD_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.commission_details MODIFY (AMND_USER CONSTRAINT CD_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.commission_details MODIFY (AMND_STATE CONSTRAINT CD_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.commission_details  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.commission_details  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.commission_details  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.commission_details ADD CONSTRAINT CD_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.CD_ID_IDX ENABLE;



ALTER TABLE ord.commission_details ADD CONSTRAINT CD_CMN_OID_FK FOREIGN KEY (commission_oid)
  REFERENCES ord.commission (ID) ENABLE;
ALTER TABLE ord.commission_details ADD CONSTRAINT CD_CT_OID_FK FOREIGN KEY (commission_template_oid)
  REFERENCES ord.commission_template (ID) ENABLE;

--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ord.CD_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.CD_TRGR 
BEFORE
INSERT
ON ord.commission_details
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select CD_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER ord.CD_TRGR ENABLE;

/



/* item_avia_status */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ord.item_avia_status 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
    item_avia_OID NUMBER(18,0), 
    PO_STATUS VARCHAR2(50 BYTE), 
    NQT_STATUS_CUR VARCHAR2(50 BYTE)
    
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.iavs_ID_IDX ON ord.item_avia_status (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.item_avia_status MODIFY (ID CONSTRAINT iavs_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.item_avia_status MODIFY (AMND_DATE CONSTRAINT iavs_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.item_avia_status MODIFY (AMND_USER CONSTRAINT iavs_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.item_avia_status MODIFY (AMND_STATE CONSTRAINT iavs_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.item_avia_status  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.item_avia_status  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.item_avia_status  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.item_avia_status ADD CONSTRAINT iavs_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.iavs_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.item_avia_status ADD CONSTRAINT iavs_iav_OID_FK FOREIGN KEY (item_avia_oid)
  REFERENCES ord.item_avia (ID) ENABLE;


--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ORD.iavs_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.iavs_TRGR 
BEFORE
INSERT
ON ord.item_avia_status
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select iavs_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.iavs_TRGR ENABLE;


/

/* pos_rule */


--------------------------------------------------------
--  DDL for Table 
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
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.posr_ID_IDX ON ord.pos_rule (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.pos_rule MODIFY (ID CONSTRAINT posr_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.pos_rule MODIFY (AMND_DATE CONSTRAINT posr_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.pos_rule MODIFY (AMND_USER CONSTRAINT posr_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.pos_rule MODIFY (AMND_STATE CONSTRAINT posr_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.pos_rule  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.pos_rule  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.pos_rule  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.pos_rule ADD CONSTRAINT posr_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.posr_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.pos_rule ADD CONSTRAINT posr_cntr_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES blng.contract (ID) ENABLE;

  ALTER TABLE ord.pos_rule ADD CONSTRAINT posr_al_OID_FK FOREIGN KEY (airline_oid)
  REFERENCES hdbk.airline (ID) ENABLE;

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
/

/* ord.currency */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ord.currency 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   code varchar2(10),
   name varchar2(50),
   nls_name varchar2(50),
   is_currency varchar2(1)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.curr_ID_IDX ON ord.currency (ID) 
  TABLESPACE USERS ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.currency MODIFY (ID CONSTRAINT curr_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.currency MODIFY (AMND_DATE CONSTRAINT curr_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.currency MODIFY (AMND_USER CONSTRAINT curr_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.currency MODIFY (AMND_STATE CONSTRAINT curr_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.currency  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.currency  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.currency  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.currency ADD CONSTRAINT curr_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.curr_ID_IDX ENABLE;
  
  
/

/* ord.task1c */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ord.task1c 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   task_type NUMBER(18,0), 
   number_1c VARCHAR2(50), 
   status VARCHAR2(1),
   request clob
   
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.t1c_ID_IDX ON ord.task1c (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.task1c MODIFY (ID CONSTRAINT t1c_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.task1c MODIFY (AMND_DATE CONSTRAINT t1c_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.task1c MODIFY (AMND_USER CONSTRAINT t1c_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.task1c MODIFY (AMND_STATE CONSTRAINT t1c_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.task1c  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.task1c  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.task1c  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.task1c ADD CONSTRAINT t1c_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.t1c_ID_IDX ENABLE;
 
  
/*  ALTER TABLE ord.task1c ADD CONSTRAINT t1c_ord_OID_FK FOREIGN KEY (order_oid)
  REFERENCES ord.ord (ID) ENABLE;

  ALTER TABLE ord.task1c ADD CONSTRAINT t1c_cntr_OID_FK FOREIGN KEY (contract_oid)
  REFERENCES blng.contract (ID) ENABLE;
  */
--------------------------------------------------------
--  DDL for Secuence MKP_SEQ
--------------------------------------------------------
 
  create sequence  ord.t1c_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger MKP_TRGR
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.t1c_TRGR 
BEFORE
INSERT
ON ord.task1c
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select t1c_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.t1c_TRGR ENABLE;

/

/* ord.bill2task */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ord.bill2task 
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   bill_oid NUMBER(18,0), 
   task_oid NUMBER(18,0)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index MKP_ID_IDX
--------------------------------------------------------

  CREATE INDEX ord.b2t_ID_IDX ON ord.bill2task (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.bill2task MODIFY (ID CONSTRAINT b2t_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.bill2task MODIFY (AMND_DATE CONSTRAINT b2t_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.bill2task MODIFY (AMND_USER CONSTRAINT b2t_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.bill2task MODIFY (AMND_STATE CONSTRAINT b2t_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.bill2task  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.bill2task  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.bill2task  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.bill2task ADD CONSTRAINT b2t_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.b2t_ID_IDX ENABLE;
 
  
  ALTER TABLE ord.bill2task ADD CONSTRAINT b2t_bill_OID_FK FOREIGN KEY (bill_oid)
  REFERENCES ord.bill (ID) ENABLE;

  ALTER TABLE ord.bill2task ADD CONSTRAINT b2t_t1c_OID_FK FOREIGN KEY (task_oid)
  REFERENCES ord.task1c (ID) ENABLE;
  
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  ord.b2t_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.b2t_TRGR 
BEFORE
INSERT
ON ord.bill2task
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select b2t_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.b2t_TRGR ENABLE;

/


/* itinerary */


  CREATE TABLE ord.itinerary
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   item_avia_oid NUMBER(18,0),
   validating_carrier NUMBER(18,0)
   
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ord.itin_ID_IDX ON ord.itinerary (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.itinerary MODIFY (ID CONSTRAINT itin_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.itinerary MODIFY (AMND_DATE CONSTRAINT itin_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.itinerary MODIFY (AMND_USER CONSTRAINT itin_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.itinerary MODIFY (AMND_STATE CONSTRAINT itin_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.itinerary  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.itinerary  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.itinerary  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.itinerary ADD CONSTRAINT itin_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.itin_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.itinerary ADD CONSTRAINT itin_iav_OID_FK FOREIGN KEY (item_avia_oid)
  REFERENCES ord.item_avia (ID) ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  ORD.itin_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache 
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
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

/

/* leg */

--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE ord.leg
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   itinerary_oid NUMBER(18,0),
   sequence_number NUMBER(18,0),
   departure_iata varchar2(10),
   departure_city NUMBER(18,0),
   departure_date date,
   arrival_iata varchar2(10),
   arrival_city NUMBER(18,0),
   arrival_date date
   
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ord.leg_ID_IDX ON ord.leg (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.leg MODIFY (ID CONSTRAINT leg_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.leg MODIFY (AMND_DATE CONSTRAINT leg_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.leg MODIFY (AMND_USER CONSTRAINT leg_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.leg MODIFY (AMND_STATE CONSTRAINT leg_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.leg  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.leg  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.leg  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.leg ADD CONSTRAINT leg_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.leg_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.leg ADD CONSTRAINT leg_itin_OID_FK FOREIGN KEY (itinerary_oid)
  REFERENCES ord.itinerary (ID) ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  ORD.leg_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache 
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
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

/
/* segment */

  CREATE TABLE ord.segment
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   leg_oid NUMBER(18,0), 
   sequence_number NUMBER(18,0),
   departure_iata varchar2(10),
   departure_city NUMBER(18,0),
   departure_date date,
   arrival_iata varchar2(10),
   arrival_city NUMBER(18,0),
   arrival_date date,
   marketing_carrier number(18),
  operating_carrier number(18)

   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ord.sgm_ID_IDX ON ord.segment (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.segment MODIFY (ID CONSTRAINT sgm_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.segment MODIFY (AMND_DATE CONSTRAINT sgm_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.segment MODIFY (AMND_USER CONSTRAINT sgm_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.segment MODIFY (AMND_STATE CONSTRAINT sgm_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.segment  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.segment  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.segment  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.segment ADD CONSTRAINT sgm_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.sgm_ID_IDX ENABLE;
 
 
  
  ALTER TABLE ord.segment ADD CONSTRAINT sgm_leg_oid_FK FOREIGN KEY (leg_oid)
  REFERENCES ord.leg (ID) ENABLE;
 
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  ORD.sgm_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache 
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
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

/
/* event */

  CREATE TABLE ord.event
   (	ID NUMBER(18,0), 
   amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
   task varchar2(50),
   contract_oid NUMBER(18,0),
   user_oid number(18,0),
   pnr_id varchar2(50),
   request clob,
   status varchar2(1),
   result  varchar2(50),
   error  varchar2(255)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE USERS ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX ord.evnt_ID_IDX ON ord.event (ID) 
  TABLESPACE USERS ;
  
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE ord.event MODIFY (ID CONSTRAINT evnt_ID_NN NOT NULL ENABLE);
  ALTER TABLE ord.event MODIFY (AMND_DATE CONSTRAINT evnt_ADT_NN NOT NULL ENABLE);
  ALTER TABLE ord.event MODIFY (AMND_USER CONSTRAINT evnt_AUR_NN NOT NULL ENABLE);
  ALTER TABLE ord.event MODIFY (AMND_STATE CONSTRAINT evnt_AST_NN NOT NULL ENABLE);
ALTER TABLE ord.event  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE ord.event  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE ord.event  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE ord.event ADD CONSTRAINT evnt_ID_PK PRIMARY KEY (ID)
  USING INDEX ord.evnt_ID_IDX ENABLE;
 
 
  
/*  ALTER TABLE ord.event ADD CONSTRAINT evnt_leg_oid_FK FOREIGN KEY (leg_oid)
  REFERENCES ord.leg (ID) ENABLE;
 */
 
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  ORD.evnt_SEQ
  increment by 1
  start with 1
  nomaxvalue
  nocache 
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER ord.evnt_TRGR 
BEFORE
INSERT
ON ord.event
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select evnt_SEQ.NEXTVAL into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER ord.evnt_TRGR ENABLE;

/

CREATE bitmap INDEX ord.ord_AS_IDX ON ord.ord (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.bill_AS_IDX ON ord.bill (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.cmn_AS_IDX ON ord.commission (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.cd_AS_IDX ON ord.commission_details (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.ct_AS_IDX ON ord.commission_template (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.iav_AS_IDX ON ord.item_avia (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.iavs_AS_IDX ON ord.item_avia_status (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.tkt_AS_IDX ON ord.ticket (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.posr_AS_IDX ON ord.pos_rule (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.t1c_AS_IDX ON ord.task1c (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.p2t_AS_IDX ON ord.bill2task (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.itin_AS_IDX ON ord.itinerary (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.leg_AS_IDX ON ord.leg (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.sgm_AS_IDX ON ord.segment (amnd_state) TABLESPACE USERS ;
CREATE bitmap INDEX ord.evnt_AS_IDX ON ord.event (amnd_state) TABLESPACE USERS ;


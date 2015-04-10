
/* hdbk.log  */


--------------------------------------------------------
--  DDL for Table 
--------------------------------------------------------

  CREATE TABLE hdbk.log 
   (ID NUMBER, 
  amnd_date date,
   amnd_user VARCHAR2(50),
   amnd_state VARCHAR2(1), 
   amnd_prev NUMBER(18,0), 
	PROC_NAME VARCHAR2(50 BYTE), 
	MSG VARCHAR2(4000 BYTE), 
	MSG_TYPE VARCHAR2(50 BYTE), 
	INFO VARCHAR2(4000 BYTE), 
	ALERT_LEVEL NUMBER(18,0)
   ) SEGMENT CREATION IMMEDIATE
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX hdbk.log_ID_IDX ON hdbk.log ("ID") 
  TABLESPACE "USERS" ;
 
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------

  ALTER TABLE hdbk.log MODIFY ("ID" CONSTRAINT log_ID_NN NOT NULL ENABLE);
  ALTER TABLE hdbk.log MODIFY (AMND_DATE CONSTRAINT "log_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.log MODIFY (AMND_USER CONSTRAINT "log_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE hdbk.log MODIFY (AMND_STATE CONSTRAINT "log_AST_NN" NOT NULL ENABLE);
ALTER TABLE hdbk.log  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE hdbk.log  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE hdbk.log  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE hdbk.log ADD CONSTRAINT log_ID_PK PRIMARY KEY (ID)
  USING INDEX hdbk.log_ID_IDX ENABLE;


  /*
  ALTER TABLE ntg.log ADD CONSTRAINT bill_clt_OID_FK FOREIGN KEY (client_oid)
  REFERENCES blng.client ("ID") ENABLE;
   */
--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  hdbk.log_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache /*!!!*/
  nocycle
  order;
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.log_TRGR 
BEFORE
INSERT
ON hdbk.log
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select log_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER hdbk.log_TRGR ENABLE;

/


CREATE bitmap INDEX hdbk.log_AS_IDX ON hdbk.log (amnd_state) TABLESPACE "USERS" ;

/* erp.pdf_printer */

/*  
CREATE TABLE erp.pdf_printer 
  (	ID NUMBER(18,0), 
    amnd_date date,
    amnd_user VARCHAR2(50),
    amnd_state VARCHAR2(1), 
    amnd_prev NUMBER(18,0), 
    payload clob,
    status VARCHAR2(1),
    filename VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index 
--------------------------------------------------------

  CREATE INDEX erp.pdfp_ID_IDX ON erp.pdf_printer ("ID") 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table 
--------------------------------------------------------


  ALTER TABLE erp.pdf_printer MODIFY ("ID" CONSTRAINT pdfp_ID_NN NOT NULL ENABLE);
  ALTER TABLE erp.pdf_printer MODIFY (AMND_DATE CONSTRAINT "pdfp_ADT_NN" NOT NULL ENABLE);
  ALTER TABLE erp.pdf_printer MODIFY (AMND_USER CONSTRAINT "pdfp_AUR_NN" NOT NULL ENABLE);
  ALTER TABLE erp.pdf_printer MODIFY (AMND_STATE CONSTRAINT "pdfp_AST_NN" NOT NULL ENABLE);
ALTER TABLE erp.pdf_printer  MODIFY (AMND_DATE DEFAULT  on null  sysdate );
ALTER TABLE erp.pdf_printer  MODIFY (AMND_USER DEFAULT  on null  user );
ALTER TABLE erp.pdf_printer  MODIFY (AMND_STATE DEFAULT  on null  'A' );
  ALTER TABLE erp.pdf_printer ADD CONSTRAINT pdfp_ID_PK PRIMARY KEY (ID)
  USING INDEX erp.pdfp_ID_IDX ENABLE;

--------------------------------------------------------
--  DDL for Secuence 
--------------------------------------------------------
 
  create sequence  erp.pdfp_seq
  increment by 1
  start with 1
  nomaxvalue
  nocache 
  nocycle
  order;
  
--------------------------------------------------------
--  DDL for Trigger 
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER erp.pdfp_TRGR 
BEFORE
INSERT
ON erp.pdf_printer
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select erp.pdfp_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER erp.pdfp_TRGR ENABLE;

/  
 */
 


/
--CREATE bitmap INDEX erp.pdfp_AS_IDX ON erp.pdf_printer (amnd_state) TABLESPACE "USERS" ;




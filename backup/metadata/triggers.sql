
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

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.al_TRGR 
BEFORE
INSERT
ON hdbk.airline
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select al_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER hdbk.al_TRGR ENABLE;

/

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.AP_TRGR 
BEFORE
INSERT
ON hdbk.airplane
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select AP_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER hdbk.AP_TRGR ENABLE;

/

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.geo_TRGR 
BEFORE
INSERT
ON hdbk.geo
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select geo_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER hdbk.geo_TRGR ENABLE;

/

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.gnt_TRGR 
BEFORE
INSERT
ON hdbk.gds_nationality
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select gnt_SEQ.nextval into :new.id from dual; 
--  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER hdbk.gnt_TRGR ENABLE;

/

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.MKPT_TRGR 
BEFORE
INSERT
ON hdbk.markup_type
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select MKPT_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;

/
ALTER TRIGGER hdbk.MKPT_TRGR ENABLE;

/

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.note_TRGR 
BEFORE
INSERT
ON hdbk.note
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select note_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER hdbk.note_TRGR ENABLE;

/

CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.ntt_TRGR 
BEFORE
INSERT
ON hdbk.note_ticket
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select ntt_SEQ.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER hdbk.ntt_TRGR ENABLE;

/

  CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.rate_TRGR 
  BEFORE
  INSERT
  ON hdbk.rate
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
   WHEN (new.id is null) BEGIN
    select rate_SEQ.nextval into :new.id from dual; 
    select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
  end;
  /
  ALTER TRIGGER hdbk.rate_TRGR ENABLE;
  
  /
  
CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.cal_TRGR 
BEFORE
INSERT
ON hdbk.calendar
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select hdbk.cal_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER hdbk.cal_TRGR ENABLE;

/  
  
CREATE OR REPLACE EDITIONABLE TRIGGER hdbk.dict_TRGR 
BEFORE
INSERT
ON hdbk.dictionary
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select hdbk.dict_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER hdbk.dict_TRGR ENABLE;

/  

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.clt_TRGR 
BEFORE
INSERT
ON BLNG.client
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.clt_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER BLNG.clt_TRGR ENABLE;

/

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.usr_TRGR 
BEFORE
INSERT
ON BLNG.usr
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.usr_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER BLNG.usr_TRGR ENABLE;

/

create or replace TRIGGER BLNG.cntr_TRGR 
BEFORE
INSERT
ON BLNG.contract
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.cntr_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.CNTR_TRGR ENABLE;

/

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.u2cntr_TRGR 
BEFORE
INSERT
ON BLNG.USR2CONTRACT
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.u2cntr_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER BLNG.u2cntr_TRGR ENABLE;

/
CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.ACCT_TRGR 
BEFORE
INSERT
ON BLNG.account_type
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.acct_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.acct_TRGR ENABLE;

/

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.ACC_TRGR 
BEFORE
INSERT
ON BLNG.account
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.acc_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.acc_TRGR ENABLE;

/

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.trt_TRGR 
BEFORE
INSERT
ON BLNG.trans_type
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.trt_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.trt_TRGR ENABLE;

/

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.doc_TRGR 
BEFORE
INSERT
ON BLNG.document
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.doc_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.doc_TRGR ENABLE;


/

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.trn_TRGR 
BEFORE
INSERT
ON BLNG.transaction
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.trn_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.trn_TRGR ENABLE;


/

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.ett_TRGR 
BEFORE
INSERT
ON BLNG.event_type
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.ett_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/

ALTER TRIGGER BLNG.ett_TRGR ENABLE;

/

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.evnt_TRGR 
BEFORE
INSERT
ON BLNG.event
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.evnt_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.evnt_TRGR ENABLE;

/

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.stt_TRGR 
BEFORE
INSERT
ON BLNG.status_type
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.stt_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;

/
ALTER TRIGGER BLNG.stt_TRGR ENABLE;


/

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.DLY_TRGR 
BEFORE
INSERT
ON BLNG.delay
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.DLY_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.DLY_TRGR ENABLE;


/

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.dmn_TRGR 
BEFORE
INSERT
ON BLNG.domain
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.dmn_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual; 
end;
/
ALTER TRIGGER BLNG.dmn_TRGR ENABLE;


/

CREATE OR REPLACE EDITIONABLE TRIGGER BLNG.usrd_TRGR 
BEFORE
INSERT
ON BLNG.USR_DATA
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (new.id is null) BEGIN
  select BLNG.usrd_seq.nextval into :new.id from dual; 
  select nvl(:new.amnd_prev,:new.id) into :new.amnd_prev from dual;
end;
/
ALTER TRIGGER BLNG.usrd_TRGR ENABLE;

/


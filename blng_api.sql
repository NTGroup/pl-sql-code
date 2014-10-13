select * from blng.client

DECLARE
 v_ReturnValue  NUMBER;
BEGIN
  v_ReturnValue := BLNG.BLNG_API.client_add();
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
END;


DECLARE
  P_ID NUMBER;
  P_NAME VARCHAR2(255);
 v_ReturnValue  blng.blng_api.t_message;
BEGIN
  P_ID := 3;
  P_NAME := 'Pavel Ryzhikov1';

  v_ReturnValue := BLNG.BLNG_API.client_set_name(P_ID => P_ID,
P_NAME => P_NAME);
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
END;
--3	10.10.2014 10:40:59	NTG	A	3	P.Ryzhikov	
select * from log
select * from blng.client order by amnd_date desc
commit
DECLARE
  P_CLIENT_OID NUMBER;
 v_ReturnValue  NUMBER;
BEGIN
  P_CLIENT_OID := 3;

  v_ReturnValue := BLNG.BLNG_API.contract_add(P_CLIENT_OID => P_CLIENT_OID);
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
END;

select * from blng.contract order by amnd_date desc

DECLARE
  P_ID NUMBER;
  P_NUMBER VARCHAR2(50);
  v_ReturnValue  blng.blng_api.t_message;
BEGIN
  P_ID := 11;
  P_NUMBER := 'num2';

  v_ReturnValue := BLNG.BLNG_API.contract_set_number(P_ID => P_ID,
P_NUMBER => P_NUMBER);
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
END;

DECLARE
  P_CONTRACT_OID NUMBER;
 v_ReturnValue   blng.blng_api.t_message;
BEGIN
  P_CONTRACT_OID := 11;

  v_ReturnValue := BLNG.BLNG_API.account_init(P_CONTRACT_OID => P_CONTRACT_OID);
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
END;

select * from blng.account


SELECT * FROM dba_CONSTRAINTS WHERE 
SEARCH_CONDITION_vc not like '%IS NOT NULL%'



DECLARE
  P_NAME VARCHAR2(50);
  P_CODE VARCHAR2(10);
  P_DETAILS VARCHAR2(255);
 v_ReturnValue  NUMBER;
BEGIN
  P_NAME := 'decline';
  P_CODE := 'D';
  P_DETAILS := '';

  v_ReturnValue := BLNG.BLNG_API.status_type_add(P_NAME => P_NAME,
P_CODE => P_CODE,
P_DETAILS => P_DETAILS);
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
END;


select * from blng.event_type


select * from DBA_SCHEDULER_JOBS


select * from DBA_CREDENTIALS



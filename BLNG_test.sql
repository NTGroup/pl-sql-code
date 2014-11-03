DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_client  NUMBER;
  P_NAME VARCHAR2(255):='pasha';
  v_contract  NUMBER;
  P_number VARCHAR2(255):=to_char(timestamp);
  v_DOC 
BEGIN
  SELECT SYSTIMESTAMP INTO starting_time FROM DUAL;

  /*client*/
  v_client := BLNG_API.client_add(P_NAME => P_NAME);
  DBMS_OUTPUT.PUT_LINE('v_client = ' || v_client);

  SELECT SYSTIMESTAMP INTO ending_time FROM DUAL;
  DBMS_OUTPUT.PUT_LINE('Time = ' || TO_CHAR(ending_time - starting_time));
/*contract*/
  v_contract := BLNG_API.contract_add(P_CLIENT => v_CLIENT,
    P_NUMBER => P_NUMBER);
  DBMS_OUTPUT.PUT_LINE('v_contract = ' || v_contract); 
  BLNG.BLNG_API.account_init(P_CONTRACT_OID => v_contract);
  /* */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => 11,P_AMOUNT => 35,P_TRANS_TYPE =>11);
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
  commit;

  
END;
/


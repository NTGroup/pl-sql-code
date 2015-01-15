--------------------------------------------------------
--  DDL for Package DTYPE
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "NTG"."DTYPE" as 


 subtype t_id is number(18,0);
 subtype t_amount is number(20,2);
 subtype t_status is varchar2(1);
 subtype t_msg is varchar2(4000);
 subtype t_name is varchar2(255);
 subtype t_code is varchar2(10);
 subtype t_long_code is varchar2(50);
 subtype t_bool is BOOLEAN;
 subtype t_date is date;
 subtype t_clob is clob;

 p_client dtype.t_id := 31;




/*  test_exception  EXCEPTION;                       -- declare exception
  PRAGMA EXCEPTION_INIT (test_exception, -20000);  -- assign error code to exception

  empty_function  EXCEPTION;                       -- declare exception
  PRAGMA EXCEPTION_INIT (empty_function, -20000);  -- assign error code to exception
*/
  INVALID_PARAMETER  EXCEPTION;                       -- declare exception
  PRAGMA EXCEPTION_INIT (INVALID_PARAMETER, -6502);  -- assign error code to exception
  

  max_loan_transaction_block EXCEPTION;                       -- declare exception
  PRAGMA EXCEPTION_INIT (max_loan_transaction_block, -6502);  -- assign error code to exception
  

----------------------------------------------------------------------------------------
  
  doc_waiting EXCEPTION;                       -- declare exception
  PRAGMA EXCEPTION_INIT (doc_waiting, -20000);  -- assign error code to exception

  insufficient_funds  EXCEPTION;                       -- declare exception
  PRAGMA EXCEPTION_INIT (insufficient_funds, -20001);  -- assign error code to exception

  api_error  EXCEPTION;                       -- declare exception
  PRAGMA EXCEPTION_INIT (api_error, -20002);  -- assign error code to exception
  
  VALUE_ERROR EXCEPTION;
  PRAGMA EXCEPTION_INIT (VALUE_ERROR, -20003);  -- assign error code to exception

  EXIT_ALERT EXCEPTION;
  PRAGMA EXCEPTION_INIT (EXIT_ALERT, -20004);  -- assign error code to exception

  INVALID_OPERATION EXCEPTION;
  PRAGMA EXCEPTION_INIT (INVALID_OPERATION, -20005);  -- assign error code to exception

  --in block RAISE VALUE_ERROR
  --insufficient funds
end dtype;

/

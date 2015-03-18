  CREATE OR REPLACE PACKAGE "NTG"."DTYPE" as 

  
/*
 pkg: NTG.DTYPE
 */


/*
$obj_type: data_type

$obj_name: t_id
$obj_desc: for id. integer/number(18,0)

$obj_name: t_amount
$obj_desc: for money. float/number(20,2)

$obj_name: t_status
$obj_desc: for 1 letter statuses. char(1)

$obj_name: t_msg
$obj_desc: for long messages less 4000 chars. string(4000)/varchar2(4000)

$obj_name: t_name
$obj_desc: for client names or geo names less 255 chars. string(255)/varchar2(255)

$obj_name: t_code
$obj_desc: for short codes less 10 chars. string(10)/varchar2(10)

$obj_name: t_long_code
$obj_desc: for long codes less 50 chars. string(50)/varchar2(50)

$obj_name: t_bool
$obj_desc: for boolean values. 

$obj_name: t_date
$obj_desc: for date with time values. 

$obj_name: t_clob
$obj_desc: for big data clob. 

*/

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


 /*
$obj_type: exception variable

$obj_name: INVALID_PARAMETER
$obj_desc: -6502

$obj_name: max_loan_transaction_block
$obj_desc:  -6502

$obj_name: doc_waiting
$obj_desc:  -20000

$obj_name: insufficient_funds
$obj_desc: -20001

$obj_name: api_error
$obj_desc: -20002

$obj_name: VALUE_ERROR
$obj_desc: -20003

$obj_name: EXIT_ALERT
$obj_desc: -20004

$obj_name: INVALID_OPERATION
$obj_desc: -20005


*/
 
  INVALID_PARAMETER  EXCEPTION;                       
  PRAGMA EXCEPTION_INIT (INVALID_PARAMETER, -6502);  

  max_loan_transaction_block EXCEPTION; 
  PRAGMA EXCEPTION_INIT (max_loan_transaction_block, -6502); 
  
  
  doc_waiting EXCEPTION;  
  PRAGMA EXCEPTION_INIT (doc_waiting, -20000); 

  insufficient_funds  EXCEPTION;    
  PRAGMA EXCEPTION_INIT (insufficient_funds, -20001); 

  api_error  EXCEPTION;     
  PRAGMA EXCEPTION_INIT (api_error, -20002); 
  
  VALUE_ERROR EXCEPTION;
  PRAGMA EXCEPTION_INIT (VALUE_ERROR, -20003);

  EXIT_ALERT EXCEPTION;
  PRAGMA EXCEPTION_INIT (EXIT_ALERT, -20004); 

  INVALID_OPERATION EXCEPTION;
  PRAGMA EXCEPTION_INIT (INVALID_OPERATION, -20005);


end dtype;

/

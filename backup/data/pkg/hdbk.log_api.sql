--------------------------------------------------------
--  DDL for Package LOG_API
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE hdbk.LOG_API as 

 /*
 
 pkg: hdbk.LOG_API 
 
 */
  

  
/*
$obj_type: procedure
$obj_name: log_add
$obj_desc: procedure for write log. this procedure make autonomous_transaction commits.
$obj_desc: its mean independent of other function commit/rollback and not affect 
$obj_desc: to other function commit/rollback
$obj_param: P_PROC_NAME: name of process
$obj_param: P_MSG: message that wont be written to log
$obj_param: P_MSG_TYPE: Information/Error or etc. default Information
$obj_param: P_INFO: some more details
$obj_param: P_ALERT_LEVEL: 0..10. priority level, default 0
*/
  procedure log_add(
    P_PROC_NAME   in hdbk.dtype.t_long_code default null,
    P_MSG         in hdbk.dtype.t_msg default null,
    P_MSG_TYPE    in hdbk.dtype.t_long_code default 'Information',
    P_INFO        in hdbk.dtype.t_msg default null,
    P_ALERT_LEVEL in hdbk.dtype.t_id default 0);

  function Print_Call_Stack
  RETURN hdbk.dtype.t_msg;
  
  function Call_Stack
  RETURN hdbk.dtype.t_msg;
  
procedure asd;

end log_api;

/


--------------------------------------------------------
--  DDL for Package Body LOG_API
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY hdbk.LOG_API as

  procedure log_add(
    P_PROC_NAME   in hdbk.dtype.t_long_code default null,
    P_MSG         in hdbk.dtype.t_msg default null,
    P_MSG_TYPE    in hdbk.dtype.t_long_code default 'Information',
    P_INFO        in hdbk.dtype.t_msg default null,
    P_ALERT_LEVEL in hdbk.dtype.t_id default 0)
  is
    pragma autonomous_transaction;
    v_log_row hdbk.log%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    insert into hdbk.log values v_log_row returning id into v_id;
    update hdbk.log set amnd_prev = v_id, amnd_date = sysdate, amnd_user = user, 
      amnd_state = 'A',
      PROC_NAME = P_PROC_NAME,
      MSG = P_MSG /*|| log_api.PRINT_CALL_STACK*/,
      error_stack = CALL_STACK,
      
      MSG_TYPE = P_MSG_TYPE,
      INFO = P_INFO,
      ALERT_LEVEL = P_ALERT_LEVEL
      where id = v_id;
    commit;
  end;


  function Print_Call_Stack
  RETURN hdbk.dtype.t_msg
  as
    Depth pls_integer := UTL_Call_Stack.Dynamic_Depth();  
    v_out hdbk.dtype.t_msg;
  begin
    dbms_output.put_line( 'Lexical   Depth   Line    Name' );
    v_out:=v_out||'Lexical   Depth   Line    Name'||chr(13)||chr(10);
    dbms_output.put_line( 'Depth             Number      ' );
    v_out:=v_out||'Depth             Number      '||chr(13)||chr(10);
    dbms_output.put_line( '-------   -----   ----    ----' );
    v_out:=v_out||'-------   -----   ----    ----'||chr(13)||chr(10);
    for j in reverse 1..Depth loop
      DBMS_Output.Put_Line(
      rpad( utl_call_stack.lexical_depth(j), 10 ) ||
      rpad( j, 7) ||
      rpad( To_Char(UTL_Call_Stack.Unit_Line(j), '99'), 9 ) ||
      UTL_Call_Stack.Concatenate_Subprogram
      (UTL_Call_Stack.Subprogram(j)));
      
      v_out:=v_out||
      rpad( utl_call_stack.lexical_depth(j), 10 ) ||
      rpad( j, 7) ||
      rpad( To_Char(UTL_Call_Stack.Unit_Line(j), '99'), 9 ) ||
      UTL_Call_Stack.OWNER(j)||'.'||UTL_Call_Stack.Concatenate_Subprogram
      (UTL_Call_Stack.Subprogram(j))||chr(13)||chr(10);

    end loop;
    return v_out;
  end;


  function Call_Stack
  RETURN hdbk.dtype.t_msg
  as
    Depth pls_integer := UTL_Call_Stack.Dynamic_Depth();  
    EDepth pls_integer := UTL_Call_Stack.ERROR_DEPTH();  
    BTDepth pls_integer := UTL_Call_Stack.BACKTRACE_DEPTH();  
    v_out hdbk.dtype.t_msg:='';
  begin
v_out:=v_out||'CALL:'||chr(13)||chr(10);
    for j in reverse 1..Depth /* -1 */ loop
    if UTL_Call_Stack.OWNER(j)='SQL' or utl_call_stack.lexical_depth(j) = 0 then continue; end if;
--      DBMS_Output.Put_Line('lexical_depth='||utl_call_stack.lexical_depth(j)||' '||j);
--      DBMS_Output.Put_Line('Unit_Line='||UTL_Call_Stack.Unit_Line(j)||'');
--      DBMS_Output.Put_Line('UTL_Call_Stack.Subprogram='||UTL_Call_Stack.Concatenate_Subprogram(UTL_Call_Stack.Subprogram(j))||'');
--     DBMS_Output.Put_Line('CURRENT_EDITION='||UTL_Call_Stack.CURRENT_EDITION(j)||'');
--      DBMS_Output.Put_Line('DYNAMIC_DEPTH='||UTL_Call_Stack.DYNAMIC_DEPTH ||'');
--      DBMS_Output.Put_Line('LEXICAL_DEPTH='||UTL_Call_Stack.LEXICAL_DEPTH(j)||'');
--      DBMS_Output.Put_Line('OWNER='||UTL_Call_Stack.OWNER(j)||'');
 --     DBMS_Output.Put_Line('INFO='||UTL_Call_Stack.OWNER(j)||UTL_Call_Stack.Concatenate_Subprogram(UTL_Call_Stack.Subprogram(j))||' line='||UTL_Call_Stack.Unit_Line(j)||'');

--      DBMS_Output.Put_Line('-------------------------------');
/*      v_out:=v_out||'lexical_depth='||utl_call_stack.lexical_depth(j)||' '||j||chr(13)||chr(10);
      v_out:=v_out||'Unit_Line='||UTL_Call_Stack.Unit_Line(j)||chr(13)||chr(10);
      v_out:=v_out||'UTL_Call_Stack.Subprogram='||UTL_Call_Stack.Concatenate_Subprogram(UTL_Call_Stack.Subprogram(j))||chr(13)||chr(10);
     v_out:=v_out||'CURRENT_EDITION='||UTL_Call_Stack.CURRENT_EDITION(j)||chr(13)||chr(10);
      v_out:=v_out||'DYNAMIC_DEPTH='||UTL_Call_Stack.DYNAMIC_DEPTH ||chr(13)||chr(10);
      v_out:=v_out||'LEXICAL_DEPTH='||UTL_Call_Stack.LEXICAL_DEPTH(j)||chr(13)||chr(10);
      v_out:=v_out||'OWNER='||UTL_Call_Stack.OWNER(j)||chr(13)||chr(10);*/
      v_out:=v_out||/*'INFO='||*/ UTL_Call_Stack.OWNER(j)||'.'||UTL_Call_Stack.Concatenate_Subprogram(UTL_Call_Stack.Subprogram(j))||' line='||UTL_Call_Stack.Unit_Line(j)||chr(13)||chr(10);

    end loop;
      v_out:=v_out||'-------------------------------'||chr(13)||chr(10);
    
      v_out:=v_out||'ERRORS:'||chr(13)||chr(10);
    for j in reverse 1..EDepth /* -1 */ loop
--       DBMS_Output.Put_Line('ERROR_MSG='||UTL_Call_Stack.ERROR_MSG(j)||'');
--      DBMS_Output.Put_Line('ERROR_NUMBER='||UTL_Call_Stack.ERROR_NUMBER(j)||'');
--      DBMS_Output.Put_Line('-------------------------------');
      v_out:=v_out||j||' '||UTL_Call_Stack.ERROR_NUMBER(j)||' '||UTL_Call_Stack.ERROR_MSG(j);
--      v_out:=v_out||'ERROR_NUMBER='||j||' '||UTL_Call_Stack.ERROR_NUMBER(j)||chr(13)||chr(10);
    end loop;
      v_out:=v_out||'-------------------------------'||chr(13)||chr(10);
      v_out:=v_out||'BACKTRACE:'||chr(13)||chr(10);
    for j in reverse 1..BTDepth /* -1 */ loop
--     DBMS_Output.Put_Line('BACKTRACE_LINE='||UTL_Call_Stack.BACKTRACE_LINE(j)||'');
--     DBMS_Output.Put_Line('BACKTRACE_UNIT='||UTL_Call_Stack.BACKTRACE_UNIT(j)||'');
--      DBMS_Output.Put_Line('-------------------------------');
     v_out:=v_out||j||' '||UTL_Call_Stack.BACKTRACE_UNIT(j)||' line='||UTL_Call_Stack.BACKTRACE_LINE(j)||chr(13)||chr(10);
--     v_out:=v_out||'BACKTRACE_UNIT='||j||' '||UTL_Call_Stack.BACKTRACE_UNIT(j)||chr(13)||chr(10);
    for i in (
                SELECT * FROM ALL_SOURCE WHERE type = 'PACKAGE BODY'
                and line  between to_number(UTL_Call_Stack.BACKTRACE_LINE(j)) and to_number(UTL_Call_Stack.BACKTRACE_LINE(j))+3
                and owner||'.'||name = UTL_Call_Stack.BACKTRACE_UNIT(j)
                order by owner, name, type, line
              )
    loop
      v_out:=v_out||i.line||': '||i.text;
    end loop;
     
    end loop;
      v_out:=v_out||'-------------------------------'||chr(13)||chr(10);
        
    return v_out;
  end;
  
procedure asd
is
    v_out hdbk.dtype.t_msg;
begin
    v_out :=Call_Stack;
end;

end log_api;

/

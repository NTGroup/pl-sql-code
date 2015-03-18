--------------------------------------------------------
--  DDL for Package LOG_API
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "DICT"."LOG_API" as 

 /*
 
 pkg: DICT.LOG_API 
 
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
    P_PROC_NAME   in dtype.t_long_code default null,
    P_MSG         in dtype.t_msg default null,
    P_MSG_TYPE    in dtype.t_long_code default 'Information',
    P_INFO        in dtype.t_msg default null,
    P_ALERT_LEVEL in dtype.t_id default 0);


end log_api;

/


--------------------------------------------------------
--  DDL for Package Body LOG_API
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "DICT"."LOG_API" as

  procedure log_add(
    P_PROC_NAME   in dtype.t_long_code default null,
    P_MSG         in dtype.t_msg default null,
    P_MSG_TYPE    in dtype.t_long_code default 'Information',
    P_INFO        in dtype.t_msg default null,
    P_ALERT_LEVEL in dtype.t_id default 0)
  is
    pragma autonomous_transaction;
    v_log_row DICT.log%rowtype;
    v_id dtype.t_id;
  begin
    insert into DICT.log values v_log_row returning id into v_id;
    update DICT.log set amnd_prev = v_id, amnd_date = sysdate, amnd_user = user, 
      amnd_state = 'A',
      PROC_NAME = P_PROC_NAME,
      MSG = P_MSG,
      MSG_TYPE = P_MSG_TYPE,
      INFO = P_INFO,
      ALERT_LEVEL = P_ALERT_LEVEL
      where id = v_id;
    commit;
  end;


end log_api;

/

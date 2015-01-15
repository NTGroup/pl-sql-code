--------------------------------------------------------
--  DDL for Package LOG_API
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "NTG"."LOG_API" as 
  subtype message is varchar2(4000);

  procedure log_add(
    P_PROC_NAME   in dtype.t_long_code default null,
    P_MSG         in dtype.t_msg default null,
    P_MSG_TYPE    in dtype.t_long_code default 'Information',
    P_INFO        in dtype.t_msg default null,
    P_ALERT_LEVEL in dtype.t_id default 0);


  /* TODO enter package declarations (types, exceptions, methods etc) here */ 


end log_api;

/


--------------------------------------------------------
--  DDL for Package Body LOG_API
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "NTG"."LOG_API" as

  procedure log_add(
    P_PROC_NAME   in dtype.t_long_code default null,
    P_MSG         in dtype.t_msg default null,
    P_MSG_TYPE    in dtype.t_long_code default 'Information',
    P_INFO        in dtype.t_msg default null,
    P_ALERT_LEVEL in dtype.t_id default 0)
  is
    pragma autonomous_transaction;
    v_log_row ntg.log%rowtype;
    v_id dtype.t_id;
  begin
    insert into ntg.log values v_log_row returning id into v_id;
    update ntg.log set amnd_prev = v_id, amnd_date = sysdate, amnd_user = user, 
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

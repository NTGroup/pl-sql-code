--------------------------------------------------------
--  DDL for Package MARKUP_API
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "NTG"."MARKUP_API" 
AS

 /*
 
 pkg: garbage 
 
 */

function get_table 
--return markup_tab_type;
return SYS_REFCURSOR;

function get_airlines(p_gds in dtype.t_long_code default null, p_pos in dtype.t_long_code default null)
return SYS_REFCURSOR;

function get_full
return SYS_REFCURSOR;

function num(p_num in number)
return sys_refcursor;


END markup_api;

/

--------------------------------------------------------
--  DDL for Package Body MARKUP_API
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "NTG"."MARKUP_API" 
AS
  
  function get_table 
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
      OPEN v_results FOR
        SELECT m.*
        FROM markup m;
    return v_results;
  exception when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'get_table', p_msg_type=>'UNHANDLED_ERROR', 
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select,p_table=markup,p_date=' 
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
      RAISE_APPLICATION_ERROR(-20002,'select row into markup error. '||SQLERRM);
    return null;  
  end;
  
  function get_airlines(p_gds in dtype.t_long_code default null, p_pos in dtype.t_long_code default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
    OPEN v_results FOR
      SELECT al.id, al.iata, al.name, al.nls_name 
      FROM markup mkp, airline al
      where mkp.validating_carrier = al.id
      and mkp.gds = nvl(p_gds,mkp.gds)
      and mkp.pos = nvl(p_pos,mkp.pos)
      and mkp.amnd_state = 'A'
      and al.amnd_state = 'A'
      group by al.id, al.nls_name , al.name, al.iata;
    return v_results;
  exception when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'get_airlines', p_msg_type=>'UNHANDLED_ERROR', 
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select,p_table=markup,p_date=' 
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
      RAISE_APPLICATION_ERROR(-20002,'select row into markup error. '||SQLERRM);
    return null;  
  end;
  
  function get_full
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
      OPEN v_results FOR
        SELECT *
        FROM v_markup;
    return v_results;
  exception when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'get_full', p_msg_type=>'UNHANDLED_ERROR', 
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select,p_table=markup,p_date=' 
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
      RAISE_APPLICATION_ERROR(-20002,'select row into markup error. '||SQLERRM);
    return null;  
  end;

  function num(p_num in number)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
      OPEN v_results FOR
        SELECT p_num num
        FROM dual;
    return v_results;
  exception when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'get_full', p_msg_type=>'UNHANDLED_ERROR', 
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select,p_table=markup,p_date=' 
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
      RAISE_APPLICATION_ERROR(-20002,'select row into markup error. '||SQLERRM);
    return null;  
  end;

END markup_api;

/

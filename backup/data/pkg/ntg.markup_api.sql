--------------------------------------------------------
--  DDL for Package MARKUP_API
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "NTG"."MARKUP_API" 
AS

  
/*type markup_record IS record ( 
  ID                markup.ID %type,
  CLIENT                     markup.CLIENT%type,
  GDS                         markup.GDS%type,
  POS                       markup. POS%type,
  VALIDATING_CARRIER         markup. VALIDATING_CARRIER%type,
  CLASS_OF_SERVICE          markup.  CLASS_OF_SERVICE%type,
  SEGMENT                   markup.  SEGMENT %type,
  HUMAN                     markup. HUMAN %type,
  V_FROM                     markup. V_FROM  %type  , 
  V_TO                      markup. V_TO  %type  ,
  ABSOLUT                   markup.  ABSOLUT%type,
  ABSOLUT_AMOUNT            markup. ABSOLUT_AMOUNT   %type   ,
  PERCENT                     markup.PERCENT%type,
  PERCENT_AMOUNT             markup.PERCENT_AMOUNT  %type ,
  MIN_ABSOLUT                markup.MIN_ABSOLUT%type,
  MAX_ABSOLUT                 markup.MAX_ABSOLUT %type   ,
  AMND_DATE                 markup. AMND_DATE %type    ,
  AMND_PREV                   markup.AMND_PREV %type  ,
  AMND_USER                 markup.AMND_USER%type,
  AMND_STATE  markup.AMND_STATE  %type 
    ); 
*/
--  type markup_record_table IS TABLE OF markup_record;
--  TYPE markup_table_row IS TABLE OF markup%ROWTYPE;
  
  
/*  PROCEDURE add(
      p_CLIENT             IN VARCHAR2,
      p_GDS                IN VARCHAR2,
      p_POS                IN VARCHAR2,
      p_VALIDATING_CARRIER IN VARCHAR2,
      p_CLASS_OF_SERVICE   IN VARCHAR2,
      p_SEGMENT            IN VARCHAR2,
      p_HUMAN              IN VARCHAR2,
      p_V_FROM             IN NUMBER ,
      p_V_TO               IN NUMBER ,
      p_ABSOLUT            IN VARCHAR2,
      p_ABSOLUT_AMOUNT     IN NUMBER ,
      p_PERCENT            IN VARCHAR2,
      p_PERCENT_AMOUNT     IN NUMBER ,
      p_MIN_ABSOLUT        IN NUMBER ,
      p_MAX_ABSOLUT        IN NUMBER ,
      p_AMND_DATE          IN DATE ,
      p_AMND_PREV          IN NUMBER,
      p_AMND_USER          IN VARCHAR2,
      p_AMND_STATE         IN VARCHAR2 ,
      p_id OUT NUMBER );
      
  PROCEDURE amendment_pre(
      p_id_in IN NUMBER,
      p_id_out OUT NUMBER,
      p_CLIENT OUT VARCHAR2,
      p_GDS OUT VARCHAR2,
      p_POS OUT VARCHAR2,
      p_VALIDATING_CARRIER OUT VARCHAR2,
      p_CLASS_OF_SERVICE OUT VARCHAR2,
      p_SEGMENT OUT VARCHAR2,
      p_HUMAN OUT VARCHAR2,
      p_V_FROM OUT NUMBER ,
      p_V_TO OUT NUMBER ,
      p_ABSOLUT OUT VARCHAR2,
      p_ABSOLUT_AMOUNT OUT NUMBER ,
      p_PERCENT OUT VARCHAR2,
      p_PERCENT_AMOUNT OUT NUMBER ,
      p_MIN_ABSOLUT OUT NUMBER ,
      p_MAX_ABSOLUT OUT NUMBER ,
      p_AMND_DATE OUT DATE ,
      p_AMND_PREV OUT NUMBER,
      p_AMND_USER OUT VARCHAR2,
      p_AMND_STATE OUT VARCHAR2 );
      
  PROCEDURE amendment_post(
      p_id OUT NUMBER,
      p_CLIENT             IN VARCHAR2,
      p_GDS                IN VARCHAR2,
      p_POS                IN VARCHAR2,
      p_VALIDATING_CARRIER IN VARCHAR2,
      p_CLASS_OF_SERVICE   IN VARCHAR2,
      p_SEGMENT            IN VARCHAR2,
      p_HUMAN              IN VARCHAR2,
      p_V_FROM             IN NUMBER ,
      p_V_TO               IN NUMBER ,
      p_ABSOLUT            IN VARCHAR2,
      p_ABSOLUT_AMOUNT     IN NUMBER ,
      p_PERCENT            IN VARCHAR2,
      p_PERCENT_AMOUNT     IN NUMBER ,
      p_MIN_ABSOLUT        IN NUMBER ,
      p_MAX_ABSOLUT        IN NUMBER ,
      p_AMND_DATE          IN DATE ,
      p_AMND_PREV          IN NUMBER,
      p_AMND_USER          IN VARCHAR2,
      p_AMND_STATE         IN VARCHAR2 );

PROCEDURE amendment
  (
    p_id in NUMBER,
    p_CLIENT             IN VARCHAR2,
    p_GDS                IN VARCHAR2,
    p_POS                IN VARCHAR2,
    p_VALIDATING_CARRIER IN VARCHAR2,
    p_CLASS_OF_SERVICE   IN VARCHAR2,
    p_SEGMENT            IN VARCHAR2,
    p_HUMAN              IN VARCHAR2,
    p_V_FROM             IN NUMBER ,
    p_V_TO               IN NUMBER ,
    p_ABSOLUT            IN VARCHAR2,
    p_ABSOLUT_AMOUNT     IN NUMBER ,
    p_PERCENT            IN VARCHAR2,
    p_PERCENT_AMOUNT     IN NUMBER ,
    p_MIN_ABSOLUT        IN NUMBER ,
    p_MAX_ABSOLUT        IN NUMBER ,
    p_AMND_USER          IN VARCHAR2 default user
  );
  

  PROCEDURE delete (p_id IN NUMBER);

function get
  (
    p_CLIENT             IN VARCHAR2 default null,
    p_GDS                IN VARCHAR2,
    p_POS                IN VARCHAR2,
    p_VALIDATING_CARRIER IN VARCHAR2 default null,
    p_CLASS_OF_SERVICE   IN VARCHAR2 default null,
    p_ticket_amount in number,
    p_segment_count IN NUMBER  default null,
    p_human_count IN NUMBER  default null
  )
  return number;
*/

function get_table 
--return markup_tab_type;
return SYS_REFCURSOR;

function get_airlines(p_gds in dtype.t_long_code default null, p_pos in dtype.t_long_code default null)
return SYS_REFCURSOR;

function get_full
return SYS_REFCURSOR;
/*
function get_full_tt
return markup_tab_type;


function get_full_rt
return markup_tab;
*/
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
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select&p_table=markup&p_date=' 
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
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select&p_table=markup&p_date=' 
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
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select&p_table=markup&p_date=' 
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
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select&p_table=markup&p_date=' 
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
      RAISE_APPLICATION_ERROR(-20002,'select row into markup error. '||SQLERRM);
    return null;  
  end;

END markup_api;

/

create or replace package ntg.fwdr as
  
  function airline_commission_list
  return SYS_REFCURSOR;

end;
/
create or replace package body ntg.fwdr as
  
  function airline_commission_list
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
  
    OPEN v_results FOR
      select 
      al.id airline_oid,
      al.nls_name name,
      al.IATA,
      case when cmn.airline is null then 'N' else 'Y' end commission
      from 
      ntg.airline al,
      (
        select airline from ord.commission 
        where amnd_state = 'A'
        and trunc(sysdate) between NVL(date_from,trunc(sysdate)) and NVL(date_to,trunc(sysdate))
        group by airline
      ) cmn
      where 
      al.amnd_state = 'A'
      and al.iata is not null
      and al.id = cmn.airline(+)
      order by 4 desc, 2;
    return v_results;
  end;
  
end;
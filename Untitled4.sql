declare 
id_out number;
begin
  MARKUP_API."ADD"(
    P_CLIENT => 'rpe',
    P_GDS => 'Sabre',
    P_POS => 'pos',
    P_VALIDATING_CARRIER => 'vac',
    P_CLASS_OF_SERVICE => 'econom',
    P_SEGMENT => 'Y',
    P_HUMAN => '',
    P_V_FROM => 1,
    P_V_TO => 3,
    P_ABSOLUT => 'Y',
    P_ABSOLUT_AMOUNT => 123,
    P_PERCENT => '',
    P_PERCENT_AMOUNT => '',
    P_MIN_ABSOLUT => 1122,
    P_MAX_ABSOLUT => '',
    P_AMND_DATE => null,
    P_AMND_PREV => null,
    P_AMND_USER => null,
    P_AMND_STATE => null,
    P_ID => id_out
  );
/* Legacy output: */
DBMS_OUTPUT.PUT_LINE('P_ID = ' || ID_out);
end;


declare 
id_out number;
begin
  MARKUP_API.amendment(
    P_CLIENT => 'rpe',
    P_GDS => 'Sabre',
    P_POS => 'pos',
    P_VALIDATING_CARRIER => 'vac',
    P_CLASS_OF_SERVICE => 'econom',
    P_SEGMENT => 'Y',
    P_HUMAN => '',
    P_V_FROM => 1,
    P_V_TO => 3,
    P_ABSOLUT => 'Y',
    P_ABSOLUT_AMOUNT => 123,
    P_PERCENT => '',
    P_PERCENT_AMOUNT => '',
    P_MIN_ABSOLUT => 1122,
    P_MAX_ABSOLUT => '',
    P_ID => 8
  );
/* Legacy output: */
DBMS_OUTPUT.PUT_LINE('P_ID = ' || ID_out);
end;


select * from  MARKUP;

select sysdate from dual


select
markup_api.get
from dual;

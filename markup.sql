declare
type markup_rec_type
IS
  record
  (
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
AMND_STATE                  markup.AMND_STATE  %type 
    ); 
  type markup_tab_type
  IS
  TABLE OF markup_rec_type;

mr markup_rec_type;
mt markup_tab_type:=markup_tab_type(null);


mrowt markup%rowtype;

begin

select *
into mr  from markup where id=5;

select *
into mrowt  from markup where id=5;
--dbms_output.put_line(mr.VALIDATING_CARRIER);

mt(1):=mr;

dbms_output.put_line(mt(1).id);

end;	

select * from markup

ntg.markup_api.get_table


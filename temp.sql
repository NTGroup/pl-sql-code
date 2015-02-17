

alter table blng.client_data add phone varchar2(255);
alter table  blng.contract add utc_offset number;
alter table blng.client add phone varchar2(255);
alter table  blng.client add utc_offset number;
alter table  blng.company add utc_offset number;



select * from log order by id



select 
blng.fwdr.get_tenant('redlinesoft@yandex.ru')
from dual

declare
a number;
begin
  a := blng.fwdr.get_tenant('redlinesoft@yandex.ru');
  dbms_output.put_line(''||a);
end;



select * from blng.v_account

select * from log order by id desc

select * from ORD.ITEM_AVIA order by id desc

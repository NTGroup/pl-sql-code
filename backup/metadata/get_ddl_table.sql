SET LONG 2000000
SET TERMOUT OFF
SET PAGESIZE 0
set serveroutput on
set feedback OFF

SPOOL ../README.md;

declare
v_out varchar2(255);
v_pkg varchar2(255);
v_obj_type varchar2(255);
v_obj_name varchar2(255);
v_obj_desc varchar2(255);
v_obj_desc_name varchar2(255);
v_obj_desc_desc varchar2(255);
v_obj_param_name varchar2(255);
v_obj_param_desc varchar2(255);
v_obj_param varchar2(255);
v_obj_return varchar2(255);
v_is_cursor varchar2(255):='N';
v_is_tab varchar2(255):='N';
v_text varchar2(255);

begin 
for i in  (
  select /*name || ' '||text */ text from 
    (SELECT 
    /*case 
    when text like '$pkg:%' then '<hr><h1>'||replace(trim(replace(replace(TEXT,chr(10),''),chr(13),'')),'$pkg:','')||'</h1>'---|| chr(13) || chr(10) 
    when text like '$obj_type:%' then '<br><br><br><i>'||replace(trim(replace(replace(TEXT,chr(10),''),chr(13),'')),'$obj_type:','')||'</i>'---|| chr(13) || chr(10) 
    when text like '$obj_name:%' then '<b>'||replace(trim(replace(replace(TEXT,chr(10),''),chr(13),'')),'$obj_name:','')||'</b><br>'---|| chr(13) || chr(10) 
    when text like '$obj_desc:%' then '<i>description:</i><br>'||replace(trim(replace(replace(TEXT,chr(10),''),chr(13),'')),'$obj_desc:','')||'<br>'---|| chr(13) || chr(10) 
    when text like '$obj_param:%' then '<i>parameters:</i><br><b>'||regexp_replace(replace(trim(replace(replace(TEXT,chr(10),''),chr(13),'')),'$obj_param:',''),':',':</b>',1,1)||'</b><br>'---|| chr(13) || chr(10) 
    when text like '$obj_return:%' then '<i>return:</i><br>'||replace(trim(replace(replace(TEXT,chr(10),''),chr(13),'')),'$obj_return:','')||'<br>' ---|| chr(13) || chr(10) 
    else trim(replace(replace(TEXT,chr(10),''),chr(13),'')) ---|| chr(13) || chr(10) 
    end
    --trim(replace(replace(TEXT,chr(10),''),chr(13),'')) 
    */
    lower(trim(replace(replace(TEXT,chr(10),''),chr(13),''))) text,
     owner||' '|| name||' '|| type name,
     line*1 line
    FROM DBA_SOURCE WHERE OWNER IN ('BLNG','NTG','ORD', /*'ERP',*/ 'HDBK') and type like 'PACKAGE%' 
    and (text like '$obj%' or text like '$pkg%')
    )
  order by name, line
)
loop
v_text:= replace(replace(i.text,'_','\_'),'*','\*');

if v_text like '$pkg%' then v_pkg := trim(replace(v_text,'$pkg:','')); 
  dbms_output.put_line('');
  dbms_output.put_line(/*'package: '*/ '# '||upper(v_pkg));
  dbms_output.put_line(/*'package: '*/ '---');
  v_obj_name := null;
  v_obj_desc := null;
  v_obj_desc_name := null;
  v_obj_desc_desc := null;
  v_obj_param_name := null;
  v_obj_param_desc := null;
  v_obj_param := null;
  v_obj_return := null;
  v_is_cursor := 'N';
  continue;
end if;

if v_text like '$obj\_type:%' then v_obj_type := trim(replace(v_text,'$obj\_type:','')); 
--  dbms_output.put_line('package: '||v_pkg);
  v_obj_name := null;
  v_obj_desc := null;
  v_obj_desc_name := null;
  v_obj_desc_desc := null;
  v_obj_param_name := null;
  v_obj_param_desc := null;
  v_obj_param := null;
  v_obj_return := null;
  v_is_cursor := 'N';

  continue;
end if;

if v_text like '$obj\_name:%' then v_obj_name := trim(replace(v_text,'$obj\_name:','')); 
  dbms_output.put_line('');
  dbms_output.put_line('### _'||v_obj_type||'_ '||upper(v_pkg||'.'||v_obj_name)||'  ');
  continue;
end if;

if v_text like '$obj\_desc:%' then 
  if v_obj_desc is null then 
    dbms_output.put_line(upper('_description:_  '));
  end if;  
  v_obj_desc := trim(replace(v_text,'$obj\_desc:','')); 

  if v_obj_desc like '\*%' then 
  
    if v_obj_desc_name is null 
      or  (v_obj_desc_name is not null and v_obj_desc not like v_obj_desc_name||'%' ) 
    then
      v_obj_desc_name:= trim(SUBSTR( v_obj_desc,1, instr(v_obj_desc,':')));  
      v_obj_desc_desc:= 
      case
      when v_obj_desc_name like '%(%' then '**'||replace(replace(v_obj_desc_name,'(','**(_'),')','_)')
      else  '**'||v_obj_desc_name||'**'
      end
      ||' '||trim(replace(v_obj_desc,v_obj_desc_name,''));  
      
    else
      v_obj_desc_desc:= trim(replace(v_obj_desc,v_obj_desc_name,''));     
    end if;  
  else
    v_obj_desc_desc:=v_obj_desc;
  end if;

  if v_obj_desc_desc like '}%' then 
    v_is_cursor := 'N'; 
    dbms_output.put_line('');    
    v_obj_desc_desc:=''||v_obj_desc_desc;    
  end if; 
  if v_is_cursor = 'Y' then v_obj_desc_desc:= '  * '||v_obj_desc_desc; end if;
    
  dbms_output.put_line(v_obj_desc_desc||'  ');
  if v_obj_desc_desc like '%{' then v_is_cursor := 'Y'; dbms_output.put_line(''); end if; 
  continue;
end if;

if v_text like '$obj\_param:%' then 
  if v_obj_param is null then 
    dbms_output.put_line(upper('_parameters:_  '));
  end if;  
  v_obj_param := trim(replace(v_text,'$obj\_param:','')); 
  if v_obj_param_name is null 
    or  (v_obj_param_name is not null and v_obj_param not like v_obj_param_name||'%' ) 
  then
    v_obj_param_name:= trim(SUBSTR( v_obj_param,1, instr(v_obj_param,':')));  
    v_obj_param_desc:= 
    case
    when v_obj_param_name like '%(%' then '**'||replace(replace(v_obj_param_name,'(','**(_'),')','_)')
    else  '**'||v_obj_param_name||'**'
    end
    ||' '||trim(replace(v_obj_param,v_obj_param_name,''));  
    
  else
    v_obj_param_desc:= trim(replace(v_obj_param,v_obj_param_name,''));     
  end if;  
  
  if v_obj_param_desc like '}%' then 
    v_is_cursor := 'N'; 
    dbms_output.put_line('');    
    v_obj_param_desc:=''||v_obj_param_desc;    
  end if; 
  if v_is_cursor = 'Y' then v_obj_param_desc:= '  * '||v_obj_param_desc; end if;
  
  dbms_output.put_line(v_obj_param_desc||'  ');
  if v_obj_param_desc like '%{' then v_is_cursor := 'Y'; dbms_output.put_line(''); end if; 
  
  continue;
end if;

if v_text like '$obj\_return:%' then 
  if v_obj_return is null then 
    dbms_output.put_line(upper('_return:_  '));
  end if;  
  v_obj_return := trim(replace(v_text,'$obj\_return:','')); 
  
  if v_obj_return like '}%' then 
    v_is_cursor := 'N'; 
    dbms_output.put_line('');    
    v_obj_return:=''||v_obj_return; 
  end if; 
  if v_is_cursor = 'Y' then v_obj_return:= '  * '||v_obj_return; end if;

  dbms_output.put_line(v_obj_return||'  ');
  
  if v_obj_return like '%{' then v_is_cursor := 'Y'; dbms_output.put_line(''); end if; 
  
  continue;
end if;

dbms_output.put_line(i.text);
end loop;
end;

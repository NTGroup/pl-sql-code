declare
  p_name ntg.log.PROC_NAME%type;
  p_id ntg.log.id%type;
begin
  ntg.LOG_API.LOG_ADD(p_proc_name=>'one', p_msg_type=>'Error');
 -- dbms_output.put_line(p_id);
end;


ALTER PACKAGE BLNG COMPILE PACKAGE; 
ALTER PACKAGE NTG COMPILE PACKAGE; 

desc blng.client


select * from dba_objects
where owner = 'BLNG'


/* get package description */
select * from ALL_SOURCE
where owner = 'BLNG'
and type = 'PACKAGE'
and text like '%spec%'


TYPE comp_depend_record_t IS RECORD(
    cid VARCHAR2(30), -- component id
    cnamespace VARCHAR2(30) -- component namespace
    );


PROCEDURE downgrading (comp_id      IN VARCHAR2,
                       old_name     IN VARCHAR2 DEFAULT NULL,
                       old_proc     IN VARCHAR2 DEFAULT NULL,
                       old_schema   IN VARCHAR2 DEFAULT NULL,
                       old_parent   IN VARCHAR2 DEFAULT NULL);
                       
                       
                      desc blng.contract
                      
                      
                      
                      select * from blng.account_type
                      
                      
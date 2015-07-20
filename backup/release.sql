
alter table blng.delay add doc_oid number(18,0) ;

ALTER TABLE BLNG.delay ADD CONSTRAINT DLY_DOC_OID_FK FOREIGN KEY (DOC_oid)
  REFERENCES BLNG.DOCUMENT (ID) ENABLE;

update  blng.delay set doc_oid = (select doc_oid from blng.transaction where id = delay.transaction_oid);
commit;

insert into hdbk.dictionary (code, name, info, dictionary_type) values('BILL_DEPOSIT','BILL_DEPOSIT','deposit bill for client','TASK');
insert into hdbk.dictionary (code, name, info, dictionary_type) values('DEPOSIT','0','1c product and vat value','1C_PRODUCT_W_VAT');

insert into hdbk.dictionary (code, name, info, dictionary_type) values('LOAN','','','TRANS_TYPE');

commit;


update blng.document set account_trans_type_oid = HDbk.core.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>HDbk.core.dictionary_get_code(account_trans_type_oid)) 
where account_trans_type_oid is not null;
commit;

delete from hdbk.dictionary where dictionary_type = 'ACCOUNT_TYPE';
commit;


insert into hdbk.dictionary (code, name, info, dictionary_type)
select 
--id,
decode(code, 'd','DEPOSIT','l','LOAN','cl','CREDIT_LIMIT','clb','CREDIT_LIMIT_BLOCK',
'do','DEBIT_ONLINE','co','CREDIT_ONLINE','ult','UP_LIM_TRANS','dd','DELAY_DAYS') a,
code,
details,
'ACCOUNT_TYPE'
from blng.account_type;
commit;




ALTER TABLE BLNG.account DROP CONSTRAINT ACC_ACCT_OID_FK; 


update BLNG.ACCOUNT set /*code=
decode(code, 'd','DEPOSIT','l','LOAN','cl','CREDIT_LIMIT','clb','CREDIT_LIMIT_BLOCK',
'do','DEBIT_ONLINE','co','CREDIT_ONLINE','ult','UP_LIM_TRANS','dd','DELAY_DAYS'),*/
ACCOUNT_TYPE_OID = HDbk.core.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=> decode(code, 'd','DEPOSIT','l','LOAN','cl','CREDIT_LIMIT','clb','CREDIT_LIMIT_BLOCK',
'do','DEBIT_ONLINE','co','CREDIT_ONLINE','ult','UP_LIM_TRANS','dd','DELAY_DAYS') ) ;
commit;


update hdbk.dictionary set code = 'DELAY_DAYS' where code = 'DELAY_DAY';
commit;


alter table blng.account drop column code;

alter table blng.account add code VARCHAR2(50);
update  blng.account set code = (select code from hdbk.dictionary where id = account_type_oid) where amnd_state = 'A';
commit;


alter TABLE blng.delay DROP COLUMN transaction_oid;

@dba/GRANTS.sql;
@metadata/view.sql;
@data/pkg/hdbk.hdbk_api.sql;
@data/pkg/hdbk.fwdr.sql;
@data/pkg/hdbk.log_api.sql;
@data/pkg/hdbk.dtype.sql;
@data/pkg/hdbk.core.sql;
@data/pkg/blng.blng_api.sql;
@data/pkg/blng.core.sql;
@data/pkg/blng.fwdr.sql;
@data/pkg/ord.ord_api.sql;
@data/pkg/ord.core.sql;
@data/pkg/ord.fwdr.sql;
-- @metadata/get_ddl.sql;
-- @metadata/get_ddl_md.sql;
@metadata/get_ddl_table.sql;







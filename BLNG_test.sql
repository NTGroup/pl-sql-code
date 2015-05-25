    BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name   => 'document_schedule', attribute         =>  'repeat_interval', value => 'FREQ=SECONDLY;INTERVAL=2') ;
END;

/
    BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name   => 'HDBK.DOC_TASK_LIST_SCHEDULE', attribute         =>  'repeat_interval', value => 'FREQ=DAILY;INTERVAL=10') ;
END;
/
    BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name   => 'HDBK.DOC_TASK_LIST_SCHEDULE', attribute         =>  'repeat_interval', value => 'FREQ=SECONDLY;INTERVAL=10') ;
END;
/
    BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name   => 'HDBK.DOC_TASK_LIST_SCHEDULE', attribute         =>  'repeat_interval', value => 'FREQ=SECONDLY;INTERVAL=30') ;
END;
/
    BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name   => 'HDBK.BUY_SCHEDULE', attribute         =>  'repeat_interval', value => 'FREQ=DAILY;INTERVAL=10') ;
END;
/

    BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name   => 'HDBK.BUY_SCHEDULE', attribute         =>  'repeat_interval', value => 'FREQ=SECONDLY;INTERVAL=2') ;
END;
/
    BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name   => 'HDBK.BUY_SCHEDULE', attribute         =>  'repeat_interval', value => 'FREQ=SECONDLY;INTERVAL=10') ;
END;
/

    BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name   => 'HDBK.ONLINE_SCHEDULE', attribute         =>  'repeat_interval', value => 'FREQ=DAILY;INTERVAL=10') ;
END;
/

BEGIN
      DBMS_SCHEDULER.disable(name=>'"HDBK"."DOC_TASK_LIST_JOB"', force => TRUE);
END;
/
BEGIN
      DBMS_SCHEDULER.disable(name=>'"HDBK"."BUY_JOB"', force => TRUE);
END;


BEGIN
      DBMS_SCHEDULER.enable(name=>'"HDBK"."DOC_TASK_LIST_JOB"');
END;
/
BEGIN
      DBMS_SCHEDULER.enable(name=>'"HDBK"."BUY_JOB"');
END;


/* first edition with check account value only*/
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  P_company VARCHAR2(255):='ООО "ИМЭЙДЖИН ГРУПП"';
  v_company hdbk.dtype.t_id;

--  P_NAME VARCHAR2(255):='pasha';
  v_client1  hdbk.dtype.t_id;
  v_client2  hdbk.dtype.t_id;
  v_client3  hdbk.dtype.t_id;
  v_client4  hdbk.dtype.t_id;
  v_client5  hdbk.dtype.t_id;
  v_client6  hdbk.dtype.t_id;
  v_contract1  hdbk.dtype.t_id;
  v_contract5  hdbk.dtype.t_id;
  P_number VARCHAR2(255);
BEGIN
--- create contract and account for begin test

/*

1	buy	b
2	cash in	ci
3	credit	c
4	debit	d
5	debit adjustment	da
6	credit adjustment	ca
11	set delay days	dd
12	credit online	co
13	debit online	do
7	credit limit	cl
8	max loan trans amount	ult
9	block	clb
10	unblock	clu

*/


  SELECT SYSTIMESTAMP INTO starting_time FROM DUAL;

  /*company*/
  v_company := blng.BLNG_API.company_add(P_name => P_company);
 -- v_company := 5;
  DBMS_OUTPUT.PUT_LINE('v_company = ' || v_company);


  /*client*/
--с1
/*  v_client1 := blng.BLNG_API.client_add(P_NAME => 'HR Ася', p_company => v_company);
  DBMS_OUTPUT.PUT_LINE('v_client1 = ' || v_client1);
  v_client3 := blng.BLNG_API.client_add(P_NAME => 'Маша', p_company => v_company);
  DBMS_OUTPUT.PUT_LINE('v_client3 = ' || v_client3);
  v_client2 := blng.BLNG_API.client_add(P_NAME => 'Вася', p_company => v_company);
  DBMS_OUTPUT.PUT_LINE('v_client2 = ' || v_client2);
  v_client4 := blng.BLNG_API.client_add(P_NAME => 'Лида', p_company => v_company);
  DBMS_OUTPUT.PUT_LINE('v_client4 = ' || v_client4);
--с2
  v_client5 := blng.BLNG_API.client_add(P_NAME => 'Head Николай', p_company => v_company);
  DBMS_OUTPUT.PUT_LINE('v_client5 = ' || v_client5);
  v_client6 := blng.BLNG_API.client_add(P_NAME => 'HR Head Александра', p_company => v_company);
  DBMS_OUTPUT.PUT_LINE('v_client6 = ' || v_client6);
*/
 -- v_client1 := 32;
--  DBMS_OUTPUT.PUT_LINE('v_client1 = ' || v_client1);


/*contract*/
  v_contract1 := blng.BLNG_API.contract_add(P_company => v_company);
  DBMS_OUTPUT.PUT_LINE('v_contract1 = ' || v_contract1); 
  BLNG.BLNG_API.account_init(v_contract1);

/*  v_contract5 := blng.BLNG_API.contract_add(P_company => v_company);
  DBMS_OUTPUT.PUT_LINE('v_contract5 = ' || v_contract5); 
  BLNG.BLNG_API.account_init(v_contract5);*/

/* client2contract */
--  blng.BLNG_API.client2contract_add(P_client => v_client1, p_permission=> 'B', p_contract => v_contract1);
--  blng.BLNG_API.client2contract_add(P_client => v_client1, p_permission=> 'I', p_contract => v_contract1);
/*  blng.BLNG_API.client2contract_add(P_client => v_client2, p_permission=> 'B', p_contract => v_contract1);
  blng.BLNG_API.client2contract_add(P_client => v_client3, p_permission=> 'B', p_contract => v_contract1);
  blng.BLNG_API.client2contract_add(P_client => v_client4, p_permission=> 'B', p_contract => v_contract1);
  blng.BLNG_API.client2contract_add(P_client => v_client1, p_permission=> 'I', p_contract => v_contract1);
  blng.BLNG_API.client2contract_add(P_client => v_client5, p_permission=> 'B', p_contract => v_contract5);
  blng.BLNG_API.client2contract_add(P_client => v_client6, p_permission=> 'B', p_contract => v_contract5);
  blng.BLNG_API.client2contract_add(P_client => v_client6, p_permission=> 'I', p_contract => v_contract1);
  blng.BLNG_API.client2contract_add(P_client => v_client6, p_permission=> 'I', p_contract => v_contract5);
*/



  SELECT SYSTIMESTAMP INTO ending_time FROM DUAL;
  DBMS_OUTPUT.PUT_LINE('Time = ' || TO_CHAR(ending_time - starting_time));
commit;
end;

/
select * from blng.client2contract;

select * from blng.account where contract_oid in (20);

/*

1	buy	b
2	cash in	ci
3	credit	c
4	debit	d
5	debit adjustment	da
6	credit adjustment	ca
11	set delay days	dd
12	credit online	co
13	debit online	do
7	credit limit	cl
8	max loan trans amount	ult
9	block	clb
10	unblock	clu

*/

--test set/update increase/decrease limit
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  hdbk.dtype.t_id:=20;
  P_number VARCHAR2(255);
  v_DOC hdbk.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* ins doc limit 1000 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 1000,P_TRANS_TYPE =>7,p_account_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'DELAY_DAY'));
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX          0          0         1000                  0            0                     0             0          0       1000 



  /* increase doc limit 1002 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 1002,P_TRANS_TYPE =>7,p_account_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'DELAY_DAY'));
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
  
-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX          0          0         1002                  0            0                     0             0          0       1002 

  /* increase doc limit 1002 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 999,P_TRANS_TYPE =>7,p_account_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'DELAY_DAY'));
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
  
-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX          0          0          999                  0            0                     0             0          0        999 

  /* set delay days 50 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 50,P_TRANS_TYPE =>11,p_account_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'DELAY_DAY'));
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  /* set max loan trans amount 200 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 200,P_TRANS_TYPE =>8,p_account_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'DELAY_DAY'));
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
  
-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX          0          0          999                  0            0                   200             0         50        999 


end;

  SELECT /* text */ * FROM blng.v_account order by contract_oid desc;
--check docs
select  /* text */ * FROM blng.document order by id desc;
--check transactions
select  /* text */ * FROM blng.transaction order by id desc;
--check log

select  /* text */ * FROM hdbk.log order by id desc;

-- approve document manually if it needed
begin
BLNG.core.approve_documents;
end;


/
--test first cash_in
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  hdbk.dtype.t_id:=23;
  P_number VARCHAR2(255);
  v_bill hdbk.dtype.t_id;
  v_amount hdbk.dtype.t_amount:=21550;
  r_contract_info blng.v_account%rowtype;
 v_trans_type hdbk.dtype.t_code:= 'CASH_IN';
BEGIN

  /* ins doc cash in 500 */
--  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 500000000,P_TRANS_TYPE =>2);
    v_bill := ord.ORD_API.bill_add( --v_ORDER => r_item_avia.order_oid,
                                P_AMOUNT => V_AMOUNT,
                                P_DATE => sysdate,
                                P_STATUS => 'W', --[M]anaging
                                P_CONTRACT => v_contract,
                                p_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>v_trans_type));
  
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_bill);
  commit;
  
  
-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX        500          0          999                  0            0                   200             0         50       1499 


end;

/

  SELECT /* text */ * FROM blng.v_account order by contract_oid desc;
--check docs

select  /* text */ * FROM blng.document order by id desc;
--check transactions
select  /* text */ * FROM blng.transaction order by id desc;
--check log
select  /* text */ * FROM hdbk.log order by id desc;

--test buy from deposit
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  hdbk.dtype.t_id:=20;
  P_number VARCHAR2(255);
  v_DOC hdbk.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* ins doc buy 300 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 300,P_TRANS_TYPE =>1);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
  
-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX        200          0          999                  0            0                   200             0         50       1199 


end;

  SELECT /* text */ * FROM blng.v_account order by contract_oid desc;
--check docs
select  /* text */ * FROM blng.document order by id desc;
--check transactions
select  /* text */ * FROM blng.transaction order by id desc;
--check delay
select  /* text */ * FROM blng.delay order by id desc;
--check log
select  /* text */ * FROM hdbk.log order by id desc;


--test buy from deposit and loan second document with amount more then MAX_LOAN_TRANS_AMOUNT
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  hdbk.dtype.t_id:=20;
  P_number VARCHAR2(255);
  v_DOC hdbk.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* ins doc buy 299 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 299,P_TRANS_TYPE =>1);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
  /* ins doc buy 301 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 301,P_TRANS_TYPE =>1);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX          0        -99          999                  0            0                   200             0         50        900 

-- delay
--         ID AMND_DATE           AMND_USER                                          AMND_STATE  AMND_PREV EVENT_TYPE_OID TRANSACTION_OID DATE_TO             CONTRACT_OID     AMOUNT STATUS   PRIORITY
-- ---------- ------------------- -------------------------------------------------- ---------- ---------- -------------- --------------- ------------------- ------------ ---------- ------ ----------
--         53 04.11.2014 14:54:00 NTG                                                A                  53              2             131 24.12.2014 00:00:00           14        -99                10 


end;

  SELECT /* text */ * FROM blng.v_account order by contract_oid desc;
--check docs
select  /* text */ * FROM blng.document order by id desc;
--check transactions
select  /* text */ * FROM blng.transaction order by id desc;
--check delay
select  /* text */ * FROM blng.delay order by id desc ;
--check log
select  /* text */ * FROM hdbk.log order by id desc;



--test close loan and close delay half part and full delay
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  hdbk.dtype.t_id:=20;
  P_number VARCHAR2(255);
  v_DOC hdbk.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* ins doc cash_in 50 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 50,P_TRANS_TYPE =>2);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  /* ins doc cash_in 100 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 100,P_TRANS_TYPE =>2);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX         51          0          999                  0            0                   200             0         50       1050 

-- delay
--         ID AMND_DATE           AMND_USER                                          AMND_STATE  AMND_PREV EVENT_TYPE_OID TRANSACTION_OID DATE_TO             CONTRACT_OID     AMOUNT STATUS   PRIORITY
-- ---------- ------------------- -------------------------------------------------- ---------- ---------- -------------- --------------- ------------------- ------------ ---------- ------ ----------
--         57 04.11.2014 15:53:11 NTG                                                I                  55              2                 24.12.2014 00:00:00           14        -49                10 
--         56 04.11.2014 15:28:20 NTG                                                I                  55              2             147 24.12.2014 00:00:00           14        -99                10 
--         55 04.11.2014 15:54:08 NTG                                                C                  55              2                 24.12.2014 00:00:00           14        -49                10 



end;

  SELECT /* text */ * FROM blng.v_account order by contract_oid desc;
--check docs
select  /* text */ * FROM blng.document  where status = 'W' and amnd_state = 'A' order by id desc;
--check transactions
select  /* text */ * FROM blng.transaction   where status = 'W' and amnd_state = 'A'  order by doc_oid desc;
--check delay
select  /* text */ * FROM blng.delay where id >=55 order by id desc;

--check log
select  /* text */ * FROM hdbk.log order by id desc;


select count(*) from ord.bill where amnd_state = 'A' and status = 'W'

--test insufficient funds exception and delay expire
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  hdbk.dtype.t_id:=20;
  P_number VARCHAR2(255);
  v_DOC hdbk.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* set max loan trans amount 2000 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 2000,P_TRANS_TYPE =>8);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
  /* ins doc buy 551 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 551,P_TRANS_TYPE =>1);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
  /* ins doc buy 1000 raise error insufficient funds */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 1000,P_TRANS_TYPE =>1);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX          0       -500          999                  0            0                  2000             0         50        499 

end;

update blng.delay set date_to = trunc(sysdate)-1 where id = 75;
commit;

-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX          0       -500          999               -999            0                  2000             0         50       -500 


DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  hdbk.dtype.t_id:=20;
  P_number VARCHAR2(255);
  v_DOC hdbk.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* ins doc buy 100 raise error insufficient funds */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 100,P_TRANS_TYPE =>1);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;

end;



  SELECT /* text */ * FROM blng.v_account order by contract_oid desc;
--check docs
select  /* text */ * FROM blng.document order by id desc;
--check transactions
select  /* text */ * FROM blng.transaction order by id desc;
--check delay
select  /* text */ * FROM blng.delay order by id desc ;
--check log
select  /* text */ * FROM hdbk.log order by id desc;



--test delay and limit unblock
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  hdbk.dtype.t_id:=20;
  P_number VARCHAR2(255);
  v_DOC hdbk.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* manually unblock contract */
  blng.core.contract_unblock(P_CONTRACT => v_contract);
  commit;
  
  /* ins doc buy 100 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 100,P_TRANS_TYPE =>1);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
  
-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX          0       -600          999                  0            0                  2000             0         50        399 

--delay
--         ID AMND_DATE           AMND_USER                                          AMND_STATE  AMND_PREV EVENT_TYPE_OID TRANSACTION_OID DATE_TO             CONTRACT_OID     AMOUNT STATUS   PRIORITY
-- ---------- ------------------- -------------------------------------------------- ---------- ---------- -------------- --------------- ------------------- ------------ ---------- ------ ----------
--         63 04.11.2014 22:17:20 NTG                                                A                  63              2             188 24.12.2014 00:00:00           14       -100                10 
--         62 04.11.2014 22:17:16 NTG                                                A                  62              3             187 05.11.2014 00:00:00           14                           20 
--         61 04.11.2014 21:40:51 NTG                                                A                  61              2             180 04.11.2014 00:00:00           14       -500                10 

end;


SELECT /* text */ * FROM blng.v_account order by contract_oid desc;
--check docs
select  /* text */ * FROM blng.document order by id desc;
--check transactions
select  /* text */ * FROM blng.transaction order by id desc;
--check delay
select  /* text */ * FROM blng.delay where id >= 61 order by id desc ;
--check log
select  /* text */ * FROM hdbk.log order by id desc;


--test expire unblock limit

--expire unblock limit. delay row for unblock limit set status C
update blng.delay set date_to = trunc(sysdate) where id = 76;
commit;

-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX          0       -600          999               -999            0                  2000             0         50       -600 

--delay
--         ID AMND_DATE           AMND_USER                                          AMND_STATE  AMND_PREV EVENT_TYPE_OID TRANSACTION_OID DATE_TO             CONTRACT_OID     AMOUNT STATUS   PRIORITY
-- ---------- ------------------- -------------------------------------------------- ---------- ---------- -------------- --------------- ------------------- ------------ ---------- ------ ----------
--         64 04.11.2014 22:17:16 NTG                                                I                  62              3             187 04.11.2014 00:00:00           14                           20 
--         63 04.11.2014 22:17:20 NTG                                                A                  63              2             188 24.12.2014 00:00:00           14       -100                10 
--         62 04.11.2014 22:25:40 NTG                                                C                  62              3                 04.11.2014 00:00:00           14                           20 
--         61 04.11.2014 21:40:51 NTG                                                A                  61              2             180 04.11.2014 00:00:00           14       -500                10 


DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  hdbk.dtype.t_id:=20;
  P_number VARCHAR2(255);
  v_DOC hdbk.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* ins doc buy 100 raise error insufficient funds */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 100,P_TRANS_TYPE =>1);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
end;


SELECT /* text */ * FROM blng.v_account order by contract_oid desc;
--check docs
select  /* text */ * FROM blng.document order by id desc;
--check transactions
select  /* text */ * FROM blng.transaction order by id desc;
--check delay
select  /* text */ * FROM blng.delay where id >= 61 order by id desc ;
--check log
select  /* text */ * FROM hdbk.log order by id desc;



--test unblock limit by cash_in
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  hdbk.dtype.t_id:=20;
  P_number VARCHAR2(255);
  v_DOC hdbk.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* ins doc cash_in 300 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 300,P_TRANS_TYPE =>2);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;

  /* ins doc cash_in 201 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 201,P_TRANS_TYPE =>2);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;

  /* ins doc buy 150 */  --now this doc can be declined --its feature-bug
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 150,P_TRANS_TYPE =>1);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;

-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX          0       -249          999                               0                  2000             0         50        750 

--delay
--         ID AMND_DATE           AMND_USER                                          AMND_STATE  AMND_PREV EVENT_TYPE_OID TRANSACTION_OID DATE_TO             CONTRACT_OID     AMOUNT STATUS   PRIORITY
-- ---------- ------------------- -------------------------------------------------- ---------- ---------- -------------- --------------- ------------------- ------------ ---------- ------ ----------
--         67 04.11.2014 22:17:20 NTG                                                I                  63              2             188 24.12.2014 00:00:00           14       -100                10 
--         66 04.11.2014 22:36:22 NTG                                                I                  61              2                 04.11.2014 00:00:00           14       -200                10 
--         65 04.11.2014 21:40:51 NTG                                                I                  61              2             180 04.11.2014 00:00:00           14       -500                10 
--         63 04.11.2014 22:36:30 NTG                                                A                  63              2                 24.12.2014 00:00:00           14        -99                10 
--         61 04.11.2014 22:36:30 NTG                                                C                  61              2                 04.11.2014 00:00:00           14       -200                10 

--delay active
--         ID AMND_DATE           AMND_USER                                          AMND_STATE  AMND_PREV EVENT_TYPE_OID TRANSACTION_OID DATE_TO             CONTRACT_OID     AMOUNT STATUS   PRIORITY
-- ---------- ------------------- -------------------------------------------------- ---------- ---------- -------------- --------------- ------------------- ------------ ---------- ------ ----------
--         68 04.11.2014 22:44:40 NTG                                                A                  68              2             202 24.12.2014 00:00:00           14       -150                10 
--         63 04.11.2014 22:36:30 NTG                                                A                  63              2                 24.12.2014 00:00:00           14        -99                10 

end;

SELECT /* text */ * FROM blng.v_account order by contract_oid desc;
--check docs
select  /* text */ * FROM blng.document order by id desc;
--check transactions
select  /* text */ * FROM blng.transaction order by id desc;
--check delay
select  /* text */ * FROM blng.delay where id >= 61  order by id desc;
--check log
select  /* text */ * FROM hdbk.log order by id desc;


--test revoke_document
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  hdbk.dtype.t_id:=20;
  P_number VARCHAR2(255);
  v_DOC hdbk.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* ins doc buy 100 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT =>100,P_TRANS_TYPE =>1);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  /* ins doc cash in 30 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT =>5,P_TRANS_TYPE =>2);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  /* ins doc cash in 30 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT =>2,P_TRANS_TYPE =>2);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  /* ins doc cash in 30 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT =>3,P_TRANS_TYPE =>2);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  /* ins doc buy 200 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT =>200,P_TRANS_TYPE =>1);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT =>150,P_TRANS_TYPE =>1);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;

  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT =>350,P_TRANS_TYPE =>2);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;

  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT =>50,P_TRANS_TYPE =>1);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  --revoke 100
end;

DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  hdbk.dtype.t_id:=20;
  P_number VARCHAR2(255);
  v_DOC hdbk.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  blng.core.revoke_document(P_document => 582);
  blng.core.revoke_document(P_document => 581);
  blng.core.revoke_document(P_document => 587);

--         r(+5)   r(-100)  r(+350)
-- start  -------	 -------  -------
-- 100    100      200      200
--   5      2  	     200 	  150
--   2      3	     150        2
--   3      90	     60       3 
--   90   200	       2      50
-- 200      200	     3
--   200  150	       85
-- 150      60	   50
--   60   50	       5  
-- 50                           
-- -----  -----  ----- finish


end;

SELECT /* text */ * FROM blng.v_account order by contract_oid desc;
--check docs
select  /* text */ * FROM blng.document order by id desc;
--check transactions
select  /* text */ * FROM blng.transaction order by id desc;
--check delay
select  /* text */ * FROM blng.delay where id >= 181 order by id desc;
--check log
select  /* text */ * FROM hdbk.log order by id desc;

select lpad(' ',2*(level-1)) || to_char(amount) s, d.*
from blng.delay d
where id >= 274 and amnd_state  in ('A','C')
start with id >= 274 and parent_id is null
connect by prior id = parent_id;



                    select
                    amount,
                    id,
                    d.contract_oid,
                    nvl((select sum(amount) from blng.delay where parent_id is not null and parent_id = d.id and amnd_state = 'A' and EVENT_TYPE_oid = blng.blng_api.event_type_get_id(p_code=>'ci')),0) amount_have,
                    amount - nvl((select sum(amount) from blng.delay where parent_id is not null and parent_id = d.id and amnd_state = 'A'  and EVENT_TYPE_oid = blng.blng_api.event_type_get_id(p_code=>'ci')),0) amount_need,
                    date_to
                    from blng.delay d
                    where d.amnd_state = 'A'
                    and parent_id is null
                    and contract_oid = 20
                    and EVENT_TYPE_oid = blng.blng_api.event_type_get_id(p_code=>'b')
                    order by contract_oid asc, date_to asc, id asc


------


DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  hdbk.dtype.t_id:=20;
  P_number VARCHAR2(255);
  v_DOC hdbk.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN


  /* ins doc cash in 30 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 215,P_TRANS_TYPE =>1);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;

  --revoke 100
end;

---------------------------------------------------------------------------------WORK


/* first edition with check account value only*/
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  P_company VARCHAR2(255):='ООО "ИМЭЙДЖИН ГРУПП"';
  v_company hdbk.dtype.t_id;

--  P_NAME VARCHAR2(255):='pasha';
  v_client1  hdbk.dtype.t_id;
  v_client2  hdbk.dtype.t_id;
  v_client3  hdbk.dtype.t_id;
  v_client4  hdbk.dtype.t_id;
  v_client5  hdbk.dtype.t_id;
  v_client6  hdbk.dtype.t_id;
  v_contract1  hdbk.dtype.t_id;
  v_contract5  hdbk.dtype.t_id;
  P_number VARCHAR2(255);
    v_DOC hdbk.dtype.t_id;
BEGIN

 for i in 1..1 loop
 
  SELECT SYSTIMESTAMP INTO starting_time FROM DUAL;

  /*company*/
  v_company := blng.BLNG_API.company_add(P_name => P_company||i);
 -- v_company := 5;
  DBMS_OUTPUT.PUT_LINE('v_company = ' || v_company);


/*contract*/
  v_contract1 := blng.BLNG_API.contract_add(P_company => v_company);
  DBMS_OUTPUT.PUT_LINE('v_contract1 = ' || v_contract1); 
  BLNG.BLNG_API.account_init(v_contract1);

  SELECT SYSTIMESTAMP INTO ending_time FROM DUAL;
  DBMS_OUTPUT.PUT_LINE('Time = ' || TO_CHAR(ending_time - starting_time));
--commit;

  /* ins doc limit 1000 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract1,P_AMOUNT => 1000000,P_TRANS_TYPE =>7);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
 -- commit;
  
  /* set delay days 50 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract1,P_AMOUNT => 3,P_TRANS_TYPE =>11);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  --commit;
  /* set max loan trans amount 200 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract1,P_AMOUNT => 0,P_TRANS_TYPE =>8);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  --commit;
*/


INSERT INTO "BLNG"."DOMAIN" (NAME, CONTRACT_OID, STATUS, IS_DOMAIN) VALUES ('fff'||i||'@asd.com', v_contract1, 'A', '0');
--commit;

end loop;
commit;
end;



/
select * from blng.client2contract;

select * from blng.account where contract_oid in (20);

  SELECT /* text */ * FROM blng.v_account order by contract_oid desc;
--check docs
select  /* text */ * FROM blng.document order by id desc;
--check transactions
select  /* text */ * FROM blng.transaction order by id desc;
--check log
select  /* text */ * FROM hdbk.log order by id desc;


INSERT INTO "NTG"."MARKUP" (CONTRACT_OID, GDS, POS, VALIDATING_CARRIER, CLASS_OF_SERVICE, HUMAN, ABSOLUT, ABSOLUT_AMOUNT, MARKUP_TYPE_OID) VALUES ('27', 'Sabre', 'CJ8H', '1597', 'default', 'Y', 'Y', '400', '1');
commit;



--- stress test


/

/* first edition with check account value only*/
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  P_company VARCHAR2(255):='ООО "ИМЭЙДЖИН ГРУПП"';
  v_company hdbk.dtype.t_id;

--  P_NAME VARCHAR2(255):='pasha';
  v_client1  hdbk.dtype.t_id;
  v_client2  hdbk.dtype.t_id;
  v_client3  hdbk.dtype.t_id;
  v_client4  hdbk.dtype.t_id;
  v_client5  hdbk.dtype.t_id;
  v_client6  hdbk.dtype.t_id;
  v_contract1  hdbk.dtype.t_id;
  v_contract  hdbk.dtype.t_id;
  v_contract5  hdbk.dtype.t_id;
  P_number VARCHAR2(255);
    v_DOC hdbk.dtype.t_id;
    v_bill hdbk.dtype.t_id;
    v_ord hdbk.dtype.t_id;
    v_item_avia hdbk.dtype.t_id;
    v_item_avia_status hdbk.dtype.t_id;
BEGIN

  /* ins doc cash in 500 */
--  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 500000000,P_TRANS_TYPE =>2);
 for i in 1..1 loop
 for k in (select id from blng.contract where amnd_state in ( 'A','T') and id > 20 and id <146) loop
if k.id=25 then continue; end if;
v_contract:=k.id;
    v_bill := ord.ORD_API.bill_add( --v_ORDER => r_item_avia.order_oid,
                                P_AMOUNT => i*5,
                                P_DATE => sysdate,
                                P_STATUS => 'W', --[M]anaging
                                P_CONTRACT => v_contract,
                                p_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'CASH_IN'));
  
 -- commit;

  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_bill);
  
  v_ord:= ORD.ORD_API.ORD_ADD(  sysdate, '2', 113,'A');
  v_item_avia:= ORD.ORD_API.item_avia_ADD(  v_ord,'sssss',p_pnr_id=>'ssssa');
  v_item_avia_status:= ORD.ORD_API.item_avia_status_ADD(  v_item_avia);
    v_bill := ord.ORD_API.bill_add( p_ORDER => v_ord, --!!! or it will be error
                                P_AMOUNT => i*30,
                                P_DATE => sysdate,
                                P_STATUS => 'W', --[M]anaging
                                P_CONTRACT => v_contract,
                               p_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'BUY'));
  
--  commit;

--  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 0,P_TRANS_TYPE =>7,p_account_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'CREDIT_LIMIT'));

  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 10000000+i,p_account_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'CREDIT_LIMIT'));

--  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 0,P_TRANS_TYPE =>11,p_account_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'DELAY_DAY'));
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => i+100,p_account_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'DELAY_DAY'));
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);

end loop;
end loop;

  commit;

end;

/

/* first edition with check account value only*/
DECLARE


  v_contract  hdbk.dtype.t_id:=22;
    v_bill hdbk.dtype.t_id;
BEGIN


    v_bill := ord.ORD_API.bill_add( --v_ORDER => r_item_avia.order_oid,
                                P_AMOUNT => 6819.07,
                                P_DATE => sysdate,
                                P_STATUS => 'W', --[M]anaging
                                P_CONTRACT => v_contract,
                                p_bill=> 431420,
                                p_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'PAY_BILL'));
  

  commit;

end;


    BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name   => 'document_schedule', attribute         =>  'repeat_interval', value => 'FREQ=SECONDLY;INTERVAL=10') ;
END;

/
    BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name   => 'document_schedule', attribute         =>  'repeat_interval', value => 'FREQ=DAILY;INTERVAL=2') ;
END;
/


/* first edition with check account value only*/
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_client  ntg.dtype.t_id;
  P_NAME VARCHAR2(255):='pasha';
  v_contract  ntg.dtype.t_id;
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

  /*client*/
  v_client := blng.BLNG_API.client_add(P_NAME => P_NAME);
  DBMS_OUTPUT.PUT_LINE('v_client = ' || v_client);

/*contract*/
  v_contract := blng.BLNG_API.contract_add(P_CLIENT => v_CLIENT,
    P_NUMBER => P_NUMBER);
  DBMS_OUTPUT.PUT_LINE('v_contract = ' || v_contract); 
  BLNG.BLNG_API.account_init(v_contract);

  SELECT SYSTIMESTAMP INTO ending_time FROM DUAL;
  DBMS_OUTPUT.PUT_LINE('Time = ' || TO_CHAR(ending_time - starting_time));
end;


--test set/update increase/decrease limit
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  ntg.dtype.t_id:=14;
  P_number VARCHAR2(255);
  v_DOC ntg.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* ins doc limit 1000 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 1000,P_TRANS_TYPE =>7);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX          0          0         1000                  0            0                     0             0          0       1000 



  /* increase doc limit 1002 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 1002,P_TRANS_TYPE =>7);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
  
-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX          0          0         1002                  0            0                     0             0          0       1002 

  /* increase doc limit 1002 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 999,P_TRANS_TYPE =>7);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
  
-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX          0          0          999                  0            0                     0             0          0        999 

  /* set delay days 50 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 50,P_TRANS_TYPE =>11);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  /* set max loan trans amount 200 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 200,P_TRANS_TYPE =>8);
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
select  /* text */ * FROM ntg.log order by id desc;

-- approve document manually if it needed
begin
BLNG.core.approve_documents;
end;

--test first cash_in
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  ntg.dtype.t_id:=14;
  P_number VARCHAR2(255);
  v_DOC ntg.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* ins doc cash in 500 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 500,P_TRANS_TYPE =>2);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;
  
  
-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX        500          0          999                  0            0                   200             0         50       1499 


end;

  SELECT /* text */ * FROM blng.v_account order by contract_oid desc;
--check docs
select  /* text */ * FROM blng.document order by id desc;
--check transactions
select  /* text */ * FROM blng.transaction order by id desc;
--check log
select  /* text */ * FROM ntg.log order by id desc;

--test buy from deposit
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  ntg.dtype.t_id:=14;
  P_number VARCHAR2(255);
  v_DOC ntg.dtype.t_id;
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
select  /* text */ * FROM ntg.log order by id desc;


--test buy from deposit and loan second document with amount more then MAX_LOAN_TRANS_AMOUNT
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  ntg.dtype.t_id:=14;
  P_number VARCHAR2(255);
  v_DOC ntg.dtype.t_id;
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
select  /* text */ * FROM ntg.log order by id desc;



--test close loan and close delay half part and full delay
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  ntg.dtype.t_id:=14;
  P_number VARCHAR2(255);
  v_DOC ntg.dtype.t_id;
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
select  /* text */ * FROM blng.document order by id desc;
--check transactions
select  /* text */ * FROM blng.transaction order by id desc;
--check delay
select  /* text */ * FROM blng.delay where id >=55 order by id desc;
--check log
select  /* text */ * FROM ntg.log order by id desc;


--test insufficient funds exception and delay expire
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  ntg.dtype.t_id:=14;
  P_number VARCHAR2(255);
  v_DOC ntg.dtype.t_id;
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

update blng.delay set date_to = trunc(sysdate)-1 where id = 61;
commit;

-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX          0       -500          999               -999            0                  2000             0         50       -500 


DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  ntg.dtype.t_id:=14;
  P_number VARCHAR2(255);
  v_DOC ntg.dtype.t_id;
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
select  /* text */ * FROM ntg.log order by id desc;



--test delay and limit unblock
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  ntg.dtype.t_id:=14;
  P_number VARCHAR2(255);
  v_DOC ntg.dtype.t_id;
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
select  /* text */ * FROM ntg.log order by id desc;


--test expire unblock limit

--expire unblock limit. delay row for unblock limit set status C
update blng.delay set date_to = trunc(sysdate) where id = 62;
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
  v_contract  ntg.dtype.t_id:=14;
  P_number VARCHAR2(255);
  v_DOC ntg.dtype.t_id;
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
select  /* text */ * FROM ntg.log order by id desc;



--test unblock limit by cash_in
DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  ntg.dtype.t_id:=14;
  P_number VARCHAR2(255);
  v_DOC ntg.dtype.t_id;
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
--          XXX          0        -99          999                               0                  2000             0         50        900 

--delay
--         ID AMND_DATE           AMND_USER                                          AMND_STATE  AMND_PREV EVENT_TYPE_OID TRANSACTION_OID DATE_TO             CONTRACT_OID     AMOUNT STATUS   PRIORITY
-- ---------- ------------------- -------------------------------------------------- ---------- ---------- -------------- --------------- ------------------- ------------ ---------- ------ ----------
--         67 04.11.2014 22:17:20 NTG                                                I                  63              2             188 24.12.2014 00:00:00           14       -100                10 
--         66 04.11.2014 22:36:22 NTG                                                I                  61              2                 04.11.2014 00:00:00           14       -200                10 
--         65 04.11.2014 21:40:51 NTG                                                I                  61              2             180 04.11.2014 00:00:00           14       -500                10 
--         63 04.11.2014 22:36:30 NTG                                                A                  63              2                 24.12.2014 00:00:00           14        -99                10 
--         61 04.11.2014 22:36:30 NTG                                                C                  61              2                 04.11.2014 00:00:00           14       -200                10 


end;


DECLARE
  starting_time  TIMESTAMP WITH TIME ZONE;
  ending_time    TIMESTAMP WITH TIME ZONE;
  v_contract  ntg.dtype.t_id:=14;
  P_number VARCHAR2(255);
  v_DOC ntg.dtype.t_id;
  r_contract_info blng.v_account%rowtype;

BEGIN

  /* ins doc buy 150 */
  v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => 150,P_TRANS_TYPE =>1);
  DBMS_OUTPUT.PUT_LINE('v_DOC = ' || v_DOC);
  commit;

-- CONTRACT_OID    DEPOSIT       LOAN CREDIT_LIMIT CREDIT_LIMIT_BLOCK DEBIT_ONLINE MAX_LOAN_TRANS_AMOUNT CREDIT_ONLINE DELAY_DAYS  AVAILABLE
-- ------------ ---------- ---------- ------------ ------------------ ------------ --------------------- ------------- ---------- ----------
--          XXX          0       -249          999                               0                  2000             0         50        750 

--delay
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
select  /* text */ * FROM blng.delay where id >= 61 and amnd_state = 'A' order by id desc;
--check log
select  /* text */ * FROM ntg.log order by id desc;


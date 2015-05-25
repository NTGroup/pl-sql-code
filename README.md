## BLNG.BLNG\_API ##



*description:*  
***\_add insert row into table ***. could return id of new row. ***\_edit update row into table ***. object have always one id. first, old data with amnd\_state = [I]nactive inserted as row with link to new row(amnd\_prev). new data just update object row, amnd\_date updates to sysdate and amnd\_user to current user who called api. ***\_get\_info return data from table *** with format SYS\_REFCURSOR. ***\_get\_info\_r return one row from table *** with format ***%rowtype.  



- *procedure* **BLNG.BLNG\_API.account\_init**  
*description:*  
create all accounts under the contract  
*parameters:*  
**p\_contract**: contract id  



## blng.core ##



- *constant* **blng.core.g\_delay\_days**  
*description:*  
means how many days client has for pay loan  



- *procedure* **blng.core.approve\_documents**  
*description:*  
calls from scheduler. get list of document and separate it by transaction type. documents like increase credit limit or loan days approve immediately docs like cash\_in/buy push to credit/debit\_online accounts.  



- *procedure* **blng.core.buy**  
*description:*  
calls inside approve\_documents and push buy documents to debit\_online account  
*parameters:*  
**p\_doc**: id of document  



- *procedure* **blng.core.cash\_in**  
*description:*  
calls inside approve\_documents and push cash\_in documents to credit\_online account  
*parameters:*  
**p\_doc**: row from document  



- *procedure* **blng.core.pay\_bill**  
*description:*  
procedure make paing for one bill  
*parameters:*  
**p\_doc**: row from document  



- *procedure* **blng.core.credit\_online**  
*description:*  
calls from scheduler. get list of credit\_online accounts and separate money to debit or loan accounts. then close loan delay  



- *procedure* **blng.core.debit\_online**  
*description:*  
calls from scheduler. get list of debit\_online accounts and separate money to debit or loan accounts. then create loan delay  



- *procedure* **blng.core.online**  
*description:*  
calls from scheduler debit\_online and credit\_online procedures. then create loan delay  



- *procedure* **blng.core.delay\_remove**  
*description:*  
calls from credit\_online and close loan delay  
*parameters:*  
**p\_contract**: id of contract  
**p\_amount**: how much money falls to delay list  
**p\_transaction**: link to transaction id. later by this id cash\_in operations may revokes  



- *procedure* **blng.core.delay\_expire**  
*description:*  
calls from scheduler at 00:00 UTC. get list of expired delays, then block credit limit  



- *procedure* **blng.core.contract\_unblock**  
*description:*  
calls by office user and give chance to pay smth for p\_days. due to this days expired contract have unblocked credit limit. after p\_days it blocks again  
*parameters:*  
**p\_contract**: id of expired contract  
**p\_days**: how much days gifted to client  



- *procedure* **blng.core.unblock**  
*description:*  
check if contract do not have expired delays and unblock it  
*parameters:*  
**p\_contract**: id of expired contract  



- *procedure* **blng.core.revoke\_document**  
*description:*  
get back money and erase transactions by p\_document id  
*parameters:*  
**p\_document**: id of document  



- *function* **blng.core.pay\_contract\_by\_client**  
*description:*  
get contract which client can spend money documents like increase credit limit or loan days approve immediately docs like buy or cash\_in push to credit/debit\_online accounts.  
*parameters:*  
**p\_client**: client id  
*return:*  
contract id  



## blng.fwdr ##



- *function* **blng.fwdr.get\_tenant**  
*description:*  
return tenant. tenant is contract identifire. tenant using for checking is client registered in the system.  
*parameters:*  
**p\_email**: user email  
*return:*  
contract identifire  



- *function* **blng.fwdr.company\_insteadof\_client**  
*description:*  
return id of client with max id across company  
*parameters:*  
**p\_company**: company id where we looking for client  
*return:*  
client id  



- *function* **blng.fwdr.balance**  
*description:*  
return info of contract for show balance to the client  
*parameters:*  
**P\_TENANT\_ID**: contract id  
*return:*  
SYS\_REFCURSOR[CONTRACT\_OID, DEPOSIT, LOAN, CREDIT\_LIMIT, UNUSED\_CREDIT\_LIMIT,AVAILABLE, BLOCK\_DATE, UNBLOCK\_SUM, NEAR\_UNBLOCK\_SUM, EXPIRY\_DATE, EXPIRY\_SUM]  



- *function* **blng.fwdr.whoami**  
*description:*  
return info for user  
*parameters:*  
**p\_user**: email  
*return:*  
SYS\_REFCURSOR[CLIENT\_ID, LAST\_NAME, FIRST\_NAME, EMAIL, PHONE, --TENANT\_ID,BIRTH\_DATE, GENDER, NATIONALITY, NLS\_NATIONALITY, DOC\_ID, DOC\_EXPIRY\_DATE,DOC\_NUMBER, DOC\_LAST\_NAME, DOC\_FIRST\_NAME, DOC\_OWNER, DOC\_GENDER,DOC\_BIRTH\_DATE, DOC\_NATIONALITY, DOC\_NLS\_NATIONALITY, DOC\_PHONE, COMPANY\_NAME,is\_tester]  



- *function* **blng.fwdr.client\_data\_edit**  
*description:*  
update client documents. if success return true else false  
*parameters:*  
**p\_data**: data for update. format json[email, first\_name, last\_name, gender, birth\_date, nationality, phone, docs[doc\_expiry\_date, doc\_gender, doc\_first\_name, doc\_last\_name, doc\_number, doc\_owner, doc\_id, doc\_nationality, doc\_birth\_date,doc\_phone]]  
*return:*  
SYS\_REFCURSOR[res:true/false]  



- *function* **blng.fwdr.statement**  
*description:*  
return list of transactions between dates in client timezone format  
*parameters:*  
**p\_email**: user email which request statement  
**p\_row\_count**: count rows per page  
**p\_page\_number**: page number to show  
**p\_date\_from**: date filter.  
**p\_date\_to**: date filter.  
*return:*  
SYS\_REFCURSOR[rn(row\_number),all v\_statemen filds + amount\_cash\_in,amount\_buy,amount\_from,amount\_to,page\_count,row\_count]  



- *function* **blng.fwdr.statement**  
*description:*  
return list of transactions in client timezone format by pages  
*parameters:*  
**p\_email**: user email which request statement  
**p\_row\_count**: count rows per page  
**p\_page\_number**: page number to show  
*return:*  
SYS\_REFCURSOR[rn(row\_number),all v\_statemen filds + amount\_cash\_in,amount\_buy,amount\_from,amount\_to,page\_count,row\_count]  



- *function* **blng.fwdr.loan\_list**  
*description:*  
return list of loans with expired flag  
*parameters:*  
**p\_email**: user email who request loan\_list  
**p\_rownum**: cuts rows for paging  
*return:*  
SYS\_REFCURSOR[ID, CONTRACT\_OID, AMOUNT, ORDER\_NUMBER, PNR\_ID, DATE\_TO, IS\_OVERDUE]  



- *function* **blng.fwdr.v\_account\_get\_info\_r**  
*description:*  
return all fields from blng.v\_account  
*parameters:*  
**p\_contract**: contract id  
*return:*  
SYS\_REFCURSOR[all v\_statemen fields]  



- *function* **blng.fwdr.contract\_get**  
*description:*  
return list of contract with company  
*parameters:*  
**p\_contract**: contract id  
*return:*  
SYS\_REFCURSOR[COMPANY\_ID, CONTRACT\_ID, COMPANY\_NAME, CONTRACT\_NUMBER]  



- *function* **blng.fwdr.check\_tenant**  
*description:*  
return tenant. tenant is contract identifire. tenant using for checking is client registered in the system. if user dosnt exist then return NULL  
*parameters:*  
**p\_email**: user email  
*return:*  
contract identifire  



- *function* **blng.fwdr.god\_unblock**  
*description:*  
unblock user god@ntg-one.com. this user must be usually at blocked status [C]losed  
*return:*  
res[SUCCESS/ERROR/NO\_DATA\_FOUND]  



- *function* **blng.fwdr.god\_block**  
*description:*  
block user god@ntg-one.com. this user must be usually at blocked status [C]losed  
*return:*  
res[SUCCESS/ERROR/NO\_DATA\_FOUND]  



- *function* **blng.fwdr.god\_move**  
*description:*  
move user god@ntg-one.com to contract with id equals p\_tenant. mission of god@ntg-one.com is to login under one of a contract and check errors. god can help others to understand some problems  
*parameters:*  
**p\_tenant**: id of contract  
*return:*  
res[SUCCESS/ERROR/NO\_DATA\_FOUND]  



- *function* **blng.fwdr.client\_list()**  
*description:*  
return list of clients(company now).  
*return:*  
on success SYS\_REFCURSOR[client\_id,name].on error SYS\_REFCURSOR[res]. res=ERROR  



- *function* **blng.fwdr.client\_add**  
*description:*  
create client(company now) and return info about this new client(company now).  
*parameters:*  
**p\_name**: name of client  
*return:*  
on success SYS\_REFCURSOR[res,client\_id,name]on error SYS\_REFCURSOR[res]. res=ERROR  



- *function* **blng.fwdr.contract\_list**  
*description:*  
return list of contracts by client id (company now)  
*parameters:*  
**p\_client**: id of client  
*return:*  
on success SYS\_REFCURSOR[CONTRACT\_ID, TENANT\_ID, IS\_BLOCKED, CONTRACT\_NAME,CREDIT\_LIMIT, DELAY\_DAYS, MAX\_CREDIT, UTC\_OFFSET, CONTACT\_NAME, CONTACT\_PHONE]on error SYS\_REFCURSOR[res]. res=ERROR  



- *function* **blng.fwdr.contract\_list**  
*description:*  
return list of contracts by client id (company now) and return info about this new contract.  
*parameters:*  
**p\_client**: id of client  
**p\_data**: json[CONTRACT\_NAME, CREDIT\_LIMIT, DELAY\_DAYS, MAX\_CREDIT, UTC\_OFFSET, CONTACT\_NAME, CONTACT\_PHONE]  
*return:*  
on success SYS\_REFCURSOR[res, CONTRACT\_ID, TENANT\_ID, IS\_BLOCKED, CONTRACT\_NAME,CREDIT\_LIMIT, DELAY\_DAYS, MAX\_CREDIT, UTC\_OFFSET, CONTACT\_NAME, CONTACT\_PHONEon error SYS\_REFCURSOR[res]. res=ERROR  



## dict.dict\_api ##



*description:*  
***\_add insert row into table ***. could return id of new row. ***\_edit update row into table ***. object have always one id. first, old data with amnd\_state = [I]nactive inserted as row with link to new row(amnd\_prev). new data just update object row, amnd\_date updates to sysdate and amnd\_user to current user who called api. ***\_get\_info return data from table *** with format SYS\_REFCURSOR. ***\_get\_info\_r return one row from table *** with format ***%rowtype.  



## dict.DTYPE ##



- *data\_type* **dict.DTYPE.t\_clob**  
*description:*  
for id. integer/number(18,0) for money. float/number(20,2) for 1 letter statuses. char(1) for long messages less 4000 chars. string(4000)/varchar2(4000) for client names or geo names less 255 chars. string(255)/varchar2(255) for short codes less 10 chars. string(10)/varchar2(10) for long codes less 50 chars. string(50)/varchar2(50) for boolean values. for date with time values. for big data clob.  



- *exception variable* **dict.DTYPE.INVALID\_OPERATION**  
*description:*  
-6502 -6502 -20000 -20001 -20002 -20003 -20004 -20005  



## dict.fwdr ##



- *function* **dict.fwdr.get\_utc\_offset**  
*description:*  
list of airlines with utc\_offset  
*return:*  
SYS\_REFCURSOR[iata,utc\_offset]  



- *function* **dict.fwdr.geo\_get\_list**  
*description:*  
list of airports and city of airport  
*return:*  
SYS\_REFCURSOR[iata,name,NLS\_NAME,city\_iata,city\_name,city\_nls\_name]  



- *function* **dict.fwdr.airline\_get\_list**  
*description:*  
list of airlines names and iata codes  
*return:*  
SYS\_REFCURSOR[iata,name,nls\_name]  



- *function* **dict.fwdr.airplane\_get\_list**  
*description:*  
list of airplane names and iata codes  
*return:*  
SYS\_REFCURSOR[iata,name,nls\_name]  



- *function* **dict.fwdr.airline\_commission\_list**  
*description:*  
list of airlines with flag commission(means: is airline have rules for calc commission).  
*return:*  
SYS\_REFCURSOR[airline\_oid,name,IATA,commission[Y/N]]  



- *function* **dict.fwdr.get\_full**  
*description:*  
return all from v\_markup  
*return:*  
SYS\_REFCURSOR  



- *function* **dict.fwdr.markup\_get**  
*description:*  
when p\_version is null then return all active rows. if not null then get all active and deleted rows that changed after p\_version id  
*parameters:*  
**p\_version**: id  
*return:*  
SYS\_REFCURSOR[ID, TENANT\_ID, VALIDATING\_CARRIER, CLASS\_OF\_SERVICE,SEGMENT, V\_FROM, V\_TO, ABSOLUT\_AMOUNT, PERCENT\_AMOUNT, MIN\_ABSOLUT, VERSION, IS\_ACTIVE, markup\_type]  



## DICT.LOG\_API ##



- *procedure* **DICT.LOG\_API.log\_add**  
*description:*  
procedure for write log. this procedure make autonomous\_transaction commits. its mean independent of other function commit/rollback and not affect to other function commit/rollback  
*parameters:*  
**P\_PROC\_NAME**: name of process  
**P\_MSG**: message that wont be written to log  
**P\_MSG\_TYPE**: Information/Error or etc. default Information  
**P\_INFO**: some more details  
**P\_ALERT\_LEVEL**: 0..10. priority level, default 0  



## erp.erp\_api ##



*description:*  
***\_add insert row into table ***. could return id of new row. ***\_edit update row into table ***. object have always one id. first, old data with amnd\_state = [I]nactive inserted as row with link to new row(amnd\_prev). new data just update object row, amnd\_date updates to sysdate and amnd\_user to current user who called api. ***\_get\_info return data from table *** with format SYS\_REFCURSOR. ***\_get\_info\_r return one row from table *** with format ***%rowtype.  



## erp.gate ##



- *function* **erp.gate.get\_cursor**  
*description:*  
test function. return cursor with rowcount <= p\_rowcount  
*parameters:*  
**p\_rowcount**: count rows in response  
*return:*  
SYS\_REFCURSOR[n,date\_to,str,int,double]. table with this columns.  



- *procedure* **erp.gate.run\_proc**  
*description:*  
test procedure. do nothing, but return string "input: p\_rowcount" in out parameter o\_result.  
*parameters:*  
**p\_rowcount**: its just parameter for input  
**o\_result**: string out parameter for return "input: p\_rowcount"  



- *function* **erp.gate.pdf\_printer\_add**  
*description:*  
add new task for pdf printer  
*parameters:*  
**p\_payload**: json with booking data  
**p\_filename**: name of generated file  
**o\_id**: out parameter return row id  
*return:*  
row id  



- *procedure* **erp.gate.pdf\_printer\_edit**  
*description:*  
edit task for pdf printer  
*parameters:*  
**p\_id**: task id  
**p\_payload**: json with booking data  
**p\_status**: wich status you want to set: [N]ew,[E]rror,[D]one  
**p\_filename**: name of generated file  



- *procedure* **erp.gate.pdf\_printer\_get**  
*description:*  
return data for task  
*parameters:*  
**p\_id**: task id  
**o\_payload**: out parameter for return json with booking data  
**o\_status**: out parameter for return status of task  
**o\_filename**: out parameter for return file name  



- *function* **erp.gate.check\_user**  
*description:*  
return user\_id. if user dosnt exist then return NULL  
*parameters:*  
**p\_email**: user email  
*return:*  
user identifire  



## hdbk.core ##



- *function* **hdbk.core.delay\_payday**  
*description:*  
find nearest date for get money from client  
*parameters:*  
**P\_DELAY**: count of days to delay bill paying.  
**P\_CONTRACT**: id of contract. maybe at custom calendar we will find special PAYDAY  
*return:*  
day of pay  



## NTG.DTYPE ##



- *data\_type* **NTG.DTYPE.t\_clob**  
*description:*  
for id. integer/number(18,0) for money. float/number(20,2) for 1 letter statuses. char(1) for long messages less 4000 chars. string(4000)/varchar2(4000) for client names or geo names less 255 chars. string(255)/varchar2(255) for short codes less 10 chars. string(10)/varchar2(10) for long codes less 50 chars. string(50)/varchar2(50) for boolean values. for date with time values. for big data clob.  



- *exception variable* **NTG.DTYPE.DEAD\_LOCK**  
*description:*  
-6502 -6502 -20000 -20001 -20002 -20003 -20004 -20005 -60  



## hdbk.fwdr ##



- *function* **hdbk.fwdr.get\_utc\_offset**  
*description:*  
list of airlines with utc\_offset  
*return:*  
SYS\_REFCURSOR[iata,utc\_offset]  



- *function* **hdbk.fwdr.geo\_get\_list**  
*description:*  
list of airports and city of airport  
*return:*  
SYS\_REFCURSOR[iata,name,NLS\_NAME,city\_iata,city\_name,city\_nls\_name]  



- *function* **hdbk.fwdr.airline\_get\_list**  
*description:*  
list of airlines names and iata codes  
*return:*  
SYS\_REFCURSOR[iata,name,nls\_name]  



- *function* **hdbk.fwdr.airplane\_get\_list**  
*description:*  
list of airplane names and iata codes  
*return:*  
SYS\_REFCURSOR[iata,name,nls\_name]  



- *function* **hdbk.fwdr.airline\_commission\_list**  
*description:*  
list of airlines with flag commission(means: is airline have rules for calc commission).  
*return:*  
SYS\_REFCURSOR[airline\_oid,name,IATA,commission[Y/N]]  



- *function* **hdbk.fwdr.get\_full**  
*description:*  
return all from v\_markup  
*return:*  
SYS\_REFCURSOR  



- *function* **hdbk.fwdr.markup\_get**  
*description:*  
when p\_version is null then return all active rows. if not null then get all active and deleted rows that changed after p\_version id  
*parameters:*  
**p\_version**: id  
*return:*  
SYS\_REFCURSOR[ID, TENANT\_ID, VALIDATING\_CARRIER, CLASS\_OF\_SERVICE,SEGMENT, V\_FROM, V\_TO, ABSOLUT\_AMOUNT, PERCENT\_AMOUNT, MIN\_ABSOLUT, VERSION, IS\_ACTIVE, markup\_type]  



- *function* **hdbk.fwdr.rate\_list**  
*description:*  
return all active rates for current moment. its not depends of p\_version  
*parameters:*  
**p\_version**: version. not useful now.  
*return:*  
SYS\_REFCURSOR[code,rate,version,is\_active(Y,N)]  



## hdbk.hdbk\_api ##



*description:*  
***\_add insert row into table ***. could return id of new row. ***\_edit update row into table ***. object have always one id. first, old data with amnd\_state = [I]nactive inserted as row with link to new row(amnd\_prev). new data just update object row, amnd\_date updates to sysdate and amnd\_user to current user who called api. ***\_get\_info return data from table *** with format SYS\_REFCURSOR. ***\_get\_info\_r return one row from table *** with format ***%rowtype.  



## hdbk.LOG\_API ##



- *procedure* **hdbk.LOG\_API.log\_add**  
*description:*  
procedure for write log. this procedure make autonomous\_transaction commits. its mean independent of other function commit/rollback and not affect to other function commit/rollback  
*parameters:*  
**P\_PROC\_NAME**: name of process  
**P\_MSG**: message that wont be written to log  
**P\_MSG\_TYPE**: Information/Error or etc. default Information  
**P\_INFO**: some more details  
**P\_ALERT\_LEVEL**: 0..10. priority level, default 0  



##  ##



## NTG.DTYPE ##



- *data\_type* **NTG.DTYPE.t\_clob**  
*description:*  
for id. integer/number(18,0) for money. float/number(20,2) for 1 letter statuses. char(1) for long messages less 4000 chars. string(4000)/varchar2(4000) for client names or geo names less 255 chars. string(255)/varchar2(255) for short codes less 10 chars. string(10)/varchar2(10) for long codes less 50 chars. string(50)/varchar2(50) for boolean values. for date with time values. for big data clob.  



- *exception variable* **NTG.DTYPE.INVALID\_OPERATION**  
*description:*  
-6502 -6502 -20000 -20001 -20002 -20003 -20004 -20005  



## hdbk.fwdr ##



- *function* **hdbk.fwdr.get\_utc\_offset**  
*description:*  
list of airlines with utc\_offset  
*return:*  
SYS\_REFCURSOR[iata,utc\_offset]  



- *function* **hdbk.fwdr.geo\_get\_list**  
*description:*  
list of airports and city of airport  
*return:*  
SYS\_REFCURSOR[iata,name,NLS\_NAME,city\_iata,city\_name,city\_nls\_name]  



- *function* **hdbk.fwdr.airline\_get\_list**  
*description:*  
list of airlines names and iata codes  
*return:*  
SYS\_REFCURSOR[iata,name,nls\_name]  



- *function* **hdbk.fwdr.airplane\_get\_list**  
*description:*  
list of airplane names and iata codes  
*return:*  
SYS\_REFCURSOR[iata,name,nls\_name]  



- *function* **hdbk.fwdr.airline\_commission\_list**  
*description:*  
list of airlines with flag commission(means: is airline have rules for calc commission).  
*return:*  
SYS\_REFCURSOR[airline\_oid,name,IATA,commission[Y/N]]  



- *function* **hdbk.fwdr.get\_full**  
*description:*  
return all from v\_markup  
*return:*  
SYS\_REFCURSOR  



- *function* **hdbk.fwdr.markup\_get**  
*description:*  
when p\_version is null then return all active rows. if not null then get all active and deleted rows that changed after p\_version id  
*parameters:*  
**p\_version**: id  
*return:*  
SYS\_REFCURSOR[ID, TENANT\_ID, VALIDATING\_CARRIER, CLASS\_OF\_SERVICE,SEGMENT, V\_FROM, V\_TO, ABSOLUT\_AMOUNT, PERCENT\_AMOUNT, MIN\_ABSOLUT, VERSION, IS\_ACTIVE, markup\_type]  



## NTG.LOG\_API ##



- *procedure* **NTG.LOG\_API.log\_add**  
*description:*  
procedure for write log. this procedure make autonomous\_transaction commits. its mean independent of other function commit/rollback and not affect to other function commit/rollback  
*parameters:*  
**P\_PROC\_NAME**: name of process  
**P\_MSG**: message that wont be written to log  
**P\_MSG\_TYPE**: Information/Error or etc. default Information  
**P\_INFO**: some more details  
**P\_ALERT\_LEVEL**: 0..10. priority level, default 0  



## hdbk.hdbk\_api ##



*description:*  
***\_add insert row into table ***. could return id of new row. ***\_edit update row into table ***. object have always one id. first, old data with amnd\_state = [I]nactive inserted as row with link to new row(amnd\_prev). new data just update object row, amnd\_date updates to sysdate and amnd\_user to current user who called api. ***\_get\_info return data from table *** with format SYS\_REFCURSOR. ***\_get\_info\_r return one row from table *** with format ***%rowtype.  



## ORD.CORE ##



- *procedure* **ORD.CORE.bill\_pay**  
*description:*  
procedure perform transit bills with status [W]aiting to billing system. that means bill requested for pay. after that bill marked as [T]ransported this procedure executed from job scheduler  



- *procedure* **ORD.CORE.doc\_task\_list**  
*description:*  
procedure perform document tasks like pay for bills, set cledit limit and others money tasks. main idea of function is to separate BUY process from others. this procedure executed from job scheduler  



## ORD.ORD\_API ##



*description:*  
***\_add insert row into table ***. could return id of new row. ***\_edit update row into table ***. object have always one id. first, old data with amnd\_state = [I]nactive inserted as row with link to new row(amnd\_prev). new data just update object row, amnd\_date updates to sysdate and amnd\_user to current user who called api. ***\_get\_info return data from table *** with format SYS\_REFCURSOR. ***\_get\_info\_r return one row from table *** with format ***%rowtype.  



## TODOs: ##  
1. all this nullable fields are bad. document\_get\_info  
2. there must be check for users with ISSUES permission  
3. there must be check for users with ISSUES permission  
4. there must be check for users with ISSUES permission  
5. there must be check for users with ISSUES permission  



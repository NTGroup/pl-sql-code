## BLNG.BLNG\_API ##



*description:*  
*****\_add**: insert row into table ***. could return id of new row.  
*****\_edit**: update row into table ***. object have always one id. first, old data with amnd\_state = [I]nactive inserted as row with link to new row(amnd\_prev). new data just update object row, amnd\_date updates to sysdate and amnd\_user to current user who called api.  
*****\_get\_info**: return data from table *** with format SYS\_REFCURSOR.  
*****\_get\_info\_r**: return one row from table *** with format ***%rowtype.  



- *procedure* **BLNG.BLNG\_API.account\_init**  
*description:*  
create all accounts under the contract  
*parameters:*  
**p\_contract**: contract id  



## TODOs: ##  
1. all this nullable fields are bad. document\_get\_info  


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
calls from scheduler at 00.00 UTC. get list of expired delays, then block credit limit  



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



- *function* **blng.core.pay\_contract\_by\_user**  
*description:*  
get contract which user can spend money documents like increase credit limit or loan days approve immediately docs like buy or cash\_in push to credit/debit\_online accounts.  
*parameters:*  
**p\_user**: user id  
*return:*  
contract id  



## blng.fwdr ##



- *function* **blng.fwdr.get\_tenant**  
*description:*  
return tenant. tenant is contract identifire. tenant using for checking is user registered in the system.  
*parameters:*  
**p\_email**: user email  
*return:*  
contract identifire  



- *function* **blng.fwdr.client\_insteadof\_user**  
*description:*  
return id of user with max id across client  
*parameters:*  
**p\_client**: client id where we looking for user  
*return:*  
user id  



- *function* **blng.fwdr.balance**  
*description:*  
return info of contract for show balance to the client. function return this filds  
**DEPOSIT**: self money  
**LOAN**: money thatspent from credit limit  
**CREDIT\_LIMIT**: credit limit  
**UNUSED\_CREDIT\_LIMIT**: credit limit - abs(loan)  
**AVAILABLE**: credit limit + deposit - abs(loan). if contract bills are expired and contract blocked then 0. if contract bills are expired and contract unblocked then ussual summ.  
**BLOCK\_DATE**: expiration date of the next bill  
**UNBLOCK\_SUM**: sum next neares bills (with one day) + all bills before current day  
**NEAR\_UNBLOCK\_SUM**: unblock sum + bills for 2 next days after after first bill  
**EXPIRY\_DATE**: date of first expired bill  
**EXPIRY\_SUM**: summ of all expired bills  
**STATUS**: if bills are expired and contract blocked then 'BLOCK', if bills are expired and contract unblocked then 'UNBLOCK', else 'ACTIVE'  
*parameters:*  
**P\_TENANT\_ID**: contract id  
*return:*  
SYS\_REFCURSOR[CONTRACT\_OID, DEPOSIT, LOAN, CREDIT\_LIMIT, UNUSED\_CREDIT\_LIMIT,AVAILABLE, BLOCK\_DATE, UNBLOCK\_SUM, NEAR\_UNBLOCK\_SUM, EXPIRY\_DATE, EXPIRY\_SUM, status]  



- *function* **blng.fwdr.whoami**  
*description:*  
return info for user  
*parameters:*  
**p\_user**: email  
*return:*  
SYS\_REFCURSOR[USER\_ID, LAST\_NAME, FIRST\_NAME, EMAIL, PHONE, --TENANT\_ID,BIRTH\_DATE, GENDER, NATIONALITY, NLS\_NATIONALITY, DOC\_ID, DOC\_EXPIRY\_DATE,DOC\_NUMBER, DOC\_LAST\_NAME, DOC\_FIRST\_NAME, DOC\_OWNER, DOC\_GENDER,DOC\_BIRTH\_DATE, DOC\_NATIONALITY, DOC\_NLS\_NATIONALITY, DOC\_PHONE, client\_id, client\_NAME,is\_tester]  



- *function* **blng.fwdr.user\_data\_edit**  
*description:*  
update user documents. if success return true else false  
*parameters:*  
**p\_data**: data for update. format json[email, first\_name, last\_name, gender, birth\_date, nationality, phone, docs[doc\_expiry\_date, doc\_gender, doc\_first\_name, doc\_last\_name, doc\_number, doc\_owner, doc\_id, doc\_nationality, doc\_birth\_date,doc\_phone]]  
*return:*  
SYS\_REFCURSOR[res:true/false]  



- *function* **blng.fwdr.statement**  
*description:*  
return list of transactions between dates in user timezone format  
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
return list of transactions in user timezone format by pages  
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
return list of contract with client  
*parameters:*  
**p\_contract**: contract id  
*return:*  
SYS\_REFCURSOR[client\_ID, CONTRACT\_ID, client\_NAME, CONTRACT\_NUMBER]  



- *function* **blng.fwdr.check\_tenant**  
*description:*  
return tenant. tenant is contract identifire. tenant using for checking is user registered in the system. if user dosnt exist then return NULL  
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
return list of clients.  
*return:*  
on success SYS\_REFCURSOR[client\_id,name].on error SYS\_REFCURSOR[res]. res=ERROR  



- *function* **blng.fwdr.client\_add**  
*description:*  
create client and return info about this new client.  
*parameters:*  
**p\_name**: name of client  
*return:*  
on success SYS\_REFCURSOR[res,client\_id,name]on error SYS\_REFCURSOR[res]. res=ERROR  



- *function* **blng.fwdr.contract\_list**  
*description:*  
return list of contracts by client id  
*parameters:*  
**p\_client**: id of client  
*return:*  
on success SYS\_REFCURSOR[client\_id, CONTRACT\_ID, TENANT\_ID, IS\_BLOCKED, CONTRACT\_NAME,CREDIT\_LIMIT, DELAY\_DAYS, MAX\_CREDIT, UTC\_OFFSET, CONTACT\_NAME, contract\_number,CONTACT\_PHONE]on error SYS\_REFCURSOR[res]. res=ERROR  



- *function* **blng.fwdr.contract\_add**  
*description:*  
add contract for client and return info about this new contract.  
*parameters:*  
**p\_client**: id of client  
**p\_data**: json[CONTRACT\_NAME, CREDIT\_LIMIT, DELAY\_DAYS, MAX\_CREDIT, UTC\_OFFSET, CONTACT\_NAME, CONTACT\_PHONE]  
*return:*  
on success SYS\_REFCURSOR[client\_id, CONTRACT\_ID, TENANT\_ID, IS\_BLOCKED, CONTRACT\_NAME, contract\_number,CREDIT\_LIMIT, DELAY\_DAYS, MAX\_CREDIT, UTC\_OFFSET, CONTACT\_NAME, CONTACT\_PHONEon error SYS\_REFCURSOR[res]. res=ERROR  



- *function* **blng.fwdr.contract\_update**  
*description:*  
update contract info for client and return info about this new contract.  
*parameters:*  
**p\_contract**: id of contract  
**p\_data**: json[CONTRACT\_NAME, CREDIT\_LIMIT, DELAY\_DAYS, MAX\_CREDIT, UTC\_OFFSET, CONTACT\_NAME, CONTACT\_PHONE]  
*return:*  
on success SYS\_REFCURSOR[client\_id, CONTRACT\_ID, TENANT\_ID, IS\_BLOCKED, CONTRACT\_NAME,CREDIT\_LIMIT, DELAY\_DAYS, MAX\_CREDIT, UTC\_OFFSET, CONTACT\_NAME,contract\_number, CONTACT\_PHONEon error SYS\_REFCURSOR[res]. res=ERROR  



## hdbk.core ##



- *function* **hdbk.core.delay\_payday**  
*description:*  
find nearest date for get money from client  
*parameters:*  
**P\_DELAY**: count of days to delay bill paying.  
**P\_CONTRACT**: id of contract. maybe at custom calendar we will find special PAYDAY  
*return:*  
day of pay  



## HDBK.DTYPE ##



- *data\_type* **HDBK.DTYPE.t\_id**  
*description:*  
for id. integer/number(18,0)  



- *data\_type* **HDBK.DTYPE.t\_amount**  
*description:*  
for money. float/number(20,2)  



- *data\_type* **HDBK.DTYPE.t\_status**  
*description:*  
for 1 letter statuses. char(1)  



- *data\_type* **HDBK.DTYPE.t\_msg**  
*description:*  
for long messages less 4000 chars. string(4000)/varchar2(4000)  



- *data\_type* **HDBK.DTYPE.t\_name**  
*description:*  
for client names or geo names less 255 chars. string(255)/varchar2(255)  



- *data\_type* **HDBK.DTYPE.t\_code**  
*description:*  
for short codes less 10 chars. string(10)/varchar2(10)  



- *data\_type* **HDBK.DTYPE.t\_long\_code**  
*description:*  
for long codes less 50 chars. string(50)/varchar2(50)  



- *data\_type* **HDBK.DTYPE.t\_bool**  
*description:*  
for boolean values.  



- *data\_type* **HDBK.DTYPE.t\_date**  
*description:*  
for date with time values.  



- *data\_type* **HDBK.DTYPE.t\_clob**  
*description:*  
for big data clob.  



- *exception variable* **HDBK.DTYPE.INVALID\_PARAMETER**  
*description:*  
-6502  



- *exception variable* **HDBK.DTYPE.max\_loan\_transaction\_block**  
*description:*  
-6502  



- *exception variable* **HDBK.DTYPE.doc\_waiting**  
*description:*  
-20000  



- *exception variable* **HDBK.DTYPE.insufficient\_funds**  
*description:*  
-20001  



- *exception variable* **HDBK.DTYPE.api\_error**  
*description:*  
-20002  



- *exception variable* **HDBK.DTYPE.VALUE\_ERROR**  
*description:*  
-20003  



- *exception variable* **HDBK.DTYPE.EXIT\_ALERT**  
*description:*  
-20004  



- *exception variable* **HDBK.DTYPE.INVALID\_OPERATION**  
*description:*  
-20005  



- *exception variable* **HDBK.DTYPE.DEAD\_LOCK**  
*description:*  
-60  



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
list of airlines with flag commission(it means, is airline have rules for calc commission).  
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
*****\_add**: insert row into table ***. could return id of new row.  
*****\_edit**: update row into table ***. object have always one id. first, old data with amnd\_state = [I]nactive inserted as row with link to new row(amnd\_prev). new data just update object row, amnd\_date updates to sysdate and amnd\_user to current user who called api.  
*****\_get\_info**: return data from table *** with format SYS\_REFCURSOR.  
*****\_get\_info\_r**: return one row from table *** with format ***%rowtype.  



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



## ORD.CORE ##



- *procedure* **ORD.CORE.bill\_pay**  
*description:*  
procedure perform transit bills with status [W]aiting to billing system. that means bill requested for pay. after that bill marked as [T]ransported this procedure executed from job scheduler  



- *procedure* **ORD.CORE.doc\_task\_list**  
*description:*  
procedure perform document tasks like pay for bills, set cledit limit and others money tasks. main idea of function is to separate BUY process from others. this procedure executed from job scheduler  



## ord.fwdr ##



- *function* **ord.fwdr.order\_create**  
*description:*  
fake function. used in avia\_register for creating emty order  
*parameters:*  
**p\_date**: date for wich we need create order  
**p\_order\_number**: number could set or generate inside  
**p\_status**: status like 'W' waiting or smth else  
*return:*  
id of created order  



- *function* **ord.fwdr.item\_add**  
*description:*  
fake function.  
*return:*  
id of created item  



- *procedure* **ord.fwdr.avia\_update**  
*description:*  
procedure update item\_avia row searched by pnr\_id.  
*parameters:*  
**p\_pnr\_id**: id from NQT. search perform by this id  
**p\_pnr\_locator**: record locator just for info  
**p\_time\_limit**: time limit just for info  
**p\_total\_amount**: total amount including markup  
**p\_total\_markup**: just total markup  
**p\_pnr\_object**: json for backup  
**p\_nqt\_status**: current NQT process  
**p\_tenant\_id**: id of contract in text format, for authorization  



- *procedure* **ord.fwdr.avia\_reg\_ticket**  
*description:*  
procedure get ticket info by pnr\_id. its create row for ticket. later this info will send to managers  
*parameters:*  
**p\_pnr\_id**: id from NQT. search perform by this id  
**p\_tenant\_id**: id of contract in text format, for authorization  
**p\_ticket**: json[p\_number,p\_name,p\_fare\_amount,p\_tax\_amount,p\_markup\_amount,p\_type]  



- *procedure* **ord.fwdr.avia\_pay**  
*description:*  
procedure send all bills in status [M]arked to [W]aiting in billing for pay.  
*parameters:*  
**p\_user\_id**: user identifire. at this moment email  
**p\_pnr\_id**: id from NQT. search perform by this id  



- *function* **ord.fwdr.order\_get**  
*description:*  
fake  



- *function* **ord.fwdr.item\_list**  
*description:*  
fake  



- *function* **ord.fwdr.item\_list**  
*description:*  
fake  



- *function* **ord.fwdr.pnr\_list**  
*description:*  
get pnr list whith statuses listed in p\_nqt\_status\_list and with paging by p\_rownum count.  
*parameters:*  
**p\_nqt\_status\_list**: json[status]  
**p\_rownum**: filter for rows count  
*return:*  
sys\_refcursor[pnr\_id, nqt\_status, po\_status, nqt\_status\_cur, null po\_msg, 'avia' item\_type, pnr\_locator, tenant\_id]  



- *function* **ord.fwdr.pnr\_list**  
*description:*  
get pnr list whith id listed in p\_pnr\_list.  
*parameters:*  
**p\_pnr\_list**: json[p\_pnr\_id,p\_tenant\_id], where  
**p\_pnr\_id**: id from NQT. search perform by this id  
**p\_tenant\_id**: id of contract in text format, for authorization  
*return:*  
sys\_refcursor[pnr\_id, nqt\_status, po\_status, nqt\_status\_cur, null po\_msg, 'avia' item\_type, pnr\_locator,tenant\_id]  



- *procedure* **ord.fwdr.commission\_get**  
*description:*  
calculate commission for pnr\_id  
*parameters:*  
**p\_pnr\_id**: id from NQT. search perform by this id  
**p\_tenant\_id**: id of contract in text format, for authorization  
**o\_fix**: in this paraveter returned fix commission value  
**o\_percent**: in this paraveter returned percent commission value  



- *function* **ord.fwdr.order\_number\_generate**  
*description:*  
generate order number as last number + 1 by user id  
*parameters:*  
**p\_user**: user id.  
*return:*  
string like 0012410032, where 1241 - user id and 32 is a counter of order  



- *procedure* **ord.fwdr.avia\_manual**  
*description:*  
update order status to p\_result[ERROR/SUCCESS] or to INPROGRESS, if ERROR then return all money.  
*parameters:*  
**p\_pnr\_id**: id from NQT. search perform by this id  
**p\_tenant\_id**: id of contract in text format, for authorization  
**p\_result**: [ERROR/SUCCESS/ if null then INPROGRESS]  



- *procedure* **ord.fwdr.cash\_back**  
*description:*  
perform reverse for order scheme. return bill to Waiting status and call revoke\_document from billing  
*parameters:*  
**p\_pnr\_id**: id from NQT. search perform by this id  



- *function* **ord.fwdr.get\_sales\_list**  
*description:*  
fake  



- *function* **ord.fwdr.rule\_view**  
*description:*  
return all rules by iata code of airline  
*parameters:*  
**p\_iata**: iata 2 char code  
*return:*  
SYS\_REFCURSOR[fields from v\_rule view]  



- *procedure* **ord.fwdr.avia\_create**  
*description:*  
procedure create item\_avia row only. it cant update item. add PNR info like who, where, when  
*parameters:*  
**p\_pnr\_id**: id from NQT. search perform by this id  
**p\_user\_id**: user identifire. at this moment email  
**p\_itinerary**: PNR info like who, where, when  



- *procedure* **ord.fwdr.avia\_booked**  
*description:*  
procedure send item/order/bill to billing for pay.  
*parameters:*  
**p\_pnr\_id**: id from NQT. search perform by this id  
**p\_user\_id**: user identifire. at this moment email  



- *function* **ord.fwdr.pos\_rule\_get**  
*description:*  
when p\_version is null then return all active rows. if not null then get all active and deleted rows that changed after p\_version id  
*parameters:*  
**p\_version**: id  
*return:*  
SYS\_REFCURSOR[ID, TENANT\_ID, VALIDATING\_CARRIER,booking\_pos,ticketing\_pos,stock,printer,VERSION, IS\_ACTIVE]default tenant\_id = 0, default validating\_carrier = 'YY'  



- *function* **ord.fwdr.pos\_rule\_edit**  
*description:*  
update pos\_rules or create new pos\_rules. if success return true else false. if status equals [C]lose or [D]elete then delete pos\_rule.  
*parameters:*  
**p\_data**: data for update. format json[id, tenant\_id, validating\_carrier, booking\_pos, ticketing\_pos, stock, printer, status]  
*return:*  
SYS\_REFCURSOR[res:true/false]  



- *function* **ord.fwdr.rule\_edit**  
*description:*  
update commission rules or create new commission rules. if success return true else false. if status equals [C]lose or [D]elete then delete commission rule.  
*parameters:*  
**p\_data**: data for update. format json[AIRLINE\_ID, CONTRACT\_ID, RULE\_ID, RULE\_DESCRIPTION, RULE\_LIFE\_FROM, RULE\_LIFE\_TO, RULE\_AMOUNT, RULE\_AMOUNT\_MEASURE, RULE\_PRIORITY, CONDITION\_ID,condition\_status, TEMPLATE\_TYPE\_ID, TEMPLATE\_NAME\_NLS, TEMPLATE\_VALUE]  
*return:*  
SYS\_REFCURSOR[res:true/false]  



- *function* **ord.fwdr.rule\_delete**  
*description:*  
delete commission rule.  
*parameters:*  
**p\_id**: rule id  
*return:*  
SYS\_REFCURSOR[res:true/false]  



- *function* **ord.fwdr.rule\_template\_list**  
*description:*  
return all commission templates  
*parameters:*  
**p\_is\_contract\_type**: if 'Y' then return all contract\_types else all template\_types  
*return:*  
SYS\_REFCURSOR[ID, TEMPLATE\_TYPE, PRIORITY, DETAILS, IS\_CONTRACT\_TYPE, NAME, NLS\_NAME, IS\_VALUE]  



- *function* **ord.fwdr.bill\_import\_list**  
*description:*  
return all bills info for import into 1C  
*return:*  
SYS\_REFCURSOR[BILL\_OID, ITEM, IS\_NDS, FLIGHT\_FROM, FLIGHT\_TO, FARE\_AMOUNT, CONTRACT\_NUMBER, PASSENGER\_NAME]  



- *function* **ord.fwdr.markup\_rule\_get**  
*description:*  
return all markup rules  
*parameters:*  
**p\_version**: version id. filter new changes  
*return:*  
SYS\_REFCURSOR[ID, IS\_ACTIVE, VERSION, TENANT\_ID, IATA, MARKUP\_TYPE, RULE\_AMOUNT, RULE\_AMOUNT\_MEASURE, MIN\_ABSOLUT, PRIORITY, PER\_SEGMENT,CONTRACT\_TYPE,CONDITION\_COUNT]  



- *function* **ord.fwdr.markup\_templ\_get**  
*description:*  
return all markup templates for rule id  
*parameters:*  
**p\_rule\_id**: id of rule  
*return:*  
SYS\_REFCURSOR[ID, TEMPLATE\_TYPE\_CODE, TEMPLATE\_VALUE]  



- *function* **ord.fwdr.task\_get**  
*description:*  
return task for 1c  
*return:*  
SYS\_REFCURSOR[email, TASK\_ID, CONTRACT\_ID, DESCRIPTION, QUANTITY, PRICE, VAT]  



- *function* **ord.fwdr.task\_close**  
*description:*  
mark task as [C]losed  
*parameters:*  
**p\_task**: task id  
**p\_number\_1c**: 1c bill number  
*return:*  
SYS\_REFCURSOR[res]  



## TODOs: ##  
1. there must be check for users with ISSUES permission  


## ORD.ORD\_API ##



*description:*  
*****\_add**: insert row into table ***. could return id of new row.  
*****\_edit**: update row into table ***. object have always one id. first, old data with amnd\_state = [I]nactive inserted as row with link to new row(amnd\_prev). new data just update object row, amnd\_date updates to sysdate and amnd\_user to current user who called api.  
*****\_get\_info**: return data from table *** with format SYS\_REFCURSOR.  
*****\_get\_info\_r**: return one row from table *** with format ***%rowtype.  




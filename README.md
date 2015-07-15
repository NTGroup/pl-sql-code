
# BLNG.BLNG\_API
---
_DESCRIPTION:_  
**\*\_add:** insert row into table \*. could return id of new row.  
**\*\_edit:** update row into table \*. object have always one id. first, old data with amnd\_state = [i]nactive  
inserted as row with link to new row(amnd\_prev). new data just update object row,  
amnd\_date updates to sysdate and amnd\_user to current user who called api.  
**\*\_get\_info:** return data from table \* with format sys\_refcursor.  
**\*\_get\_info\_r:** return one row from table \* with format \*%rowtype.  

### _procedure_ BLNG.BLNG\_API.ACCOUNT\_INIT  
_DESCRIPTION:_  
create all accounts under the contract  
_PARAMETERS:_  
**p\_contract:** contract id  

# BLNG.CORE
---

### _constant_ BLNG.CORE.G\_DELAY\_DAYS  
_DESCRIPTION:_  
means how many days client has for pay loan  

### _procedure_ BLNG.CORE.APPROVE\_DOCUMENTS  
_DESCRIPTION:_  
calls from scheduler. get list of document and separate it by transaction type.  
documents like increase credit limit or loan days approve immediately  
docs like cash\_in/buy push to credit/debit\_online accounts.  

### _procedure_ BLNG.CORE.BUY  
_DESCRIPTION:_  
calls inside approve\_documents and push buy documents to debit\_online account  
_PARAMETERS:_  
**p\_doc:** id of document  

### _procedure_ BLNG.CORE.CASH\_IN  
_DESCRIPTION:_  
calls inside approve\_documents and push cash\_in documents to credit\_online account  
_PARAMETERS:_  
**p\_doc:** row from document  

### _procedure_ BLNG.CORE.PAY\_BILL  
_DESCRIPTION:_  
procedure make paing for one bill  
_PARAMETERS:_  
**p\_doc:** row from document  

### _procedure_ BLNG.CORE.CREDIT\_ONLINE  
_DESCRIPTION:_  
calls from scheduler. get list of credit\_online accounts and separate money to debit or loan accounts.  
then close loan delay  

### _procedure_ BLNG.CORE.DEBIT\_ONLINE  
_DESCRIPTION:_  
calls from scheduler. get list of debit\_online accounts and separate money to debit or loan accounts.  
then create loan delay  

### _procedure_ BLNG.CORE.ONLINE  
_DESCRIPTION:_  
calls from scheduler debit\_online and credit\_online procedures.  
then create loan delay  

### _procedure_ BLNG.CORE.DELAY\_REMOVE  
_DESCRIPTION:_  
calls from credit\_online and close loan delay  
_PARAMETERS:_  
**p\_contract:** id of contract  
**p\_amount:** how much money falls to delay list  
**p\_doc:** link to document id. later by this id cash\_in operations may revokes  

### _procedure_ BLNG.CORE.DELAY\_EXPIRE  
_DESCRIPTION:_  
calls from scheduler at 00.00 utc. get list of expired delays, then block credit limit  

### _procedure_ BLNG.CORE.CONTRACT\_UNBLOCK  
_DESCRIPTION:_  
calls by office user and give chance to pay smth for p\_days.  
due to this days expired contract have unblocked credit limit.  
after p\_days it blocks again  
_PARAMETERS:_  
**p\_contract:** id of expired contract  
**p\_days:** how much days gifted to client  

### _procedure_ BLNG.CORE.UNBLOCK  
_DESCRIPTION:_  
check if contract do not have expired delays and unblock it  
_PARAMETERS:_  
**p\_contract:** id of expired contract  

### _procedure_ BLNG.CORE.REVOKE\_DOCUMENT  
_DESCRIPTION:_  
get back money and erase transactions by p\_document id  
_PARAMETERS:_  
**p\_document:** id of document  

### _function_ BLNG.CORE.PAY\_CONTRACT\_BY\_USER  
_DESCRIPTION:_  
get contract which user can spend money  
documents like increase credit limit or loan days approve immediately  
docs like buy or cash\_in push to credit/debit\_online accounts.  
_PARAMETERS:_  
**p\_user:** user id  
_RETURN:_  
contract id  

# BLNG.FWDR
---

### _function_ BLNG.FWDR.GET\_TENANT  
_DESCRIPTION:_  
return tenant. tenant is contract identifire. tenant using  
for checking is user registered in the system.  
_PARAMETERS:_  
**p\_email:** user email  
_RETURN:_  
contract identifire  

### _function_ BLNG.FWDR.CLIENT\_INSTEADOF\_USER  
_DESCRIPTION:_  
return id of user with max id across client  
_PARAMETERS:_  
**p\_client:** client id where we looking for user  
_RETURN:_  
user id  

### _function_ BLNG.FWDR.BALANCE  
_DESCRIPTION:_  
return info of contract for show balance to the client. function return this filds {  

  * deposit: self money  
  * loan: money thatspent from credit limit  
  * credit\_limit: credit limit  
  * unused\_credit\_limit: credit limit - abs(loan)  
  * available: credit limit + deposit - abs(loan). if contract bills are expired and contract blocked then 0. if contract bills are expired and contract unblocked then ussual summ.  
  * block\_date: expiration date of the next bill  
  * unblock\_sum: sum next neares bills (with one day) + all bills before current day  
  * near\_unblock\_sum: unblock sum + bills for 2 next days after after first bill  
  * expiry\_date: date of first expired bill  
  * expiry\_sum: summ of all expired bills  
  * status: if bills are expired and contract blocked then 'block', if bills are expired and contract unblocked then 'unblock', else 'active'  

}  
_PARAMETERS:_  
**p\_tenant\_id:** contract id  
_RETURN:_  
sys\_refcursor[contract\_oid, deposit, loan, credit\_limit, unused\_credit\_limit,  
available, block\_date, unblock\_sum, near\_unblock\_sum, expiry\_date, expiry\_sum, status]  

### _function_ BLNG.FWDR.WHOAMI  
_DESCRIPTION:_  
return info for user  
_PARAMETERS:_  
**p\_user:** email  
_RETURN:_  
sys\_refcursor[user\_id, last\_name, first\_name, email, phone, --tenant\_id,  
birth\_date, gender, nationality, nls\_nationality, doc\_id, doc\_expiry\_date,  
doc\_number, doc\_last\_name, doc\_first\_name, doc\_owner, doc\_gender,  
doc\_birth\_date, doc\_nationality, doc\_nls\_nationality, doc\_phone, client\_id, client\_name,is\_tester]  

### _function_ BLNG.FWDR.USER\_DATA\_EDIT  
_DESCRIPTION:_  
update user documents. if success return true else false  
_PARAMETERS:_  
**p\_data:** data for update. format json[email, first\_name, last\_name,  
gender, birth\_date, nationality, phone, docs[doc\_expiry\_date,  
doc\_gender, doc\_first\_name, doc\_last\_name, doc\_number, doc\_owner,  
doc\_id, doc\_nationality, doc\_birth\_date,doc\_phone]]  
_RETURN:_  
sys\_refcursor[res:true/false]  

### _function_ BLNG.FWDR.STATEMENT  
_DESCRIPTION:_  
return list of transactions between dates in user timezone format  
_PARAMETERS:_  
**p\_email:** user email which request statement  
**p\_row\_count:** count rows per page  
**p\_page\_number:** page number to show  
**p\_date\_from:** date filter.  
**p\_date\_to:** date filter.  
_RETURN:_  
sys\_refcursor[rn(row\_number),all v\_statemen filds + amount\_cash\_in,amount\_buy,amount\_from,amount\_to,page\_count,row\_count]  

### _function_ BLNG.FWDR.STATEMENT  
_DESCRIPTION:_  
return list of transactions in user timezone format by pages  
_PARAMETERS:_  
**p\_email:** user email which request statement  
**p\_row\_count:** count rows per page  
**p\_page\_number:** page number to show  
_RETURN:_  
sys\_refcursor[rn(row\_number),all v\_statemen filds + amount\_cash\_in,amount\_buy,amount\_from,amount\_to,page\_count,row\_count]  

### _function_ BLNG.FWDR.LOAN\_LIST  
_DESCRIPTION:_  
return list of loans with expired flag  
_PARAMETERS:_  
**p\_email:** user email who request loan\_list  
**p\_rownum:** cuts rows for paging  
_RETURN:_  
sys\_refcursor[id, contract\_oid, amount, order\_number, pnr\_id, date\_to, is\_overdue]  

### _function_ BLNG.FWDR.V\_ACCOUNT\_GET\_INFO\_R  
_DESCRIPTION:_  
return all fields from blng.v\_account  
_PARAMETERS:_  
**p\_contract:** contract id  
_RETURN:_  
sys\_refcursor[all v\_statemen fields]  

### _function_ BLNG.FWDR.CONTRACT\_GET  
_DESCRIPTION:_  
return list of contract with client  
_PARAMETERS:_  
**p\_contract:** contract id  
_RETURN:_  
sys\_refcursor[client\_id, contract\_id, client\_name, contract\_number]  

### _function_ BLNG.FWDR.CHECK\_TENANT  
_DESCRIPTION:_  
return tenant. tenant is contract identifire. tenant using  
for checking is user registered in the system. if user dosnt exist then return null  
_PARAMETERS:_  
**p\_email:** user email  
_RETURN:_  
contract identifire  

### _function_ BLNG.FWDR.GOD\_UNBLOCK  
_DESCRIPTION:_  
unblock user god@ntg-one.com. this user must be usually at blocked status [c]losed  
_RETURN:_  
res[success/error/no\_data\_found]  

### _function_ BLNG.FWDR.GOD\_BLOCK  
_DESCRIPTION:_  
block user god@ntg-one.com. this user must be usually at blocked status [c]losed  
_RETURN:_  
res[success/error/no\_data\_found]  

### _function_ BLNG.FWDR.GOD\_MOVE  
_DESCRIPTION:_  
move user god@ntg-one.com to contract with id equals p\_tenant.  
mission of god@ntg-one.com is to login under one of a contract and check errors.  
god can help others to understand some problems  
_PARAMETERS:_  
**p\_tenant:** id of contract  
_RETURN:_  
res[success/error/no\_data\_found]  

### _function_ BLNG.FWDR.CLIENT\_LIST()  
_DESCRIPTION:_  
return list of clients.  
_RETURN:_  
on success sys\_refcursor[client\_id,name].  
on error sys\_refcursor[res]. res=error  

### _function_ BLNG.FWDR.CLIENT\_ADD  
_DESCRIPTION:_  
create client and return info about this new client.  
_PARAMETERS:_  
**p\_name:** name of client  
_RETURN:_  
on success sys\_refcursor[res,client\_id,name]  
on error sys\_refcursor[res]. res=error  

### _function_ BLNG.FWDR.CONTRACT\_LIST  
_DESCRIPTION:_  
return list of contracts by client id  
_PARAMETERS:_  
**p\_client:** id of client  
_RETURN:_  
on success sys\_refcursor[client\_id, contract\_id, tenant\_id, is\_blocked, contract\_name,  
credit\_limit, delay\_days, max\_credit, utc\_offset, contact\_name, contract\_number,contact\_phone]  
on error sys\_refcursor[res]. res=error  

### _function_ BLNG.FWDR.CONTRACT\_ADD  
_DESCRIPTION:_  
add contract for client and return info about this new contract.  
_PARAMETERS:_  
**p\_client:** id of client  
**p\_data:** json[contract\_name, credit\_limit, delay\_days, max\_credit, utc\_offset, contact\_name, contact\_phone]  
_RETURN:_  
on success sys\_refcursor[client\_id, contract\_id, tenant\_id, is\_blocked, contract\_name, contract\_number,  
credit\_limit, delay\_days, max\_credit, utc\_offset, contact\_name, contact\_phone  
on error sys\_refcursor[res]. res=error  

### _function_ BLNG.FWDR.CONTRACT\_UPDATE  
_DESCRIPTION:_  
update contract info for client and return info about this new contract.  
_PARAMETERS:_  
**p\_contract:** id of contract  
**p\_data:** json[contract\_name, credit\_limit, delay\_days, max\_credit, utc\_offset, contact\_name, contact\_phone]  
_RETURN:_  
on success sys\_refcursor[client\_id, contract\_id, tenant\_id, is\_blocked, contract\_name,  
credit\_limit, delay\_days, max\_credit, utc\_offset, contact\_name,contract\_number, contact\_phone  
on error sys\_refcursor[res]. res=error  

# HDBK.CORE
---

### _function_ HDBK.CORE.DELAY\_PAYDAY  
_DESCRIPTION:_  
find nearest date for get money from client  
_PARAMETERS:_  
**p\_delay:** count of days to delay bill paying.  
**p\_contract:** id of contract. maybe at custom calendar we will find special payday  
_RETURN:_  
day of pay  

# HDBK.DTYPE
---

### _data\_type_ HDBK.DTYPE.T\_ID  
_DESCRIPTION:_  
for id. integer/number(18,0)  

### _data\_type_ HDBK.DTYPE.T\_AMOUNT  
_DESCRIPTION:_  
for money. float/number(20,2)  

### _data\_type_ HDBK.DTYPE.T\_STATUS  
_DESCRIPTION:_  
for 1 letter statuses. char(1)  

### _data\_type_ HDBK.DTYPE.T\_MSG  
_DESCRIPTION:_  
for long messages less 4000 chars. string(4000)/varchar2(4000)  

### _data\_type_ HDBK.DTYPE.T\_NAME  
_DESCRIPTION:_  
for client names or geo names less 255 chars. string(255)/varchar2(255)  

### _data\_type_ HDBK.DTYPE.T\_CODE  
_DESCRIPTION:_  
for short codes less 10 chars. string(10)/varchar2(10)  

### _data\_type_ HDBK.DTYPE.T\_LONG\_CODE  
_DESCRIPTION:_  
for long codes less 50 chars. string(50)/varchar2(50)  

### _data\_type_ HDBK.DTYPE.T\_BOOL  
_DESCRIPTION:_  
for boolean values.  

### _data\_type_ HDBK.DTYPE.T\_DATE  
_DESCRIPTION:_  
for date with time values.  

### _data\_type_ HDBK.DTYPE.T\_CLOB  
_DESCRIPTION:_  
for big data clob.  

### _exception variable_ HDBK.DTYPE.INVALID\_PARAMETER  
_DESCRIPTION:_  
-6502  

### _exception variable_ HDBK.DTYPE.MAX\_LOAN\_TRANSACTION\_BLOCK  
_DESCRIPTION:_  
-6502  

### _exception variable_ HDBK.DTYPE.DOC\_WAITING  
_DESCRIPTION:_  
-20000  

### _exception variable_ HDBK.DTYPE.INSUFFICIENT\_FUNDS  
_DESCRIPTION:_  
-20001  

### _exception variable_ HDBK.DTYPE.API\_ERROR  
_DESCRIPTION:_  
-20002  

### _exception variable_ HDBK.DTYPE.VALUE\_ERROR  
_DESCRIPTION:_  
-20003  

### _exception variable_ HDBK.DTYPE.EXIT\_ALERT  
_DESCRIPTION:_  
-20004  

### _exception variable_ HDBK.DTYPE.INVALID\_OPERATION  
_DESCRIPTION:_  
-20005  

### _exception variable_ HDBK.DTYPE.DEAD\_LOCK  
_DESCRIPTION:_  
-60  

### _exception variable_ HDBK.DTYPE.NOT\_AUTHORIZED  
_DESCRIPTION:_  
-20006  

# HDBK.FWDR
---

### _function_ HDBK.FWDR.GET\_UTC\_OFFSET  
_DESCRIPTION:_  
list of airlines with utc\_offset  
_RETURN:_  
sys\_refcursor[iata,utc\_offset]  

### _function_ HDBK.FWDR.GEO\_GET\_LIST  
_DESCRIPTION:_  
list of airports and city of airport  
_RETURN:_  
sys\_refcursor[iata,name,nls\_name,city\_iata,city\_name,city\_nls\_name]  

### _function_ HDBK.FWDR.AIRLINE\_GET\_LIST  
_DESCRIPTION:_  
list of airlines names and iata codes  
_RETURN:_  
sys\_refcursor[iata,name,nls\_name]  

### _function_ HDBK.FWDR.AIRPLANE\_GET\_LIST  
_DESCRIPTION:_  
list of airplane names and iata codes  
_RETURN:_  
sys\_refcursor[iata,name,nls\_name]  

### _function_ HDBK.FWDR.AIRLINE\_COMMISSION\_LIST  
_DESCRIPTION:_  
list of airlines with flag commission(it means, is airline have rules for calc commission).  
_RETURN:_  
sys\_refcursor[airline\_oid,name,iata,commission[y/n]]  

### _function_ HDBK.FWDR.GET\_FULL  
_DESCRIPTION:_  
return all from v\_markup  
_RETURN:_  
sys\_refcursor  

### _function_ HDBK.FWDR.MARKUP\_GET  
_DESCRIPTION:_  
when p\_version is null then return all active rows. if not null then  
get all active and deleted rows that changed after p\_version id  
_PARAMETERS:_  
**p\_version:** id  
_RETURN:_  
sys\_refcursor[id, tenant\_id, validating\_carrier, class\_of\_service,  
segment, v\_from, v\_to, absolut\_amount, percent\_amount, min\_absolut, version, is\_active, markup\_type]  

### _function_ HDBK.FWDR.RATE\_LIST  
_DESCRIPTION:_  
return all active rates for current moment. its not depends of p\_version  
_PARAMETERS:_  
**p\_version:** version. not useful now.  
_RETURN:_  
sys\_refcursor[code,rate,version,is\_active(y,n)]  

# HDBK.HDBK\_API
---
_DESCRIPTION:_  
**\*\_add:** insert row into table \*. could return id of new row.  
**\*\_edit:** update row into table \*. object have always one id. first, old data with amnd\_state = [i]nactive  
inserted as row with link to new row(amnd\_prev). new data just update object row,  
amnd\_date updates to sysdate and amnd\_user to current user who called api.  
**\*\_get\_info:** return data from table \* with format sys\_refcursor.  
**\*\_get\_info\_r:** return one row from table \* with format \*%rowtype.  

# HDBK.LOG\_API
---

### _procedure_ HDBK.LOG\_API.LOG\_ADD  
_DESCRIPTION:_  
procedure for write log. this procedure make autonomous\_transaction commits.  
its mean independent of other function commit/rollback and not affect  
to other function commit/rollback  
_PARAMETERS:_  
**p\_proc\_name:** name of process  
**p\_msg:** message that wont be written to log  
**p\_msg\_type:** information/error or etc. default information  
**p\_info:** some more details  
**p\_alert\_level:** 0..10. priority level, default 0  

# ORD.CORE
---

### _procedure_ ORD.CORE.BILL\_PAY  
_DESCRIPTION:_  
procedure perform transit bills with status [w]aiting to billing system.  
that means bill requested for pay. after that bill marked as [t]ransported  
this procedure executed from job scheduler  

### _procedure_ ORD.CORE.DOC\_TASK\_LIST  
_DESCRIPTION:_  
procedure perform document tasks like pay for bills, set cledit limit and others money tasks.  
main idea of function is to separate buy process from others.  
this procedure executed from job scheduler  

# ORD.FWDR
---

### _function_ ORD.FWDR.ORDER\_CREATE  
_DESCRIPTION:_  
fake function. used in avia\_register for creating emty order  
_PARAMETERS:_  
**p\_date:** date for wich we need create order  
**p\_order\_number:** number could set or generate inside  
**p\_status:** status like 'w' waiting or smth else  
_RETURN:_  
id of created order  

### _function_ ORD.FWDR.ITEM\_ADD  
_DESCRIPTION:_  
fake function.  
_RETURN:_  
id of created item  

### _procedure_ ORD.FWDR.AVIA\_UPDATE  
_DESCRIPTION:_  
procedure update item\_avia row searched by pnr\_id.  
_PARAMETERS:_  
**p\_pnr\_id:** id from nqt. search perform by this id  
**p\_pnr\_locator:** record locator just for info  
**p\_time\_limit:** time limit just for info  
**p\_total\_amount:** total amount including markup  
**p\_total\_markup:** just total markup  
**p\_pnr\_object:** json for backup  
**p\_nqt\_status:** current nqt process  
**p\_tenant\_id:** id of contract in text format, for authorization  

### _procedure_ ORD.FWDR.AVIA\_REG\_TICKET  
_DESCRIPTION:_  
procedure get ticket info by pnr\_id.  
its create row for ticket. later this info will send to managers  
_PARAMETERS:_  
**p\_pnr\_id:** id from nqt. search perform by this id  
**p\_tenant\_id:** id of contract in text format, for authorization  
**p\_ticket:** json[p\_number,p\_name,p\_fare\_amount,p\_tax\_amount,p\_markup\_amount,p\_type]  

### _procedure_ ORD.FWDR.AVIA\_PAY  
_DESCRIPTION:_  
procedure send all bills in status [m]arked to [w]aiting in billing for pay.  
_PARAMETERS:_  
**p\_user\_id:** user identifire. at this moment email  
**p\_pnr\_id:** id from nqt. search perform by this id  

### _function_ ORD.FWDR.ORDER\_GET  
_DESCRIPTION:_  
fake  

### _function_ ORD.FWDR.ITEM\_LIST  
_DESCRIPTION:_  
fake  

### _function_ ORD.FWDR.ITEM\_LIST  
_DESCRIPTION:_  
fake  

### _function_ ORD.FWDR.PNR\_LIST  
_DESCRIPTION:_  
get pnr list whith statuses listed in p\_nqt\_status\_list and with paging by p\_rownum count.  
_PARAMETERS:_  
**p\_nqt\_status\_list:** json[status]  
**p\_rownum:** filter for rows count  
_RETURN:_  
sys\_refcursor[pnr\_id, nqt\_status, po\_status, nqt\_status\_cur, null po\_msg, 'avia' item\_type, pnr\_locator, tenant\_id]  

### _function_ ORD.FWDR.PNR\_LIST  
_DESCRIPTION:_  
get pnr list whith id listed in p\_pnr\_list.  
_PARAMETERS:_  
**p\_pnr\_list:** json[p\_pnr\_id,p\_tenant\_id], where  
**p\_pnr\_id:** id from nqt. search perform by this id  
**p\_tenant\_id:** id of contract in text format, for authorization  
_RETURN:_  
sys\_refcursor[pnr\_id, nqt\_status, po\_status, nqt\_status\_cur, null po\_msg, 'avia' item\_type, pnr\_locator,tenant\_id]  

### _procedure_ ORD.FWDR.COMMISSION\_GET  
_DESCRIPTION:_  
calculate commission for pnr\_id  
_PARAMETERS:_  
**p\_pnr\_id:** id from nqt. search perform by this id  
**p\_tenant\_id:** id of contract in text format, for authorization  
**o\_fix:** in this paraveter returned fix commission value  
**o\_percent:** in this paraveter returned percent commission value  

### _function_ ORD.FWDR.ORDER\_NUMBER\_GENERATE  
_DESCRIPTION:_  
generate order number as last number + 1 by user id  
_PARAMETERS:_  
**p\_user:** user id.  
_RETURN:_  
string like 0012410032, where 1241 - user id and 32 is a counter of order  

### _procedure_ ORD.FWDR.AVIA\_MANUAL  
_DESCRIPTION:_  
update order status to p\_result[error/success] or to inprogress, if error then return all money.  
_PARAMETERS:_  
**p\_pnr\_id:** id from nqt. search perform by this id  
**p\_tenant\_id:** id of contract in text format, for authorization  
**p\_result:** [error/success/ if null then inprogress]  

### _procedure_ ORD.FWDR.CASH\_BACK  
_DESCRIPTION:_  
perform reverse for order scheme. return bill to waiting status  
and call revoke\_document from billing  
_PARAMETERS:_  
**p\_pnr\_id:** id from nqt. search perform by this id  

### _function_ ORD.FWDR.GET\_SALES\_LIST  
_DESCRIPTION:_  
fake  

### _function_ ORD.FWDR.RULE\_VIEW  
_DESCRIPTION:_  
return all rules by iata code of airline  
_PARAMETERS:_  
**p\_iata:** iata 2 char code  
_RETURN:_  
sys\_refcursor[fields from v\_rule view]  

### _procedure_ ORD.FWDR.AVIA\_CREATE  
_DESCRIPTION:_  
procedure create item\_avia row only. it cant update item. add pnr info like who, where, when  
_PARAMETERS:_  
**p\_pnr\_id:** id from nqt. search perform by this id  
**p\_user\_id:** user identifire. at this moment email  
**p\_itinerary:** pnr info like who, where, when  

### _procedure_ ORD.FWDR.AVIA\_BOOKED  
_DESCRIPTION:_  
procedure send item/order/bill to billing for pay.  
_PARAMETERS:_  
**p\_pnr\_id:** id from nqt. search perform by this id  
**p\_user\_id:** user identifire. at this moment email  

### _function_ ORD.FWDR.POS\_RULE\_GET  
_DESCRIPTION:_  
when p\_version is null then return all active rows. if not null then  
get all active and deleted rows that changed after p\_version id  
_PARAMETERS:_  
**p\_version:** id  
_RETURN:_  
sys\_refcursor[id, tenant\_id, validating\_carrier,booking\_pos,ticketing\_pos,stock,printer,version, is\_active]  
default tenant\_id = 0, default validating\_carrier = 'yy'  

### _function_ ORD.FWDR.POS\_RULE\_EDIT  
_DESCRIPTION:_  
update pos\_rules or create new pos\_rules. if success return true else false.  
if status equals [c]lose or [d]elete then delete pos\_rule.  
_PARAMETERS:_  
**p\_data:** data for update. format json[id, tenant\_id, validating\_carrier,  
booking\_pos, ticketing\_pos, stock, printer, status]  
_RETURN:_  
sys\_refcursor[res:true/false]  

### _function_ ORD.FWDR.RULE\_ADD  
_DESCRIPTION:_  
add rule.  
_PARAMETERS:_  
**p\_data:** data for update. format json[airline\_iata, tenant\_id, contract\_type\_id, rule\_id,  
rule\_description, rule\_life\_from, rule\_life\_to, rule\_amount,  
rule\_amount\_measure, rule\_priority, condition\_id,condition\_status, template\_type\_id,  
template\_name\_nls, template\_value]  
_RETURN:_  
sys\_refcursor[res:true/false]  

### _function_ ORD.FWDR.RULE\_EDIT  
_DESCRIPTION:_  
update rule info.  
add new condition or update info.  
if condition status equals [d]elete then delete condition from rule.  
_PARAMETERS:_  
**p\_data:** data for update. format json[rule\_id,  
rule\_description, rule\_life\_from, rule\_life\_to, rule\_amount,  
rule\_amount\_measure, rule\_priority, condition\_id,condition\_status, template\_type\_id,  
template\_name\_nls, template\_value]  
_RETURN:_  
sys\_refcursor[res:true/false]  

### _function_ ORD.FWDR.RULE\_DELETE  
_DESCRIPTION:_  
delete commission rule.  
_PARAMETERS:_  
**p\_rule\_id:** rule id  
_RETURN:_  
sys\_refcursor[res:true/false]  

### _function_ ORD.FWDR.RULE\_TEMPLATE\_LIST  
_DESCRIPTION:_  
return all commission templates  
_PARAMETERS:_  
**p\_is\_contract\_type:** if 'y' then return all contract\_types else all template\_types  
_RETURN:_  
sys\_refcursor[id, template\_type, priority, details, is\_contract\_type, name, nls\_name, is\_value]  

### _function_ ORD.FWDR.BILL\_IMPORT\_LIST  
_DESCRIPTION:_  
return all bills info for import into 1c  
_RETURN:_  
sys\_refcursor[bill\_oid, item, is\_nds, flight\_from, flight\_to, fare\_amount, contract\_number, passenger\_name]  

### _function_ ORD.FWDR.MARKUP\_RULE\_GET  
_DESCRIPTION:_  
return all markup rules  
_PARAMETERS:_  
**p\_version:** version id. filter new changes  
_RETURN:_  
sys\_refcursor[id, is\_active, version, tenant\_id, iata, markup\_type, rule\_amount, rule\_amount\_measure, min\_absolut, priority, per\_segment,contract\_type,condition\_count]  

### _function_ ORD.FWDR.MARKUP\_TEMPL\_GET  
_DESCRIPTION:_  
return all markup templates for rule id  
_PARAMETERS:_  
**p\_rule\_id:** id of rule  
_RETURN:_  
sys\_refcursor[id, template\_type\_code, template\_value]  

### _function_ ORD.FWDR.TASK\_GET  
_DESCRIPTION:_  
return task for 1c  
_RETURN:_  
sys\_refcursor[email, task\_id, contract\_id, description, quantity, price, vat]  

### _function_ ORD.FWDR.TASK\_CLOSE  
_DESCRIPTION:_  
mark task as [c]losed  
_PARAMETERS:_  
**p\_task:** task id  
**p\_number\_1c:** 1c bill number  
_RETURN:_  
sys\_refcursor[res]  

### _function_ ORD.FWDR.BILL\_1C\_PAYED  
_DESCRIPTION:_  
create task that sends fin docs.  
_PARAMETERS:_  
**p\_number\_1c:** 1c bill number  
_RETURN:_  
sys\_refcursor{  

  * res - result. could get values error, success  

}  

### _function_ ORD.FWDR.VAT\_CALC  
_DESCRIPTION:_  
calculate vat. vat values saved at dictionary 1c\_product\_w\_vat code.  
_PARAMETERS:_  
**p\_itinerary:** itinerary id  
_RETURN:_  
id of dictionary 1c\_product\_w\_vat code  

# ORD.ORD\_API
---
_DESCRIPTION:_  
**\*\_add:** insert row into table \*. could return id of new row.  
**\*\_edit:** update row into table \*. object have always one id. first, old data with amnd\_state = [i]nactive  
inserted as row with link to new row(amnd\_prev). new data just update object row,  
amnd\_date updates to sysdate and amnd\_user to current user who called api.  
**\*\_get\_info:** return data from table \* with format sys\_refcursor.  
**\*\_get\_info\_r:** return one row from table \* with format \*%rowtype.  


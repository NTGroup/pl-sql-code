
  CREATE OR REPLACE  VIEW "ORD"."V_COMMISSION" 
  AS 
  select 
al.id al_oid,
al.name,
al.IATA,
cmn.priority,
cmn.id cmn_oid,
ct.id template_type_oid,
cmn.details,
ct.template_type template_type,
cd.value,
-- LISTAGG(cd.value, ',') WITHIN GROUP (ORDER BY ct.template_type) assa,
cmn.fix,
cmn.percent
from 
ord.commission cmn,
ord.commission_template ct,
ord.commission_details cd,
hdbk.airline al
where 
al.amnd_state = 'A'
and cmn.amnd_state = 'A'
and cd.amnd_state = 'A'
and ct.amnd_state = 'A'
and cmn.id= cd.commission_oid
and ct.id = cd.commission_template_oid
and cmn.airline = al.id
and trunc(sysdate) between NVL(cmn.date_from,trunc(sysdate)) and NVL(date_to,trunc(sysdate))

order by iata,cmn.priority desc, cmn.id, ct.priority desc;
/



  CREATE OR REPLACE VIEW "ORD"."V_JSON" 
  AS 
  SELECT 
ia.id,
--jt."BOOK_ID",jt."ROW_NUMBER",jt."PAXTYPE",jt."QUANTITY",jt."SEATS",jt."DEP_LOCATION",jt."DEP_DATETIME",jt."ARR_LOCATION",jt."ARR_DATETIME",jt."ELAPSEDTIME",jt."STOP_LOCATION",jt."ARRIVALDATETIME",jt."DEPARTUREDATETIME",jt."STOPS_TIMING_ELAPSEDTIME",jt."O_FLIGHTNUMBER",jt."O_AIRLINE",jt."M_FLIGHTNUMBER",jt."M_AIRLINE",jt."PLANETYPE",jt."MARRIAGEGROUP",jt."BOOKINGCODE",jt."FS_TIMEWASCHANGED",jt."FLIGHTTIME",jt."TOTALOFFLIGHTSEGMENTS",jt."PI_TF_FAREAMOUNT",jt."PI_TF_TAXESAMOUNT",jt."PI_TF_TOTALAMOUNT",jt."PI_PTCF_PK_PAXTYPE",jt."PI_PTCF_PK_QUANTITY",jt."PI_PTCF_PK_SEATS",jt."PI_PTCF_BD_FAREAMOUNT",jt."PI_PTCF_BD_TAXESAMOUNT",jt."PI_PTCF_BD_TOTALAMOUNT",jt."PI_PTCF_FAREBASISCODES",jt."VALIDATINGCARRIER",jt."SEEMSTOBEINVALID",jt."PERSEGMENT",jt."PERPTCBREAKDOWNS",jt."TOTALAMOUNT",jt."TOTALMARKUP",jt."PAX_GIVENNAME",jt."PAX_SURNAME",jt."PAX_DATEOFBIRTH",jt."PAX_PAXTYPE",jt."PHONE",jt."EMAIL",jt."SYSTEMTIMELIMIT",jt."PRICEWASCHANGED",jt."TIMEWASCHANGED",jt."ISFAILED",jt."PNRRECORDLOCATOR"
jt.*
FROM ord.item_avia ia,
json_table(pnr_object, '$'
  COLUMNS (
    book_id VARCHAR2(250) PATH '$._id',
    row_number FOR ORDINALITY,
  --  paxType VARCHAR2(250) PATH '$.PassengersQueried[0].paxType',
  --  quantity VARCHAR2(250) PATH '$.PassengersQueried[0].quantity',
  --  seats VARCHAR2(250) PATH '$.PassengersQueried[0].seats',
    
    
    NESTED PATH '$.PricedItinerary.AirItinerary.Legs[*]' COLUMNS (
      NESTED PATH '$.FlightSegments[*]' COLUMNS (
        dep_location VARCHAR2(256 CHAR) PATH '$.Departure.Location',
--        dep_dateTime VARCHAR2(256 CHAR) PATH '$.departure.dateTime',
        arr_location VARCHAR2(256 CHAR) PATH '$.Arrival.Location',
--        arr_dateTime VARCHAR2(256 CHAR) PATH '$.arrival.dateTime',
        --elapsedTime VARCHAR2(256 CHAR) PATH '$.ElapsedTime',
--        stop_location VARCHAR2(256 CHAR) PATH '$.Stops[0].Location',
--        arrivalDateTime VARCHAR2(256 CHAR) PATH '$.stops[0].timing.arrivalDateTime',
--        departureDateTime VARCHAR2(256 CHAR) PATH '$.Stops[0].Timing.DepartureDateTime',
--        stops_timing_elapsedTime VARCHAR2(256 CHAR) PATH '$.Stops[0].Timing.ElapsedTime',
        o_flightNumber VARCHAR2(256 CHAR) PATH '$.Operating.FlightNumber',
        o_airline VARCHAR2(256 CHAR) PATH '$.Operating.Airline',
        m_flightNumber VARCHAR2(256 CHAR) PATH '$.Marketing.FlightNumber',
        m_airline VARCHAR2(256 CHAR) PATH '$.Marketing.Airline',
--        planeType VARCHAR2(256 CHAR) PATH '$.planeType',
--        marriageGroup VARCHAR2(256 CHAR) PATH '$.marriageGroup',
        bookingCode VARCHAR2(256 CHAR) PATH '$.BookingCode'
--        fs_timeWasChanged VARCHAR2(256 CHAR) PATH '$.timeWasChanged'
      ),
      flightTime VARCHAR2(256 CHAR) PATH '$.FlightTime'
    ),
    totalOfFlightSegments number(3) PATH '$.PricedItinerary.AirItinerary.TotalOfFlightSegments',
    pi_tf_fareAmount number(20,2) PATH '$.PricedItinerary.PricingInfo.TotalFareBreakdown.FareAmount',
    pi_tf_taxesAmount number(20,2) PATH '$.PricedItinerary.PricingInfo.TotalFareBreakdown.TaxesAmount',
    pi_tf_totalAmount number(20,2) PATH '$.PricedItinerary.PricingInfo.TotalFareBreakdown.TotalAmount',

    pi_ptcf_pk_paxType VARCHAR2(100) PATH '$.PricedItinerary.PricingInfo.PtcFareBreakdowns[0].PaxKit.PaxType',
    pi_ptcf_pk_quantity number(18) PATH '$.PricedItinerary.PricingInfo.PtcFareBreakdowns[0].PaxKit.Quantity',
--    pi_ptcf_pk_seats number(18) PATH '$.PricedItinerary.PricingInfo.PtcFareBreakdowns[0].PaxKit.Seats',
    pi_ptcf_bd_fareAmount number(20,2) PATH '$.PricedItinerary.PricingInfo.PtcFareBreakdowns[0].Breakdown.FareAmount',
    pi_ptcf_bd_taxesAmount number(20,2) PATH '$.PricedItinerary.PricingInfo.PtcFareBreakdowns[0].Breakdown.TaxesAmount',
    pi_ptcf_bd_totalAmount number(20,2) PATH '$.PricedItinerary.PricingInfo.PtcFareBreakdowns[0].Breakdown.TotalAmount',

/*!!!*/    pi_ptcf_fareBasisCodes  VARCHAR2(100) FORMAT JSON  PATH '$.PricedItinerary.PricingInfo.PtcFareBreakdowns[0].FareBasisCodes',
    validatingCarrier VARCHAR2(100) PATH '$.PricedItinerary.PricingInfo.ValidatingCarrier',
--    seemsToBeInvalid VARCHAR2(100) PATH '$.PricedItinerary.PricingInfo.SeemsToBeInvalid',
    perSegment number(20,2) PATH '$.MarkupValue.PerSegment',
    perPtcBreakdowns number(20,2) PATH '$.MarkupValue.PerPtcBreakdowns[0]',

--    totalAmount number(20,2) PATH '$.TotalAmount',
--    totalMarkup number(20,2) PATH '$.TotalMarkup',
    pax_givenName varchar2(120) PATH '$.PaxGroup._persons[0].GivenName',
    pax_surname varchar2(120) PATH '$.PaxGroup._persons[0].Surname',
--    pax_dateOfBirth varchar2(120) PATH '$.PaxGroup._persons[0].DateOfBirth[0]',
    pax_paxType varchar2(120) PATH '$.PaxGroup._persons[0].PaxType',
--    phone varchar2(120) PATH '$.PaxGroup.Phone',
--    email varchar2(120) PATH '$.PaxGroup.Email',
--    systemTimeLimit VARCHAR2(250) PATH '$.SystemTimeLimit',
    priceWasChanged VARCHAR2(250) PATH '$.PriceWasChanged',
--    timeWasChanged VARCHAR2(250) PATH '$.TimeWasChanged',
--    isFailed VARCHAR2(250) PATH '$.IsFailed',
    pnrRecordLocator VARCHAR2(250) PATH '$.PnrRecordLocator'
  )
) AS "JT"
where amnd_state = 'A'
--and  ia.id = 25412
order by ia.id desc;

/


  CREATE OR REPLACE  VIEW "BLNG"."V_ACCOUNT_TYPE" 
  AS 
  select
id,
decode(code,'d',1,0) deposit,
decode(code,'l',1,0) loan,
decode(code,'cl',1,0) credit_limit,
decode(code,'clb',1,0) credit_limit_block,
decode(code,'do',1,0) debit_online,
decode(code,'ult',1,0) max_loan_trans_amount,
decode(code,'co',1,0) credit_online,
decode(code,'dd',1,0) delay_days,
case when code in ('l','cl','clb') then 1 else 0 end unused_credit_limit,
case when code in ('d','l','cl','clb') then 1 else 0 end available
from blng.account_type act
where amnd_state = 'A';

/
  CREATE OR REPLACE VIEW "BLNG"."V_ACCOUNT" 
  AS 
  select
acc.contract_oid contract_oid,
sum(acc.amount*act.deposit) deposit,
sum(acc.amount*act.loan) loan,
sum(acc.amount*act.credit_limit) credit_limit,
sum(acc.amount*act.unused_credit_limit) unused_credit_limit,
sum(acc.amount*act.credit_limit_block) credit_limit_block,
sum(acc.amount*act.debit_online) debit_online,
sum(acc.amount*act.max_loan_trans_amount) max_loan_trans_amount,
sum(acc.amount*act.credit_online) credit_online,
sum(acc.amount*act.delay_days) delay_days,
sum(acc.amount*act.available) available
from blng.v_account_type act, blng.account acc
where acc.amnd_state = 'A'
and acc.account_type_oid = act.id
group by acc.contract_oid;


/

  CREATE OR REPLACE  VIEW hdbk.V_GEO 
  AS 
  SELECT 
iata, max(utc_offset) utc_offset
FROM GEO
WHERE IS_ACTIVE IN ('W','Y')
and iata is not null
and iata not like '%@%'
group by iata;
/
  CREATE OR REPLACE VIEW hdbk.V_GEO_SUGGEST
  AS 
  select
id,
iata,
name,
nvl(
 ( select nls_name from hdbk.geo where id = 
  (
    select city_id from hdbk.geo where id=d_i_n.id
  ) )
,name) city,
(
  select nls_name from hdbk.geo where id = 
  (
    select country_id from hdbk.geo where id=d_i_n.id
  ) 
) country,

  (
    select nvl(search_rating,0) from hdbk.geo where id=d_i_n.id
  ) 
 search_rating,
 name_from,
 name_to
from 
  (
  select 
  max(id) id,
  iata,
  nls_name name,
  nls_name_rp name_from,
  nls_name_vp name_to
  from 
  hdbk.geo
  where object_type in (
  'airport',
  'airport real',
  'city',
  'city-airport'
  )
  and iata is not null
  and length(iata) = 3
  and is_active = 'Y'
  group by iata, nls_name,nls_name_rp,nls_name_vp
  ) d_i_n
--where iata in ('MOW','SVO','QPP','DAC','EBU','LED','PIE')
order by 2;

/

 create or replace view ord.v_rule as      
  select 
        al.id airline_id,
        al.IATA,
        al.nls_name nls_airline,
        nvl(cmn.contract_type,0) contract_type_id,
        nvl(cmn.contract_oid,0) tenant_id,
        nvl((select name from 
        ORD.commission_template 
        where id = cmn.contract_type),'DEFAULT') contract_type_name,
        cmn.id rule_id,
        --max(ct.priority) over (partition by cmn.id) priority,
        cmn.details rule_description,
        nvl(cmn.percent,cmn.fix) rule_amount,
        cmn.min_absolut rule_min_absolute,
        case 
        when cmn.percent is not null then 'PERCENT'
        when cmn.fix is not null then 'FIX'
        else ''
        end rule_amount_measure,
        cmn.priority,
        to_char(cmn.date_from + hdbk.fwdr.utc_offset_mow / 24 ,'yyyy-mm-dd') rule_life_from,
        to_char(cmn.date_to + hdbk.fwdr.utc_offset_mow / 24 ,'yyyy-mm-dd') rule_life_to,
        dtl.condition_oid condition_id,
        dtl.template_type_oid template_type_id,
        nvl(dtl.template_type,'default') template_type,
        dtl.template_type_code,
        dtl.template_value,
        dtl.is_value,
--        cmn.percent,
--        cmn.fix,
        (select code from hdbk.currency where id = cmn.currency) currency,
        nvl(cmn.per_segment,'N') per_segment,
        nvl(cmn.per_fare,'N') per_fare,
        (select name from hdbk.markup_type where id = cmn.rule_type) rule_type,
        (select name from hdbk.markup_type where id = cmn.markup_type) markup_type
        
        from 
        ord.commission cmn ,
        hdbk.airline al,
        (
          select 
          cd.commission_oid ,
          ct.id template_type_oid, 
          ct.nls_name template_type,
          ct.name template_type_code,
          ct.is_value,
          cd.id condition_oid,
          cd.value template_value
          from 
          ord.commission_details  cd,
          ORD.commission_template ct
          where cd.amnd_state = 'A'
          and ct.amnd_state = 'A'
          and cd.commission_template_oid = ct.id        
        ) dtl        
        where
        al.amnd_state = 'A'
        and cmn.amnd_state = 'A'
        and cmn.airline = al.id
    --    and al.IATA = p_iata
        and cmn.id = dtl.commission_oid(+)
        order by al.id,cmn.contract_type,cmn.priority desc, cmn.id
        ;      
        
 /
 
create or replace view blng.v_total as
  select 
  ddd.contract_oid,
  block_date,
  nvl(sum(case when ddd.date_to <= block_date+1  then ddd.amount_need else 0 end),0) unblock_sum,
  nvl(sum(case when ddd.date_to <= block_date+1+2 then ddd.amount_need else 0 end),0) near_unblock_sum,
  expiry_date,
  nvl(sum(case when ddd.date_to <= trunc(sysdate)  then ddd.amount_need else 0 end),0) expiry_sum
  from 
  (
    select 
    amount,
    id,
    d.contract_oid,
    nvl((select sum(amount) from blng.delay where parent_id is not null and parent_id = d.id and amnd_state = 'A' and EVENT_TYPE_oid = blng.blng_api.event_type_get_id(p_code=>'ci')),0) amount_have,
    amount - nvl((select sum(amount) from blng.delay where parent_id is not null and parent_id = d.id and amnd_state = 'A' and EVENT_TYPE_oid = blng.blng_api.event_type_get_id(p_code=>'ci')),0) amount_need,
    date_to date_to,
  min(case when date_to-1 >= trunc(sysdate) then date_to-1 else null end)  over (partition by contract_oid) block_date ,
  min(case when date_to < sysdate then date_to else null end) over (partition by contract_oid) expiry_date
    from blng.delay d
    where d.amnd_state = 'A'
    and parent_id is null
    --and contract_oid = 21
    and EVENT_TYPE_oid = blng.blng_api.event_type_get_id(p_code=>'b')
    order by contract_oid asc, date_to asc, id asc  
  ) ddd
  group by ddd.contract_oid,block_date,expiry_date;


/

        create or replace view blng.v_statement as
        select
        doc_id,
        transaction_id,
        contract_id,
        utc_offset,
        doc_trans_code,
        one,
        trans_date,
        transaction_date,
        transaction_time,
(sum(amount) over (partition by contract_id order by trans_date RANGE UNBOUNDED PRECEDING))
-
amount amount_before,
        amount,
sum(amount) over (partition by contract_id order by trans_date RANGE UNBOUNDED PRECEDING) amount_after,
        transaction_type,
         pnr_id,
         order_number,
         last_name,
        first_name,
        email              
             from 
        (select
        document.id doc_id,
        trans.id transaction_id,
        contract.id contract_id,
        client.utc_offset,
        doc_trans.code doc_trans_code,
        1 one,
     --   row_number() over (order by trans.trans_date) rn,
        trans.trans_date,
        to_char(trans.trans_date + client.utc_offset/24,'yyyy-mm-dd') transaction_date,
        to_char(trans.trans_date + client.utc_offset/24,'HH24:mi:ss') transaction_time,
--        nvl((select sum(amount) from blng.transaction tr where tr.doc_oid < trans.doc_oid and amnd_state = 'A' and target_account_oid in (select id from blng.account where amnd_state = 'A' and contract_oid = contract.id and account_type_oid in (1,2,3))),0) amount_before,
        trans.amount,
--        nvl((select sum(amount) from blng.transaction tr where tr.doc_oid <= trans.doc_oid and amnd_state = 'A' and target_account_oid in (select id from blng.account where amnd_state = 'A' and contract_oid = contract.id and account_type_oid in (1,2,3))),0) amount_after,
        (select code from hdbk.dictionary where id = document.account_trans_type_oid) transaction_type,
        pnr_id,
        pnr_locator order_number,
        INITCAP(client.last_name) last_name,
        INITCAP(client.first_name) first_name,
        client.email 
        from 
        blng.client,
        ord.bill,
        blng.contract,
        ord.item_avia,
        blng.document,
        blng.transaction trans,
        blng.trans_type doc_trans,
        blng.trans_type trans_trans,
        ord.ord
        where  contract.amnd_state = 'A'
        and document.amnd_state = 'A'
        and document.status = 'P'
        and document.contract_oid = contract.id
        and doc_trans.amnd_state = 'A'
        and doc_trans.id = document.trans_type_oid
        and doc_trans.code in ('b','ci','cl')
        and trans.amnd_state = 'A'
        and document.id = trans.doc_oid
        and trans_trans.amnd_state = 'A'
        and trans_trans.id = trans.trans_type_oid
        and trans_trans.code in ('b','ci','cl')
        and document.bill_oid = bill.id
        and bill.contract_oid = contract.id
        and item_avia.order_oid = bill.order_oid
        and item_avia.nqt_status in ('ISSUED')
        and item_avia.amnd_state = 'A'
        and bill.amnd_state = 'A'
        and ord.client_oid = client.id
        and ord.amnd_state = 'A'
        and ord.id = bill.order_oid
       --         and contract.id = 22

union all


        select
        document.id doc_id,
        trans.id transaction_id,
        contract.id contract_id,
        contract.utc_offset,
        doc_trans.code doc_trans_code,
        1 one,
        trans.trans_date,
        to_char(trans.trans_date + contract.utc_offset/24,'yyyy-mm-dd') transaction_date,
        to_char(trans.trans_date + contract.utc_offset/24,'HH24:mi:ss') transaction_time,
--        nvl((select sum(amount) from blng.transaction tr where tr.doc_oid < trans.doc_oid and amnd_state = 'A' and target_account_oid in (select id from blng.account where amnd_state = 'A' and contract_oid = contract.id and account_type_oid in (1,2,3))),0) amount_before,
        trans.amount,
--        nvl((select sum(amount) from blng.transaction tr where tr.doc_oid <= trans.doc_oid and amnd_state = 'A' and target_account_oid in (select id from blng.account where amnd_state = 'A' and contract_oid = contract.id and account_type_oid in (1,2,3))),0) amount_after,
        (select code from hdbk.dictionary where id = document.account_trans_type_oid) transaction_type,
        null pnr_id,
        null order_number,
        null last_name,
        null first_name,
        null email 
        from 
        blng.contract,
        blng.document,
        blng.transaction trans,
        blng.trans_type doc_trans,
        blng.trans_type trans_trans
        
        where 
        contract.amnd_state = 'A'
        and document.amnd_state = 'A'
        and document.status = 'P'
        and document.contract_oid = contract.id
        and doc_trans.amnd_state = 'A'
        and doc_trans.id = document.trans_type_oid
        and doc_trans.code in ('b','ci','cl')
        and trans.amnd_state = 'A'
        and document.id = trans.doc_oid
        and trans_trans.amnd_state = 'A'
        and trans_trans.id = trans.trans_type_oid
        and trans_trans.code in ('b','ci','cl')
        and document.bill_oid is null
    --    and contract.id = 22
        )
      --  where contract_id = 21
        order by contract_id, trans_date;
/
/*
grant CREATE MATERIALIZED VIEW to blng;
grant CREATE TABLE to blng;
drop MATERIALIZED VIEW blng.MV_STATEMENT ;
CREATE MATERIALIZED VIEW blng.MV_STATEMENT 
NOCACHE 
USING INDEX 
REFRESH ON commit 
FORCE 
WITH PRIMARY KEY 
USING DEFAULT ROLLBACK SEGMENT 
DISABLE QUERY REWRITE AS 
SELECT * from blng.v_statement;
*/
/



create or replace view blng.v_delay as
select
delay_buy.contract_oid contract_id,
document.bill_oid bill_id,
document.id doc_id,
delay_buy.id delay_id,
delay_buy.amount,
nvl((select sum(amount) from blng.delay where parent_id is not null and parent_id = delay_buy.id and amnd_state = 'A' and EVENT_TYPE_oid = blng.blng_api.event_type_get_id(p_code=>'ci')),0) amount_have,
delay_buy.amount - nvl((select sum(amount) from blng.delay where parent_id is not null and parent_id = delay_buy.id and amnd_state = 'A' and EVENT_TYPE_oid = blng.blng_api.event_type_get_id(p_code=>'ci')),0) amount_need,
delay_buy.date_to
from blng.delay delay_buy, blng.document, blng.transaction
where delay_buy.amnd_state = 'A'
and parent_id is null
--      and contract_oid = p_contract
and delay_buy.EVENT_TYPE_oid = blng.blng_api.event_type_get_id(p_code=>'b')
and transaction.id = delay_buy.transaction_oid
and transaction.amnd_state = 'A'
and document.amnd_state = 'A'
and document.id = transaction.doc_oid
order by delay_buy.contract_oid asc, date_to asc, delay_buy.id asc;
/

                    

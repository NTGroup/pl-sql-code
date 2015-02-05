
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
ntg.airline al
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


  CREATE OR REPLACE  VIEW "ORD"."V_COMMISSION_BAK"
  AS 
  select 
al.id al_oid,
al.name,
al.IATA,

max(ct.priority) over (partition by cmn.id) priority,
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
ntg.airline al
where 
al.amnd_state = 'A'
and cmn.amnd_state = 'A'
and cd.amnd_state = 'A'
and ct.amnd_state = 'A'
and cmn.id= cd.commission_oid
and ct.id = cd.commission_template_oid
and cmn.airline = al.id
and trunc(sysdate) between NVL(cmn.date_from,trunc(sysdate)) and NVL(date_to,trunc(sysdate))
/*group by al.id ,ct.id,
al.name,
al.IATA,
cmn.id ,
cmn.details,
ct.template_type,
ct.flight_oc,
flight_segment,
cmn.priority,
cmn.fix,
cmn.percent*/
order by iata,4 desc, cmn.id, ct.priority desc;


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
sum(acc.amount*act.credit_limit+acc.amount*act.loan) unused_credit_limit,
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

  CREATE OR REPLACE VIEW "BLNG"."V_STATEMENT" 
  AS 
  select
doc.contract_oid contract_oid,
tt.id trans_type_oid,
doc.id doc_oid,
cntr.contract_number,
tt.name trans_type,
tt.details trans_detals,
doc.doc_date,
doc.amount

from BLNG.document doc,
blng.trans_type tt,
blng.contract cntr
where doc.amnd_state = 'A'
and tt.amnd_state = 'A'
and doc.status = 'A'
and tt.id = doc.trans_type_oid
--and trans_type_oid = 2
and doc.contract_oid = cntr.id
order by doc.contract_oid, doc.doc_date;

/

  CREATE OR REPLACE  VIEW "NTG"."V_GEO" 
  AS 
  SELECT 
iata, max(utc_offset) utc_offset
FROM GEO
WHERE IS_ACTIVE IN ('W','Y')
and iata is not null
and iata not like '%@%'
group by iata;
/
  CREATE OR REPLACE VIEW "NTG"."V_GEO_SUGGEST" 
  AS 
  select
id,
iata,
name,
(
  select nls_name from ntg.geo where id = 
  (
    select city_id from ntg.geo where id=d_i_n.id
  ) 
) city,
(
  select nls_name from ntg.geo where id = 
  (
    select country_id from ntg.geo where id=d_i_n.id
  ) 
) country,

  (
    select nvl(search_rating,0) from ntg.geo where id=d_i_n.id
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
  ntg.geo
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

  CREATE OR REPLACE  VIEW "NTG"."V_MARKUP" 
  as
  select
  (select iata from ntg.airline a where a.id = validating_carrier) validating_carrier,
  class_of_service,
  case
  when segment is not null and segment = 'Y' then 'Y' 
  else 'N'
  end segment,
  nvl(v_from,0) v_from,
  nvl(v_to,0) v_to,
  case
  when absolut = 'Y'  then absolut_amount 
  else null
  end absolut_amount,
  case
  when percent = 'Y'  then percent_amount 
  else null
  end percent_amount,
  case
  when percent = 'Y'  then min_absolut 
  else null
  end min_absolut
  
  from markup
  where amnd_state = 'A';

/

 create or replace view ord.v_rule as      
  select 
        al.id airline_oid,
        al.IATA,
        al.nls_name nls_airline,
        cmn.contract_type contract_type_oid,
        (select name from 
        ORD.commission_template 
        where id = cmn.contract_type) contract_type,
        cmn.id rule_oid,
        --max(ct.priority) over (partition by cmn.id) priority,
        cmn.details rule_description,
        nvl(cmn.percent,cmn.fix) rule_amount,
        case 
        when cmn.percent is not null then 'PERCENT'
        when cmn.fix is not null then 'RUB'
        else ''
        end rule_amount_measure,
        cmn.priority,
        to_char(cmn.date_from,'dd.mm.yyyy') rule_life_from,
        to_char(cmn.date_to,'dd.mm.yyyy') rule_life_to,
        dtl.condition_oid,
        dtl.template_type_oid,
        nvl(dtl.template_type,'default') template_type,
        dtl.template_type_code,
        dtl.template_value,
        dtl.is_value,
        cmn.percent,
        cmn.fix
        from 
        ord.commission cmn ,
        ntg.airline al,
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
--       sum(ddd.amount),
--     sum(ddd.amount_need),
  sum(case when ddd.date_to=date_from  then ddd.amount_need else 0 end) unblock_sum,
  sum(case when ddd.date_to-date_from <= 2 then ddd.amount_need else 0 end) near_unblock_sum,
--      sum(case when ddd.date_to-date_from <= 11 then ddd.amount_need else 0 end) sc,
  ddd.date_from block_date /*,
  max(ddd.date_to-date_from),
  min(ddd.date_to-date_from) m  */
  from 
  (
    select 
    amount,
    id,
    d.contract_oid,
    nvl((select sum(amount) from blng.delay where parent_id is not null and parent_id = d.id and amnd_state = 'A' and EVENT_TYPE_oid = blng.blng_api.event_type_get_id(p_code=>'ci')),0) amount_have,
    amount - nvl((select sum(amount) from blng.delay where parent_id is not null and parent_id = d.id and amnd_state = 'A' and EVENT_TYPE_oid = blng.blng_api.event_type_get_id(p_code=>'ci')),0) amount_need,
    date_to-1 date_to,
    (MIN(date_to) OVER (PARTITION BY contract_oid))-1 date_from
    from blng.delay d
    where d.amnd_state = 'A'
    and parent_id is null
    --and contract_oid = 21
    and EVENT_TYPE_oid = blng.blng_api.event_type_get_id(p_code=>'b')
    order by contract_oid asc, date_to asc, id asc  
  ) ddd
  group by ddd.contract_oid,ddd.date_from;


/

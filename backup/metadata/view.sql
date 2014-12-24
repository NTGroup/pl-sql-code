
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
jt."BOOK_ID",jt."ROW_NUMBER",jt."PAXTYPE",jt."QUANTITY",jt."SEATS",jt."DEP_LOCATION",jt."DEP_DATETIME",jt."ARR_LOCATION",jt."ARR_DATETIME",jt."ELAPSEDTIME",jt."STOP_LOCATION",jt."ARRIVALDATETIME",jt."DEPARTUREDATETIME",jt."STOPS_TIMING_ELAPSEDTIME",jt."O_FLIGHTNUMBER",jt."O_AIRLINE",jt."M_FLIGHTNUMBER",jt."M_AIRLINE",jt."PLANETYPE",jt."MARRIAGEGROUP",jt."BOOKINGCODE",jt."FS_TIMEWASCHANGED",jt."FLIGHTTIME",jt."TOTALOFFLIGHTSEGMENTS",jt."PI_TF_FAREAMOUNT",jt."PI_TF_TAXESAMOUNT",jt."PI_TF_TOTALAMOUNT",jt."PI_PTCF_PK_PAXTYPE",jt."PI_PTCF_PK_QUANTITY",jt."PI_PTCF_PK_SEATS",jt."PI_PTCF_BD_FAREAMOUNT",jt."PI_PTCF_BD_TAXESAMOUNT",jt."PI_PTCF_BD_TOTALAMOUNT",jt."PI_PTCF_FAREBASISCODES",jt."VALIDATINGCARRIER",jt."SEEMSTOBEINVALID",jt."PERSEGMENT",jt."PERPTCBREAKDOWNS",jt."TOTALAMOUNT",jt."TOTALMARKUP",jt."PAX_GIVENNAME",jt."PAX_SURNAME",jt."PAX_DATEOFBIRTH",jt."PAX_PAXTYPE",jt."PHONE",jt."EMAIL",jt."SYSTEMTIMELIMIT",jt."PRICEWASCHANGED",jt."TIMEWASCHANGED",jt."ISFAILED",jt."PNRRECORDLOCATOR"

FROM ord.item_avia ia,
json_table(pnr_object, '$'
  COLUMNS (
    book_id VARCHAR2(250) PATH '$.id',
    row_number FOR ORDINALITY,
    paxType VARCHAR2(250) PATH '$.passengersQueried[0].paxType',
    quantity VARCHAR2(250) PATH '$.passengersQueried[0].quantity',
    seats VARCHAR2(250) PATH '$.passengersQueried[0].seats',
    
    
    NESTED PATH '$.pricedItinerary.airItinerary.legs[*]' COLUMNS (
      NESTED PATH '$.flightSegments[*]' COLUMNS (
        dep_location VARCHAR2(256 CHAR) PATH '$.departure.location',
        dep_dateTime VARCHAR2(256 CHAR) PATH '$.departure.dateTime',
        arr_location VARCHAR2(256 CHAR) PATH '$.arrival.location',
        arr_dateTime VARCHAR2(256 CHAR) PATH '$.arrival.dateTime',
        elapsedTime VARCHAR2(256 CHAR) PATH '$.elapsedTime',
        stop_location VARCHAR2(256 CHAR) PATH '$.stops[0].location',
        arrivalDateTime VARCHAR2(256 CHAR) PATH '$.stops[0].timing.arrivalDateTime',
        departureDateTime VARCHAR2(256 CHAR) PATH '$.stops[0].timing.departureDateTime',
        stops_timing_elapsedTime VARCHAR2(256 CHAR) PATH '$.stops[0].timing.elapsedTime',
        o_flightNumber VARCHAR2(256 CHAR) PATH '$.operating.flightNumber',
        o_airline VARCHAR2(256 CHAR) PATH '$.operating.airline',
        m_flightNumber VARCHAR2(256 CHAR) PATH '$.marketing.flightNumber',
        m_airline VARCHAR2(256 CHAR) PATH '$.marketing.airline',
        planeType VARCHAR2(256 CHAR) PATH '$.planeType',
        marriageGroup VARCHAR2(256 CHAR) PATH '$.marriageGroup',
        bookingCode VARCHAR2(256 CHAR) PATH '$.bookingCode',
        fs_timeWasChanged VARCHAR2(256 CHAR) PATH '$.timeWasChanged'
      ),
      flightTime VARCHAR2(256 CHAR) PATH '$.flightTime'
    ),
    totalOfFlightSegments number(3) PATH '$.airItinerary.totalOfFlightSegments',
    pi_tf_fareAmount number(20,2) PATH '$.pricedItinerary.pricingInfo.totalFareBreakdown.fareAmount',
    pi_tf_taxesAmount number(20,2) PATH '$.pricedItinerary.pricingInfo.totalFareBreakdown.taxesAmount',
    pi_tf_totalAmount number(20,2) PATH '$.pricedItinerary.pricingInfo.totalFareBreakdown.totalAmount',

    pi_ptcf_pk_paxType VARCHAR2(100) PATH '$.pricedItinerary.pricingInfo.ptcFareBreakdowns[0].paxKit.paxType',
    pi_ptcf_pk_quantity number(18) PATH '$.pricedItinerary.pricingInfo.ptcFareBreakdowns[0].paxKit.quantity',
    pi_ptcf_pk_seats number(18) PATH '$.pricedItinerary.pricingInfo.ptcFareBreakdowns[0].paxKit.seats',
    pi_ptcf_bd_fareAmount number(20,2) PATH '$.pricedItinerary.pricingInfo.ptcFareBreakdowns[0].breakdown.fareAmount',
    pi_ptcf_bd_taxesAmount number(20,2) PATH '$.pricedItinerary.pricingInfo.ptcFareBreakdowns[0].breakdown.taxesAmount',
    pi_ptcf_bd_totalAmount number(20,2) PATH '$.pricedItinerary.pricingInfo.ptcFareBreakdowns[0].breakdown.totalAmount',

/*!!!*/    pi_ptcf_fareBasisCodes  VARCHAR2(100) FORMAT JSON  PATH '$.pricedItinerary.pricingInfo.ptcFareBreakdowns[0].fareBasisCodes',
    validatingCarrier VARCHAR2(100) PATH '$.pricedItinerary.pricingInfo.validatingCarrier',
    seemsToBeInvalid VARCHAR2(100) PATH '$.pricedItinerary.pricingInfo.seemsToBeInvalid',
    perSegment number(20,2) PATH '$.markupValue.perSegment',
    perPtcBreakdowns number(20,2) PATH '$.markupValue.perPtcBreakdowns[0]',

    totalAmount number(20,2) PATH '$.totalAmount',
    totalMarkup number(20,2) PATH '$.totalMarkup',
    pax_givenName varchar2(120) PATH '$.paxDetails.paxes[0].givenName',
    pax_surname varchar2(120) PATH '$.paxDetails.paxes[0].surname',
    pax_dateOfBirth varchar2(120) PATH '$.paxDetails.paxes[0].dateOfBirth',
    pax_paxType varchar2(120) PATH '$.paxDetails.paxes[0].paxType',
    phone varchar2(120) PATH '$.paxDetails.phone',
    email varchar2(120) PATH '$.paxDetails.email',
    systemTimeLimit VARCHAR2(250) PATH '$.systemTimeLimit',
    priceWasChanged VARCHAR2(250) PATH '$.priceWasChanged',
    timeWasChanged VARCHAR2(250) PATH '$.timeWasChanged',
    isFailed VARCHAR2(250) PATH '$.isFailed',
    pnrRecordLocator VARCHAR2(250) PATH '$.pnrRecordLocator'
  )
) AS "JT"
where amnd_state = 'A'
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

  CREATE OR REPLACE  VIEW "NTG"."V_GEO_SUGGEST" 
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
 search_rating
from 
  (
  select 
  max(id) id,
  iata,
  nls_name name
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
  group by iata, nls_name
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


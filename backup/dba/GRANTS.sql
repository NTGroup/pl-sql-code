-- special grants
GRANT CREATE JOB TO HDBK;
grant references on  ord.bill TO blng;
grant references on blng.usr TO hdbk;


-- HDBK
grant execute on hdbk.dtype to po_fwdr;
grant execute on hdbk.dtype to ord;
grant execute on hdbk.dtype to blng;
grant execute on hdbk.dtype to erp;

grant execute on hdbk.hdbk_api to po_fwdr;
grant execute on hdbk.hdbk_api to ord;
grant execute on hdbk.hdbk_api to blng;

grant execute on hdbk.log_api to ord;
grant execute on hdbk.log_api to blng;
grant execute on hdbk.log_api to erp;
grant execute on hdbk.log_api to po_fwdr;

grant execute on hdbk.core to blng with grant option;
grant execute on hdbk.core to ord;

grant execute on hdbk.fwdr to po_fwdr;
grant execute on hdbk.fwdr to ord;
grant execute on hdbk.fwdr to blng;

grant select on hdbk.airline TO ord;
grant select on hdbk.airline to po_fwdr;
grant select on hdbk.geo TO ord;
--grant select on hdbk.markup_type TO ord;
grant select on hdbk.currency TO ord;
grant select on hdbk.dictionary TO blng;
grant select on hdbk.dictionary TO ord;

grant select on hdbk.V_GEO_SUGGEST to po_fwdr;



-- BLNG
grant debug on blng.core to hdbk;
grant execute on blng.core to hdbk;
grant debug on blng.fwdr to hdbk;
grant execute on blng.blng_api to hdbk;
grant debug on blng.blng_api to hdbk;

grant select on blng.usr TO hdbk;
grant select on BLNG.USR TO ord with grant option;
grant select on blng.v_delay to ord;


-- ORD
grant debug on ord.ord_api to hdbk;
grant debug on ord.core to hdbk;
grant debug on ord.fwdr to hdbk;

grant execute on ord.core to hdbk;
grant select on ord.commission TO hdbk;
grant select on ord.bill to hdbk;
grant select on ord.v_bill to blng;


-- ERP
GRANT create SESSION to erp_gate;
grant debug on erp.erp_api to hdbk;
grant execute on erp.gate to erp_gate;
grant debug on erp.gate to hdbk;



---- NOT_SORTED
grant select on blng.contract to ord;
grant select on blng.usr to ord;
grant select on blng.client to ord;
grant select on blng.domain to ord;
grant select on blng.USR2CONTRACT to ord;
grant select on blng.USR_DATA to ord;
grant select on blng.account to ord;
grant select on blng.document to ord;
grant select on blng.transaction to ord;
grant select on blng.delay to ord;
grant select on blng.event to ord;
----grant select on blng.trans_type to ord;


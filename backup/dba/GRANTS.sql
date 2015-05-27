grant references on  ord.bill TO blng;
grant references on blng.client TO hdbk;

grant execute on hdbk.dtype to po_fwdr;
grant execute on hdbk.dtype to ord;
grant execute on hdbk.dtype to blng;
grant execute on hdbk.log_api to ord;
grant execute on hdbk.log_api to blng;
grant execute on hdbk.log_api to po_fwdr;
grant execute on hdbk.fwdr to po_fwdr;
grant execute on hdbk.fwdr to ord;
grant execute on hdbk.fwdr to blng;
grant execute on hdbk.hdbk_api to po_fwdr;
grant execute on hdbk.hdbk_api to ord;
grant execute on hdbk.hdbk_api to blng;


grant select on hdbk.airline TO ord;
grant select on hdbk.geo TO ord;
grant select on hdbk.markup_type TO ord;
grant select on hdbk.currency TO ord;

grant execute on blng.blng_api to hdbk;
grant select on blng.client TO hdbk;
grant select on ord.commission TO hdbk;

grant execute on blng.blng_api to hdbk;

grant select on hdbk.V_GEO_SUGGEST to po_fwdr;
grant execute on hdbk.core to blng;

grant select on hdbk.dictionary TO blng;
grant select on hdbk.dictionary TO ord;

grant execute on ord.core to hdbk;
grant execute on blng.core to hdbk;

grant select on hdbk.airline to po_fwdr;

grant select on ord.bill to hdbk;


grant execute on erp.gate to erp_gate;
grant execute on hdbk.dtype to erp;
grant execute on hdbk.log_api to erp;

GRANT create SESSION to erp_gate;
GRANT CREATE JOB TO HDBK;


grant debug on ord.ord_api to hdbk;
grant debug on ord.core to hdbk;
grant debug on ord.fwdr to hdbk;
grant debug on blng.blng_api to hdbk;
grant debug on blng.core to hdbk;
grant debug on blng.fwdr to hdbk;
grant debug on erp.erp_api to hdbk;
grant debug on erp.gate to hdbk;



------ system
/*grant select on hdbk.gds_nationality to ntg;
grant select on hdbk.note to ntg;
grant select on hdbk.note_ticket to ntg;
grant insert on hdbk.gds_nationality to ntg;
grant insert on hdbk.note to ntg;
grant insert on hdbk.note_ticket to ntg;
grant update on hdbk.gds_nationality to ntg;
grant update on hdbk.note to ntg;
grant update on hdbk.note_ticket to ntg;


grant select on hdbk.geo to ntg;
grant insert on hdbk.geo to ntg;
grant update on hdbk.geo to ntg;
grant select on hdbk.airplane to ntg;
grant insert on hdbk.airplane to ntg;
grant update on hdbk.airplane to ntg;
grant select on hdbk.airline to ntg;
grant insert on hdbk.airline to ntg;
grant update on hdbk.airline to ntg;
grant select on hdbk.markup_type to ntg;
grant insert on hdbk.markup_type to ntg;
grant update on hdbk.markup_type to ntg;

grant execute on hdbk.hdbk_api to ntg;*/
---



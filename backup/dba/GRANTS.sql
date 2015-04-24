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



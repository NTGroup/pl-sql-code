

@metadata/view.sql;
@data/pkg/blng.blng_api.sql;
@data/pkg/blng.core.sql;
@data/pkg/blng.fwdr.sql;
@data/pkg/ntg.ntg_api.sql;
@data/pkg/ntg.fwdr.sql;
@data/pkg/ntg.log_api.sql;
@data/pkg/ntg.dtype.sql;
@data/pkg/ord.ord_api.sql;
@data/pkg/ord.core.sql;
@data/pkg/ord.fwdr.sql;


CREATE bitmap INDEX blng.cmp_AS_IDX ON blng.company (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.clt_AS_IDX ON blng.client (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.cntr_AS_IDX ON blng.contract (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.cl2cntr_AS_IDX ON blng.client2contract (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.doc_AS_IDX ON blng.document (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.trn_AS_IDX ON blng.transaction (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.acc_AS_IDX ON blng.account (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.dly_AS_IDX ON blng.delay (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.dmn_AS_IDX ON blng.domain (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.cld_AS_IDX ON blng.client_data (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.trt_AS_IDX ON blng.trans_type (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.ett_AS_IDX ON blng.event_type (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.stt_AS_IDX ON blng.status_type (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.acct_AS_IDX ON blng.account_type (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX blng.evnt_AS_IDX ON blng.event (amnd_state) TABLESPACE "USERS" ;

CREATE bitmap INDEX ord.ord_AS_IDX ON ord.ord (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX ord.bill_AS_IDX ON ord.bill (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX ord.cmn_AS_IDX ON ord.commission (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX ord.cd_AS_IDX ON ord.commission_details (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX ord.ct_AS_IDX ON ord.commission_template (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX ord.iav_AS_IDX ON ord.item_avia (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX ord.iavs_AS_IDX ON ord.item_avia_status (amnd_state) TABLESPACE "USERS" ;

CREATE bitmap INDEX ntg.geo_AS_IDX ON ntg.geo (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX ntg.log_AS_IDX ON ntg.log (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX ntg.mkp_AS_IDX ON ntg.markup (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX ntg.al_AS_IDX ON ntg.airline (amnd_state) TABLESPACE "USERS" ;
CREATE bitmap INDEX ntg.ap_AS_IDX ON ntg.airplane (amnd_state) TABLESPACE "USERS" ;

CREATE INDEX blng.doc_dd_IDX ON blng.document (doc_date) TABLESPACE "USERS" ;
CREATE INDEX blng.trn_td_IDX ON blng.transaction (trans_date) TABLESPACE "USERS" ;
CREATE INDEX blng.dly_dt_IDX ON blng.delay (date_to) TABLESPACE "USERS" ;




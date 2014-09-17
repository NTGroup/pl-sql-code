CREATE TABLE  doc
(
id           NUMBER(18,0)
    CONSTRAINT doc_id_nn NOT NULL,
    CONSTRAINT    doc_id_pk
                    PRIMARY KEY (id ) 
                    using index ( create index doc_id_idx on m_transaction(id)
                    TABLESPACE  users),
)
 
INITRANS    1
MAXTRANS    255
TABLESPACE  users
STORAGE   (
INITIAL     65536
MINEXTENTS  1
MAXEXTENTS  2147483645
);
/


CREATE TABLE  m_transaction
(
id           NUMBER(18,0)
    CONSTRAINT mtr_id_nn NOT NULL,
doc_oid  number ,
    CONSTRAINT    mtr_id_pk
                    PRIMARY KEY (id)
                    using index ( create index mtr_id_idx on m_transaction(id)
                    TABLESPACE  users),
    CONSTRAINT    mtr_doc_oid_fk
                    FOREIGN KEY (id) REFerences doc(id)
        
)
 
INITRANS    1
MAXTRANS    255
TABLESPACE  users
STORAGE   (
INITIAL     65536
MINEXTENTS  1
MAXEXTENTS  2147483645
);
/




create sequence  mtr_seq
increment by 1
start with 1
nomaxvalue
nocache /*!!!*/
nocycle
order;
/
 
CREATE OR REPLACE TRIGGER mtr_trgr
BEFORE
INSERT
ON m_transaction
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
WHEN (new.id is null)
BEGIN
select mtr_seq.nextval into :new.id from dual; end;
/




ALTER TABLE geo
ADD CONSTRAINT geo_id_pk PRIMARY KEY (id);


ALTER TABLE geo 
MODIFY (parent_id NUMBER CONSTRAINT geo_parent_id_nn NOT NULL); 


ALTER TABLE geo 
MODIFY (id NUMBER CONSTRAINT geo_id_nn NOT NULL); 


???????????????
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
   FOREIGN KEY (column1, column2, ... column_n)
   REFERENCES parent_table (column1, column2, ... column_n);
   
   
   
   ALTER TABLE  c##tagan.t_doc_airport
ADD CONSTRAINT airport_id_fk1
   foreign KEY (id)
   references  c##tagan.t_version(geo_id);
  
 
   select * from  c##tagan.t_doc_city
   
   
   ALTER TABLE t_version
ADD CONSTRAINt version_id_unq UNIQUE (geo_id);

 
   ALTER TABLE t_doc_city
ADD CONSTRAINt city_id_unq UNIQUE (id);


create or replace TRIGGER mkp_upd_trgr
BEFORE
UPDATE
ON markup
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
declare
mkp markup%rowtype;
BEGIN
select * into mkp from markup where id = :new.id;
mkp.id := null;
mkp.amnd_state := 'I';
insert into markup values mkp;
commit;
--select mtr_seq.nextval into :new.id from dual; 
end;


insert into markup (client) values ('hello');
commit;

select * from markup
update markup set gds = 'ggg1' where id = 4;
commit;
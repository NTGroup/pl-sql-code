--------------------------------------------------------
--  DDL for Package DP
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "NTG"."DP" is

/**
* Project: W4Kernel
* Description: Standard data types
* @headcom
*/

Counter integer;
RecordID integer;

RecordIdt varchar2(255);
RecordIdtLength constant Counter %Type := 255;

Tag varchar2 (1);
TagLength constant Counter %Type := 1;

StoredNameLength constant Counter %Type := 32;

Name varchar2 (255);
NameLength constant Counter %Type := 255;

String varchar2 (255);
StringLength constant Counter %Type := 255;

ErrorMessage varchar2 (4000);
ErrorMessageLength constant Counter %Type := 3900;

LongStr varchar2 (4000);
LongStrLength constant Counter %Type := 3900;

XMLString varchar2 (32740);
XMLStringLength constant Counter %Type := 32740;

CurrentTime date;
CurrentDate date;
CurrentTimestamp timestamp (3);

LongInteger integer;
BigDecimal number;
XMLclob clob;
BinaryBlob blob;
LongData long;
ClobData clob;
NClobData nclob;


ContractNumber varchar2(64);
ContractNumberLength constant dp.Counter%type := 64;
GLNumber varchar2(64);
GLNumberLength constant dp.Counter%type := 64;
DocNumber varchar2(32);
DocNumberLength constant dp.Counter%type := 32;
MemberID varchar2(32);
MemberIDLength constant dp. Counter %type := 32;
CSRefNum varchar2(12);
CSRefNumLength constant dp. Counter %type := 12;
TransCode varchar2(32);
TransCodeLength constant dp. Counter %type := 32;
SICCode varchar2(4);
SICCodeLength constant dp. Counter %type := 4;
AccCode varchar2(32);
AccCodeLength constant dp. Counter %type := 32;
AuthCode varchar2(32);
AuthCodeLength constant dp. Counter %type := 32;

Money number;
CurrencyCode varchar2(3);
CurrencyCodeLength constant dp. Counter %type := 3;
RateValue number;
InterestRate number;
ReasonCode varchar2(2);
ReasonCodeLength constant dp. Counter %type := 2;
Direction integer;
EntryType varchar2(1);
EntryTypeLength constant dp. Counter %type := 1;

end dp;

/

CREATE TABLE j_purchaseorder
   (id          RAW (16) NOT NULL,
    date_loaded TIMESTAMP WITH TIME ZONE,
    po_document CLOB
    CONSTRAINT ensure_json CHECK (po_document IS JSON));
    
    
    
    INSERT INTO j_purchaseorder
  VALUES (
    SYS_GUID(),
    SYSTIMESTAMP,
    '{"PONumber"             : 1600,
      "Reference"            : "ABULL-20140421",
      "Requestor"            : "Alexis Bull",
      "User"                 : "ABULL",
      "CostCenter"           : "A50",
      "ShippingInstructions" : {"name"   : "Alexis Bull",
                                "Address": {"street"  : "200 Sporting Green",
                                            "city"    : "South San Francisco",
                                            "state"   : "CA",
                                            "zipCode" : 99236,
                                            "country" : "United States of America"},
                                "Phone" : [{"type" : "Office", "number" : "909-555-7307"},
                                           {"type" : "Mobile", "number" : "415-555-1234"}]},
      "Special Instructions" : null,
      "AllowPartialShipment" : true,
      "LineItems"            : [{"ItemNumber" : 1,
                                 "Part"       : {"Description" : "One Magic Christmas",
                                                 "UnitPrice"   : 19.95,
                                                 "UPCCode"     : 13131092899},
                                 "Quantity"   : 9.0},
                                {"ItemNumber" : 2,
                                 "Part"       : {"Description" : "Lethal Weapon",
                                                 "UnitPrice"   : 19.95,
                                                 "UPCCode"     : 85391628927},
                                 "Quantity"   : 5.0}]}');
                                 
                                 commit
                                 
                                 
                                 
                                 
                                 

SELECT po.* FROM j_purchaseorder po;
SELECT po.po_document FROM j_purchaseorder po;

SELECT json_value(po_document, '$.*')
 FROM j_purchaseorder;

SELECT json_value(po_document, '$.AllowPartialShipment' RETURNING NUMBER)
  FROM j_purchaseorder;

SELECT json_query(po_document, '$.ShippingInstructions.Phone'
                               WITHOUT WRAPPER)
  FROM j_purchaseorder;
  
SELECT *
  FROM j_purchaseorder;


  SELECT json_value(po_document, '$.Requestor' RETURNING VARCHAR2(32)),
       json_query(po_document, '$.ShippingInstructions.Phone'
                               RETURNING VARCHAR2(100))
  FROM j_purchaseorder
  WHERE json_exists(po_document, '$.ShippingInstructions.Address.zipCode')
    AND json_value(po_document,  '$.AllowPartialShipment' RETURNING NUMBER(1))
        = 1;
        
        
        SELECT jt.*
  FROM j_purchaseorder,
       json_table(po_document, '$'
         COLUMNS (requestor VARCHAR2(32 CHAR) PATH '$.Requestor',
                  phones    VARCHAR2(100 CHAR) FORMAT JSON
                            PATH '$.ShippingInstructions.Phone',
                  partial   NUMBER(1) PATH '$.AllowPartialShipment',
                  has_zip   VARCHAR2(5 CHAR) EXISTS
                            PATH '$.ShippingInstructions.Address.zipCode')) jt
  WHERE jt.partial = 1 AND jt.has_zip = 'true';
  
  select * from j_purchaseorder
  
  
  
  SELECT jt.*
  FROM j_purchaseorder,
       json_table(po_document, '$.ShippingInstructions.Phone[*]'
         COLUMNS (phone_type VARCHAR2(10) PATH '$.type',
                  phone_num VARCHAR2(20) PATH '$.number')) AS "JT";
    
    
              
  SELECT json_query(po_document, '$.ShippingInstructions.Phone[*].number')
  FROM j_purchaseorder




  SELECT jtq.*
  FROM (      
  
  SELECT  json_query(jt.q,'$' ) q
  FROM j_purchaseorder,
       json_table(po_document, '$'
         COLUMNS (requestor VARCHAR2(32 CHAR) PATH '$.Requestor',
                  phones    VARCHAR2(100 CHAR) FORMAT JSON
                            PATH '$.ShippingInstructions.Phone',
                  partial   NUMBER(1) PATH '$.AllowPartialShipment',
                  has_zip   VARCHAR2(5 CHAR) EXISTS
                            PATH '$.ShippingInstructions.Address.zipCode',
                  q         VARCHAR2(100 CHAR) FORMAT JSON
                            PATH '$.ShippingInstructions'       )
                            ) jt
  WHERE jt.partial = 1 AND jt.has_zip = 'true'
  
  
  ),
       json_table(q, '$.Phone[*]'
         COLUMNS (phone_type VARCHAR2(10) PATH '$.type',
                  phone_num VARCHAR2(20) PATH '$.number')) AS jtq;
                  
 SELECT po.po_document.ShippingInstructions.Phone FROM j_purchaseorder po;
 
 
 
  SELECT *
    FROM j_purchaseorder 


    
 SELECT d.*/*,
 json_query(po_document, '$.ShippingInstructions.unitprice'
                               RETURNING number(12,2) )*/
    FROM j_purchaseorder po,
         json_table(po.po_document, '$'
           COLUMNS (
             po_number        NUMBER(10)         PATH '$.PONumber',
             reference        VARCHAR2(30 CHAR)  PATH '$.Reference',
             requestor        VARCHAR2(128 CHAR) PATH '$.Requestor',
             userid           VARCHAR2(10 CHAR)  PATH '$.User',
             costcenter       VARCHAR2(16)       PATH '$.CostCenter',
             ship_to_name     VARCHAR2(20 CHAR)
                              PATH '$.ShippingInstructions.name',
             ship_to_street   VARCHAR2(32 CHAR)
                              PATH '$.ShippingInstructions.Address.street',
             ship_to_city     VARCHAR2(32 CHAR)
                              PATH '$.ShippingInstructions.Address.city',
             ship_to_county   VARCHAR2(32 CHAR)
                              PATH '$.ShippingInstructions.Address.county',
             ship_to_postcode VARCHAR2(10 CHAR)
                              PATH '$.ShippingInstructions.Address.postcode',
             ship_to_state    VARCHAR2(2 CHAR)
                              PATH '$.ShippingInstructions.Address.state',
             ship_to_zip      VARCHAR2(8 CHAR)
                              PATH '$.ShippingInstructions.Address.zipCode',
             ship_to_country  VARCHAR2(32 CHAR)
                              PATH '$.ShippingInstructions.Address.country',
             ship_to_phone    VARCHAR2(24 CHAR)
                              PATH '$.ShippingInstructions.Phone[0].number',
             NESTED PATH '$.LineItems[*]'
               COLUMNS (
                 itemno      VARCHAR2(256 CHAR)         PATH '$.ItemNumber', 
                 description VARCHAR2(256 CHAR) PATH '$.Part.Description', 
                 upc_code    VARCHAR2(256 CHAR)  PATH '$.Part.UPCCode', 
                 quantity    VARCHAR2(256 CHAR)      PATH '$.Quantity', 
                 unitprice  number(12,2)      PATH '$.Part.UnitPrice'
                
                 
                 ))) d;



             
                        select 12.12*2 from dual    
                        
                        
                        
ALTER SESSION SET 
NLS_NUMERIC_CHARACTERS = ',.';

SQL> SELECT ename, hiredate, ROUND(sal/12,2) sal FROM emp;
ENAME     HIREDATE    SAL
-----     --------    ---
Clark     09.DEZ.88   4195.83
Miller    23.MÄR.87   4366.67
Strauß    01.APR.95   3795.87

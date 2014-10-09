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
  
  
  
  SELECT jt.*
  FROM j_purchaseorder,
       json_table(po_document, '$.ShippingInstructions.Phone[*]'
         COLUMNS (phone_type VARCHAR2(10) PATH '$.type',
                  phone_num VARCHAR2(20) PATH '$.number')) AS "JT";
                  



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
                  
                  
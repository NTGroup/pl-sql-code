
   create or replace and compile
   java source named "RandomUUID"
   as
   public class RandomUUID
    {
       public static String create()
     {
             return java.util.UUID.randomUUID().toString();
     }
   };
/

CREATE OR REPLACE FUNCTION RandomUUID
   RETURN VARCHAR2
    AS LANGUAGE JAVA
    NAME 'RandomUUID.create() return java.lang.String';



DATA SHARING 
-- AVAILABLE FOR ALL SNOWFLAKE EDITIONS 


 Account1   ========= Data is Synchronized ====================>   Account2 (Read only , can't be modified )
(Provider)                                                        (Consumer)   


Note :  
      1. Data will not be copied , it is just the metadata operation ( cloud service layer)
      2. Account1 will have the storage 
      3. Account2 will have it's own "compute resources" . So when Account2 will try to read something , then the respective compute resources of Account2 will be charged . 
      4. Provider & Consumer can be together . Account1(Provider & Consumer) <===> Account2(Provider & Consumer) 


      
Steps : 


1. Create Share : ACCOUNTADMIN role or CREATE SHARE privilges required 
   CREATE SHARE my_share;

2. Grant Privilges to share 
   GRANT USAGE ON DATABASE my_db TO SHARE my_share; 
   GRANT USAGE ON SCHEMA my_schema.my_db TO SHARE my_share; 
   GRANT SELECT ON TABLE my_table.my_schema.my_db TO SHARE my_share; 

3. Add consumer accounts(s)
   ALTER SHARE my_share ADD ACCOUNT 76JGJGJ; 

4. Import Share :  ACCOUNTADMIN role or IMPORT SHARE / CREATE DATABASE privileges required . 
   CREATE DATABASE my_db FROM SHARE my_share; 


What can be shared ?

TABLES | EXTERNAL TABLES | SECURE VIEWS | SECURE MATERIALIZED VIEWS | SECURE UDFs


Share is like a container which has : 
    1. database 
    2. Schema 
    3. Objects 
    4. Accounts(s)
    5. Privileges 

Best Practices : 
     1. Database 
     2. Schema 
     3. Secure views
     4. Accounts(s)
     5. Privileges


Data Sharing with Non-Snowflake Users :
-- Using Reader Account 





////// PRACTICLES ////////////////////////////////////////////////////////////////


-- PREPARATION 

CREATE OR REPLACE DATABASE DATA_SHARE; 
USE DATA_SHARE;

CREATE OR REPLACE FILE FORMAT DATA_SHARE.PUBLIC.FLEFORMAT_AZURE
  TYPE = CSV
  FIELD_DELIMITER = ','
  SKIP_HEADER=1;

  
CREATE OR REPLACE STAGE AZURE_STAGE
     URL = 'azure://azuresnowflakecoupling.blob.core.windows.net/snowflakelearning'
     STORAGE_INTEGRATION = azure_integration
     FILE_FORMAT = DATA_SHARE.PUBLIC.FLEFORMAT_AZURE;


LIST @AZURE_STAGE;     


CREATE OR REPLACE TABLE ORDERS 
(
EMPNO STRING,
ENAME STRING,
JOB STRING,
MGR STRING,
HIREDATE string,
SAL STRING,
COMM STRING,
DEPTNO STRING,
UPDATED_DATE string
);  


COPY INTO ORDERS FROM @AZURE_STAGE
FILES = ('emp.csv')

SELECT * FROM ORDERS ; 


-- NOW suppose we want to share only 5 fields to users without exposing all the data . So we will create a view 

CREATE OR REPLACE VIEW ORDERS_VIEW AS 
SELECT EMPNO,ENAME,JOB,MGR FROM ORDERS; 



NOTE : IT is not possible (recommended ) to share the view to the user . Because though we are sharing the limited data but still the 'text' column can reveal more data . 
SHOW VIEWS LIKE '%ORDERS%' 
The 'text' column will have the whole view defination 



So it is a best practice to share the data using the 'SECURE VIEWS' 

CREATE OR REPLACE SECURE VIEW ORDERS_VIEW_SECURE AS 
(SELECT EMPNO,ENAME,JOB,MGR FROM ORDERS); 

SHOW VIEWS LIKE '%ORDERS%' 




/// CREATING SHARE //// 

-- STEP 1 : CREATE A SHARE OBJECT 
-- You need the ACCOUNTADMIN role 

USE ROLE ACCOUNTADMIN;

-- CREATE SHARE 
CREATE OR REPLACE SHARE ORDERS_SHARE;


-- STEP 2: SET UP THE GRANTS 

GRANT USAGE ON DATABASE DATA_SHARE TO SHARE ORDERS_SHARE; 
GRANT USAGE ON SCHEMA DATA_SHARE.PUBLIC TO SHARE ORDERS_SHARE; 

GRANT SELECT ON VIEW ORDERS_VIEW_SECURE TO SHARE ORDERS_SHARE;

-- VALIDATE GRANTS 
SHOW GRANTS TO SHARE ORDERS_SHARE;





-- CREATE READER ACCOUNT FOR NON-SNOWFLAKE ACCOUNT 

CREATE MANAGED ACCOUNT READER_ACCOUNT 
ADMIN_NAME = read_acc_admin,
ADMIN_PASSWORD = 'Hello@world12456',
TYPE = READER; 

SHOW MANAGED ACCOUNTS;
-- NOTE THE URL 

ALTER SHARE ORDERS_SHARE 
ADD ACCOUNT = FK13264


ALTER SHARE ORDERS_SHARE 
ADD ACCOUNT = FK13264
SHARE_RESTRICTIONS=false 


show shares;


SHOW MANAGED ACCOUNTS;



















 
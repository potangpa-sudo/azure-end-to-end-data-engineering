CREATE DATABASE SCOPED CREDENTIAL cred_poto
WITH
    IDENTITY = 'Managed Identity'


CREATE EXTERNAL DATA SOURCE source_silver
WITH
(
    LOCATION = 'https://potoazurestoragedatalake.blob.core.windows.net/silver/',
    CREDENTIAL = cred_poto
)

CREATE EXTERNAL DATA SOURCE source_gold
WITH
(
    LOCATION = 'https://potoazurestoragedatalake.blob.core.windows.net/gold/',
    CREDENTIAL = cred_poto
)

CREATE EXTERNAL FILE FORMAT format_paquet
WITH(
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)

--------------------------------------
-- CREATE EXTERNAL TABLE EXTSALES
--------------------------------------

CREATE EXTERNAL TABLE gold.extsales
WITH(
    LOCATION = 'extsale',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_paquet
)
AS
SELECT *
FROM gold.sales

SELECT *
FROM gold.extsales
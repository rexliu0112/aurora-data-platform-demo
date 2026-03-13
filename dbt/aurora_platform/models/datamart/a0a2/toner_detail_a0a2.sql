{{ config(
    materialized='table',
    schema='datamart_a0a2',
    alias='toner_detail',
    partition_by={"field": "POSTDATE_D", "data_type": "date", "granularity": "month"},
    cluster_by=["MARA", "MACNO", "CTNO"]
) }}

SELECT
    *,
    PARSE_DATE('%Y%m%d', POSTDATE) AS POSTDATE_D
FROM (
    {{ toner_detail_build('a0a2') }}
)
{% macro stg_sd022dl(source_name) %}

SELECT
    CAST(ORIGIN_AGRE AS STRING) AS ORIGIN_AGRE,
    CAST(SO_NO AS STRING) AS SO_NO,
    CAST(CUSTNO AS STRING) AS CUSTNO,
    CAST(CT010_61 AS STRING) AS CT010_61,
    CT010_69
FROM {{ source(source_name, 'sd022dl_new') }}

{% endmacro %}

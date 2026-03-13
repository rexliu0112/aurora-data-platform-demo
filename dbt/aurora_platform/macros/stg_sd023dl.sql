{% macro stg_sd023dl(source_name) %}

SELECT
    CAST(MACNO AS STRING) AS MACNO,
    CAST(MARA AS STRING) AS MARA,
    CAST(SO_NO AS STRING) AS SO_NO,
    CAST(SERIAL_NO AS STRING) AS SERIAL_NO,
    CT020_52,
    CT020_54,
    CAST(TG_TYPE AS STRING) AS TG_TYPE,
    CT020_53AC,
    CT020_53C,
    CT020_53,
    CT020_56,
    CT020_57,
    CT020_36A,
    CT020_36,
    CT020_58
FROM {{ source(source_name, 'sd023dl_new') }}

{% endmacro %}

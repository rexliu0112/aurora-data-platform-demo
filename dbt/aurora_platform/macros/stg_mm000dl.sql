{% macro stg_mm000dl(source_name) %}

SELECT
    CAST(MARAGRP AS STRING) AS MARAGRP,
    CAST(MARA AS STRING) AS MARA
FROM {{ source(source_name, 'mm000dl_new') }}

{% endmacro %}

{% macro stg_eq010dl(source_name) %}

SELECT
    CAST(EQ010_1 AS STRING) AS EQ010_1,
    CAST(EQ010_3 AS STRING) AS EQ010_3,
    CAST(MACID AS STRING) AS MACID,
    CAST(SO_NO1 AS STRING) AS SO_NO1
FROM {{ source(source_name, 'eq010dl_new') }}

{% endmacro %}

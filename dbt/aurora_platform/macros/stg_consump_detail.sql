{% macro stg_consump_detail(source_name) %}

SELECT
*
FROM {{ source(source_name, 'consump_detail') }}

{% endmacro %}

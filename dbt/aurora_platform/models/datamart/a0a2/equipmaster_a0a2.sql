{{ config(
    materialized='incremental',
    schema='datamart_a0a2',
    alias='equipmaster',
    cluster_by=["MARA", "MACNO", "CTNO"]
) }}

{% if is_incremental() %}
  {% do run_query(
    "DELETE FROM " ~ this ~ " WHERE (STOPDT IS NULL OR STOPDT = '') OR PARSE_DATE('%Y%m%d', STOPDT) >= DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH), MONTH)"
  ) %}
{% endif %}

{{ equipmaster_build('a0a2') }}

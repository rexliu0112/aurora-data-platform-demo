{% macro toner_qty(flag_col, counter_col) %}
    CASE WHEN {{ flag_col }} = 1 AND {{ counter_col }} > 0 THEN {{ counter_col }} ELSE NULL END
    - LAG(CASE WHEN {{ flag_col }} = 1 AND {{ counter_col }} > 0 THEN {{ counter_col }} ELSE NULL END)
      OVER (PARTITION BY MARA, MACNO, CTNO, {{ flag_col }} ORDER BY POSTDATE)
{% endmacro %}

{% macro toner_days(flag_col) %}
    DATE_DIFF(
        PARSE_DATE('%Y%m%d', CASE WHEN {{ flag_col }} = 1 THEN POSTDATE ELSE NULL END),
        LAG(PARSE_DATE('%Y%m%d', CASE WHEN {{ flag_col }} = 1 THEN POSTDATE ELSE NULL END))
            OVER (PARTITION BY MARA, MACNO, CTNO, {{ flag_col }} ORDER BY POSTDATE),
        DAY
    )
{% endmacro %}
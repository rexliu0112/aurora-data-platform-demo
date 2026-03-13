{{ config(
    materialized='table',
    schema='datamart_a0a2',
    alias='print_invoice_detail',
    partition_by={"field": "INVOICE_DATE", "data_type": "date", "granularity": "month"},
    cluster_by=["MARA", "MACNO", "CTNO"]
) }}

{{ print_invoice_detail_build('a0a2') }}

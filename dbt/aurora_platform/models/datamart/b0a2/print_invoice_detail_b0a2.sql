{{ config(
    materialized='table',
    schema='datamart_b0a2',
    alias='print_invoice_detail',
    partition_by={"field": "INVOICE_DATE", "data_type": "date", "granularity": "month"},
    cluster_by=["MARA", "MACNO", "CTNO"]
) }}

{{ print_invoice_detail_build('b0a2') }}
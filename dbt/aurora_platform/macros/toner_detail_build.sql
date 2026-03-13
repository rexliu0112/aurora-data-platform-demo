{% macro toner_detail_build(company) %}

WITH consump AS (
    SELECT * FROM {{ ref('stg_' ~ company ~ '_consump_detail') }}
),

-- 找出回倉紀錄
return_consump AS (
    SELECT MARA, MACNO, CTNO, ITEM_MARA, DOCNO
    FROM consump
    WHERE DOCNO_TYPE LIKE '%回倉%'
      AND (LEFT(CTNO, 2) = 'CT' OR LEFT(CTNO, 2) = 'RT')
      AND LEFT(MARAGRP, 4) = 'SAC2'
),

-- 標記已回倉的耗材，過濾非 SAC2
consump_clean AS (
    SELECT
        A.*,
        CASE WHEN B.DOCNO IS NOT NULL THEN 1 ELSE 0 END AS RETURN_IND
    FROM consump AS A
    LEFT JOIN return_consump AS B
        ON A.MARA = B.MARA
        AND A.MACNO = B.MACNO
        AND A.CTNO = B.CTNO
        AND A.ITEM_MARA = B.ITEM_MARA
        AND A.DOCNO = B.DOCNO
    WHERE LEFT(A.MARAGRP, 4) = 'SAC2'
),

-- 分色標記 + 過濾回倉
toner_clean AS (
    SELECT
        MARA, MACNO, CTNO, POSTDATE, DOCNO, NDOCNO, DOCNO_TYPE,
        ITEM_MARA, ITEM_MARADESC, DILQTY, HEAD_COST, DPT_COST,
        BLACK_COUNTER, COLOR_COUNTER,
        -- 黑色：不含紅黃青藍
        CASE WHEN NOT (ITEM_MARADESC LIKE '%紅%' OR ITEM_MARADESC LIKE '%黃%'
                    OR ITEM_MARADESC LIKE '%青%' OR ITEM_MARADESC LIKE '%藍%')
             THEN 1 ELSE 0 END AS TONER_B_REPLACE,
        -- 紅色
        CASE WHEN ITEM_MARADESC LIKE '%紅%' THEN 1 ELSE 0 END AS TONER_R_REPLACE,
        -- 黃色
        CASE WHEN ITEM_MARADESC LIKE '%黃%' THEN 1 ELSE 0 END AS TONER_Y_REPLACE,
        -- 青藍色
        CASE WHEN ITEM_MARADESC LIKE '%青%' OR ITEM_MARADESC LIKE '%藍%'
             THEN 1 ELSE 0 END AS TONER_BL_REPLACE
    FROM consump_clean
    WHERE RETURN_IND != 1
      AND DOCNO_TYPE NOT LIKE '%回倉%'
)

SELECT
    MARA, MACNO, CTNO, POSTDATE, DOCNO, NDOCNO, DOCNO_TYPE,
    ITEM_MARA, ITEM_MARADESC, DILQTY, HEAD_COST, DPT_COST,
    BLACK_COUNTER, COLOR_COUNTER,

    -- 黑色碳粉
    TONER_B_REPLACE,
    {{ toner_qty('TONER_B_REPLACE', 'BLACK_COUNTER') }} AS TONER_B_QTY,
    {{ toner_days('TONER_B_REPLACE') }} AS TONER_B_DAYS,

    -- 紅色碳粉
    TONER_R_REPLACE,
    {{ toner_qty('TONER_R_REPLACE', 'COLOR_COUNTER') }} AS TONER_R_QTY,
    {{ toner_days('TONER_R_REPLACE') }} AS TONER_R_DAYS,

    -- 黃色碳粉
    TONER_Y_REPLACE,
    {{ toner_qty('TONER_Y_REPLACE', 'COLOR_COUNTER') }} AS TONER_Y_QTY,
    {{ toner_days('TONER_Y_REPLACE') }} AS TONER_Y_DAYS,

    -- 青藍色碳粉
    TONER_BL_REPLACE,
    {{ toner_qty('TONER_BL_REPLACE', 'COLOR_COUNTER') }} AS TONER_BL_QTY,
    {{ toner_days('TONER_BL_REPLACE') }} AS TONER_BL_DAYS,

    CURRENT_DATE() AS ETL_DT
FROM toner_clean

{% endmacro %}
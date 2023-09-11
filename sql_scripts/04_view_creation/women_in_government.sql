CREATE OR REPLACE VIEW women_in_government AS WITH data AS (
        SELECT ce_data.period_date,
            CONCAT_WS(' ', ce_period.month, ce_data.year) AS date,
            SUM(ce_data.value) AS valueInThousands
        FROM ce_data
            INNER JOIN ce_period ON ce_data.period = ce_period.period_id
        WHERE ce_data.series_id ~ '^CE[S|U]90[\d]{6}10$'
            and ce_period.period_id != 'M13'
        GROUP BY 1,
            2
        ORDER BY ce_data.period_date
    )
SELECT jsonb_agg(
        jsonb_build_object(
            'date',
            date,
            'valueInThousands',
            valueInThousands
        )
    ) response
FROM data;
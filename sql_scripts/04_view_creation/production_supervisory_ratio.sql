CREATE OR REPLACE VIEW production_supervisory_ratio AS WITH all_employees AS (
        select ce_data.period_date,
            CONCAT_WS(' ', ce_period.month, ce_data.year) AS date,
            SUM(ce_data.value) AS valueInThousands
        FROM ce_data
            INNER JOIN ce_period ON ce_data.period = ce_period.period_id
        WHERE ce_data.series_id ~ '^CE[S|U][\d]{8}01$'
            and ce_period.period_id != 'M13'
        group by 1,
            2
    ),
    production_employees AS (
        select ce_data.period_date,
            CONCAT_WS(' ', ce_period.month, ce_data.year) AS date,
            SUM(ce_data.value) AS valueInThousands
        FROM ce_data
            INNER JOIN ce_period ON ce_data.period = ce_period.period_id
        WHERE ce_data.series_id ~ '^CE[S|U][\d]{8}06$'
            and ce_period.period_id != 'M13'
        group by 1,
            2
    ),
    ratio_production_supervisory_employees AS (
        select production_employees.period_date,
            production_employees.date,
            CASE
                WHEN (
                    all_employees.valueInThousands - production_employees.valueInThousands
                ) = 0 THEN NULL
                ELSE production_employees.valueInThousands / (
                    all_employees.valueInThousands - production_employees.valueInThousands
                )
            END AS value
        from production_employees
            inner join all_employees on production_employees.period_date = all_employees.period_date
        order by production_employees.period_date
    )
SELECT jsonb_agg(
        jsonb_build_object(
            'date',
            date,
            'ratio',
            value
        )
    ) AS response
FROM ratio_production_supervisory_employees;
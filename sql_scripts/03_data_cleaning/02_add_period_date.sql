ALTER TABLE ce_period
ADD COLUMN month_num INT;

-- UPDATE month_num using row_number() function
UPDATE ce_period
SET month_num = subquery.month_id
FROM (
    SELECT month, ROW_NUMBER() OVER(order by period_id) month_id
    FROM ce_period
) AS subquery
WHERE ce_period.month = subquery.month;

-- UPDATE ce_data to include period_date
ALTER TABLE ce_data
ADD COLUMN period_date DATE;

-- UPDATE period_date using year and period value. For example  2019 M01 -> 2019-01-01
UPDATE ce_data
SET period_date = (year || '-' || RIGHT(period, 2) || '-' || '01')::DATE
WHERE period != 'M13';
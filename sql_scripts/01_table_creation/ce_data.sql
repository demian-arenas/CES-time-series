CREATE TABLE IF NOT EXISTS ce_data (
    series_id VARCHAR(17),
    year INT,
    period VARCHAR(3),
    value DECIMAL(14,2),
    footnote_codes VARCHAR(10)
);
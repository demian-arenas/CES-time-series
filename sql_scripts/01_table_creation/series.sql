CREATE TABLE IF NOT EXISTS series (
    series_id VARCHAR(13) PRIMARY KEY,
    supersector_code INT,
    industry_code INT,
    data_type_code INT,
    seasonal VARCHAR(1),
    series_title VARCHAR(250),
    footnote_codes VARCHAR(5),
    begin_year INT,
    begin_period VARCHAR(3),
    end_year INT,
    end_period VARCHAR(3)
);
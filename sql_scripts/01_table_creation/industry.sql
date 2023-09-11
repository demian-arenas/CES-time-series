CREATE TABLE IF NOT EXISTS industry (
    industry_code VARCHAR(8) PRIMARY KEY,
    naics_code VARCHAR(13),
    publishing_status VARCHAR(2),
    industry_name VARCHAR(130),
    display_level INT,
    selectable VARCHAR(2),
    sort_sequence INT
);
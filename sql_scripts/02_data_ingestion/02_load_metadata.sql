-- Load data into datatype table
COPY datatypes FROM '/data/ce.datatype' DELIMITER E'\t' CSV HEADER;

-- Load data into footnote_codes table
COPY footnote_codes FROM '/data/ce.footnote_codes' DELIMITER E'\t' CSV HEADER;

-- Load data into industry table
COPY industry FROM '/data/ce.industry' DELIMITER E'\t' CSV HEADER;

-- Load data into ce_period table
COPY ce_period FROM '/data/ce.period' DELIMITER E'\t' CSV HEADER;

-- Load data into seasonal table
COPY seasonal FROM '/data/ce.seasonal' DELIMITER E'\t' CSV HEADER;

-- Load data into series table
COPY series FROM '/data/ce.series' DELIMITER E'\t' CSV HEADER;

-- Load data into supersector table
COPY supersector FROM '/data/ce.supersector' DELIMITER E'\t' CSV HEADER;

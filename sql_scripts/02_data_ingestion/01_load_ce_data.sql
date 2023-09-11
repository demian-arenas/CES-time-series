-- /sql_scripts/data_ingestion/load_all_files.sql

DO $$
DECLARE
    dir_path text := '/data/';
    each_file text;
    full_path text;
BEGIN
    -- Check if the ce_data table is empty
    IF (SELECT COUNT(*) FROM ce_data) = 0 THEN
        FOR each_file IN (
            SELECT filename 
            FROM pg_ls_dir(dir_path) AS t(filename) 
            WHERE t.filename LIKE 'ce.data.%'
        )
        LOOP
            full_path := dir_path || each_file;
            RAISE NOTICE 'Loading data from: %', full_path; -- This is just for logging purposes, you can remove it if you wish
            EXECUTE format('COPY ce_data FROM %L WITH DELIMITER E''\t'' CSV HEADER', full_path);
        END LOOP;
    END IF;
END $$;

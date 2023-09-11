#!/bin/bash
set -e

# Execute download script
/docker-entrypoint-initdb.d/download_data.sh

# Execute table creation scripts
echo "Creating tables..."
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/sql_scripts/01_table_creation/ce_data.sql
echo "Table ce_data created"
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/sql_scripts/01_table_creation/datatype.sql
echo "Table datatype created"
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/sql_scripts/01_table_creation/footnote_code.sql
echo "Table footnote_code created"
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/sql_scripts/01_table_creation/industry.sql
echo "Table industry created"
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/sql_scripts/01_table_creation/period.sql
echo "Table period created"
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/sql_scripts/01_table_creation/seasonal.sql
echo "Table seasonal created"
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/sql_scripts/01_table_creation/series.sql
echo "Table series created"
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/sql_scripts/01_table_creation/supersector.sql
echo "Table supersector created"

echo "Loading data..."
# Execute data ingestion scripts
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/sql_scripts/02_data_ingestion/01_load_ce_data.sql
echo "Data loaded into ce_data"
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/sql_scripts/02_data_ingestion/02_load_metadata.sql
echo "Data loaded into all metadata tables"

echo "Cleaning data"
# Execute data cleaning scripts
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/sql_scripts/03_data_cleaning/01_update_tables.sql
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/sql_scripts/03_data_cleaning/02_add_period_date.sql

echo "Creating views"
# Execute view creation scripts
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/sql_scripts/04_view_creation/production_supervisory_ratio.sql
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/sql_scripts/04_view_creation/women_in_government.sql

echo "Creating PostgREST user"
# Create PostgREST user
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/sql_scripts/05_postgrest.sql

echo "Finished initializing database"
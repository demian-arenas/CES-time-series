#!/bin/bash

BASE_URL="https://download.bls.gov"
BASE_DIR=$BASE_URL"/pub/time.series/ce/"

mkdir -p ./data  # Ensure the data directory exists

echo "Downloading files from $BASE_URL"
echo "Downloading files from $BASE_DIR"

# Fetch the list of files from the directory
FILE_LIST=$(curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" $BASE_DIR | \
           grep -oP '\/pub\/time\.series\/ce\/ce\.data\.[^"\s>]+' | \
           awk -v base=$BASE_URL '{print base $0}')

echo $FILE_LIST

# Loop through each file and download
for file in $FILE_LIST; do
    echo "Downloading $file..."
    curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" "$file" -o "./data/$(basename $file)"
done

echo "All data files downloaded."

# Now download the datatype, footnote_codes, industry, period, seasonal, series and supersector files
curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" $BASE_URL/pub/time.series/ce/ce.datatype > ./data/ce.datatype
curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" $BASE_URL/pub/time.series/ce/ce.footnote > ./data/ce.footnote_codes
curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" $BASE_URL/pub/time.series/ce/ce.industry > ./data/ce.industry
curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" $BASE_URL/pub/time.series/ce/ce.period > ./data/ce.period
curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" $BASE_URL/pub/time.series/ce/ce.seasonal > ./data/ce.seasonal
curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" $BASE_URL/pub/time.series/ce/ce.series > ./data/ce.series
curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" $BASE_URL/pub/time.series/ce/ce.supersector > ./data/ce.supersector

echo "All metadata files downloaded."
# Use the official PostgreSQL image as the base image
FROM postgres:latest

# Install curl for data download
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

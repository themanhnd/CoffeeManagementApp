#!/bin/bash
set -e

# Script to create multiple databases in PostgreSQL
# This script will be executed when PostgreSQL container starts

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Create database for Coffee Shop Management
    CREATE DATABASE coffeeshop;
    
    -- Create user for Coffee Shop app
    CREATE USER coffeeshop WITH ENCRYPTED PASSWORD 'coffeeshop123';
    
    -- Grant privileges
    GRANT ALL PRIVILEGES ON DATABASE coffeeshop TO coffeeshop;
    
    -- Connect to coffeeshop database and grant schema privileges
    \c coffeeshop;
    GRANT ALL ON SCHEMA public TO coffeeshop;
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO coffeeshop;
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO coffeeshop;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO coffeeshop;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO coffeeshop;
EOSQL

echo "✅ Coffee Shop database and user created successfully!"


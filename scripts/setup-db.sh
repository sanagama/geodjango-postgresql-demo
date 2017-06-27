#!/bin/bash
# Create PostgreSQL database $DB_NAME on instance $DB_HOST and enable the PostGIS extension
#
# This script does the following:
# - create a new database $DB_NAME on instance $DB_HOST
# - enable PostGIS extension on $DB_NAME
#
# Call as follows:
# setup-db.sh
#
# Use the following environment variables to customize creation of the database:
# DB_HOST=<host> DB_NAME=<name> DB_USER=<user> DB_PASSWORD=<password> setup-db.sh
#

# Exit immediately on errors
set -e

printf "\nCreating database '$DB_NAME' in PostgreSQL instance '$DB_HOST'"
printf "\nThis takes a few minutes, please wait...\n"

# Dump environment variables
printf "\nEnvironment variables:"
printf "\n CURRENT_USER: `$CURRENT_USER`"
printf "\n DB_HOST: $DB_HOST"
printf "\n DB_NAME: $DB_NAME"
printf "\n DB_USER: $DB_USER"
printf "\n DB_PASSWORD: $DB_PASSWORD"
printf "\n"

# 1. Create database $DB_NAME on $DB_HOST
printf "\nCreating database '$DB_NAME' in PostgreSQL instance '$DB_HOST'\n"
PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -U $DB_USER -d postgres -c "CREATE DATABASE $DB_NAME;"

# 2. Enable the PostGIS extension in database $DB_NAME
printf "\nEnabling PostGIS extension in database '$DB_NAME' in PostgreSQL instance '$DB_HOST'\n"
PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -U $DB_USER -d $DB_NAME -c "CREATE EXTENSION postgis;"

# 3. Verify that the PostGIS extension is enabled
printf "\nVerifying PostGIS extension in database '$DB_NAME' in PostgreSQL instance '$DB_HOST'\n"
PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -U $DB_USER -d $DB_NAME -c "SELECT postgis_full_version();"

printf "\nDone!\n"
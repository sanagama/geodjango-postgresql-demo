#!/bin/bash
# Initialize the local PostgreSQL instance running in the Docker container
#
# This script does the following:
# - initialize the local PostgreSQL instance with 'initdb'
# - start the local PostgreSQL instance
# - create user $DB_USER with SUPERUSER access
# - call 'create-db-and-tables.sh' to create new database $DB_NAME and enable PostGIS extension
# - create tables and load data
#
# Call as follows:
# start-local-pgsql.sh
#

# Exit immediately on errors
set -e

# Call script to initialize environment variables
printf "\nInitializing PostgreSQL on '$DB_HOST', one moment..."

# Dump environment variables
printf "\nEnvironment variables:"
printf "\n CURRENT_USER: `$CURRENT_USER`"
printf "\n HOMEDIR: $HOMEDIR"
printf "\n SCRIPTDIR: $SCRIPTDIR"
printf "\n DB_HOST: $DB_HOST"
printf "\n POSTGRES_USER: $POSTGRES_USER"
printf "\n POSTGRES_PASSWORD: $POSTGRES_PASSWORD"
printf "\n PGDATA: $PGDATA"
printf "\n"

# 1. Initialize PostgreSQL data directories
initdb

# 2. Start PostgreSQL in the background
printf "\nStarting PostgreSQL on '$DB_HOST', one moment...\n"
postgres &

# Wait for PostgreSQL to start
printf "Waiting for PostgreSQL to start..."
until pg_isready
do
    sleep 1
done

# 3. Create user $DB_USER with SUPERUSER access.
printf "\nCreating super user '$DB_USER' in PostgreSQL instance '$DB_HOST'\n"
psql -h $DB_HOST -U $POSTGRES_USER -d postgres -c "CREATE USER $DB_USER WITH SUPERUSER PASSWORD '$DB_PASSWORD';"

# 4. Call script to create PostgreSQL database $DB_NAME and enable the PostGIS extension
source $SCRIPTDIR/setup-db.sh

# 5. Call script to create tables and load data
printf "\nCreating tables and loading data."
printf "\nThis takes a few minutes, please wait...\n"
source $SCRIPTDIR/setup-tables.sh

printf "\nDone!\n"
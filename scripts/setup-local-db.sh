#!/bin/bash

SCRIPTDIR=$HOMEDIR/scripts

# Setup PostgreSQL database and tables
printf "\Creating demo database, user and tables. One moment..."
printf "\n DEMO_DB_HOST: $DEMO_DB_HOST"
printf "\n DEMO_DB_NAME: $DEMO_DB_NAME"
printf "\n DEMO_DB_USER: $DEMO_DB_USER"
printf "\n DEMO_DB_PASSWORD: $DEMO_DB_PASSWORD"
printf "\n"

# 1. Create $DB_USER user with SUPERUSER access.
printf "\nCreating user '$DEMO_DB_USER' in PostgreSQL instance '$DEMO_DB_HOST'\n"
psql -U $POSTGRES_USER -d postgres -c "CREATE USER $DEMO_DB_USER WITH SUPERUSER PASSWORD '$DEMO_DB_PASSWORD';"

# 2. Create $DB_NAME database
printf "\nCreating database '$DEMO_DB_NAME' in PostgreSQL instance '$DEMO_DB_HOST'\n"
PGPASSWORD=$DEMO_DB_PASSWORD psql -h $DEMO_DB_HOST -U $DEMO_DB_USER -d postgres -c "CREATE DATABASE $DEMO_DB_NAME;"

# 3. Enable the PostGIS extension in $DB_NAME database
printf "\nEnabling PostGIS extension in database '$DEMO_DB_NAME' in PostgreSQL instance '$DEMO_DB_HOST'\n"
PGPASSWORD=$DEMO_DB_PASSWORD psql -h $DEMO_DB_HOST -U $DEMO_DB_USER -d $DEMO_DB_NAME -c "CREATE EXTENSION postgis;"

# 4. Verify that the PostGIS extension is enabled
printf "\nVerifying PostGIS extension in database '$DEMO_DB_NAME' in PostgreSQL instance '$DEMO_DB_HOST'\n"
PGPASSWORD=$DEMO_DB_PASSWORD psql -h $DEMO_DB_HOST -U $DEMO_DB_USER -d $DEMO_DB_NAME -c "SELECT postgis_full_version();"

# 5. Create tables in the $DB_NAME database
printf "\nCreating tables and adding data to database '$DEMO_DB_NAME' in PostgreSQL instance '$DEMO_DB_HOST'\n"
PGPASSWORD=$DEMO_DB_PASSWORD psql -h $DEMO_DB_HOST -U $DEMO_DB_USER -d $DEMO_DB_NAME -f $SCRIPTDIR/demodb_dump.sql

printf "\nDone!\n"
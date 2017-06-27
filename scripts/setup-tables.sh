#!/bin/bash
# Create tables in PostgreSQL database $DB_NAME and load data
#
# Call as follows:
# setup-tables.sh
#
# Use the following environment variables to customize creation of the tables:
# DB_HOST=<host> DB_NAME=<name> DB_USER=<user> DB_PASSWORD=<password> setup-tables.sh
#
# NOTE: if you specify a username other than 'demo' then you will need to recreate
# the source file ($SCRIPTDIR/demodb_dump.sql)
#

# Exit immediately on errors
set -e

printf "\nCreating tables and adding data to database '$DB_NAME' in PostgreSQL instance '$DB_HOST'\n"
printf "\nThis takes a few minutes, please wait...\n"

# Dump environment variables
printf "\nEnvironment variables:"
printf "\n CURRENT_USER: `$CURRENT_USER`"
printf "\n DB_HOST: $DB_HOST"
printf "\n DB_NAME: $DB_NAME"
printf "\n DB_USER: $DB_USER"
printf "\n DB_PASSWORD: $DB_PASSWORD"
printf "\n"

# Create tables in database $DB_NAME and add data
PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -U $DB_USER -d $DB_NAME -f $SCRIPTDIR/demodb_dump.sql

printf "\nDone!\n"
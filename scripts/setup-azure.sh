#!/bin/bash

#
# This script uses Azure CLI 2.0
# Please install from: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
#

AZ_LOCATION=WestUS
AZ_RESOURCE_GROUP="<replace-with-desired-Azure-resource-group-name>"
AZ_PGSQL_SERVER_NAME="<replace-with-desired-Azure-PgSQL-server-name>"
DEMO_DB_HOST=$AZ_PGSQL_SERVER_NAME.database.windows.net

SCRIPTDIR=$HOMEDIR/scripts

# Setup PostgreSQL database and tables
printf "\nInitializing demo database, user and tables as follows, one moment..."
printf "\n AZ_LOCATION: $AZ_LOCATION"
printf "\n AZ_RESOURCE_GROUP: $AZ_RESOURCE_GROUP"
printf "\n AZ_PGSQL_SERVER_NAME: $AZ_PGSQL_SERVER_NAME"
printf "\n DEMO_DB_HOST: $DEMO_DB_HOST"
printf "\n DEMO_DB_NAME: $DEMO_DB_NAME"
printf "\n DEMO_DB_USER: $DEMO_DB_USER"
printf "\n DEMO_DB_PASSWORD: $DEMO_DB_PASSWORD"
printf "\n"

# 1. Create Resource Group
printf "\nCreating Azure Resource Group: $AZ_RESOURCE_GROUP in $AZ_LOCATION\n"
az group create --name $AZ_RESOURCE_GROUP --location $AZ_LOCATION

# 2. Create a new Azure PgSQL server (Basic @ 50 compute units). This takes ~4 minutes.
printf "\nCreating Azure Database for PostgreSQL instance: $AZ_PGSQL_SERVER_NAME in $AZ_LOCATION\n"
az postgres server create -n $AZ_PGSQL_SERVER_NAME --version "9.6" -l $AZ_LOCATION -g $AZ_RESOURCE_GROUP -u $DEMO_DB_USER -p $DEMO_DB_PASSWORD --compute-units 50 --performance-tier Basic

# 3. Add a firewall rule. This takes ~1 minute
printf "\nAdding firewall rule to $DEMO_DB_HOST to allow IPs: 0.0.0.0 to 255.255.255.255\n"
az postgres server firewall-rule create -g $AZ_RESOURCE_GROUP --server $AZ_PGSQL_SERVER_NAME -n allowAllRule --start-ip-address 0.0.0.0 --end-ip-address 255.255.255.255

# 4. Create new database in $AZ_PGSQL_SERVER_NAME
printf "\nCreating database $DEMO_DB_NAME in instance $AZ_PGSQL_SERVER_NAME\n"
PGPASSWORD=$DEMO_DB_PASSWORD psql -h $DEMO_DB_HOST -d postgres -U $DEMO_DB_USER@$AZ_PGSQL_SERVER_NAME -c "CREATE DATABASE $DEMO_DB_NAME;"

# 5. Enable the PostGIS extension in $DB_NAME database
printf "\nEnabling PostGIS extension in database $DB_NAME in instance $AZ_PGSQL_SERVER_NAME\n"
PGPASSWORD=$DEMO_DB_PASSWORD psql -h $DEMO_DB_HOST -d $DEMO_DB_NAME -U $DEMO_DB_USER@$AZ_PGSQL_SERVER_NAME -c "CREATE EXTENSION postgis;"

# 6. Verify that the PostGIS extension is enabled
printf "\nVerifying PostGIS extension\n"
PGPASSWORD=$DEMO_DB_PASSWORD psql -h $DEMO_DB_HOST -d $DEMO_DB_NAME -U $DEMO_DB_USER@$AZ_PGSQL_SERVER_NAME -c "SELECT postgis_full_version();"

# 7. Create tables in the $DB_NAME database
printf "\nCreating tables and adding data to database '$DEMO_DB_NAME' in PostgreSQL instance '$DEMO_DB_HOST'\n"
PGPASSWORD=$DEMO_DB_PASSWORD psql -h $DEMO_DB_HOST -U $DEMO_DB_USER -d $DEMO_DB_NAME -f $SCRIPTDIR/demodb_dump.sql

printf "\nDone!\n"
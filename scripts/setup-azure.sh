#!/bin/bash
# Create Azure resources
#
# This script does the following:
# - create new Azure Resource group (name = pgdemo-rg-<random-text>)
# - create new Azure Database for PostgreSQL server (servername=pgdemo-<random-text> | superuser=$DB_USER | password=$DB_PASSWORD)
# - set server firewall rule to open ports 0.0.0.0 - 255.255.255.255
# - create new database in Azure PgSQL Server (name = $DB_NAME)
#
# Call as follows:
# setup-azure.sh
#
# Use the following environment variables to customize creation of Azure resources:
# AZ_LOCATION=<location> AZ_RESOURCE_GROUP=<group-name> AZ_PGSQL_SERVER=<server-name> setup-azure.sh
#
# NOTE:
# This script uses Azure CLI 2.0 to create resources in Azure
# Install from: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
#

# Exit immediately on errors
set -e

printf "\nCreating Azure resources, one moment...\n"

# Dump environment variables
printf "\nEnvironment variables:"
printf "\n CURRENT_USER: `$CURRENT_USER`"
printf "\n SCRIPTDIR: $SCRIPTDIR"
printf "\n AZ_LOCATION: $AZ_LOCATION"
printf "\n AZ_RESOURCE_GROUP: $AZ_RESOURCE_GROUP"
printf "\n AZ_PGSQL_SERVER: $AZ_PGSQL_SERVER"
printf "\n AZ_PGSQL_COMPUTE_UNITS: $AZ_PGSQL_COMPUTE_UNITS"
printf "\n AZ_PGSQL_PERF_TIER: $AZ_PGSQL_PERF_TIER"
printf "\n DB_HOST: $DB_HOST"
printf "\n DB_HOST_AZ: $DB_HOST_AZ"
printf "\n DB_NAME: $DB_NAME"
printf "\n DB_USER: $DB_USER"
printf "\n DB_USER_AZ: $DB_USER_AZ"
printf "\n DB_PASSWORD: $DB_PASSWORD"
printf "\n"

# 1. Create Resource Group
printf "\nCreating Azure Resource Group: $AZ_RESOURCE_GROUP in $AZ_LOCATION\n"
az group create --name $AZ_RESOURCE_GROUP --location $AZ_LOCATION

# 2. Create a new Azure PgSQL server (Basic @ 50 compute units). This takes ~5 minutes.
printf "\nCreating Azure Database for PostgreSQL server: $AZ_PGSQL_SERVER in $AZ_LOCATION"
printf "\nThis takes ~5 minutes, please wait...\n"
az postgres server create -n $AZ_PGSQL_SERVER --version "9.6" \
    -l $AZ_LOCATION -g $AZ_RESOURCE_GROUP \
    -u $DB_USER -p $DB_PASSWORD \
    --compute-units $AZ_PGSQL_COMPUTE_UNITS --performance-tier $AZ_PGSQL_PERF_TIER

# 3. Add a firewall rule. This takes ~1 minute
printf "\nAdding firewall rule to $DB_HOST to allow IPs: 0.0.0.0 to 255.255.255.255"
printf "\nThis takes ~1 minute, please wait...\n"
az postgres server firewall-rule create -g $AZ_RESOURCE_GROUP --server $AZ_PGSQL_SERVER -n allowAllRule --start-ip-address 0.0.0.0 --end-ip-address 255.255.255.255

# 4. Call script to create PostgreSQL database $DB_NAME and enable the PostGIS extension
# Call script to initialize environment variables
DB_USER_AZ=$DB_USER@$AZ_PGSQL_SERVER
DB_HOST_AZ=$AZ_PGSQL_SERVER.database.windows.net
DB_HOST=$DB_HOST_AZ DB_USER=$DB_USER_AZ source $SCRIPTDIR/setup-db.sh

# Dump what we created
printf "\nAzure resources created:"
printf "\n Azure Resource Group: $AZ_RESOURCE_GROUP"
printf "\n Azure Database for PostgreSQL server: $DB_HOST_AZ (superuser: $DB_USER | password: $DB_PASSWORD)"
printf "\n Database: $DB_NAME"
printf "\n"

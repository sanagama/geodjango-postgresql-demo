#!/bin/bash
#
# This Docker image startup script does the following:
# 1. Initialize and start the local instance of PostgreSQL
# 2. Start GeoDjango web app
#

printf "\n ** Python GeoDjango + PostgreSQL Demo in Docker **"
printf "\n https://github.com/sanagama/geodjango-postgresql-demo"
printf "\n"

# Call script to initialize environment variables
printf "\nScript is running as user: `$CURRENT_USER`\n"

# Initialize PostgreSQL only if using the local PostgreSQL instance in this Docker container
# Skip if using Azure or another PostgreSQL instance
if [[ -z "${AZ_PGSQL_SERVER// }" ]]; then
    printf "\n** Using local PostgreSQL instance **\n"
    source $SCRIPTDIR/start-local-pgsql.sh
else
    printf "\n ** Using Azure PostgreSQL instance: $AZ_PGSQL_SERVER\n"
    export DB_HOST_AZ=$AZ_PGSQL_SERVER.database.windows.net
	export DB_USER_AZ=$DB_USER@$AZ_PGSQL_SERVER
    export DB_HOST=$DB_HOST_AZ
    export DB_USER=$DB_USER_AZ
fi

# Start web app
source $SCRIPTDIR/start-webapp.sh

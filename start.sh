#!/bin/bash

# Initialize and start PostgreSQL
# https://hub.docker.com/r/mdillon/postgis/

printf "\n ** Python GeoDjango + PostgreSQL Demo in Docker **"
printf "\n https://github.com/sanagama/geodjango-postgresql-demo"
printf "\n"

SCRIPTDIR=$HOMEDIR/scripts

# Initialize PostgreSQL data directories
printf "\nInitializing PostgreSQL, one moment...\n"
su-exec $POSTGRES_USER initdb

# Start PostgreSQL in the background
printf "\nStarting PostgreSQL, one moment...\n"
su-exec $POSTGRES_USER postgres &

# Wait for PostgreSQL to start
printf "Waiting for PostgreSQL to start..."
until su-exec $POSTGRES_USER pg_isready
do
    sleep 1
done

# Create demo database, users and tables
su-exec $POSTGRES_USER $SCRIPTDIR/setup-local-db.sh

printf "\nStarting GeoDjango web app on port $PORT..."
printf "\nOn your host computer running Docker, browse to: http://localhost:$PORT\n\n"

# Bind Django to 0.0.0.0
# See: https://serverfault.com/questions/262981/cannot-access-django-development-server-running-on-linode-from-outside
cd $HOMEDIR/app
python manage.py runserver 0.0.0.0:$PORT

#!/bin/bash

# Initialize and start PostgreSQL
# https://hub.docker.com/r/mdillon/postgis/

printf "\n+-------------------------------------------------------+"
printf "\n|                                                       |"
printf "\n| Python GeoDjango + PostgreSQL Demo in Docker          |"
printf "\n| https://github.com/sanagama/geodjango-postgresql-demo |"
printf "\n|                                                       |"
printf "\n| This container has a demo GeoDjango web app that uses |"
printf "\n| a local instance of PostgreSQL.                       |"
printf "\n|                                                       |"
printf "\n+-------------------------------------------------------+"
printf "\n"

printf "\nContents:"
printf "\n- Alpine 3.5 base OS"
printf "\n- Python 2.7 and PostgreSQL 9.6"
printf "\n- PostgreSQL command command-line utilities."
printf "\n- PostGIS client libraries and Python bindings."
printf "\n- Demo GeoDjango web app."
printf "\n"

printf "\nTo start the GeoDjango app and PostgreSQL in this container, use:"
printf "\n docker run -it -p 8000:8000 sanagama/geodjango-postgresql-demo:9.6-alpine"
printf "\n"

printf "\nTo use this Docker image in Azure Web App on Linux, see this:"
printf "\nhttps://docs.microsoft.com/en-us/azure/app-service-web/app-service-linux-using-custom-docker-image"
printf "\n"

printf "\nTo start an interactive shell session with this container, use:"
printf "\n docker run -it -p 8000:8000 --entrypoint /bin/bash sanagama/geodjango-postgresql-demo:9.6-alpine"
printf "\n"

printf "\nTo use a use a different PostgreSQL database with the GeoDjango app, use:"
printf "\n docker run -it -p 8000:8000 -e DEMO_DB_HOST='<host-name>' -e DEMO_DB_NAME='<dbname>'"
printf "\n            -e DEMO_DB_USER='<user>' -e DEMO_DB_PASSWORD='<password>' sanagama/geodjango-postgresql-demo"
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

printf "\nStarting GeoDjango web app..."
printf "\nOn your host computer running Docker, browse to: http://localhost:8000\n\n"

# Bind Django to 0.0.0.0
# See: https://serverfault.com/questions/262981/cannot-access-django-development-server-running-on-linode-from-outside

cd $HOMEDIR/app
python manage.py runserver 0.0.0.0:8000

#!/bin/bash
#
# Start GeoDjango web app in Docker container
#
# Call as follows:
# start-webapp.sh
#

printf "\nStarting GeoDjango web app on port $PORT..."
printf "\nScript is running as user: `$CURRENT_USER`\n"

printf "\nPostgreSQL Host: $DB_HOST"
printf "\nPostgreSQL Database: $DB_NAME"
printf "\nPostgreSQL User: $DB_USER"
printf "\nPostgreSQL Password: $DB_PASSWORD"
printf "\nOn your host computer running Docker, browse to: http://localhost:$PORT\n\n"

# Bind Django to 0.0.0.0:$PORT
# See: https://serverfault.com/questions/262981/cannot-access-django-development-server-running-on-linode-from-outside
cd $HOMEDIR/app
python manage.py runserver 0.0.0.0:$PORT

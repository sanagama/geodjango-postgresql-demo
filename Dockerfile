# Python GeoDjango + PostgreSQL Demo app
# Dockerfile inspired by:
# https://hub.docker.com/r/mdillon/postgis/
# https://bitbucket.org/lontongcorp/docker-postgis
# https://github.com/jfloff/alpine-python/blob/master/2.7/Dockerfile
#
FROM mdillon/postgis:9.6-alpine

MAINTAINER Sanjay Nagamangalam <sanagama2@gmail.com>

# Environment variables
# Chaining the ENV allows for only one layer, instead of one per ENV statement
ENV HOMEDIR=/src \
    PYTHONUNBUFFERED=1 \
    CURRENT_USER="id -un" \

    # Default PostgreSQL environment variables
    POSTGRES_USER=postgres \
    POSTGRES_PASSWORD=postgres \
    PGDATA=/var/lib/postgresql/data \
    DB_HOST=localhost \
    DB_NAME=demodb \
    DB_USER=demo \
    DB_PASSWORD=Password1 \

    # Default Azure environment variables 
    AZ_PGSQL_COMPUTE_UNITS=50 \
    AZ_PGSQL_PERF_TIER=Basic \
    AZ_LOCATION=WestUS \
    AZ_RESOURCE_GROUP="" \
    AZ_PGSQL_SERVER=""

# Set computed environment variables in a different ENV so earlier ENV gets picked up
# See: https://docs.docker.com/engine/reference/builder/#environment-replacement
ENV SCRIPTDIR=$HOMEDIR/scripts
ENV DB_USER_AZ=$DB_USER@$AZ_PGSQL_SERVER
ENV DB_HOST_AZ=$AZ_PGSQL_SERVER.database.windows.net

# Set the PORT environment variable
# Azure Web App Linux adds the PORT environment variable to the container when you use a custom Docker image
# See: https://docs.microsoft.com/en-us/azure/app-service-web/app-service-linux-using-custom-docker-image
ENV PORT=8080

# Alpine Packages
#   * bash: so we can access /bin/bash
#   * git: to ease up clones of repos
#   * su-exec: switch user and group id, setgroups and exec
ENV ALPINE_PACKAGES="\
  bash \
  git \
  su-exec \
  curl \
  nano \
"

# Python Alpine Packages
#   * build-base: used so we include the basic development packages (gcc)
#   * ca-certificates: for SSL verification during Pip and easy_install
#   * python2: the binaries themselves
#   * python2-dev: are used for gevent e.g.
#   * py-pip: Python pip
ENV PYTHON_PACKAGES="\
  build-base \
  ca-certificates \
  python2 \
  python2-dev \
  py-pip \
  py-numpy \
"

# Replace default repositories with the edge ones and install packages
RUN echo \
  && apk update \
  && apk add --no-cache $ALPINE_PACKAGES $PYTHON_PACKAGES \
  && rm -rf /var/cache/apk/*

WORKDIR $HOMEDIR

# Copy demo web app directory to image
RUN mkdir -pv $HOMEDIR
WORKDIR $HOMEDIR
COPY . $HOMEDIR

# Change ownership from 'root' to 'postgres'
RUN chown -R $POSTGRES_USER $HOMEDIR

# Install Django & requirements
RUN pip install --upgrade pip && pip install -r $HOMEDIR/app/requirements.txt

# EXPOSE port to allow communication to/from the GeoDjango web app
EXPOSE $PORT

# Run subsequent commands as user 'postgres'
USER $POSTGRES_USER

CMD ["sh", "-c", "$HOMEDIR/scripts/docker-start.sh"]
# done!
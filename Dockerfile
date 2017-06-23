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
    POSTGRES_USER=postgres \
    POSTGRES_PASSWORD=postgres \
    PGDATA=/var/lib/postgresql/data \
    DEMO_DB_HOST=localhost \
    DEMO_DB_NAME=demodb \
    DEMO_DB_USER=demo \
    DEMO_DB_PASSWORD=Password1

# Set the PORT environment variable
# Azure Web App Linux adds the PORT environment variable to the when you use this Docker image as a custom image
# See: https://docs.microsoft.com/en-us/azure/app-service-web/app-service-linux-using-custom-docker-image
ENV PORT=8000

# Alpine Packages
#   * bash: so we can access /bin/bash
#   * git: to ease up clones of repos
#   * su-exec: switch user and group id, setgroups and exec
ENV ALPINE_PACKAGES="\
  bash \
  curl \
  git \
  su-exec \
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

# Install Azure CLI 2.0 (TBD: future enhancement!)
# RUN curl -L https://aka.ms/InstallAzureCli | bash

WORKDIR $HOMEDIR

# Copy demo web app directory to image
RUN mkdir -pv $HOMEDIR
WORKDIR $HOMEDIR
COPY . $HOMEDIR

# Install Django & requirements
RUN pip install --upgrade pip && pip install -r $HOMEDIR/app/requirements.txt

# EXPOSE port 8000 to allow communication to/from the GeoDjango web ap
EXPOSE 8000

# Run script to start PostgreSQL, create user/database/tables and start the GeoDjango web app.
CMD ["sh", "-c", "$HOMEDIR/start.sh"]
# done!
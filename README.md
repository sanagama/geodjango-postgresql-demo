# Demo Python GeoDjango Web App + PostgreSQL + PostGIS in Docker

Get it from Docker Hub: [sanagama/geodjango-postgresql-demo](https://hub.docker.com/r/sanagama/geodjango-postgresql-demo)

Docker image based on [mdillon/postgis:9.6-alpine](https://hub.docker.com/r/mdillon/postgis/)

## Contents
- Alpine 3.5 base OS
- Python 2.7 and PostgreSQL 9.6
- PostgreSQL command command-line utilities
- PostGIS client libraries and Python bindings
- Demo GeoDjango web app

## Run locally
To start the GeoDjango app and PostgreSQL in this container, use:

```
docker run -it -p 8000:8000 sanagama/geodjango-postgresql-demo:9.6-alpine
```

## Run in Azure Web App on Linux
To use this Docker image in Azure Web App on Linux, see: 
<https://docs.microsoft.com/en-us/azure/app-service-web/app-service-linux-using-custom-docker-image>

## Run interactively
To start an interactive shell session with this container use:

```
docker run -it -p 8000:8000 --entrypoint /bin/bash sanagama/geodjango-postgresql-demo:9.6-alpine
```

## Use a different database
To use a use a different PostgreSQL database with the GeoDjango app, use:

```
docker run -it -p 8000:8000 -e DEMO_DB_HOST='<host-name>' -e DEMO_DB_NAME='<dbname>' -e DEMO_DB_USER='<user>' -e DEMO_DB_PASSWORD='<password>' sanagama/geodjango-postgresql-demo:9.6-alpine
```
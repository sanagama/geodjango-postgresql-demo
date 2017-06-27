# Azure Database for PostgreSQL Demo - Docker

Get it from Docker Hub: [sanagama/geodjango-postgresql-demo](https://hub.docker.com/r/sanagama/geodjango-postgresql-demo)

This Docker image is based on [mdillon/postgis:9.6-alpine](https://hub.docker.com/r/mdillon/postgis/)

### Contents
- Alpine 3.5 base OS
- Python 2.7 and PostgreSQL 9.6
- PostgreSQL command command-line utilities
- PostGIS client libraries and Python bindings
- Demo GeoDjango web app

### Run locally
To start the GeoDjango app and PostgreSQL in this container, use:

```
docker run -it -p 8080:8080 sanagama/geodjango-postgresql-demo
```

### Run interactively
To start an interactive shell session with this container use:

```
docker run -it -p 8080:8080 --user postgres --entrypoint /bin/bash sanagama/geodjango-postgresql-demo
```

### Use with Azure Database for PostgreSQL
To use with Azure Database for PostgreSQL, pass the ***server name*** as an environment variable:

```
docker run -it -p 8080:8080 -e AZ_PGSQL_SERVER=server-name-without-database.windows.net> sanagama/geodjango-postgresql-demo
```

>**NOTE:** The demo web app expects the server to have a database called ***demodb*** and a user called ***demo**. 

> See the detailed walkthrough at: <https://github.com/sanagama/geodjango-postgresql-demo>

### Run in Azure Web App on Linux
To use this Docker image in Azure Web App on Linux, see: 
<https://docs.microsoft.com/en-us/azure/app-service-web/app-service-linux-using-custom-docker-image>

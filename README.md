# Azure Database for PostgreSQL Demo - Docker

## Introduction
This demo web app is written in Python and uses the [GeoDjango framework](https://docs.djangoproject.com/en/1.11/ref/contrib/gis/) to *simulate* online traffic of people watching //Build 2017 sessions across the United States. When users tune in to watch a session, the app collects information about session and geo location and stores it in a PostgreSQL database.

You can run the demo app in Docker on your computer or host the Docker image in [Azure Web App (Linux)](https://docs.microsoft.com/en-us/azure/app-service-web/app-service-linux-using-custom-docker-image). In both cases, you can customize the PostgreSQL instance used by the demo web app via environment variables.

The Docker image for the demo web app is available on Docker Hub: [sanagama/geodjango-postgresql-demo](https://hub.docker.com/r/sanagama/geodjango-postgresql-demo) and is based on [mdillon/postgis:9.6-alpine](https://hub.docker.com/r/mdillon/postgis/).

Jump to:
1. [Demo Prerequisites](#demo-prerequisites)
1. [One-time Demo Setup](#one-time-demo-setup)
1. [Demo Walkthrough](#demo-walkthrough)

Additional resources:
- [Host in Azure Web App Linux](#host-in-azure-web-app-linux)
- [Delete Azure Resources](#delete-azure-resources)
- [Script Reference](#script-reference)

## Demo Prerequisites

The prerequisites to run this demo are:
- An active Azure subscription.
- Docker installed on your computer: [Docker for Mac](https://www.docker.com/docker-mac) | [Docker for Windows](https://www.docker.com/docker-windows)

## One-time Demo Setup
Perform these steps ***once*** on your computer:
1. Install Docker.
1. Get the demo Docker image onto your computer.
1. Pre-create the Azure Database for PostgreSQL server and database for the demo web app.

### 1. Install Docker on your computer
>**Tip:** Skip this step if you already have Docker installed on your computer.

Download Docker for your operating system and complete installation:
- [Docker for Mac](https://www.docker.com/docker-mac)
- [Docker for Windows](https://www.docker.com/docker-windows)

### 2. Get the Docker image for the demo
>**Tip:** Skip this step if you already have the demo Docker image available on your computer.

The demo image is available on Docker Hub: [sanagama/geodjango-postgresql-demo](https://hub.docker.com/r/sanagama/geodjango-postgresql-demo)

Copy/paste the command below into a Command or Terminal window to get the Docker image:
```
docker pull sanagama/geodjango-postgresql-demo
```

### 3. Pre-create the Azure Database for PostgreSQL server for the demo web app

>**Tip:** Skip this step if you already have an existing Azure Database for PostgreSQL server that you wish to use with the demo app.

>**NOTE:** If you wish to use an existing Azure Database for PostgreSQL server, then make sure it has an empty database called ***demodb*** and a superuser called ***demo***.

#### Create the Azure Database for PostgreSQL server

Create an Azure Database for PostgreSQL server required for this demo in one of two ways:
- [Create an Azure Database for PostgreSQL - Portal](https://docs.microsoft.com/en-us/azure/postgresql/quickstart-create-server-database-portal)
- [Create an Azure Database for PostgreSQL using the Azure CLI](https://docs.microsoft.com/en-us/azure/postgresql/quickstart-create-server-database-azure-cli) 

Use the following information when you create the Azure Database for PostgreSQL server:

Property | Value
--------------- | ------
Server Name | ***pgsqlgisdemo*** (If this is taken, please enter a different name)
Subscription | Select the desired subscription
Resource Group | Create a resource group called ***pgsqlgisdemo-rg*** or select the desired resource group
Server admin login | ***demo***
Password | ***Password1***
Location | Select the desired location
PostgreSQL Version | ***9.6***
Pricing tier | ***Basic***
Compute Units | ***50***
Storage | ***50 GB***

>**Tip:** Make sure the *Server admin login* is ***demo*** and the *Password* is ***Password1*** since this is what the demo expects by default.

>**Tip:** Remember the ***server name*** of the Azure Database for PostgreSQL server. You will need the server name later during the demo.

>**NOTE:** Follow the instructions at [Configure a server-level firewall rule](https://docs.microsoft.com/en-us/azure/postgresql/quickstart-create-server-database-portal) to allow  clients from all IPs (0.0.0.0 - 255.255.255.255) to connect to the Azure Database for PostgreSQL server.

#### Create the *demodb* database in the Azure Database for PostgreSQL server

1. Start the Docker container interactively

	Copy/paste the command below into a Command or Terminal window to start an interactive shell session with the demo Docker container:
	```
	docker run -it -p 8080:8080 --user postgres --entrypoint /bin/bash sanagama/geodjango-postgresql-demo
	```
1. Initialize environment variables for Azure

	Copy/paste the commands below at the Bash prompt in the Docker session to initialize environment variables for Azure in the Docker container:

	>**Tip:** Set ***AZ_PGSQL_SERVER*** to the ***server name*** of the Azure Database for PostgreSQL you created in the [One-time Demo Setup](#one-time-demo-setup) section.

	```
	AZ_PGSQL_SERVER=<server-name-without-database.windows.net>

	DB_HOST=$AZ_PGSQL_SERVER.database.windows.net

	DB_USER=$DB_USER@$AZ_PGSQL_SERVER

	echo $DB_HOST $DB_NAME $DB_USER $DB_PASSWORD
	```

1. Create the ***demodb*** database

	Copy/paste the command below at the Bash prompt in the Docker session to create the **demodb** database in your Azure Database for PostgreSQL server:
	```
	./scripts/setup-db.sh
	```

1. Type `exit` at the Bash prompt in the Docker session to stop the Docker container.

Demo setup all done! You are now ready for the demo walkthrough.

At this point, you have an Azure Database for PostgreSQL server with an empty database called ***demodb*** in it.

You will add tables and data to the ***demodb*** as part of ***pg_restore*** during the demo.


## Demo Walkthrough
This section walks througn the demo steps below:

Jump to:
1. [Introduce the Web App](#1-introduce-the-web-app)
1. [Create Azure PostgreSQL Server](#2-create-azure-postgresql-server)
1. [Restore local database to Azure PostgreSQL](#3-restore-local-database-to-azure-postgresql)
1. [Update connection string in local web app](#4-update-connection-string-in-local-web-app)
1. [Scale up Azure PostgreSQL server](#5-scale-up-azure-postgresql-server)

### 1. Introduce the Web App

(**Talking Points**)
- I have a demo web app written in Python and the GeoDjango framework that *simulates* the online traffic of people watching //Build 2017 sessions across the US.
- When users tune in to watch a session, the app collects information about session and geo location and stores it in a PostgreSQL database.
- As a starting point, the demo web app and PostgreSQL are both running locally in my Docker container.

1. Start the Docker container interactively

	(**Talking Point**) Let's start my Docker container and get a Bash prompt.

	Copy/paste the command below into a Command or Terminal window to start an interactive shell session with the demo Docker container:
	```
	docker run -it -p 8080:8080 --user postgres --entrypoint /bin/bash sanagama/geodjango-postgresql-demo
	```

	(**Talking Point**) Let's start PostgreSQL in the Docker container.

	Copy/paste the command below at the Bash prompt in the Docker session to start PostgreSQL in the Docker container:
	```
	./scripts/start-local-pgsql.sh
	```

1. Show database configuration

	(**Talking Point**) The demo web app is currently configured to use the local instance of PostgreSQL running in the Docker container via environment variables. Let's take a quick look.

	Copy/paste the command below at the Bash prompt in the Docker session to show environment variables:
	```
	echo $DB_HOST $DB_NAME $DB_USER $DB_PASSWORD
	```
	Copy/paste the command below at the Bash prompt in the Docker session to display ***settings.py*** in the terminal:
	```
	cat ./app/geodjango/settings.py | more
	```

	Show that database connection settings are loaded from the ***$DB_HOST*** and ***$DB_USER*** environment variables (scroll down to the section that reads **DATABASES**)	

	Press **Ctrl+C** to return to the Bash prompt.
	
1. Run the demo web app

	(**Talking Point**) Let's run the demo web app.

	Copy/paste the command below at the Bash prompt in the Docker session to start the web app in the Docker container:
	```
	./scripts/start-webapp.sh
	```

1. On your host computer, navigate to <http://localhost:8080> in your browser to see the app running.

	(**Talking Points**)
	- The web app shows a heatmap of the locations of the users tuning in to watch the //Build conference.
	- As you let the application run, data is generated on the client side that causes the heatmap to gets denser.
	- Information about the session and their geo locationgets stored in the local PostgreSQL instance running in the Docker container.
	- The gauge in the bottom right corner the shows the number of users tuning in.
	- The database server being used by the web app (**localhost**) is shown at the top right corner. The web app loads database connection settings setting from the ***settings.py*** file I showed you earlier.

	(**Talking Point**) As the app continues to run longer, more and more users tune in, thus creating a need for us to switch to a managed PostgreSQL database so we can scale up and down easily.

1. Stop the web app

	Press **Ctrl+C** in the interactive Docker shell session to stop the web app in the Docker container.

### 2. Create Azure PostgreSQL Server

>**Note:** In order to save time, we already pre-created the Azure PostgreSQL Server in the [One-time Demo Setup](#one-time-demo-setup) section.

>**Tip:** The steps below are documented at [Create an Azure Database for PostgreSQL - Portal](https://docs.microsoft.com/en-us/azure/postgresql/quickstart-create-server-database-portal)

(**Talking Point**) Let me show you how easy it is to create an Azure Database for PostgreSQL server with a few clicks in the Azure portal.

1. Open the Azure Portal in your browser and sign-in with your Microsoft account.

1. Click **+New** -> **Databases** -> **Azure Database for PostgreSQL**

1. Fill out the following information to create a new PostgreSQL server.

Property | Value
--------------- | ------
Server Name | ***pgsqlgisdemo*** (If this is taken, please enter a different name)
Subscription | Select the desired subscription
Resource Group | Select the desired resource group
Server admin login | ***demo***
Password | ***Password1***
Location | Select the desired location
PostgreSQL Version | ***9.6***
Pricing tier | ***Basic***
Compute Units | ***50***
Storage | ***50 GB***

  
>**Note:** Confirm the selections but **DO NOT** click **Create**.

(**Talking Point**) To save time during this demo, I have pre-created an Azure Database for PostgreSQL server and setup firewall rules.

### 3. Restore local database to Azure PostgreSQL

(**Talking Point**) Let's restore the schema + data from the local PostgreSQL database in my Docker container to my Azure Database for PostgreSQL server.

(**Talking Point**) For this demo, I already used **pg_dump** to export the schema + data of the local PostgreSQL database to a file.

Switch to the interactive Docker shell session.

Copy/paste the command below at the Bash prompt in the Docker session to show the dump file in the Docker container:
```
ls -al ./scripts/*.dump
```

(**Talking Point**) Let's use **pg_restore** to restore the database dump to my Azure Database for PostgreSQL server.

(**Talking Point**) If you prefer, you can upload this dump file into Azure Storage which you can access from within the Azure Cloud Shell and run **pg_restore** from there.

(**Talking Point**) For this demo, I'll run **pg_restore** from the Docker container.

1. Copy/paste the command below at the Bash prompt in the Docker session to initialize environment variables for Azure in the Docker container:

	>**Tip:** Set ***AZ_PGSQL_SERVER*** to the ***server name*** of the Azure Database for PostgreSQL you created in the [One-time Demo Setup](#one-time-demo-setup) section.

	```
	AZ_PGSQL_SERVER=<server-name-without-database.windows.net>

	DB_HOST=$AZ_PGSQL_SERVER.database.windows.net

	DB_USER=$DB_USER@$AZ_PGSQL_SERVER

	echo $DB_HOST $DB_NAME $DB_USER $DB_PASSWORD
	```

1. Copy/paste the command below at the Bash prompt in the Docker session to run **pg_restore** in the Docker container:
	```
	PGPASSWORD=$DB_PASSWORD pg_restore -h $DB_HOST -d $DB_NAME -U $DB_USER ./scripts/demodb.dump
	```

1. Copy/paste the command below at the Bash prompt in the Docker session to verify that the data was migrated to the Azure PostgreSQL database.

	``` 
	PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -U $DB_USER -d $DB_NAME -c "SELECT * FROM heatmap_heatmap LIMIT 10;"
	```

### 4. Update connection string in local web app

1. Show database configuration

	(**Talking Point**) Recall that the ***settings.py*** file in the web app gets the database configuration from environment variables.

	Copy/paste the command below at the Bash prompt in the Docker session to show environment variables:
	```
	echo $DB_HOST $DB_NAME $DB_USER $DB_PASSWORD
	```
	(**Talking Point**) We've updated the environment variables to point to the Azure Database for PostgreSQL server. We're all set to run the web app.

1. Run the demo web app

	(**Talking Point**) Let's run the demo web app and have it store data in the Azure Database for PostgreSQL database.

	Copy/paste the command below at the Bash prompt in the Docker session to start the web app in the Docker container:
	```
	./scripts/start-webapp.sh
	```

1. On your host computer, open <http://localhost:8080> in your browser to see the app running.

	(**Talking Points**)
	- Our web app in Docker runs seamlessly.
	- The web app is now using our Azure PgSQL server as shown at the top right corner. The web app loads this setting from the ***settings.py*** file I showed you earlier.
	- There is an additional gauge in the bottom right corner that shows how many compute units are being used. This will help you decide if you need to scale up the database on the fly.

	>**Note:** Currently, the compute units gauge is *simulated* and not tied to the actual compute units in the Azure PostgreSQL instance. It is  steadily incremented by on the client side as an example.

(**Talking Point**) The number of users are starting to increase. Let me show you how you can easily scale-up the Azure Database for PostgreSQL server on the fly.

>**Tip:** Leave the web app in Docker running. We will scale-up the Azure PgSQL database using the Azure Cloud Shell and show the web app again after that.

### 5. Scale up Azure PostgreSQL server

1. Switch to the Azure Portal and launch the **Azure Cloud Shell**

1. Copy/paste the command below in the Azure Cloud Shell to scale-up the compute units from ***50*** to ***100***.
	>**Tip:** Specify the Azure Database for PostgreSQL ***servername*** and the Azure Resource Group name that you created in the the [One-time Demo Setup](#one-time-demo-setup) section.

	```
	az postgres server update -g <resource-group-name> -n <server-name-without-database.windows.net>  --compute-units 100
	```

	>**CHEAT SHEET:** If you used the suggested defaults in the [One-time Demo Setup](#one-time-demo-setup) then you can use the command below:

	```
	az postgres server update -g pgsqlgisdemo-rg -n pgsqlgisdemo --compute-units 100
	```

1. Switch back to the web app in the browser and press the **F3** key to simulate the upgrade on the compute units. This will update the compute and users gauges limits and the numbers keep increasing.

1. This highlights that we can scale up Azure PostgreSQL database on the fly without the need to take down the web app.

(**Talking Point**) At this point, we have completed the demo. The source code for the demo is available at: <https://github.com/sanagama/geodjango-postgresql-demo>

Press **Ctrl+C** in the interactive Docker shell session to stop the web app in the Docker container.

Close all browsers and stop Docker. Remember to delete your Azure resources so you can start clean next time.

## Host in Azure Web App Linux

>**TIP:** Helpful documentation: [Using a custom Docker image for Azure Web App on Linux](https://docs.microsoft.com/en-us/azure/app-service-web/app-service-linux-using-custom-docker-image)

Follow the steps below to create an Azure Web App (Linux) with the demo web app Docker image.

1. Create a new Azure Web App (Linux) as documented here: [Create an Azure web app running on Linux](https://docs.microsoft.com/en-us/azure/app-service-web/app-service-linux-how-to-create-web-app)

2. In the ***Create*** blade, click on ***Configure Container*** and enter the following information:

Property | Value
--------------- | ------
Image source | ***Docker Hub***
Repository Access | ***Public***
Image and optional tag | ***sanagama/geodjango-postgresql-demo***
Startup Command | *leave empty*

3. Click ***Create*** to create the Azure Web App (Linux).

4. After creation, click ***Browse*** from the Azure Web App (Linux) blade to run the web app.

>**NOTE:** It may take ~1 minute to launch the web app for the first time because Azure Web App (Linux) pulls down the Docker image from Docker Hub.

### Customize the PostgreSQL instance used by the demo web app

By default, the demo web app in Docker in Azure Web App (Linux) uses the local PostgreSQL instance running in the Docker container.

You can add an ***App Setting*** to the Azure Web App (Linux) to use an Azure Database for PostgreSQL server of your choice with the demo web app.

>**TIP:** Managing ***App Settings*** is documented here: [Configure web apps in Azure App Service](https://docs.microsoft.com/en-us/azure/app-service-web/web-sites-configure)

Follow the steps below to use an Azure Database for PostgreSQL server with the demo web app in Docker in Azure Web App (Linux).

1. In the Azure portal, click on the Azure Web App (Linux) to open its blade.
1. Click ***Application Settings*** on the left of the blade.
1. Add the following entry in the ***App Settings*** section:

Key | Value
--------------- | ---
AZ_PGSQL_SERVER| Azure Database for PostgreSQL server name (without the .database.windows.net)

>**NOTE:** The demo web app expects the Azure Database for PostgreSQL server to have a database called ***demodb*** and a superuser called ***demo***.

>Make sure the Azure PostgreSQL Server you specify here was setup according to the [One-time Demo Setup](#one-time-demo-setup) section.

Click ***Save*** and restart the Azure Web App (Linux) instance.

Click ***Browse*** from the Azure Web App (Linux) blade to run the web app and connect to the Azure Database for PostgreSQL server that you specified in ***App Settings***.

## Delete Azure Resources

After the demo is complete, please log in into the Azure Portal and delete the Azure Database for PostgreSQL server that you created for this demo.

## Script Reference

For your reference, the table below describes the scripts in the **scripts** directory:

Script | Purpose
--------------- | ---
$/scripts/docker-start.sh|Called by Docker when the container starts. Initializes and starts the local instance of PostgreSQL in the container and the GeoDjango web app,.
$/scripts/start-local-pgsql.sh|Called from docker-start.sh to initialize and start the local instance of PostgreSQL.
$/scripts/start-webapp.sh|Called from docker-start.sh to start the GeoDjango web app in the Docker container.
$/scripts/setup-azure.sh|Create Azure Resource Group and Azure PostgreSQL server and sets firewall rules
$/scripts/setup-db.sh|Creates demo database and enables PostGIS extenion
$/scripts/setup-tables.sh|Creates tables and loads data. Runs **psql** with the file $/scripts/demodb_dump.sql.

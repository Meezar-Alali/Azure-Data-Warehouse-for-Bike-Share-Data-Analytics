# Azure-Data-Warehouse-for-Bike-Share-Data-Analytics
### Divvy is a bike sharing program in Chicago, Illinois USA that allows riders to purchase a pass at a kiosk or use a mobile application to unlock a bike at stations around the city and use the bike for a specified amount of time. The bikes can be returned to the same station or to another station. The City of Chicago makes the anonymized bike trip data publicly available for projects like this where we can analyze the data. The dataset looks like this
![project_data](screenshots/project_data.png "project_data")

The goal of this project is to develop a data warehouse solution using Azure Synapse Analytics. You will:
•	Design a star schema based on the business outcomes listed below;
•	Import the data into Synapse;
•	Transform the data into the star schema;
•	and finally, view the reports from Analytics.
The business outcomes you are designing for are as follows:
1.	Analyze how much time is spent per ride
•	Based on date and time factors such as day of week and time of day
•	Based on which station is the starting and / or ending station
•	Based on age of the rider at time of the ride
•	Based on whether the rider is a member or a casual rider
2.	Analyze how much money is spent
•	Per month, quarter, year
•	Per member, based on the age of the rider at account start
3.	EXTRA CREDIT - Analyze how much money is spent per member
•	Based on how many rides the rider averages per month
•	Based on how many minutes the rider spends on a bike per month
## First Step Create Azure resources
•	Create an Azure PostgreSQL database
•	Create an Azure Synapse workspace. 
### 1- Create an Azure PostgreSQL database
![postgres1](screenshots/postgres1.png "postgres1")

### 2- Create Azure resources
#### 2-1-Create an Azure Synapse workspace
![synapse1](screenshots/synapse1.png "synapse1")
![synapse2](screenshots/synapse2.png "synapse2")
#### 2-2 Create a Dedicated SQL Pool and database within the Synapse workspace
![didecated_sql1](screenshots/didecated_sql1.png "didecated_sql1")
![didecated_sql2](screenshots/didecated_sql2.png "didecated_sql2")

## Second Step Design a star schema
Based on the given set of business requirements the following star schema was designed
![star_schema](screenshots/star_schema.png "star_schema")

## Third Step Create the data in PostgreSQL
### 1-Open  the script file ProjectDataToPostgres.py  in VS Code and add the host, username, and password information for your PostgreSQL database

![postgers2](screenshots/postgers2.png "postgers2")

### 2-Run the script and verify that all four data files are copied/uploaded into PostgreSQL we can veiw the table in local machine PGAdmin 4
![postgres3](screenshots/postgres3.png "postgres3")

## Fourth Step EXTRACT the data from PostgreSQL

In our Azure Synapse workspace, we will use the ingest wizard to create a one-time pipeline that ingests the data from PostgreSQL into Azure Blob Storage. This will result in all four tables being represented as text files in Blob Storage, ready for loading into the data warehouse

### 1-First create link connection to my Postgres database udacityproject
And as shown in the screenshot the connection succeeded
![links1](screenshots/links1.png "links1")
![links2](screenshots/links2.png "links2")

### 2- create link connection to Azure Blop Storage
And as shown in the screenshot the connection succeeded
![links3](screenshots/links3.png "links3")
![links4](screenshots/links4.png "links4")

### 3-In our Azure Synapse workspace, we will use the ingest wizard to create a one-time pipeline that ingests the data from PostgreSQL into Azure Blob Storage. This will result in all four tables being represented as text files in Blob Storage, ready for loading into the data warehouse

![ingesting1](screenshots/ingesting1.png "ingesting1")
![ingesting2](screenshots/ingesting2.png "ingesting2")
![ingesting3](screenshots/ingesting3.png "ingesting3")
![ingesting4](screenshots/ingesting4.png "ingesting4")

## Fifth Step LOAD the data into external tables in the data warehouse
Once in Blob storage, the files will be shown in the data lake node in the Synapse Workspace. 
![external1](screenshots/external1.png "external1")

### 1-create external table staging_payment run SQL script file Payment_load.sql 
![external2](screenshots/external1.png "external2")

### 2-create external table staging_rider run SQL script file rider_load.sql 
![external3](screenshots/external3.png "external3")

### 3-create external table staging_station run SQL script file station_load.sql
![external4](screenshots/external4.png "external4")

### 4-create external table staging_trip run SQL script file trip_load.sql 
![external5](screenshots/external5.png "external5")

### Now we notice that the 4 tables are created in EXTERNAL TABLE 
![external6](screenshots/external6.png "external6")

## Sixth Step TRANSFORM the data to the star schema
### 1- in synapse workspace we go to Develop and we create new SQL script .
![transform1](screenshots/transform1.png "transform1")

### 2- For the fife tables star schema I had explain in the Second step
So for each table of the following we run SQL script the script in transfor_files
1- time_dim
2- rider_dim
3- payment_fact
4- station_dim
5- trip_fact
So we can notice the 5 tables are created in bikesharesqlpool DB workspace
![transform2](screenshots/transform2.png "transform2")





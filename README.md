# Google Finance to MySQL
Download global indices data from Google Finance using Python & MySQL. These scripts eliminates the 200 records limit set by google finance while browsing through the webpages/csv download. 

Software Requirements:

MySQL
Python 2.7.12

Dependencies:
Pandas 0.19.1

BeautifulSoup 3.2.1

Requests 2.12.4

Datetime 

MySQLdb 1.2.5



The attached files will create a database system which will download and store daily data for different global financial market indices.
To create the database system, create the database schema and tables,upload the google id, name and description for the different indices using the file create_schema_tables.sql

Then update the table with initial data with the file global_indices.py This file will download the daily data from 01-01-2000 onwards. If a particular index is not having data from that date onwards, a warning 'NoneType' object has no attribute 'find_all'' will be display which can be safely ignored. In case if any modifications are required, the dates can be suitably changed.

Finally to download the data daily, run global_indices_daily.py to update the database regularly! This will find out the last update date and automatically update the indices data upto the latest date!

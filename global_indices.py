import pandas as pd
import datetime
import MySQLdb as mdb
from bs4 import BeautifulSoup
import requests

db_host = 'whatever_your_server_name_or_ip'
db_user = 'whatever_is_your_database_user'
db_pass = 'whatever_your_database_password'
db_name = 'whatever_your_database_name'
con = mdb.connect(db_host, db_user, db_pass, db_name)

def obtain_list_of_index_symbols():
	with con: 
		cur = con.cursor()
		cur.execute("SELECT google_id, indice_name FROM global_indices_symbols")   
		data = cur.fetchall()
	return [(d[0], d[1].strip().replace('%26', '&')) for d in data]

def get_daily_historic_data_nse(nse_symbol,ab):
	url = "https://www.google.com/finance/historical?cid=%s&startdate=%s+1%%2C+%s&enddate=%s+31%%2C+%s&num=200" % (nse_symbol,ab[0],ab[2],ab[1],ab[2])
	html = requests.get(url).content
	soup = BeautifulSoup(html,"html5lib")
	table = soup.find(class_='gf-table historical_price')
	
	price_date = []
	open_price = []
	high_price = []
	low_price = []
	close_price = []
	volume = []
	intra_prices=[]
	
	try:
		for row in table.find_all('tr')[1:]:
			col = row.find_all('td')

			column_1 = col[0].string.strip()
			column_1 = pd.to_datetime(column_1)
			price_date.append(column_1)
	
			column_2 = col[1].string.strip()
			column_2 = column_2.replace(",","")
			column_2 = column_2.replace("-","0.00")
			open_price.append(column_2)
	
			column_3 = col[2].string.strip()
			column_3 = column_3.replace(",","")
			column_3 = column_3.replace("-","0.00")
			high_price.append(column_3)
	
			column_4 = col[3].string.strip()
			column_4 = column_4.replace(",","")
			column_4 = column_4.replace("-","0.00")
			low_price.append(column_4)
	
			column_5 = col[4].string.strip()
			column_5 = column_5.replace(",","")
			column_5 = column_5.replace("-","0.00")
			close_price.append(column_5)

			column_6 = col[5].string.strip()
			column_6 = column_6.replace(",","")
			column_6 = column_6.replace("-","0.00")
			volume.append(column_6)
		indices_data = zip(price_date,open_price,  high_price,  low_price, close_price,volume)
		return indices_data
	except Exception, excpp1:
		print excpp1
		return 0

def insert_indices_data_into_db(ind_name,daily_data):
  now = datetime.datetime.now()
  daily_data = [(ind_name,(datetime.datetime.strptime(str(d[0]), '%Y-%m-%d %H:%M:%S')).strftime('%Y-%m-%d'),d[1], d[2], d[3], d[4], d[5],now,now) for d in daily_data]
  column_str = """indices_name,price_date,open_price,high_price,low_price,close_price, volume,created_date,last_updated_date"""
  insert_str = ("%s, " * 9)[:-2]
  final_str = "INSERT INTO global_indices (%s) VALUES (%s)" % (column_str, insert_str)
  with con: 
	cur = con.cursor()
	cur.executemany(final_str, (daily_data))


if __name__ == "__main__":
	tickers = obtain_list_of_index_symbols()
	for t in tickers:
		print ("Adding Data For %s "%t[0]+"Having Index Name %s "%t[1])
		all_dates=[
		('Jan','Jul',2000),('Aug','Dec',2000),\
		('Jan','Jul',2001),('Aug','Dec',2001),\
		('Jan','Jul',2002),('Aug','Dec',2002),\
		('Jan','Jul',2003),('Aug','Dec',2003),\
		('Jan','Jul',2004),('Aug','Dec',2004),\
		('Jan','Jul',2005),('Aug','Dec',2005),\
		('Jan','Jul',2006),('Aug','Dec',2006),\
		('Jan','Jul',2007),('Aug','Dec',2007),\
		('Jan','Jul',2008),('Aug','Dec',2008),\
		('Jan','Jul',2009),('Aug','Dec',2009),\
		('Jan','Jul',2010),('Aug','Dec',2010),\
		('Jan','Jul',2011),('Aug','Dec',2011),\
		('Jan','Jul',2012),('Aug','Dec',2012),\
		('Jan','Jul',2013),('Aug','Dec',2013),\
		('Jan','Jul',2014),('Aug','Dec',2014),\
		('Jan','Jul',2015),('Aug','Dec',2015),\
		('Jan','Jul',2016),('Aug','Dec',2016),\
		('Jan','Jul',2017)
		]
		try:
			for ab in all_dates:
				#print "Adding for : ",ab
				#'NoneType' object has no attribute 'find_all' if the particular year data is not available in google finance
				yf_data = get_daily_historic_data_nse(str(t[0]),ab)
				if yf_data <>0:
					insert_indices_data_into_db(t[1],yf_data)
		except Exception, excpp:
			print "Problem!!!",excpp
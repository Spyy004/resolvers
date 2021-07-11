import requests
import json
from bsedata.bse import BSE
b = BSE(update_codes = True)

from nsetools import Nse
nse = Nse()

bse_gain = b.topGainers()
bse_lose = b.topLosers()
nse_gain = nse.get_top_gainers()
nse_lose = nse.get_top_losers()
bseg_data=[{},{},{},{},{}]

for i in range(5):
    bseg_data[i]['stock_type'] = 'bse_gainers'
    bseg_data[i]['name'] = bse_gain[i]['securityID']
    bseg_data[i]['LTP'] = bse_gain[i]['LTP'].replace(',','')
    bseg_data[i]['change'] = bse_gain[i]['change'].replace(',','')
    bseg_data[i]['pChange'] = bse_gain[i]['pChange'].replace(',','')

bsel_data=[{},{},{},{},{}]

for i in range(5):
    bsel_data[i]['stock_type'] = 'bse_losers'
    bsel_data[i]['name'] = bse_lose[i]['securityID']
    bsel_data[i]['LTP'] = bse_lose[i]['LTP'].replace(',','')
    bsel_data[i]['change'] = bse_lose[i]['change'].replace(',','')
    bsel_data[i]['pChange'] = bse_lose[i]['pChange'].replace(',','')

nseg_data=[{},{},{},{},{}]

for i in range(5):
    nseg_data[i]['stock_type'] = 'nse_gainers'
    nseg_data[i]['name'] = nse_gain[i]['symbol']
    nseg_data[i]['LTP'] = nse_gain[i]['ltp']
    nseg_data[i]['change'] = abs(round(nse_gain[i]['ltp']-nse_gain[i]['previousPrice'],2))
    nseg_data[i]['pChange'] = nse_gain[i]['netPrice']

nsel_data=[{},{},{},{},{}]

for i in range(5):
    nsel_data[i]['stock_type'] = 'nse_losers'
    nsel_data[i]['name'] = nse_lose[i]['symbol']
    nsel_data[i]['LTP'] = nse_lose[i]['ltp']
    nsel_data[i]['change'] = abs(round(nse_lose[i]['ltp']-nse_lose[i]['previousPrice'],2))
    nsel_data[i]['pChange'] = nse_lose[i]['netPrice']

for i in range(5):
    t = requests.post("https://ashish226.pythonanywhere.com/api/stock/",data=bseg_data[i])
    print(t.json())


for i in range(5):
    t = requests.post("https://ashish226.pythonanywhere.com/api/stock/",data=bsel_data[i])
    print(t.json())

for i in range(5):
    t = requests.post("https://ashish226.pythonanywhere.com/api/stock/",data=nseg_data[i])
    print(t.json())

for i in range(5):
    t = requests.post("https://ashish226.pythonanywhere.com/api/stock/",data=nsel_data[i])
    print(t.json())

stock_data = requests.get("https://ashish226.pythonanywhere.com/api/stock/")
print(stock_data)
stock_data.json()
#!/usr/bin/env python
# coding: utf-8

# In[1]:


import testCallStackInfo
import json
from web3 import Web3
import web3
import csv
import array
import time
import asyncio

# contract address after deploy
myContractAddress = "0xea54A06F8e74B72DF67B77b9D76046833757c165"; 

# get abi from Data.json, get data from soini_filtered_last.csv, collect url that makes error in errorSnippet.txt
with open("./build/contracts/Data.json") as f, open('./Dataset/soini_filtered_last.csv', 'r', encoding="utf-8", errors='ignore') as csv_file, open('errorSnippet.txt', 'a') as text_file :
    info_json = json.load(f)
    abi = info_json["abi"]
    
    csv_reader = csv.reader(csv_file)
    # start at 0
    count = 0
    start = count;
    skip = 0;
    url = None
    
    transact = None
    
    # set up web3 connection with Ganache
    w3 = Web3(Web3.WebsocketProvider("ws://127.0.0.1:8545", websocket_kwargs={'timeout': 10000}))
    # read smart contract
    myContract = w3.eth.contract(address=myContractAddress, abi=abi)
    
    # set up default account to be sender
    w3.eth.defaultAccount = w3.eth.accounts[0]
    
    # question link from testCallStackInfo that use to check answer
    listFromStack = testCallStackInfo.createQuestion()
    
    for row in csv_reader:
        # 11465
        if(count > 11465):
            break
        if(skip < start):
            skip += 1
            continue
            
        url = row[0]        
        
        if row[2]:
            snippet = ({ 'url': row[0],
                         'date': row[1], 
                         'language': row[2],
                         'projectName' : row[3],
                         'companyName' : row[4],
                         'projectPath' : row[5],
                         'projectAuthor' : row[6]   
                      })
            # convert from dictionary to string
            snippetString = json.dumps(snippet)
            
            # call function to store data on blockchain                    
            try:
                transact = myContract.functions.createNewCodeSnippet(url, listFromStack[count], snippetString).transact()                
                # waiting for transaction to be mined
                w3.eth.waitForTransactionReceipt(transact)
            except asyncio.TimeoutError:
                # when timeout error occured, url will be written in textfile
                text_file.write(url + "\n")
                print('timeout!')                        

            # txn_receipt = w3.eth.getTransactionReceipt(transact)
            
            # collect transaction number in array
            transactionNumber = []
            transactionNumber.append(w3.toHex(transact))
#             print(transactionNumber)
#             print(txn_receipt['transactionHash'])           
        print(count)
#         print(listFromStack[count])
        count += 1;
        
         



# In[3]:


# get code snippet's datail from url by index
# first parameter - url
# second parameter - index (start at 0)
myContract.functions.getDetailSnippet("http://stackoverflow.com/questions/393954/how-to-convert-an-opencv-iplimage-to-an-sdl-surface",0).call()


# In[4]:


myContract.functions.getUUIDQuestion("http://stackoverflow.com/questions/393954/how-to-convert-an-opencv-iplimage-to-an-sdl-surface").call()


# In[5]:


myContract.functions.getDetailQuestion("http://stackoverflow.com/questions/393954/how-to-convert-an-opencv-iplimage-to-an-sdl-surface").call()


# In[6]:


myContract.functions.getDetailAnswer("https://stackoverflow.com/questions/10001728/how-to-flip-image-horizontaly-and-vertically-with-php").call()


# In[8]:


myContract.functions.getUUIDAnswer("https://stackoverflow.com/questions/10001728/how-to-flip-image-horizontaly-and-vertically-with-php",0).call()


# In[7]:


myContract.functions.getDetailSnippet("https://stackoverflow.com/questions/10001728/how-to-flip-image-horizontaly-and-vertically-with-php",0).call()


# In[ ]:





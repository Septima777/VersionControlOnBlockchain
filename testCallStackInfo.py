import json
from web3 import Web3
import web3
import csv
import array
import time
import asyncio

# method createQuestion() that use for collecting question and answer data
def createQuestion():
    # contract address after deploy
    myContractAddress = "0xea54A06F8e74B72DF67B77b9D76046833757c165"; 

    # get abi from Data.json, get data from output_new_without_body.csv, collect url that makes error in errorQuestion.txt
    with open("./build/contracts/Data.json") as f, open('./Dataset/output_with_answer.csv', 'r', encoding="utf-8", errors='ignore') as csv_file, open('errorQuestion.txt', 'a') as text_file :
        info_json = json.load(f)
        abi = info_json["abi"]

        csv_reader = csv.reader(csv_file)
        # start at 0
        count = 0
        start = count;
        skip = 0;
        url = None
        questionUrlFromAnswer = None
        questionString = None
        answerAtring = None
        linkList = []

        transact = None

        # set up web3 connection with Ganache
        w3 = Web3(Web3.WebsocketProvider("ws://127.0.0.1:8545", websocket_kwargs={'timeout': 10000}))
        # read smart contract
        myContract = w3.eth.contract(address=myContractAddress, abi=abi)

        # set up default account to be sender
        w3.eth.defaultAccount = w3.eth.accounts[0]
        
        # for loop reading data
        for row in csv_reader:
            # 11465
            if(count > 11465):
                break
            if(skip < start):
                skip += 1
                continue
            url = row[0]
            questionUrlFromAnswer = row[8]
            # collect question link in list, and snippet file will use this list to check answer
            linkList.append(questionUrlFromAnswer)
            question = None
            answer = None

            if row[2]:
                # collect question data
                question = ({'url': row[0],
                                 'questionTitle': row[1], 
                                 'viewCount': row[2],
                                 'questionAuthor' : row[3],
                                 'questionEditor' : row[4],
                                 'questionCreationDate' : int(row[5]),
                                 'questionLastActivity' : int(row[6]),
                                 'questionLastModified' : int(row[7]),
                                 'questionUrlFromAnswer' : row[8]    
                                })
                # collect answer data
                answer = ({'questionUrlFromAnswer' : row[8],
                               'answerBody' : row[9],
                               'answerAuthor' : row[10],
                               'answerEditor' : row[11],
                               'answerCreationDate' : row[12],
                               'answerLastActivity' : row[13],
                               'answerLastModified' : row[14],

                              })
                # convert from dictionary to string
                questionString = json.dumps(question)
                answerString = json.dumps(answer)

                # call function to store data on blockchain                    
                try:
                    # if questionUrlFromAnswer equal to "", it is a question 
                    if(questionUrlFromAnswer == ""):
                        transact = myContract.functions.createNewQuestion(url,questionUrlFromAnswer,questionString).transact()
                    else:
                        # it is an answer
                        transact = myContract.functions.createNewQuestion(url,questionUrlFromAnswer,answerString).transact()
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
            print("info")
            print(count)
            count += 1;
        return linkList;
    
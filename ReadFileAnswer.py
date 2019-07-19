#!/usr/bin/env python
# coding: utf-8

# In[1]:


import csv
import requests
import re
import json
import time

with open ('./Dataset/output_new_without_body.csv', 'r', encoding="utf-8", errors='ignore') as csv_file, open ('./Dataset/output_with_answer.csv', 'a', newline='', encoding="utf-8", errors='ignore') as write_file :
    reader = csv.reader(csv_file)
    writer = csv.writer(write_file)
    count = 3680;
    start = count;
    skip = 0;

    for row in reader:
        if(count > 11465):
            break
        if(skip < start):
            skip += 1
#             print(skip)
            continue
        count+=1
        url = row[0]
        title = None
#         body = None
        view_count = None
        answer_author = None
        answer_last_modified = None
        answer_last_activity = None
        answer_creation_date = None
        answer_last_editor = None
        answer_body = None
        question_author = None
        question_last_modified = None
        question_last_activity = None
        question_creation_date = None
        question_last_editor = None
        link = None
        
        
        
        if("/a/" in url):
            num = re.findall(r'\d+', url)
            new_url = "https://api.stackexchange.com/2.2/answers/"+num[0]+"?order=desc&sort=activity&site=stackoverflow&filter=2zZ0Wf8537j.jAlX&key=cddOrZkFxzgUsieCXQCT7A(("
        elif("/q/" in url or "/questions/" in url):
            num = re.findall(r'\d+', url)
            new_url = "https://api.stackexchange.com/2.2/questions/"+num[0]+"?order=desc&sort=activity&site=stackoverflow&filter=!azbR7x6XSni)uP&key=cddOrZkFxzgUsieCXQCT7A(("
        else:
            new_url = "null";
            
        r = requests.get(url = new_url)
        json_obj = r.json()
        json_string = json.dumps(json_obj)
        response = json.loads(json_string)
        
#         print(response['items'])
#         print(json_obj)
        
        time.sleep(3)
        
        print("-----------------------------------")    
        
        if("/answers/" in new_url):
            if(response['items']):
                question_id = response['items'][0].get('question_id');
                answer_body = response['items'][0].get('body');
                answer_author = response['items'][0].get('owner').get('display_name');
                answer_last_activity = response['items'][0].get('last_activity_date');
                answer_creation_date = response['items'][0].get('creation_date');                

                if('last_edit_date' not in response['items'][0]):
                    answer_last_modified = 0;
                else:
                    answer_last_modified = response['items'][0].get('last_edit_date');

                if('last_editor' not in response['items'][0]):
                    answer_last_editor = None;
                else:
                    answer_last_editor = response['items'][0].get('last_editor').get('display_name');          

                    
                last_url = "https://api.stackexchange.com/2.2/questions/"+str(question_id)+"?order=desc&sort=activity&site=stackoverflow&filter=!azbR7x6XSni)uP&key=cddOrZkFxzgUsieCXQCT7A(("
                r = requests.get(url = last_url)
                json_obj = r.json()
                json_string = json.dumps(json_obj)
                response = json.loads(json_string)
                
                link = response['items'][0].get('link');
                question_author = response['items'][0].get('owner').get('display_name');
                view_count = response['items'][0].get('view_count');
                title = response['items'][0].get('title');
#                 body = response['items'][0].get('body');
                question_creation_date = response['items'][0].get('creation_date');
                question_last_activity = response['items'][0].get('last_activity_date');
                
                if('last_edit_date' not in response['items'][0]):
                    question_last_modified = 0;
                else:
                    question_last_modified = response['items'][0].get('last_edit_date');

                if('last_editor' not in response['items'][0]):
                    question_last_editor = None;
                else:
                    question_last_editor = response['items'][0].get('last_editor').get('display_name');          
                
                time.sleep(3)                
            
                
        elif("/questions/" in new_url or "/q/" in new_url):
            if(response['items']):
#                 question_id = response['items'][0].get('question_id');
                title = response['items'][0].get('title');
                question_author = response['items'][0].get('owner').get('display_name');
#                 body = response['items'][0].get('body');
                view_count = response['items'][0].get('view_count');
                question_creation_date = response['items'][0].get('creation_date');
                question_last_activity = response['items'][0].get('last_activity_date');
                
                if('last_edit_date' not in response['items'][0]):
                    question_last_modified = 0;
                else:
                    question_last_modified = response['items'][0].get('last_edit_date');                
                    
                if('last_editor' not in response['items'][0]):
                    question_last_editor = None;
                else:
                    question_last_editor = response['items'][0].get('last_editor').get('display_name');    
               
                    
#                 last_url = "https://api.stackexchange.com/2.2/questions/"+str(question_id)+"/answers?order=desc&sort=activity&site=stackoverflow&filter=!9Z(-wzu0T&key=cddOrZkFxzgUsieCXQCT7A(("
#                 r = requests.get(url = last_url)
#                 json_obj = r.json()
#                 json_string = json.dumps(json_obj)
#                 response = json.loads(json_string)            
                
#                 for index, element in enumerate(response['items']):
#                     if(response['items'][index].get('is_accepted') == True):
#                         answer_author = response['items'][index].get('owner').get('display_name')
#                         score = response['items'][index].get('score')
#                         body = response['items'][index].get('body')
#                         if(response['items'][index].get('last_edit_date') in response['items']):
#                             answer_last_modified = response['items'][index].get('last_edit_date')
#                         else:
#                             answer_last_modified = response['items'][index].get('last_activity_date');
#                     else:
#                         continue
#                 time.sleep(3)
                
                
        else:
            print("else")

############################ write file ######################################
#         writer.writerow([url,title,body,view_count,question_author,question_last_editor,question_creation_date,question_last_activity,question_last_modified])
        writer.writerow([url,title,view_count,question_author,question_last_editor,question_creation_date,question_last_activity,question_last_modified,
                        link,answer_body,answer_author,answer_last_editor,answer_creation_date,answer_last_activity,answer_last_modified])

        print(count)

# In[5]:


# new_url = "https://api.stackexchange.com/2.2/answers/10311877?order=desc&sort=activity&site=stackoverflow&filter=2zZ0Wf8537j.jAlX"
# r = requests.get(url = new_url)
# json_obj = r.json()
# json_string = json.dumps(json_obj)
# response = json.loads(json_string)
# print(response)


# In[ ]:





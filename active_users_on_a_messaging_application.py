#Task:  
#Here (https://raw.githubusercontent.com/erood/interviewqs.com_code_snippets/master/Datasets/ddi_message_app_data.csv)
#is a table containing information from a P2P messaging application. The table contains send/receive message data
#for the application's users. The structure is as follows:
#Table name: user_messaging
#date
#sender_id (#id of the message sender)
#receiver_id (#id of the message receiver)
#Question: Using Python, calculate what fraction of senders sent messages to at least 9 unique people on March 1, 2018. 

import pandas as pd
import re

url = ("https://raw.githubusercontent.com/erood/interviewqs.com_code_snippets/master/Datasets/ddi_message_app_data.csv")
df = pd.read_csv(url)

#Count of messages sent on 1st March 2018
count_march = df[df['date'] == '2018-03-01']

#Number of unique messages sent by each sender
group_by_senders = count_march.groupby('sender_id')['receiver_id'].nunique()

#Senders with 9 or more unique receivers 
senders_with_9_or_more = group_by_senders[group_by_senders >= 9]

#Fraction of senders who sent messages to atleast 9 unique recievers
fraction_of_senders = len(senders_with_9_or_more)/len(group_by_senders)

print(f"Number of messages sent on 2018-03-01: {len(count_march)}")

print(f"Total number of unique senders in 2018-03-01 senders' list: {len(group_by_senders)}")

print(f"Number of senders with atleast 9 unique recievers: {len(senders_with_9_or_more)}")

print(f"Fraction of senders with atleast 9 unique recievers: {fraction_of_senders}")


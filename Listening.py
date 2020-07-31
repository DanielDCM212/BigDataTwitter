#!/usr/bin/python3

import twint
from confluent_kafka import Producer

import json
import sys

# Variables to kafka
producer_topic = 'test1'


p = Producer({'bootstrap.servers': 'localhost:9092'})

# Kafka Reports

def delivery_report(err, msg):
    """
    Called once for each message produced to indicate delivery result.
    Triggered by poll() or flush().
    """
    if err is not None:
        print('Message delivery failed: {}'.format(err))
    else:
        print('Message delivered to {} [{}]'.format(msg.topic(), msg.partition()))



module = sys.modules["twint.storage.write"]

def Json(obj, config):
    tweet = obj.__dict__
    doc = json.dumps(tweet)
    # print("HolaMundi")
    p.produce(producer_topic, value=doc, callback=delivery_report)
    p.flush()


#  module.Json = Json

c = twint.Config()

c.Search = "Covid-19"
#c.Search = "Nike"
c.Store_json = True
c.Geo = "20.71502,-101.68945,500km"
# c.Lowercase = True
#c.Custom["user"] = ["id", "tweet", "user_id", "username", "hashtags", "mentions"]
c.User_full = True
c.Output = "tweets.json"
c.Since = "2020-01-01 00:00:00"
c.Hide_output = True
# c.Limit = 12

c.Elasticsearch = "localhost:9200"


twint.run.Search(c)

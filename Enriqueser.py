import json
from textblob import TextBlob
from confluent_kafka import Producer
from confluent_kafka import Consumer, KafkaException, KafkaError
import time


broker = 'localhost:9092'
consumer_topic = ['test1']
producer_topic = 'test2'
groupid = 'test2x4'

confProducer = {
    'bootstrap.servers': broker,
    'queue.buffering.max.messages': 10000,
    'queue.buffering.max.ms': 500,
    'batch.num.messages': 100,
    'default.topic.config': {'acks': 1}
}

confConsumer = {
    'bootstrap.servers': broker,
    'group.id': groupid, 'session.timeout.ms': 6000,
    'default.topic.config': {
        'auto.offset.reset': 'smallest'
    }
}

p = Producer(confProducer)
c = Consumer(confConsumer)
c.subscribe(consumer_topic)

def delivery_report(err, msg):
    """ Called once for each message produced to indicate delivery result.
        Triggered by poll() or flush(). """
    if err is not None:
        print('Message delivery failed: {}'.format(err))
    else:
        print('Message delivered to {} [{}]'.format(msg.topic(), msg.partition()))



def main():

    try:
        while True:
            msg = c.poll(10)
            if msg is None:
                continue
            else:
                message = json.loads(msg.value().decode('UTF-8'))
                tweet = message['tweet']
                data = TextBlob(tweet)
                message['sentiment'] = data.sentiment[0]
                doc = json.dumps(message)
                p.poll(0)
                p.produce(producer_topic, value=doc, callback=delivery_report)
                print(doc)
    except KeyboardInterrupt:
        print("ERROR")

    finally:
        c.close()
        p.flush()

if __name__ == "__main__":
    main()

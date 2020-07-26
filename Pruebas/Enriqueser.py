import json

from confluent_kafka import Producer
from confluent_kafka import Consumer, KafkaException, KafkaError
import time

# import pyodbc 



server = 'IP DB Server o Localhost' 
database = 'data base name' 
username = 'user' 
password = 'password' 
# cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
# cursor = cnxn.cursor()


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



# Kafka Reports

def delivery_report(err, msg):
    """ Called once for each message produced to indicate delivery result.
        Triggered by poll() or flush(). """
    if err is not None:
        print('Message delivery failed: {}'.format(err))
    else:
        print('Message delivered to {} [{}]'.format(msg.topic(), msg.partition()))



def main():

    i = 1
    try:
        while True:
            msg = c.poll(10)
            if msg is None:
                continue
            else:
                message = json.loads(msg.value().decode('UTF-8'))
                # query = "SELECT TOP 1 D_mnpio,d_estado,d_zona FROM Codes_ONE.dbo.CPS WHERE d_codigo = '" + str(message['cp']) + "'"
                # cursor.execute(query)
                # row = cursor.fetchone()
                
            
            message['municipio'] = "1"
            message['estado'] = "1"
            message['zona'] = "1"
            # row = cursor.fetchone()
            jd = json.dumps(message)
            try:
                p.poll(0)
                p.produce(producer_topic, value=jd, key=msg.key(),callback=delivery_report)
            except BufferError:
                print('ERROR')
            except Exception as e:
                print(e) 
            except KafkaException as e:
                print(e)
    except KeyboardInterrupt:
        print('ERROR')
    finally:
        c.close()
        p.flush()



if __name__ == "__main__":
    main()


from confluent_kafka import Producer

import json

# Conexión a Kafka

producer_topic = 'test1'

p = Producer({'bootstrap.servers': 'localhost:9092'})

# Kafka Reports

def delivery_report(err, msg):

    """ Called once for each message produced to indicate delivery result.
        Triggered by poll() or flush()."""
    if err is not None:
        print('Message delivery failed: {}'.format(err))
    else:
        print('Message delivered to {} [{}]'.format(msg.topic(), msg.partition()))



def main():

    # Using readlines() 

    file1 = open('cps.txt', 'r') 
    Lines = file1.readlines() 
    # Strips the newline character 
    for line in Lines: 
        json1 = {}
        cp = line.strip() 
        json1['cp'] = cp
        jd = json.dumps(json1)
        print(cp, json1)

        try:
            p.poll(0)
            p.produce(producer_topic, value=jd, key=cp, callback=delivery_report)
        except BufferError:
            print('ERROR')
        except KafkaException as e:
            print(e)
        
        p.flush()



if __name__ == "__main__":
    main()


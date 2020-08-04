### Start Kafka ###
sudo /opt/confluent/bin/zookeeper-server-start -daemon /opt/confluent/etc/kafka/zookeeper.properties
nohup /opt/confluent/bin/kafka-server-start /opt/confluent/etc/kafka/server.properties &
sleep 15

### Create Topics ###
/opt/confluent/bin/kafka-topics --create --topic test1 --zookeeper  localhost:2181 --partitions 1 --replication-factor 1
/opt/confluent/bin/kafka-topics --create --topic test2 --zookeeper  localhost:2181 --partitions 1 --replication-factor 1

### Start ElasticStack ###
nohup ~/ElasticSearchHub/elasticsearch-7.8.1/bin/elasticsearch &
nohup ~/ElasticSearchHub/kibana-7.8.1-linux-x86_64/bin/kibana &
nohup ~/ElasticSearchHub/logstash-7.8.1/bin/logstash -f ~/ElasticSearchHub/logstash-7.8.1/config/logstash.conf &
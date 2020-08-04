### Start Kafka ###
sudo /opt/confluent/bin/zookeeper-server-start -daemon /opt/confluent/etc/kafka/zookeeper.properties
nohup /opt/confluent/bin/kafka-server-start /opt/confluent/etc/kafka/server.properties &
sleep 20
nohup ~/ElasticSearchHub/kibana-7.8.1-linux-x86_64/bin/kibana &
sleep 20
nohup ~/ElasticSearchHub/elasticsearch-7.8.1/bin/elasticsearch &
nohup ~/ElasticSearchHub/logstash-7.8.1/bin/logstash -f ~/ElasticSearchHub/logstash-7.8.1/config/logstash.conf &
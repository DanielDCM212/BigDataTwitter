cd ~/

sed -i -e 's/#server.port: 5601/server.port: 5601/g' \
    -e 's/#server.host: "localhost"/server.host: "0.0.0.0"/g' \
    -e 's/#elasticsearch.hosts: ["http:\/\/localhost:9200"]/elasticsearch.hosts: ["http:\/\/localhost:9200"]/g' \
    -e 's/#kibana.index: ".kibana"/kibana.index: ".kibana"/g' \
    ~/ElasticSearchHub/kibana-7.8.1-linux-x86_64/config/kibana.yml

echo '
input {
    kafka {
        codec => json
        bootstrap_servers => "localhost:9092"
        topics => "test2"
    }
}
output {
    elasticsearch {
        hosts => "http://localhost:9200"
        index => "twitter"
    }
}
' > ~/ElasticSearchHub/logstash-7.8.1/config/logstash.conf


### Start Kafka ###
sudo /opt/confluent/bin/zookeeper-server-start -daemon /opt/confluent/etc/kafka/zookeeper.properties
nohup /opt/confluent/bin/kafka-server-start /opt/confluent/etc/kafka/server.properties &
sleep 20
nohup ~/ElasticSearchHub/kibana-7.8.1-linux-x86_64/bin/kibana &
sleep 20
nohup ~/ElasticSearchHub/elasticsearch-7.8.1/bin/elasticsearch &
nohup ~/ElasticSearchHub/logstash-7.8.1/bin/logstash -f ~/ElasticSearchHub/logstash-7.8.1/config/logstash.conf &
sleep 20
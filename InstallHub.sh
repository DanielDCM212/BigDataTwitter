#!/usr/bin/bash

sudo apt-get update -y && sudo apt-get upgrade -y

sudo apt-get install -y git

sudo apt-get install -y nodejs

sudo apt-get install -y npm

sudo apt install -y openjdk-11-jre-headless

sudo apt-get install -y python3-pip

pip3 install confluent-kafka textblob elasticsearch twint

cd BigDataTwitter

sudo mv confluent/ /opt

cd ~/

mkdir ElasticSearchHub
cd ElasticSearchHub

wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.8.1-linux-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.8.1-linux-x86_64.tar.gz.sha512
shasum -a 512 -c elasticsearch-7.8.1-linux-x86_64.tar.gz.sha512 
tar -xzf elasticsearch-7.8.1-linux-x86_64.tar.gz

curl -O https://artifacts.elastic.co/downloads/kibana/kibana-7.8.1-linux-x86_64.tar.gz
curl https://artifacts.elastic.co/downloads/kibana/kibana-7.8.1-linux-x86_64.tar.gz.sha512 | shasum -a 512 -c - 
tar -xzf kibana-7.8.1-linux-x86_64.tar.gz

wget https://artifacts.elastic.co/downloads/logstash/logstash-7.8.1.tar.gz
tar -xzf logstash-7.8.1.tar.gz

mkdir compress

mv *.tar.gz compress

echo '
##### Kafka Confluent #####
KAFKA_HOME="/opt/confluent/bin"

##### ElasticSearch Hub #####
ELASTIC_HOME="~/ElasticSearchHub/elasticsearch-7.8.1/bin";
KIBANA_HOME="~/ElasticSearchHub/kibana-7.8.1-linux-x86_64/bin";
LOGSTASH_HOME="~/ElasticSearchHub/logstash-7.8.1/bin";
export PATH=$PATH:$ELASTIC_HOME:$KIBANA_HOME:$LOGSTASH_HOME:$KAFKA_HOME;
' | sudo tee -a /etc/profile

source /etc/profile

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

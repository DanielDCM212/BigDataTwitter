#!/usr/bin/bash

sudo apt-get update -y && sudo apt-get upgrade -y

sudo apt-get install -y git

sudo apt-get install -y nodejs

sudo apt-get install -y npm

sudo apt install -y openjdk-11-jre-headless

sudo apt-get install -y python3-pip

pip3 install confluent-kafka textblob elasticsearch twint

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
KAFKA_HOME="~/confluent/bin"

##### ElasticSearch Hub #####
ELASTIC_HOME="~/ElasticSearchHub/elasticsearch-7.8.1/bin";
KIBANA_HOME="~/ElasticSearchHub/kibana-7.8.1-linux-x86_64/bin";
LOGSTASH_HOME="~/ElasticSearchHub/logstash-7.8.1/bin";
export PATH=$PATH:$ELASTIC_HOME:$KIBANA_HOME:$LOGSTASH_HOME:$KAFKA_HOME;
' | sudo tee -a /etc/profile

source /etc/profile

# cd ~/

# git clone https://github.com/DanielDCM212/BigDataTwitter.git

# cd BigDataTwitter

# tar -xzf confluent.tar.gz

sudo mv confluent/ /opt


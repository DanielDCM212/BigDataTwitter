cd ~/
sudo su
/opt/confluent/bin/zookeeper-server-start -daemon /opt/confluent/etc/kafka/zookeeper.properties
nohup /opt/confluent/bin/kafka-server-start /opt/confluent/etc/kafka/server.properties &

exit

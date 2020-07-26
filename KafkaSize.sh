#!/bin/bash
# Regex to parse timestamp from output
pattern='CreateTime:([0-9]+)'

# Get list of all topics
topic_list=$(kafka-topics --list --zookeeper localhost:2181)

for topic in $topic_list
do  
    # Try to consume one message from each topic
    # --timeout-ms is set not to fail in case there are no messages
    output=$(kafka-console-consumer \
                --bootstrap-server localhost:9092\
                --topic $topic\
                --group oldest_message \
                --from-beginning \
                --max-messages 1 \
                --timeout-ms 2000 \
                --property print.timestamp=true)
    [[ $output =~ $pattern ]]
    if [ ! -z "${BASH_REMATCH[1]}" ]
    then
        # If the regex matched a timestamp, print the actual metric for this particular topic
        echo "kafka_oldest_message_age{topic=\"$topic\"} ${BASH_REMATCH[1]}"
    fi
done
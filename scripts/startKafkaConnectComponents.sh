#!/bin/bash
echo "Installing connector plugins"
confluent-hub install clickhouse/clickhouse-kafka-connect:latest
confluent-hub install --no-prompt confluentinc/kafka-connect-splunk-s2s:latest
#
echo "Launching Kafka Connect worker"
/etc/confluent/docker/run &
#
echo "waiting 2 minutes for things to stabilise"
sleep 120

curl -X POST -H "${HEADER}" --data "${DATA}" http://localhost:8083/connectors

echo "Starting the clickhouse cloud conector"
  
HEADER="Content-Type: application/json"
DATA=$( cat << EOF
{
  "name": "clickhouse_cloud_sink",
  "config": {
    "connector.class": "com.clickhouse.kafka.connect.ClickHouseSinkConnector",
    "tasks.max": "1",
    "topics": "****"
    "security.protocol": "SSL",
    "ssl": "true",
    "hostname": "****.****.****.clickhouse.cloud",
    "errors.tolerance": "all",
    "database": "****",
    "password": "****",
    "port": "8443",
    "value.converter.schemas.enable":"false",
    "value.converter":"org.apache.kafka.connect.json.JsonConverter",
    "username":"****",
    "schemas.enable":"false"
  }
}
EOF
)

curl -X POST -H "${HEADER}" --data "${DATA}" http://localhost:8083/connectors

echo "Sleeping forever"
sleep infinity

